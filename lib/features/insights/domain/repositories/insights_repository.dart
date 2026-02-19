// Модели и интерфейс для инсайтов.

/// Результат расчёта гибкой серии.
class FlexibleStreak {
  /// Количество успешных недель подряд.
  final int weekStreak;

  /// Выполнено на текущей неделе.
  final int currentWeekDone;

  /// Цель на неделю.
  final int goalPerWeek;

  /// True если текущая неделя уже успешна.
  bool get currentWeekSuccess => currentWeekDone >= goalPerWeek;

  /// Прогресс текущей недели (0.0 - 1.0).
  double get weekProgress =>
      goalPerWeek > 0 ? (currentWeekDone / goalPerWeek).clamp(0.0, 1.0) : 0;

  const FlexibleStreak({
    required this.weekStreak,
    required this.currentWeekDone,
    required this.goalPerWeek,
  });
}

/// Статистика за период.
class PeriodStats {
  final int totalDays;
  final int completedDays;
  final int partialDays;
  final int skippedDays;
  final int missedDays;
  final double averageEnergy;
  final Map<int, int> dayOfWeekDistribution; // weekday -> completions

  const PeriodStats({
    required this.totalDays,
    required this.completedDays,
    required this.partialDays,
    required this.skippedDays,
    required this.missedDays,
    required this.averageEnergy,
    required this.dayOfWeekDistribution,
  });

  double get completionRate =>
      totalDays > 0 ? (completedDays + partialDays) / totalDays : 0;
}

/// Интерфейс репозитория инсайтов.
abstract interface class InsightsRepository {
  /// Рассчитать гибкую серию для привычки.
  Future<FlexibleStreak> calculateStreak(
    int habitId,
    int goalPerWeek, {
    int dayStartHour = 0,
  });

  /// Статистика по привычке за последние N дней.
  Future<PeriodStats> getHabitStats(
    int habitId, {
    int days = 30,
    int dayStartHour = 0,
  });

  /// Средний уровень энергии по дням недели.
  Future<Map<int, double>> energyByWeekday({int days = 30});

  /// Тепловая карта: дата -> количество выполненных привычек.
  Future<Map<DateTime, int>> heatmapData({int days = 90, int dayStartHour = 0});
}
