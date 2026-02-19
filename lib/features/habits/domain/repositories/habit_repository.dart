import '../../../../database/app_database.dart';

/// Интерфейс репозитория привычек.
abstract interface class HabitRepository {
  /// Наблюдать активные (не архивные) привычки.
  Stream<List<Habit>> watchActive();

  /// Наблюдать привычки по сфере.
  Stream<List<Habit>> watchBySphere(int sphereId);

  /// Получить привычку по ID.
  Future<Habit> getById(int id);

  /// Создать привычку.
  Future<int> create(HabitsCompanion companion);

  /// Обновить привычку.
  Future<void> update(int id, HabitsCompanion companion);

  /// Архивировать привычку.
  Future<void> archive(int id);

  /// Удалить привычку.
  Future<void> delete(int id);
}
