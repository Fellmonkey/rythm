import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../database/app_database.dart';
import '../../../habits/di/habit_providers.dart';
import '../../di/insights_providers.dart';

/// Экран «Инсайты» — еженедельный обзор и статистика.
class InsightsScreen extends ConsumerWidget {
  const InsightsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habitsAsync = ref.watch(activeHabitsProvider);
    final heatmapAsync = ref.watch(heatmapProvider);
    final energyWeekdayAsync = ref.watch(energyByWeekdayProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Инсайты',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Тепловая карта
          _SectionTitle('Активность за 90 дней'),
          const SizedBox(height: 8),
          heatmapAsync.when(
            data: (data) => _HeatmapCard(data: data),
            loading: () => const SizedBox(
              height: 120,
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (e, _) => Text('Ошибка: $e'),
          ),
          const SizedBox(height: 24),

          // Энергия по дням недели
          _SectionTitle('Энергия по дням недели'),
          const SizedBox(height: 8),
          energyWeekdayAsync.when(
            data: (data) => _EnergyWeekdayCard(data: data),
            loading: () => const SizedBox(
              height: 80,
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (e, _) => Text('Ошибка: $e'),
          ),
          const SizedBox(height: 24),

          // Стрики привычек
          _SectionTitle('Недельный ритм'),
          const SizedBox(height: 8),
          habitsAsync.when(
            data: (habits) => Column(
              children: habits.map((h) => _HabitStreakTile(habit: h)).toList(),
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Text('Ошибка: $e'),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
    );
  }
}

/// Упрощённая тепловая карта.
class _HeatmapCard extends StatelessWidget {
  const _HeatmapCard({required this.data});
  final Map<DateTime, int> data;

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Center(
            child: Text(
              'Пока нет данных. Начните выполнять привычки!',
              style: TextStyle(color: AppColors.textSecondary),
            ),
          ),
        ),
      );
    }

    final maxVal = data.values.reduce((a, b) => a > b ? a : b);
    final today = DateTime.now();
    final days = <DateTime>[];
    for (int i = 89; i >= 0; i--) {
      days.add(
        DateTime(
          today.year,
          today.month,
          today.day,
        ).subtract(Duration(days: i)),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          spacing: 3,
          runSpacing: 3,
          children: days.map((day) {
            final count = data[day] ?? 0;
            final intensity = maxVal > 0
                ? (count / maxVal).clamp(0.0, 1.0)
                : 0.0;
            return Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: count > 0
                    ? AppColors.accent.withValues(alpha: 0.2 + intensity * 0.8)
                    : AppColors.surfaceVariant,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

/// Барный график энергии по дням недели.
class _EnergyWeekdayCard extends StatelessWidget {
  const _EnergyWeekdayCard({required this.data});
  final Map<int, double> data;

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Center(
            child: Text(
              'Нет данных об энергии',
              style: TextStyle(color: AppColors.textSecondary),
            ),
          ),
        ),
      );
    }

    const weekdays = ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(7, (i) {
            final wd = i + 1; // 1 = Monday
            final avg = data[wd] ?? 0;
            final height = (avg / 3.0 * 40).clamp(4.0, 40.0);
            final color = avg >= 2.5
                ? AppColors.energyHigh
                : avg >= 1.5
                ? AppColors.energyMedium
                : avg > 0
                ? AppColors.energyLow
                : AppColors.surfaceVariant;

            return Column(
              children: [
                Container(
                  width: 24,
                  height: height,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  weekdays[i],
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textHint,
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}

/// Карточка стрика привычки.
class _HabitStreakTile extends ConsumerWidget {
  const _HabitStreakTile({required this.habit});
  final Habit habit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final streakAsync = ref.watch(habitStreakProvider(habit));

    return Card(
      child: ListTile(
        title: Text(habit.name),
        subtitle: streakAsync.when(
          data: (streak) {
            final weekLabel = streak.weekStreak == 1
                ? 'неделя'
                : streak.weekStreak < 5
                ? 'недели'
                : 'недель';
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                // Прогресс текущей недели
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: streak.weekProgress,
                    backgroundColor: AppColors.surfaceVariant,
                    color: streak.currentWeekSuccess
                        ? AppColors.success
                        : AppColors.accent,
                    minHeight: 6,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${streak.currentWeekDone}/${streak.goalPerWeek} на этой неделе'
                  '${streak.weekStreak > 0 ? ' · ${streak.weekStreak} $weekLabel подряд' : ''}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textHint,
                  ),
                ),
              ],
            );
          },
          loading: () => const LinearProgressIndicator(),
          error: (_, _) => const Text('—'),
        ),
      ),
    );
  }
}
