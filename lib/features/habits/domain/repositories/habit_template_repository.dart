import '../../../../database/app_database.dart';

/// Интерфейс репозитория шаблонов привычек.
abstract interface class HabitTemplateRepository {
  /// Все шаблоны.
  Future<List<HabitTemplate>> getAll();

  /// Элементы одного шаблона.
  Future<List<HabitTemplateItem>> getItems(int templateId);

  /// Применить шаблон — создать привычки из элементов.
  Future<int> apply(int templateId);

  /// Создать пользовательский шаблон из существующих привычек.
  Future<int> createFromHabits(String name, List<int> habitIds);

  /// Удалить пользовательский шаблон.
  Future<void> delete(int templateId);
}
