import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path/path.dart' as p;

import '../../../../core/theme/app_colors.dart';
import '../../di/backup_providers.dart';

/// Экран управления бэкапами: экспорт/импорт JSON.
class BackupScreen extends ConsumerStatefulWidget {
  const BackupScreen({super.key});

  @override
  ConsumerState<BackupScreen> createState() => _BackupScreenState();
}

class _BackupScreenState extends ConsumerState<BackupScreen> {
  bool _exporting = false;
  bool _importing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Резервное копирование')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Статус
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.shield_outlined,
                        color: AppColors.accent,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Безопасность данных',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Все данные хранятся только на вашем устройстве. '
                    'Регулярно делайте экспорт для защиты от потери.',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Экспорт JSON
          _ActionCard(
            icon: Icons.upload_file,
            title: 'Экспорт JSON',
            subtitle: 'Полный бэкап всех данных',
            loading: _exporting,
            onTap: _export,
          ),
          const SizedBox(height: 8),

          // Импорт JSON
          _ActionCard(
            icon: Icons.download,
            title: 'Импорт JSON',
            subtitle: 'Восстановить из бэкапа',
            loading: _importing,
            onTap: _import,
          ),

          const SizedBox(height: 24),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Экспорт CSV и Markdown будет доступен в следующем обновлении.',
              style: TextStyle(color: AppColors.textHint, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _export() async {
    setState(() => _exporting = true);
    try {
      final repo = ref.read(backupRepositoryProvider);
      final json = await repo.exportToJson();

      final dir = await getApplicationDocumentsDirectory();
      final timestamp = DateTime.now()
          .toIso8601String()
          .replaceAll(':', '-')
          .split('.')
          .first;
      final file = File(p.join(dir.path, 'rythm_backup_$timestamp.json'));
      await file.writeAsString(json);

      await SharePlus.instance.share(
        ShareParams(
          files: [XFile(file.path)],
          subject: 'Ритм — бэкап $timestamp',
        ),
      );

      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Бэкап экспортирован')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Ошибка экспорта: $e')));
      }
    } finally {
      setState(() => _exporting = false);
    }
  }

  Future<void> _import() async {
    // Предупреждение
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Внимание!'),
        content: const Text(
          'Импорт заменит ВСЕ текущие данные данными из файла. '
          'Эту операцию нельзя отменить.\n\n'
          'Рекомендуем сначала сделать экспорт текущих данных.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Отмена'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Продолжить'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    setState(() => _importing = true);
    try {
      // В реальном приложении здесь file_picker
      // Для MVP показываем инструкцию
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Поместите файл бэкапа в папку Documents приложения'),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Ошибка импорта: $e')));
      }
    } finally {
      setState(() => _importing = false);
    }
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.loading,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool loading;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: loading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Icon(icon, color: AppColors.accent),
        title: Text(title),
        subtitle: Text(
          subtitle,
          style: const TextStyle(color: AppColors.textHint, fontSize: 12),
        ),
        trailing: const Icon(Icons.chevron_right, color: AppColors.textHint),
        enabled: !loading,
        onTap: onTap,
      ),
    );
  }
}
