import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/enums.dart';
import '../../../../core/keys.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/generator/plant_params.dart';
import '../../domain/generator/plant_widget.dart';
import '../../providers/garden_providers.dart';
import '../widgets/path_trail_painter.dart';

/// Time Path (Тропа Времени) — scrollable garden of crystallized plants.
/// Renders months in reverse chronological order, each with focus plants on the
/// path and background forest canopy.
class TimePathScreen extends ConsumerWidget {
  const TimePathScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gardenByMonth = ref.watch(gardenByMonthProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);

    final months = gardenByMonth.keys.toList()
      ..sort((a, b) {
        final cmp = b.$1.compareTo(a.$1);
        return cmp != 0 ? cmp : b.$2.compareTo(a.$2);
      });

    return Scaffold(
      body: SafeArea(
        child: months.isEmpty
            ? _buildEmptyState(theme)
            : CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                      child: Text(
                        'Тропа Времени',
                        key: K.timePathTitle,
                        style: theme.textTheme.headlineLarge,
                      ),
                    ),
                  ),
                  SliverList.builder(
                    itemCount: months.length,
                    itemBuilder: (context, index) {
                      final key = months[index];
                      final objects = gardenByMonth[key]!;
                      return _MonthSegment(
                        year: key.$1,
                        month: key.$2,
                        objects: objects,
                        isDark: isDark,
                      );
                    },
                  ),
                  const SliverPadding(padding: EdgeInsets.only(bottom: 80)),
                ],
              ),
      ),
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.park_outlined,
              size: 64,
              color: theme.colorScheme.primary.withValues(alpha: 0.3),
            ),
            const SizedBox(height: 16),
            Text(
              'Тропа пока пуста',
              key: K.timePathEmpty,
              style: theme.textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Растения появятся здесь в конце месяца, когда ваши привычки кристаллизуются в сад',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

/// A single month's section on the Time Path.
class _MonthSegment extends StatelessWidget {
  const _MonthSegment({
    required this.year,
    required this.month,
    required this.objects,
    required this.isDark,
  });

  final int year, month;
  final List<GardenObject> objects;
  final bool isDark;

  static const _months = [
    '', 'Январь', 'Февраль', 'Март', 'Апрель', 'Май', 'Июнь',
    'Июль', 'Август', 'Сентябрь', 'Октябрь', 'Ноябрь', 'Декабрь',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Separate focus (Layer 1) and background (Layer 0) objects
    final focus = objects.where((o) => o.completionPct >= 80).toList();
    final background = objects.where((o) => o.completionPct < 80).toList();

    final segmentHeight = 200.0 + focus.length * 60.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Month label
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 4),
          child: Text(
            '${_months[month]} $year',
            style: theme.textTheme.titleLarge?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
            ),
          ),
        ),

        // Garden segment
        SizedBox(
          height: segmentHeight,
          child: Stack(
            children: [
              // Trail path in background
              Positioned.fill(
                child: CustomPaint(
                  painter: PathTrailPainter(
                    segmentCount: 1,
                    isDark: isDark,
                  ),
                ),
              ),

              // Background forest (Layer 0) — clustered small images
              if (background.isNotEmpty)
                Positioned.fill(
                  child: _ForestCanopy(objects: background),
                ),

              // Focus plants (Layer 1) — along the path
              for (var i = 0; i < focus.length; i++)
                Positioned(
                  left: i.isEven ? 20 : null,
                  right: i.isEven ? null : 20,
                  top: 30.0 + i * 60.0,
                  child: GestureDetector(
                    onTap: () => _showMemoryCard(context, focus[i]),
                    child: _PlantThumbnail(object: focus[i], size: 100),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  void _showMemoryCard(BuildContext context, GardenObject obj) {
    final theme = Theme.of(context);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _MemoryCard(object: obj, theme: theme),
    );
  }
}

/// Background forest canopy (Layer 0) — a cluster of small plant images.
class _ForestCanopy extends StatelessWidget {
  const _ForestCanopy({required this.objects});

  final List<GardenObject> objects;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            for (var i = 0; i < objects.length && i < 10; i++)
              Positioned(
                left: _canopyX(i, constraints.maxWidth),
                top: _canopyY(i, constraints.maxHeight),
                child: Opacity(
                  opacity: 0.5,
                  child: _PlantThumbnail(object: objects[i], size: 50),
                ),
              ),
          ],
        );
      },
    );
  }

  double _canopyX(int index, double maxWidth) {
    final seed = objects[index].generationSeed;
    return (seed % maxWidth.toInt()).toDouble().clamp(10, maxWidth - 60);
  }

  double _canopyY(int index, double maxHeight) {
    final seed = objects[index].generationSeed;
    return ((seed ~/ 100) % maxHeight.toInt()).toDouble().clamp(10, maxHeight - 60);
  }
}

/// Renders a plant either from its cached PNG or live via CustomPaint.
class _PlantThumbnail extends StatelessWidget {
  const _PlantThumbnail({required this.object, required this.size});

  final GardenObject object;
  final double size;

  @override
  Widget build(BuildContext context) {
    // Try to load cached PNG first
    if (object.pngPath != null && object.pngPath!.isNotEmpty) {
      final file = File(object.pngPath!);
      if (file.existsSync()) {
        return Image.file(
          file,
          width: size,
          height: size,
          fit: BoxFit.contain,
          filterQuality: FilterQuality.medium,
        );
      }
    }

    // Fallback: render live with CustomPaint
    final objectType = GardenObjectType.fromString(object.objectType);
    final archetype = _resolveArchetype(objectType);

    final params = GenerationParams(
      archetype: archetype,
      completionPct: object.completionPct,
      absoluteCompletions: object.absoluteCompletions,
      maxStreak: object.maxStreak,
      morningRatio: object.morningRatio,
      afternoonRatio: object.afternoonRatio,
      eveningRatio: object.eveningRatio,
      seed: object.generationSeed,
      isShortPerfect: object.isShortPerfect,
      objectType: objectType,
    );

    return PlantWidget(params: params, size: size);
  }

  /// Map object type back to an archetype for rendering.
  /// In a real scenario we'd store the archetype in GardenObject,
  /// but for now default to oak for trees.
  SeedArchetype _resolveArchetype(GardenObjectType type) {
    return switch (type) {
      GardenObjectType.tree => SeedArchetype.oak,
      GardenObjectType.bush => SeedArchetype.oak,
      GardenObjectType.moss => SeedArchetype.oak,
      GardenObjectType.sleepingBulb => SeedArchetype.oak,
    };
  }
}

/// Memory Card bottom sheet — shown when tapping a plant on the path.
class _MemoryCard extends StatelessWidget {
  const _MemoryCard({required this.object, required this.theme});

  final GardenObject object;
  final ThemeData theme;

  static const _months = [
    '', 'Январь', 'Февраль', 'Март', 'Апрель', 'Май', 'Июнь',
    'Июль', 'Август', 'Сентябрь', 'Октябрь', 'Ноябрь', 'Декабрь',
  ];

  @override
  Widget build(BuildContext context) {
    final pct = object.completionPct.round();
    final objectType = GardenObjectType.fromString(object.objectType);
    final typeLabel = switch (objectType) {
      GardenObjectType.tree => 'Дерево',
      GardenObjectType.bush => 'Куст',
      GardenObjectType.moss => 'Мох',
      GardenObjectType.sleepingBulb => 'Спящая луковица',
    };

    return DraggableScrollableSheet(
      initialChildSize: 0.45,
      minChildSize: 0.3,
      maxChildSize: 0.7,
      expand: false,
      builder: (_, controller) => Container(
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: ListView(
          controller: controller,
          padding: const EdgeInsets.all(24),
          children: [
            // Handle bar
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.2),
                  borderRadius: AppRadius.borderS,
                ),
              ),
            ),

            // Title
            Text(
              '${_months[object.month]} ${object.year}',
              style: theme.textTheme.headlineMedium,
            ),
            const SizedBox(height: 4),
            Text(
              typeLabel,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 20),

            // Stats grid
            Row(
              children: [
                _StatChip(label: 'Выполнение', value: '$pct%', theme: theme),
                const SizedBox(width: 12),
                _StatChip(
                  label: 'Выполнений',
                  value: '${object.absoluteCompletions}',
                  theme: theme,
                ),
                const SizedBox(width: 12),
                _StatChip(
                  label: 'Макс. серия',
                  value: '${object.maxStreak}',
                  theme: theme,
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Short perfect badge
            if (object.isShortPerfect)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0x20FFD700),
                  borderRadius: AppRadius.borderM,
                  border: Border.all(color: const Color(0x40FFD700)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.auto_awesome, color: Color(0xFFFFD700), size: 18),
                    const SizedBox(width: 8),
                    Text(
                      'Аура идеального старта',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: const Color(0xFFFFD700),
                      ),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 20),

            // Time-of-day distribution
            Text('Время отметок', style: theme.textTheme.labelLarge),
            const SizedBox(height: 8),
            _TimeDistribution(
              morningRatio: object.morningRatio,
              afternoonRatio: object.afternoonRatio,
              eveningRatio: object.eveningRatio,
              theme: theme,
            ),
          ],
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({
    required this.label,
    required this.value,
    required this.theme,
  });

  final String label, value;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: AppRadius.borderM,
        ),
        child: Column(
          children: [
            Text(value, style: theme.textTheme.titleLarge),
            const SizedBox(height: 2),
            Text(
              label,
              style: theme.textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _TimeDistribution extends StatelessWidget {
  const _TimeDistribution({
    required this.morningRatio,
    required this.afternoonRatio,
    required this.eveningRatio,
    required this.theme,
  });

  final double morningRatio, afternoonRatio, eveningRatio;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _bar('Утро', morningRatio, const Color(0xFF8FAF7A)),
        const SizedBox(width: 8),
        _bar('День', afternoonRatio, const Color(0xFFD4A767)),
        const SizedBox(width: 8),
        _bar('Вечер', eveningRatio, const Color(0xFFB8A9D4)),
      ],
    );
  }

  Widget _bar(String label, double ratio, Color color) {
    return Expanded(
      child: Column(
        children: [
          SizedBox(
            height: 40,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: FractionallySizedBox(
                heightFactor: ratio.clamp(0.05, 1.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.7),
                    borderRadius: AppRadius.borderS,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${(ratio * 100).round()}%',
            style: theme.textTheme.bodySmall,
          ),
          Text(label, style: theme.textTheme.labelSmall),
        ],
      ),
    );
  }
}
