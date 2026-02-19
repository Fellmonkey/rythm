import '../../../../database/app_database.dart';

/// Интерфейс репозитория тегов.
abstract interface class TagRepository {
  /// Наблюдать все теги.
  Stream<List<Tag>> watchAll();

  /// Создать тег.
  Future<int> create(String name, {String? color});

  /// Обновить тег.
  Future<void> update(int id, {String? name, String? color});

  /// Удалить тег.
  Future<void> delete(int id);

  /// Получить теги привычки.
  Future<List<Tag>> getTagsForHabit(int habitId);

  /// Наблюдать теги привычки.
  Stream<List<Tag>> watchTagsForHabit(int habitId);

  /// Установить теги для привычки (заменяет все).
  Future<void> setHabitTags(int habitId, List<int> tagIds);
}
