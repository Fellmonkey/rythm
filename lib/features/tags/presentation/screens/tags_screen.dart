import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../di/tag_providers.dart';

/// Экран управления тегами.
class TagsScreen extends ConsumerWidget {
  const TagsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tagsAsync = ref.watch(tagsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Теги')),
      body: tagsAsync.when(
        data: (tags) {
          if (tags.isEmpty) {
            return const Center(
              child: Text(
                'Добавьте теги для\nкросс-сферной группировки',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.textSecondary),
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.only(bottom: 80),
            itemCount: tags.length,
            itemBuilder: (context, index) {
              final tag = tags[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: tag.color != null
                      ? _colorFromHex(tag.color!)
                      : AppColors.accent,
                  radius: 16,
                  child: const Icon(Icons.label, size: 16, color: Colors.white),
                ),
                title: Text(tag.name),
                trailing: IconButton(
                  icon: const Icon(
                    Icons.delete_outline,
                    color: AppColors.textHint,
                  ),
                  onPressed: () =>
                      _confirmDelete(context, ref, tag.id, tag.name),
                ),
                onTap: () => _editTag(context, ref, tag),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Ошибка: $e')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addTag(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addTag(BuildContext context, WidgetRef ref) {
    _showTagDialog(context, ref);
  }

  void _editTag(BuildContext context, WidgetRef ref, dynamic tag) {
    _showTagDialog(
      context,
      ref,
      id: tag.id,
      initialName: tag.name,
      initialColor: tag.color ?? '#9B7EBD',
    );
  }

  void _showTagDialog(
    BuildContext context,
    WidgetRef ref, {
    int? id,
    String initialName = '',
    String initialColor = '#9B7EBD',
  }) {
    final nameCtrl = TextEditingController(text: initialName);
    final colors = [
      '#9B7EBD',
      '#7CB69D',
      '#E8A87C',
      '#78CAD2',
      '#C38D9E',
      '#D4A574',
      '#95B8D1',
      '#B8E0D4',
    ];
    var selectedColor = initialColor;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          title: Text(id != null ? 'Редактировать тег' : 'Новый тег'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameCtrl,
                decoration: const InputDecoration(hintText: 'Название тега'),
                autofocus: true,
                textCapitalization: TextCapitalization.sentences,
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: colors.map((c) {
                  final color = _colorFromHex(c);
                  return GestureDetector(
                    onTap: () => setDialogState(() => selectedColor = c),
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                        border: selectedColor == c
                            ? Border.all(color: Colors.white, width: 2)
                            : null,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Отмена'),
            ),
            ElevatedButton(
              onPressed: () {
                final name = nameCtrl.text.trim();
                if (name.isEmpty) return;
                final repo = ref.read(tagRepositoryProvider);
                if (id != null) {
                  repo.update(id, name: name, color: selectedColor);
                } else {
                  repo.create(name, color: selectedColor);
                }
                Navigator.pop(ctx);
              },
              child: const Text('Сохранить'),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    int id,
    String name,
  ) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Удалить тег?'),
        content: Text('Тег «$name» будет удалён из всех привычек.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () {
              ref.read(tagRepositoryProvider).delete(id);
              Navigator.pop(ctx);
            },
            child: const Text(
              'Удалить',
              style: TextStyle(color: AppColors.warning),
            ),
          ),
        ],
      ),
    );
  }

  Color _colorFromHex(String hex) {
    final buffer = StringBuffer();
    if (hex.startsWith('#')) hex = hex.substring(1);
    if (hex.length == 6) buffer.write('FF');
    buffer.write(hex);
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
