import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/app_providers.dart';
import '../../../database/app_database.dart';
import '../../home/presentation/providers/home_providers.dart';
import '../data/repositories/insights_repository_impl.dart';
import '../domain/repositories/insights_repository.dart';

final insightsRepositoryProvider = Provider<InsightsRepository>((ref) {
  return InsightsRepositoryImpl(ref.watch(databaseProvider));
});

/// Стрик для конкретной привычки.
final habitStreakProvider = FutureProvider.family<FlexibleStreak, Habit>((
  ref,
  habit,
) {
  final dayStartHour = ref.watch(dayStartHourProvider);
  return ref
      .watch(insightsRepositoryProvider)
      .calculateStreak(habit.id, habit.goalPerWeek, dayStartHour: dayStartHour);
});

/// Тепловая карта за 90 дней.
final heatmapProvider = FutureProvider<Map<DateTime, int>>((ref) {
  final dayStartHour = ref.watch(dayStartHourProvider);
  return ref
      .watch(insightsRepositoryProvider)
      .heatmapData(dayStartHour: dayStartHour);
});

/// Средняя энергия по дням недели.
final energyByWeekdayProvider = FutureProvider<Map<int, double>>((ref) {
  return ref.watch(insightsRepositoryProvider).energyByWeekday();
});
