import '../../../../database/app_database.dart';

/// Интерфейс репозитория логов привычек.
abstract interface class HabitLogRepository {
  /// Наблюдать логи за день (UTC диапазон).
  Stream<List<HabitLog>> watchForDateRange(DateTime start, DateTime end);

  /// Записать лог привычки.
  Future<int> log(HabitLogsCompanion companion);

  /// Обновить лог (для Partial → Complete).
  Future<void> updateLog(int id, HabitLogsCompanion companion);

  /// Получить лог привычки за конкретный period.
  Future<HabitLog?> getForHabitInRange(
    int habitId,
    DateTime start,
    DateTime end,
  );

  /// Логи привычки за интервал (для статистики).
  Future<List<HabitLog>> getLogsForHabit(
    int habitId,
    DateTime start,
    DateTime end,
  );
}
