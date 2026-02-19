import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../database/app_database.dart';
import '../../../energy_tracker/di/energy_providers.dart';
import '../../../habit_logs/di/habit_log_providers.dart';
import '../../../habits/di/habit_providers.dart';
import '../../../profiles/di/profile_providers.dart';

/// Модель привычки с состоянием на сегодня.
class HabitWithStatus {
  final Habit habit;
  final HabitLog? log;

  HabitWithStatus({required this.habit, this.log});

  bool get isCompleted => log?.status == 2;
  bool get isPartial => log?.status == 1;
  bool get isSkipped => log?.skipReasonId != null;

  double get progress {
    if (habit.targetValue <= 0) return 0;
    return ((log?.actualValue ?? 0) / habit.targetValue).clamp(0.0, 1.0);
  }
}

/// Привычки с их состоянием на сегодня.
final todayHabitsWithStatusProvider =
    Provider<AsyncValue<List<HabitWithStatus>>>((ref) {
      final habitsAsync = ref.watch(activeHabitsProvider);
      final logsAsync = ref.watch(todayLogsProvider);
      final energyAsync = ref.watch(todayEnergyProvider);

      return habitsAsync.when(
        data: (habits) {
          return logsAsync.when(
            data: (logs) {
              final logMap = <int, HabitLog>{};
              for (final log in logs) {
                logMap[log.habitId] = log;
              }

              // Фильтрация по энергии
              final energyLevel = energyAsync.value?.energyLevel;

              var filtered = habits;
              if (energyLevel != null) {
                filtered = habits
                    .where((h) => h.energyRequired <= energyLevel)
                    .toList();
              }

              final result = filtered
                  .map((h) => HabitWithStatus(habit: h, log: logMap[h.id]))
                  .toList();

              // Невыполненные сверху, выполненные снизу
              result.sort((a, b) {
                if (a.isCompleted != b.isCompleted) {
                  return a.isCompleted ? 1 : -1;
                }
                return b.habit.priority.compareTo(a.habit.priority);
              });

              return AsyncValue.data(result);
            },
            loading: () => const AsyncValue.loading(),
            error: (e, st) => AsyncValue.error(e, st),
          );
        },
        loading: () => const AsyncValue.loading(),
        error: (e, st) => AsyncValue.error(e, st),
      );
    });

/// Счётчик: выполнено / всего за сегодня.
final todayProgressProvider = Provider<(int completed, int total)>((ref) {
  final data = ref.watch(todayHabitsWithStatusProvider);
  return data.when(
    data: (list) {
      final completed = list.where((h) => h.isCompleted).length;
      return (completed, list.length);
    },
    loading: () => (0, 0),
    error: (_, _) => (0, 0),
  );
});

/// dayStartHour из текущего профиля (утилита).
final dayStartHourProvider = Provider<int>((ref) {
  return ref.watch(profileProvider).value?.dayStartHour ?? 0;
});
