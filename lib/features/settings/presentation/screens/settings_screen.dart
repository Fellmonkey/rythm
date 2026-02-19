import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/providers/app_providers.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../database/app_database.dart';
import '../../../profiles/di/profile_providers.dart';

/// Экран настроек приложения.
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Настройки',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: profileAsync.when(
        data: (profile) => ListView(
          padding: const EdgeInsets.symmetric(vertical: 8),
          children: [
            // --- Профиль ---
            _SectionHeader('Профиль'),
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.person_outline,
                      color: AppColors.accent,
                    ),
                    title: const Text('Имя'),
                    subtitle: Text(profile.name),
                    onTap: () => _editName(context, ref, profile),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.schedule,
                      color: AppColors.accent,
                    ),
                    title: const Text('Начало дня'),
                    subtitle: Text('${profile.dayStartHour}:00'),
                    onTap: () => _editDayStartHour(context, ref, profile),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.travel_explore,
                      color: AppColors.accent,
                    ),
                    title: const Text('Часовой пояс'),
                    subtitle: Text(
                      profile.timezoneMode == 'auto'
                          ? 'Следовать за устройством'
                          : 'Зафиксирован: ${profile.fixedTimezone ?? "—"}',
                    ),
                    trailing: Switch(
                      value: profile.timezoneMode == 'fixed',
                      onChanged: (fixed) {
                        ref
                            .read(profileRepositoryProvider)
                            .updateProfile(
                              ProfilesCompanion(
                                timezoneMode: Value(fixed ? 'fixed' : 'auto'),
                              ),
                            );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // --- Организация ---
            _SectionHeader('Организация'),
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.category_outlined,
                      color: AppColors.accent,
                    ),
                    title: const Text('Сферы жизни'),
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: AppColors.textHint,
                    ),
                    onTap: () => context.go('/settings/spheres'),
                  ),
                ],
              ),
            ),

            // --- Данные ---
            _SectionHeader('Данные'),
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.backup_outlined,
                      color: AppColors.accent,
                    ),
                    title: const Text('Резервное копирование'),
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: AppColors.textHint,
                    ),
                    onTap: () => context.go('/settings/backup'),
                  ),
                  SwitchListTile(
                    secondary: const Icon(
                      Icons.autorenew,
                      color: AppColors.accent,
                    ),
                    title: const Text('Автобэкап'),
                    subtitle: Text('Каждые ${profile.backupFrequencyDays} дн.'),
                    value: profile.backupEnabled,
                    onChanged: (v) {
                      ref
                          .read(profileRepositoryProvider)
                          .updateProfile(
                            ProfilesCompanion(backupEnabled: Value(v)),
                          );
                    },
                  ),
                ],
              ),
            ),

            // --- О приложении ---
            _SectionHeader('О приложении'),
            Card(
              child: Column(
                children: [
                  const ListTile(
                    leading: Icon(Icons.info_outline, color: AppColors.accent),
                    title: Text(AppConstants.appName),
                    subtitle: Text('v${AppConstants.appVersion} · Open Source'),
                  ),
                  const ListTile(
                    leading: Icon(
                      Icons.favorite_outline,
                      color: AppColors.accent,
                    ),
                    title: Text('Поддержать разработчика'),
                    subtitle: Text(
                      'github.com — GitHub Sponsors',
                      style: TextStyle(color: AppColors.textHint, fontSize: 12),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.delete_forever_outlined,
                      color: AppColors.warning,
                    ),
                    title: const Text(
                      'Полный сброс',
                      style: TextStyle(color: AppColors.warning),
                    ),
                    subtitle: const Text('Удалить все данные'),
                    onTap: () => _confirmReset(context, ref),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Ошибка: $e')),
      ),
    );
  }

  void _editName(BuildContext context, WidgetRef ref, Profile profile) {
    final ctrl = TextEditingController(text: profile.name);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Имя профиля'),
        content: TextField(
          controller: ctrl,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Ваше имя'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Отмена'),
          ),
          ElevatedButton(
            onPressed: () {
              final name = ctrl.text.trim();
              if (name.isNotEmpty) {
                ref
                    .read(profileRepositoryProvider)
                    .updateProfile(ProfilesCompanion(name: Value(name)));
              }
              Navigator.pop(ctx);
            },
            child: const Text('Сохранить'),
          ),
        ],
      ),
    );
  }

  void _editDayStartHour(BuildContext context, WidgetRef ref, Profile profile) {
    showDialog(
      context: context,
      builder: (ctx) {
        var selected = profile.dayStartHour;
        return StatefulBuilder(
          builder: (ctx, setDialogState) => AlertDialog(
            title: const Text('Начало дня'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Определяет, когда «сегодня» начинается для вас.',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButton<int>(
                  value: selected,
                  isExpanded: true,
                  items: List.generate(
                    24,
                    (i) => DropdownMenuItem(value: i, child: Text('$i:00')),
                  ),
                  onChanged: (v) {
                    if (v != null) setDialogState(() => selected = v);
                  },
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
                  ref
                      .read(profileRepositoryProvider)
                      .updateProfile(
                        ProfilesCompanion(dayStartHour: Value(selected)),
                      );
                  Navigator.pop(ctx);
                },
                child: const Text('Сохранить'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _confirmReset(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Полный сброс?'),
        content: const Text(
          'ВСЕ данные будут безвозвратно удалены. '
          'Рекомендуем сначала сделать экспорт.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              // Полный сброс: пересоздать БД
              final db = ref.read(databaseProvider);
              // Удалить все данные из всех таблиц
              await db.transaction(() async {
                await db.delete(db.habitLogs).go();
                await db.delete(db.habitTags).go();
                await db.delete(db.energyLogs).go();
                await db.delete(db.skipDays).go();
                await db.delete(db.habits).go();
                await db.delete(db.tags).go();
                await db.delete(db.spheres).go();
                await db.delete(db.backupRecords).go();
                // Сбросить профиль
                await db.delete(db.profiles).go();
                final now = DateTime.now().toUtc();
                await db
                    .into(db.profiles)
                    .insert(
                      ProfilesCompanion.insert(
                        name: 'Default',
                        createdAt: now,
                        updatedAt: now,
                      ),
                    );
              });
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Все данные удалены')),
                );
              }
            },
            child: const Text(
              'Удалить всё',
              style: TextStyle(color: AppColors.warning),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 8),
      child: Text(
        title,
        style: const TextStyle(
          color: AppColors.textHint,
          fontSize: 13,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
