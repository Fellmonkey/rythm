import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../di/sphere_providers.dart';

/// Экран управления сферами жизни.
class SpheresScreen extends ConsumerWidget {
  const SpheresScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final spheresAsync = ref.watch(spheresProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Сферы жизни')),
      body: spheresAsync.when(
        data: (spheres) {
          if (spheres.isEmpty) {
            return const Center(
              child: Text(
                'Добавьте сферы жизни\nдля группировки привычек',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.textSecondary),
              ),
            );
          }
          return ReorderableListView.builder(
            padding: const EdgeInsets.only(bottom: 80),
            itemCount: spheres.length,
            onReorder: (oldIndex, newIndex) {
              if (newIndex > oldIndex) newIndex--;
              final repo = ref.read(sphereRepositoryProvider);
              repo.update(spheres[oldIndex].id, sortOrder: newIndex);
            },
            itemBuilder: (context, index) {
              final sphere = spheres[index];
              return ListTile(
                key: ValueKey(sphere.id),
                leading: CircleAvatar(
                  backgroundColor: _colorFromHex(sphere.color),
                  radius: 16,
                ),
                title: Text(sphere.name),
                trailing: IconButton(
                  icon: const Icon(
                    Icons.delete_outline,
                    color: AppColors.textHint,
                  ),
                  onPressed: () =>
                      _confirmDelete(context, ref, sphere.id, sphere.name),
                ),
                onTap: () => _editSphere(context, ref, sphere),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Ошибка: $e')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addSphere(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addSphere(BuildContext context, WidgetRef ref) {
    _showSphereDialog(context, ref);
  }

  void _editSphere(BuildContext context, WidgetRef ref, dynamic sphere) {
    _showSphereDialog(
      context,
      ref,
      id: sphere.id,
      initialName: sphere.name,
      initialColor: sphere.color,
    );
  }

  void _showSphereDialog(
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
          title: Text(id != null ? 'Редактировать сферу' : 'Новая сфера'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameCtrl,
                decoration: const InputDecoration(hintText: 'Название'),
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
                final repo = ref.read(sphereRepositoryProvider);
                if (id != null) {
                  repo.update(id, name: name, color: selectedColor);
                } else {
                  repo.create(name, selectedColor);
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
        title: const Text('Удалить сферу?'),
        content: Text(
          'Сфера «$name» будет удалена. Привычки останутся без сферы.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () {
              ref.read(sphereRepositoryProvider).delete(id);
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
