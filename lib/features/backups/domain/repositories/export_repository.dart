/// Интерфейс экспорта в различные форматы.
abstract interface class ExportRepository {
  /// Экспорт данных в CSV (таблица привычек + логи).
  Future<String> exportToCsv({int? daysBack});

  /// Экспорт данных в Markdown (Obsidian-compatible).
  Future<String> exportToMarkdown({int? daysBack});
}
