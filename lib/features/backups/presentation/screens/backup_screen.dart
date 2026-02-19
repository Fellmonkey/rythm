import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path/path.dart' as p;

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/path_provider_web.dart';
import '../../di/backup_providers.dart';
import '../../di/export_providers.dart';

/// Экран управления бэкапами: экспорт/импорт JSON, CSV, Markdown.
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

          // --- Экспорт ---
          _SectionLabel('Экспорт'),
          const SizedBox(height: 8),
          _ActionCard(
            icon: Icons.data_object,
            title: 'Экспорт JSON',
            subtitle: 'Полный бэкап — можно восстановить',
            loading: _exporting,
            onTap: () => _exportJson(),
          ),
          const SizedBox(height: 4),
          _ActionCard(
            icon: Icons.table_chart_outlined,
            title: 'Экспорт CSV',
            subtitle: 'Для Excel, Google Sheets, Notion',
            loading: false,
            onTap: () => _exportCsv(),
          ),
          const SizedBox(height: 4),
          _ActionCard(
            icon: Icons.description_outlined,
            title: 'Экспорт Markdown',
            subtitle: 'Для Obsidian, Logseq, Roam',
            loading: false,
            onTap: () => _exportMarkdown(),
          ),
          const SizedBox(height: 20),

          // --- Импорт ---
          _SectionLabel('Импорт'),
          const SizedBox(height: 8),
          _ActionCard(
            icon: Icons.download,
            title: 'Импорт JSON',
            subtitle: 'Восстановить из бэкапа',
            loading: _importing,
            onTap: _import,
          ),
        ],
      ),
    );
  }

  // --- Export helpers ---

  Future<void> _shareFile(
    String content,
    String filename,
    String subject,
  ) async {
    if (kIsWeb) {
      final mimeType = filename.endsWith('.json')
          ? 'application/json'
          : filename.endsWith('.csv')
          ? 'text/csv'
          : 'text/markdown';
      await downloadFileWeb(content, filename, mimeType);
    } else {
      final dir = await getApplicationDocumentsDirectory();
      final file = File(p.join(dir.path, filename));
      await file.writeAsString(content);
      await SharePlus.instance.share(
        ShareParams(files: [XFile(file.path)], subject: subject),
      );
    }
  }

  String get _timestamp =>
      DateTime.now().toIso8601String().replaceAll(':', '-').split('.').first;

  Future<void> _exportJson() async {
    setState(() => _exporting = true);
    try {
      final json = await ref.read(backupRepositoryProvider).exportToJson();
      await _shareFile(
        json,
        'rythm_backup_$_timestamp.json',
        'Ритм — бэкап $_timestamp',
      );
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('JSON экспортирован')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Ошибка: $e')));
      }
    } finally {
      setState(() => _exporting = false);
    }
  }

  Future<void> _exportCsv() async {
    try {
      final csv = await ref.read(exportRepositoryProvider).exportToCsv();
      await _shareFile(
        csv,
        'rythm_export_$_timestamp.csv',
        'Ритм — CSV $_timestamp',
      );
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('CSV экспортирован')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Ошибка: $e')));
      }
    }
  }

  Future<void> _exportMarkdown() async {
    try {
      final md = await ref.read(exportRepositoryProvider).exportToMarkdown();
      await _shareFile(
        md,
        'rythm_export_$_timestamp.md',
        'Ритм — Markdown $_timestamp',
      );
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Markdown экспортирован')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Ошибка: $e')));
      }
    }
  }

  // --- Import ---

  Future<void> _import() async {
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
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json'],
      );

      if (result == null || result.files.isEmpty) {
        setState(() => _importing = false);
        return;
      }

      final filePath = result.files.single.path;
      if (filePath == null) {
        setState(() => _importing = false);
        return;
      }

      final content = await File(filePath).readAsString();
      await ref.read(backupRepositoryProvider).importFromJson(content);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Данные успешно восстановлены')),
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
