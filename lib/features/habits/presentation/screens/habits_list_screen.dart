import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../database/app_database.dart';
import '../../di/habit_providers.dart';

/// Экран списка всех привычек (управление).
class HabitsListScreen extends ConsumerWidget {
  const HabitsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habitsAsync = ref.watch(activeHabitsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Привычки',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: habitsAsync.when(
        data: (habits) {
          if (habits.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.checklist,
                    size: 64,
                    color: AppColors.textHint,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Привычек пока нет',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () => context.go('/habits/create'),
                    icon: const Icon(Icons.add),
                    label: const Text('Создать'),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.only(bottom: 80),
            itemCount: habits.length,
            itemBuilder: (context, index) {
              final habit = habits[index];
              return _HabitListTile(habit: habit);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Ошибка: $e')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/habits/create'),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _HabitListTile extends ConsumerWidget {
  const _HabitListTile({required this.habit});

  final Habit habit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final typeIcon = switch (habit.type) {
      AppConstants.habitTypeCounter => Icons.add_circle_outline,
      AppConstants.habitTypeDuration => Icons.timer_outlined,
      _ => Icons.check_circle_outline,
    };

    final energyColor = switch (habit.energyRequired) {
      1 => AppColors.energyLow,
      3 => AppColors.energyHigh,
      _ => AppColors.energyMedium,
    };

    return Dismissible(
      key: ValueKey(habit.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: AppColors.warning.withValues(alpha: 0.3),
        child: const Icon(Icons.archive, color: AppColors.warning),
      ),
      confirmDismiss: (_) async {
        await ref.read(habitRepositoryProvider).archive(habit.id);
        if (context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('${habit.name} архивирована')));
        }
        return false; // Не удаляем из списка вручную — стрим обновит
      },
      child: ListTile(
        leading: Icon(typeIcon, color: AppColors.accent),
        title: Text(habit.name),
        subtitle: Text(
          [
            if (habit.unit != null) '${habit.targetValue} ${habit.unit}',
            '${habit.goalPerWeek} дн/нед',
          ].join(' · '),
          style: const TextStyle(color: AppColors.textHint, fontSize: 12),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: energyColor,
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.chevron_right, color: AppColors.textHint),
          ],
        ),
        onTap: () => context.go('/habits/${habit.id}/edit'),
      ),
    );
  }
}
