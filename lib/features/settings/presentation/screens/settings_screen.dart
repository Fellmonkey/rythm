import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/widgets/glass_card.dart';
import '../../../garden/providers/garden_providers.dart';
import '../../../habits/providers/habit_providers.dart';
import '../../domain/card_generator_service.dart';
import '../../domain/friend_code_service.dart';
import '../../providers/settings_providers.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Настройки')),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          // ── Backup section ──────────────────────────────────────
          _SectionHeader(title: 'Резервное копирование', theme: theme),
          const SizedBox(height: 8),
          _SettingsTile(
            icon: Icons.upload_file,
            title: 'Экспорт данных',
            subtitle: 'Сохранить все привычки и сад в файл',
            onTap: () => _exportBackup(context, ref),
          ),
          const SizedBox(height: 8),
          _SettingsTile(
            icon: Icons.download,
            title: 'Импорт данных',
            subtitle: 'Восстановить из файла (заменит текущие данные)',
            onTap: () => _importBackup(context, ref),
          ),

          const SizedBox(height: 24),

          // ── Friend Codes section ────────────────────────────────
          _SectionHeader(title: 'Семена-Коды', theme: theme),
          const SizedBox(height: 8),
          _SettingsTile(
            icon: Icons.share,
            title: 'Поделиться садом',
            subtitle: 'Сгенерировать код для друзей',
            onTap: () => _generateFriendCode(context, ref),
          ),
          const SizedBox(height: 8),
          _SettingsTile(
            icon: Icons.input,
            title: 'Ввести код друга',
            subtitle: 'Посмотреть чужой сад и получить новые семена',
            onTap: () => _importFriendCode(context, ref),
          ),

          const SizedBox(height: 24),

          // ── Card generation section ─────────────────────────────
          _SectionHeader(title: 'Поделиться достижениями', theme: theme),
          const SizedBox(height: 8),
          _SettingsTile(
            icon: Icons.image,
            title: 'Карточка месяца',
            subtitle: 'Создать красивую картинку с растениями',
            onTap: () => _generateCard(context, ref),
          ),

          const SizedBox(height: 24),

          // ── About section ───────────────────────────────────────
          _SectionHeader(title: 'О приложении', theme: theme),
          const SizedBox(height: 8),
          _SettingsTile(
            icon: Icons.eco,
            title: 'Rythm',
            subtitle: 'Версия 1.0.0',
            onTap: null,
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  // ── Export backup ─────────────────────────────────────────────

  Future<void> _exportBackup(BuildContext context, WidgetRef ref) async {
    try {
      final service = ref.read(backupServiceProvider);
      final json = await service.exportToJson();
      final bytes = Uint8List.fromList(json.codeUnits);

      await SharePlus.instance.share(
        ShareParams(
          files: [
            XFile.fromData(
              bytes,
              mimeType: 'application/json',
              name: 'rythm_backup.json',
            ),
          ],
        ),
      );
    } catch (e) {
      if (context.mounted) {
        _showSnackBar(context, 'Ошибка экспорта: $e');
      }
    }
  }

  // ── Import backup ─────────────────────────────────────────────

  Future<void> _importBackup(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Импорт данных'),
        content: const Text(
          'Все текущие данные будут заменены данными из файла. '
          'Это действие нельзя отменить. Продолжить?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Импортировать'),
          ),
        ],
      ),
    );

    if (confirmed != true || !context.mounted) return;

    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json'],
        withData: true,
      );

      if (result == null || result.files.isEmpty) return;

      final bytes = result.files.first.bytes;
      if (bytes == null) {
        if (context.mounted) _showSnackBar(context, 'Не удалось прочитать файл');
        return;
      }

      final json = String.fromCharCodes(bytes);
      final service = ref.read(backupServiceProvider);
      final count = await service.importFromJson(json);

      if (context.mounted) {
        _showSnackBar(context, 'Импортировано привычек: $count');
      }
    } catch (e) {
      if (context.mounted) {
        _showSnackBar(context, 'Ошибка импорта: $e');
      }
    }
  }

  // ── Generate friend code ──────────────────────────────────────

  Future<void> _generateFriendCode(BuildContext context, WidgetRef ref) async {
    try {
      final service = ref.read(friendCodeServiceProvider);
      final code = await service.generateCode();

      if (!context.mounted) return;

      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (ctx) => _FriendCodeSheet(code: code),
      );
    } catch (e) {
      if (context.mounted) {
        _showSnackBar(context, 'Ошибка генерации кода: $e');
      }
    }
  }

  // ── Import friend code ────────────────────────────────────────

  Future<void> _importFriendCode(BuildContext context, WidgetRef ref) async {
    final controller = TextEditingController();
    final code = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Ввести код друга'),
        content: TextField(
          controller: controller,
          maxLines: 5,
          decoration: const InputDecoration(
            hintText: 'Вставьте код сюда...',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, controller.text),
            child: const Text('Применить'),
          ),
        ],
      ),
    );

    controller.dispose();

    if (code == null || code.trim().isEmpty || !context.mounted) return;

    final garden = FriendCodeService.decodeCode(code);
    if (garden == null) {
      if (context.mounted) {
        _showSnackBar(context, 'Неверный код. Проверьте и попробуйте снова.');
      }
      return;
    }

    // Check cross-pollination eligibility.
    final qualifies = FriendCodeService.qualifiesForCrossPollination(garden);

    if (context.mounted) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (ctx) => _GuestGardenSheet(
          garden: garden,
          qualifiesForPollination: qualifies,
        ),
      );
    }
  }

  // ── Generate month card ───────────────────────────────────────

  Future<void> _generateCard(BuildContext context, WidgetRef ref) async {
    try {
      final objectsAsync = ref.read(allGardenObjectsProvider);
      final objects = objectsAsync.value;
      if (objects == null || objects.isEmpty) {
        if (context.mounted) {
          _showSnackBar(
            context,
            'Пока нет завершённых месяцев для генерации карточки.',
          );
        }
        return;
      }

      // Use the latest month.
      final latestYear = objects.first.year;
      final latestMonth = objects.first.month;
      final monthObjects = objects
          .where((o) => o.year == latestYear && o.month == latestMonth)
          .toList();

      // Fetch habit names.
      final habitsAsync = ref.read(activeHabitsProvider);
      final habits = habitsAsync.value ?? [];
      final habitNames = {
        for (final h in habits) h.id: h.name,
      };

      final pngBytes = await CardGeneratorService.generateMonthCard(
        year: latestYear,
        month: latestMonth,
        objects: monthObjects,
        habitNames: habitNames,
      );

      await SharePlus.instance.share(
        ShareParams(
          files: [
            XFile.fromData(
              Uint8List.fromList(pngBytes),
              mimeType: 'image/png',
              name: 'rythm_${latestYear}_$latestMonth.png',
            ),
          ],
        ),
      );
    } catch (e) {
      if (context.mounted) {
        _showSnackBar(context, 'Ошибка генерации карточки: $e');
      }
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}

// ── Section header ──────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, required this.theme});
  final String title;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        title,
        style: theme.textTheme.titleMedium?.copyWith(
          color: theme.colorScheme.primary,
        ),
      ),
    );
  }
}

// ── Settings tile ───────────────────────────────────────────────

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GlassCard(
      child: ListTile(
        leading: Icon(icon, color: theme.colorScheme.primary),
        title: Text(title, style: theme.textTheme.titleSmall),
        subtitle: Text(subtitle, style: theme.textTheme.bodySmall),
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: AppRadius.borderM),
      ),
    );
  }
}

// ── Friend code bottom sheet ────────────────────────────────────

class _FriendCodeSheet extends StatelessWidget {
  const _FriendCodeSheet({required this.code});
  final String code;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DraggableScrollableSheet(
      initialChildSize: 0.45,
      minChildSize: 0.3,
      maxChildSize: 0.7,
      expand: false,
      builder: (ctx, controller) => GlassCard(
        child: ListView(
          controller: controller,
          padding: const EdgeInsets.all(24),
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
                  borderRadius: AppRadius.borderS,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Ваш Семена-Код',
              style: theme.textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Поделитесь этим кодом с друзьями, чтобы они могли увидеть ваш сад.',
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: AppRadius.borderM,
                border: Border.all(
                  color: theme.colorScheme.primary.withValues(alpha: 0.3),
                ),
              ),
              child: SelectableText(
                code,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontFamily: 'monospace',
                ),
                maxLines: 8,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: code));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Код скопирован')),
                      );
                    },
                    icon: const Icon(Icons.copy),
                    label: const Text('Копировать'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      SharePlus.instance.share(ShareParams(text: code));
                    },
                    icon: const Icon(Icons.share),
                    label: const Text('Отправить'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ── Guest garden bottom sheet ───────────────────────────────────

class _GuestGardenSheet extends StatelessWidget {
  const _GuestGardenSheet({
    required this.garden,
    required this.qualifiesForPollination,
  });

  final GuestGarden garden;
  final bool qualifiesForPollination;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final byMonth = garden.byMonth;
    final sortedKeys = byMonth.keys.toList()
      ..sort((a, b) {
        final cmp = b.$1.compareTo(a.$1);
        return cmp != 0 ? cmp : b.$2.compareTo(a.$2);
      });

    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.3,
      maxChildSize: 0.85,
      expand: false,
      builder: (ctx, controller) => GlassCard(
        child: ListView(
          controller: controller,
          padding: const EdgeInsets.all(24),
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
                  borderRadius: AppRadius.borderS,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Сад друга',
              style: theme.textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              '${garden.entries.length} растений',
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            if (qualifiesForPollination) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: AppColors.sageGreen.withValues(alpha: 0.15),
                  borderRadius: AppRadius.borderM,
                  border: Border.all(
                    color: AppColors.sageGreen.withValues(alpha: 0.4),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.auto_awesome, color: AppColors.warmAmber),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Этот сад успешный! Перекрёстное опыление доступно.',
                        style: theme.textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 16),
            for (final key in sortedKeys) ...[
              _GuestMonthSection(
                year: key.$1,
                month: key.$2,
                entries: byMonth[key]!,
                theme: theme,
              ),
              const SizedBox(height: 12),
            ],
          ],
        ),
      ),
    );
  }
}

class _GuestMonthSection extends StatelessWidget {
  const _GuestMonthSection({
    required this.year,
    required this.month,
    required this.entries,
    required this.theme,
  });

  final int year;
  final int month;
  final List<GuestGardenEntry> entries;
  final ThemeData theme;

  static const _months = [
    '', 'Янв', 'Фев', 'Мар', 'Апр', 'Май', 'Июн',
    'Июл', 'Авг', 'Сен', 'Окт', 'Ноя', 'Дек',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${_months[month]} $year',
          style: theme.textTheme.titleSmall,
        ),
        const SizedBox(height: 4),
        for (final entry in entries)
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              children: [
                Icon(
                  _iconForType(entry.objectType),
                  size: 18,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    entry.habitName,
                    style: theme.textTheme.bodyMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '${(entry.completionPct * 100).round()}%',
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
      ],
    );
  }

  IconData _iconForType(String type) {
    return switch (type) {
      'tree' => Icons.park,
      'bush' => Icons.grass,
      _ => Icons.spa,
    };
  }
}
