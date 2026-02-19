import '../../../../database/app_database.dart';

/// Интерфейс репозитория бэкапов.
abstract interface class BackupRepository {
  /// Экспорт всех данных в JSON.
  Future<String> exportToJson();

  /// Импорт данных из JSON (полная замена).
  Future<void> importFromJson(String jsonString);

  /// Наблюдать историю бэкапов.
  Stream<List<BackupRecord>> watchAll();
}
