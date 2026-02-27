import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/garden/domain/generator/plant_params.dart';
import '../../features/garden/domain/generator/plant_widget.dart';
import '../database/database_provider.dart';
import '../router/app_router.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import 'debug_data_seeder.dart';
import 'debug_profiles.dart';

/// Draggable floating debug button that opens the debug menu.
///
/// Only rendered in debug mode (wrapped with [kDebugMode] check in main.dart).
class DebugMenuOverlay extends StatefulWidget {
  const DebugMenuOverlay({required this.child, super.key});

  final Widget child;

  @override
  State<DebugMenuOverlay> createState() => _DebugMenuOverlayState();
}

class _DebugMenuOverlayState extends State<DebugMenuOverlay> {
  Offset _fabPosition = const Offset(16, 100);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        Positioned(
          left: _fabPosition.dx,
          top: _fabPosition.dy,
          child: GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                _fabPosition += details.delta;
              });
            },
            child: FloatingActionButton.small(
              heroTag: '__debug_fab__',
              backgroundColor: AppColors.glowViolet.withValues(alpha: 0.85),
              onPressed: _openDebugMenu,
              child: const Icon(Icons.bug_report, color: Colors.white, size: 20),
            ),
          ),
        ),
      ],
    );
  }

  void _openDebugMenu() {
    final navContext = rootNavigatorKey.currentContext;
    if (navContext == null) return;

    showModalBottomSheet<void>(
      context: navContext,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const _DebugSheet(),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// Debug bottom sheet — two tabs: Scenarios (DB) + Plant Profiles
// ═══════════════════════════════════════════════════════════

class _DebugSheet extends StatelessWidget {
  const _DebugSheet();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return DraggableScrollableSheet(
      initialChildSize: 0.65,
      minChildSize: 0.3,
      maxChildSize: 0.92,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                // Handle
                Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 4),
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: (isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.lightTextSecondary)
                          .withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                // Title
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                  child: Row(
                    children: [
                      Icon(Icons.bug_report,
                          color: AppColors.glowViolet, size: 22),
                      const SizedBox(width: 8),
                      Text(
                        'Debug Menu',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                // Tabs
                TabBar(
                  labelColor: AppColors.glowViolet,
                  unselectedLabelColor: isDark
                      ? AppColors.darkTextSecondary
                      : AppColors.lightTextSecondary,
                  indicatorColor: AppColors.glowViolet,
                  tabs: const [
                    Tab(text: 'Сценарии БД'),
                    Tab(text: 'Растения'),
                  ],
                ),
                // Tab content
                Expanded(
                  child: TabBarView(
                    children: [
                      _ScenariosTab(scrollController: scrollController),
                      _PlantProfilesTab(scrollController: scrollController),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ═══════════════════════════════════════════════════════════
// TAB 1: Database scenarios
// ═══════════════════════════════════════════════════════════

class _ScenariosTab extends ConsumerStatefulWidget {
  const _ScenariosTab({required this.scrollController});
  final ScrollController scrollController;

  @override
  ConsumerState<_ScenariosTab> createState() => _ScenariosTabState();
}

class _ScenariosTabState extends ConsumerState<_ScenariosTab> {
  bool _seeding = false;
  String? _lastResult;

  Future<void> _runScenario(DebugScenario scenario) async {
    setState(() {
      _seeding = true;
      _lastResult = null;
    });

    try {
      final db = ref.read(databaseProvider);
      final seeder = DebugDataSeeder(db);
      final sw = Stopwatch()..start();
      final count = await seeder.seed(scenario);
      sw.stop();

      if (!mounted) return;
      setState(() {
        _seeding = false;
        _lastResult =
            '✅ ${scenario.name}: $count привычек за ${sw.elapsedMilliseconds} мс';
      });

      // Refresh providers so the UI updates
      ref.invalidate(databaseProvider);
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _seeding = false;
        _lastResult = '❌ Ошибка: $e';
      });
    }
  }

  Future<void> _clearAll() async {
    setState(() {
      _seeding = true;
      _lastResult = null;
    });
    try {
      final db = ref.read(databaseProvider);
      await db.gardenObjectsDao.deleteAllObjects();
      await db.habitLogsDao.deleteAllLogs();
      await db.habitsDao.deleteAllHabits();

      if (!mounted) return;
      setState(() {
        _seeding = false;
        _lastResult = '🗑️ База очищена';
      });
      ref.invalidate(databaseProvider);
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _seeding = false;
        _lastResult = '❌ Ошибка: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ListView(
      controller: widget.scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      children: [
        // Status bar
        if (_seeding)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Center(child: CircularProgressIndicator()),
          ),
        if (_lastResult != null)
          Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.darkBackground.withValues(alpha: 0.7)
                  : AppColors.sageGreen.withValues(alpha: 0.12),
              borderRadius: AppRadius.borderS,
            ),
            child: Text(
              _lastResult!,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),

        // Clear button
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: OutlinedButton.icon(
            onPressed: _seeding ? null : _clearAll,
            icon: const Icon(Icons.delete_sweep, size: 18),
            label: const Text('Очистить БД'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.dustyRose,
              side: const BorderSide(color: AppColors.dustyRose),
            ),
          ),
        ),

        // Scenario cards
        _CategoryHeader(title: 'Сценарии'),
        for (final scenario in debugScenarios)
          _ScenarioTile(
            scenario: scenario,
            enabled: !_seeding,
            onTap: () => _runScenario(scenario),
          ),
      ],
    );
  }
}

class _ScenarioTile extends StatelessWidget {
  const _ScenarioTile({
    required this.scenario,
    required this.enabled,
    required this.onTap,
  });

  final DebugScenario scenario;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 3),
      elevation: 0,
      color: isDark
          ? AppColors.darkBackground.withValues(alpha: 0.6)
          : AppColors.lightBackground.withValues(alpha: 0.6),
      shape: RoundedRectangleBorder(borderRadius: AppRadius.borderS),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
        leading: Text(scenario.icon, style: const TextStyle(fontSize: 28)),
        title: Text(
          scenario.name,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          scenario.description,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        trailing: Icon(
          Icons.play_circle_fill,
          color: enabled ? AppColors.sageGreen : AppColors.coolGreyBlue,
          size: 28,
        ),
        onTap: enabled ? onTap : null,
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// TAB 2: Plant profiles  (preserved from previous version)
// ═══════════════════════════════════════════════════════════

class _PlantProfilesTab extends StatelessWidget {
  const _PlantProfilesTab({required this.scrollController});
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final categories = DebugProfiles.categories;

    return ListView(
      controller: scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      children: [
        for (final entry in categories.entries) ...[
          _CategoryHeader(title: entry.key),
          for (final profile in entry.value)
            _ProfileTile(profile: profile),
          const SizedBox(height: 12),
        ],
      ],
    );
  }
}

// ── Category header ────────────────────────────────────────

class _CategoryHeader extends StatelessWidget {
  const _CategoryHeader({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 4),
      child: Text(
        title.toUpperCase(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
              color: Theme.of(context).brightness == Brightness.dark
                  ? AppColors.darkTextSecondary
                  : AppColors.lightTextSecondary,
            ),
      ),
    );
  }
}

// ── Profile tile ───────────────────────────────────────────

class _ProfileTile extends StatelessWidget {
  const _ProfileTile({required this.profile});
  final DebugProfile profile;

  @override
  Widget build(BuildContext context) {
    final params = profile.params;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 3),
      elevation: 0,
      color: isDark
          ? AppColors.darkBackground.withValues(alpha: 0.6)
          : AppColors.lightBackground.withValues(alpha: 0.6),
      shape: RoundedRectangleBorder(borderRadius: AppRadius.borderS),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        leading: SizedBox(
          width: 48,
          height: 48,
          child: PlantWidget(params: params, size: 48),
        ),
        title: Text(
          profile.name,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        subtitle: Text(
          '${profile.description}  •  ${params.archetype.displayName}  •  '
          '${params.objectType.name}',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        trailing: const Icon(Icons.chevron_right, size: 20),
        onTap: () {
          final nav = rootNavigatorKey.currentState;
          if (nav == null) return;
          // Close the bottom sheet first, then push preview
          nav.pop();
          nav.push(
            MaterialPageRoute<void>(
              builder: (_) => DebugPlantPreviewScreen(profile: profile),
            ),
          );
        },
      ),
    );
  }
}

// ── Full-screen plant preview ──────────────────────────────

class DebugPlantPreviewScreen extends StatefulWidget {
  const DebugPlantPreviewScreen({required this.profile, super.key});
  final DebugProfile profile;

  @override
  State<DebugPlantPreviewScreen> createState() => _DebugPlantPreviewScreenState();
}

class _DebugPlantPreviewScreenState extends State<DebugPlantPreviewScreen> {
  late GenerationParams _params;
  late TextEditingController _seedController;

  @override
  void initState() {
    super.initState();
    _params = widget.profile.params;
    _seedController = TextEditingController(text: _params.seed.toString());
  }

  @override
  void dispose() {
    _seedController.dispose();
    super.dispose();
  }

  void _updateSeed(int newSeed) {
    setState(() {
      _params = GenerationParams(
        archetype: _params.archetype,
        completionPct: _params.completionPct,
        absoluteCompletions: _params.absoluteCompletions,
        maxStreak: _params.maxStreak,
        morningRatio: _params.morningRatio,
        afternoonRatio: _params.afternoonRatio,
        eveningRatio: _params.eveningRatio,
        seed: newSeed,
        isShortPerfect: _params.isShortPerfect,
        objectType: _params.objectType,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.darkText : AppColors.lightText;
    final secondaryColor = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.profile.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.shuffle),
            tooltip: 'Случайный seed',
            onPressed: () {
              final newSeed = DateTime.now().microsecondsSinceEpoch % 100000;
              _seedController.text = newSeed.toString();
              _updateSeed(newSeed);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Plant preview
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.darkBackground
                    : AppColors.lightBackground,
                borderRadius: AppRadius.borderL,
                border: Border.all(
                  color: isDark
                      ? AppColors.glassBorderDark
                      : AppColors.lightTextSecondary.withValues(alpha: 0.15),
                ),
              ),
              child: Center(
                child: PlantWidget(params: _params, size: 280),
              ),
            ),
          ),
          // Params panel
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: ListView(
                children: [
                  // Seed editor
                  Row(
                    children: [
                      Text('Seed:', style: TextStyle(color: secondaryColor)),
                      const SizedBox(width: 8),
                      SizedBox(
                        width: 100,
                        child: TextField(
                          controller: _seedController,
                          keyboardType: TextInputType.number,
                          style: TextStyle(color: textColor, fontSize: 14),
                          decoration: const InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 8, vertical: 6,
                            ),
                          ),
                          onSubmitted: (v) {
                            final parsed = int.tryParse(v);
                            if (parsed != null) _updateSeed(parsed);
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Info grid
                  _InfoRow(label: 'Архетип', value: _params.archetype.displayName, color: secondaryColor, valueColor: textColor),
                  _InfoRow(label: 'Тип объекта', value: _params.objectType.name, color: secondaryColor, valueColor: textColor),
                  _InfoRow(label: 'Прогресс', value: '${_params.completionPct}%', color: secondaryColor, valueColor: textColor),
                  _InfoRow(label: 'Кол-во отметок', value: '${_params.absoluteCompletions}', color: secondaryColor, valueColor: textColor),
                  _InfoRow(label: 'Макс. стрик', value: '${_params.maxStreak}', color: secondaryColor, valueColor: textColor),
                  _InfoRow(label: 'Short-perfect', value: _params.isShortPerfect ? 'Да' : 'Нет', color: secondaryColor, valueColor: textColor),
                  _InfoRow(
                    label: 'Утро / День / Вечер',
                    value: '${(_params.morningRatio * 100).toInt()}% / '
                        '${(_params.afternoonRatio * 100).toInt()}% / '
                        '${(_params.eveningRatio * 100).toInt()}%',
                    color: secondaryColor,
                    valueColor: textColor,
                  ),
                  _InfoRow(label: 'Scale factor', value: _params.scaleFactor.toStringAsFixed(2), color: secondaryColor, valueColor: textColor),
                  _InfoRow(label: 'Lushness', value: _params.lushness.toStringAsFixed(2), color: secondaryColor, valueColor: textColor),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Helper: info row ───────────────────────────────────────

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.label,
    required this.value,
    required this.color,
    required this.valueColor,
  });

  final String label;
  final String value;
  final Color color;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: color, fontSize: 13)),
          Text(value, style: TextStyle(color: valueColor, fontSize: 13, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
