import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../database/app_database.dart';
import '../../di/habit_template_providers.dart';

/// Экран выбора шаблона привычек.
class HabitTemplatesScreen extends ConsumerWidget {
  const HabitTemplatesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final templatesAsync = ref.watch(templatesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Шаблоны привычек')),
      body: templatesAsync.when(
        data: (templates) {
          if (templates.isEmpty) {
            return const Center(
              child: Text(
                'Шаблоны загружаются…',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            );
          }

          final presets = templates.where((t) => t.isPreset).toList();
          final custom = templates.where((t) => !t.isPreset).toList();

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              if (presets.isNotEmpty) ...[
                const _SectionLabel('Встроенные'),
                const SizedBox(height: 8),
                ...presets.map(
                  (t) => _TemplateCard(
                    template: t,
                    onApply: () => _apply(context, ref, t),
                  ),
                ),
              ],
              if (custom.isNotEmpty) ...[
                const SizedBox(height: 20),
                const _SectionLabel('Пользовательские'),
                const SizedBox(height: 8),
                ...custom.map(
                  (t) => _TemplateCard(
                    template: t,
                    onApply: () => _apply(context, ref, t),
                    onDelete: () => _delete(context, ref, t),
                  ),
                ),
              ],
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Ошибка: $e')),
      ),
    );
  }

  Future<void> _apply(
    BuildContext context,
    WidgetRef ref,
    HabitTemplate template,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Применить «${template.name}»?'),
        content: FutureBuilder<List<HabitTemplateItem>>(
          future: ref
              .read(habitTemplateRepositoryProvider)
              .getItems(template.id),
          builder: (ctx, snap) {
            if (!snap.hasData) {
              return const SizedBox(
                height: 60,
                child: Center(child: CircularProgressIndicator()),
              );
            }
            final items = snap.data!;
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Будут созданы ${items.length} привычек:',
                  style: const TextStyle(color: AppColors.textSecondary),
                ),
                const SizedBox(height: 8),
                ...items.map(
                  (i) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.circle,
                          size: 6,
                          color: AppColors.accent,
                        ),
                        const SizedBox(width: 8),
                        Expanded(child: Text(i.habitName)),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Отмена'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Создать'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    final count = await ref
        .read(habitTemplateRepositoryProvider)
        .apply(template.id);
    HapticFeedback.lightImpact();

    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Создано $count привычек')));
      context.pop();
    }
  }

  Future<void> _delete(
    BuildContext context,
    WidgetRef ref,
    HabitTemplate template,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Удалить шаблон?'),
        content: Text('«${template.name}» будет удалён.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text(
              'Удалить',
              style: TextStyle(color: AppColors.warning),
            ),
          ),
        ],
      ),
    );

    if (confirmed != true) return;
    await ref.read(habitTemplateRepositoryProvider).delete(template.id);
    ref.invalidate(templatesProvider);
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.title);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: AppColors.textHint,
        fontSize: 13,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
    );
  }
}

class _TemplateCard extends StatelessWidget {
  const _TemplateCard({
    required this.template,
    required this.onApply,
    this.onDelete,
  });

  final HabitTemplate template;
  final VoidCallback onApply;
  final VoidCallback? onDelete;

  IconData get _categoryIcon {
    switch (template.category) {
      case 'morning':
        return Icons.wb_sunny_outlined;
      case 'evening':
        return Icons.nights_stay_outlined;
      case 'health':
        return Icons.favorite_outline;
      case 'productivity':
        return Icons.rocket_launch_outlined;
      default:
        return Icons.auto_awesome_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(_categoryIcon, color: AppColors.accent),
        title: Text(template.name),
        subtitle: template.description != null
            ? Text(
                template.description!,
                style: const TextStyle(color: AppColors.textHint, fontSize: 12),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              )
            : null,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (onDelete != null)
              IconButton(
                icon: const Icon(
                  Icons.delete_outline,
                  size: 20,
                  color: AppColors.warning,
                ),
                onPressed: onDelete,
              ),
            const Icon(Icons.chevron_right, color: AppColors.textHint),
          ],
        ),
        onTap: onApply,
      ),
    );
  }
}
