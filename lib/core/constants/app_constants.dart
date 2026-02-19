/// Константы приложения Ритм.
abstract final class AppConstants {
  static const appName = 'Ритм';
  static const appVersion = '1.0.0';

  /// Статусы выполнения привычки
  static const int statusMissed = 0;
  static const int statusPartial = 1;
  static const int statusComplete = 2;

  /// Типы привычек
  static const String habitTypeBinary = 'binary';
  static const String habitTypeCounter = 'counter';
  static const String habitTypeDuration = 'duration';

  /// Уровни энергии
  static const int energyLow = 1;
  static const int energyMedium = 2;
  static const int energyHigh = 3;

  /// Приоритеты
  static const int priorityLow = 0;
  static const int priorityMedium = 1;
  static const int priorityHigh = 2;

  /// Причины пропуска
  static const List<String> skipReasons = ['rest', 'sick', 'travel', 'other'];

  /// Подписи причин пропуска
  static const Map<String, String> skipReasonLabels = {
    'rest': 'Отдых',
    'sick': 'Болезнь',
    'travel': 'Путешествие',
    'other': 'Другое',
  };
}
