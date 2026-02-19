/// Утилиты для работы с датами и day_start_hour.
///
/// Все таймстемпы в БД хранятся в UTC.
/// Отображение конвертируется с учётом часового пояса и day_start_hour.
abstract final class DateHelper {
  /// Вычисляет начало «сегодня» с учётом [dayStartHour].
  ///
  /// Если сейчас 02:00, а dayStartHour = 4, то «сегодня» началось вчера в 04:00.
  static DateTime todayStart({int dayStartHour = 0}) {
    final now = DateTime.now();
    var start = DateTime(now.year, now.month, now.day, dayStartHour);
    if (now.isBefore(start)) {
      start = start.subtract(const Duration(days: 1));
    }
    return start.toUtc();
  }

  /// Вычисляет конец «сегодня» (начало следующего «дня»).
  static DateTime todayEnd({int dayStartHour = 0}) {
    return todayStart(
      dayStartHour: dayStartHour,
    ).add(const Duration(hours: 24));
  }

  /// Диапазон «сегодня» в UTC для запросов к БД.
  static (DateTime start, DateTime end) todayRange({int dayStartHour = 0}) {
    final start = todayStart(dayStartHour: dayStartHour);
    return (start, start.add(const Duration(hours: 24)));
  }

  /// Диапазон конкретного дня (offset от сегодня) в UTC.
  static (DateTime start, DateTime end) dayRange({
    int dayStartHour = 0,
    int offsetDays = 0,
  }) {
    final todayS = todayStart(dayStartHour: dayStartHour);
    final start = todayS.add(Duration(days: offsetDays));
    return (start, start.add(const Duration(hours: 24)));
  }

  /// Начало текущей недели (понедельник) с учётом [dayStartHour].
  static DateTime weekStart({int dayStartHour = 0}) {
    final today = todayStart(dayStartHour: dayStartHour);
    final todayLocal = today.toLocal();
    final monday = todayLocal.subtract(Duration(days: todayLocal.weekday - 1));
    return DateTime(
      monday.year,
      monday.month,
      monday.day,
      dayStartHour,
    ).toUtc();
  }

  /// Конец текущей недели (следующий понедельник).
  static DateTime weekEnd({int dayStartHour = 0}) {
    return weekStart(dayStartHour: dayStartHour).add(const Duration(days: 7));
  }

  /// Форматирует дату для отображения: «19 февраля, среда».
  static String formatDate(DateTime date, {String locale = 'ru'}) {
    const months = [
      'января',
      'февраля',
      'марта',
      'апреля',
      'мая',
      'июня',
      'июля',
      'августа',
      'сентября',
      'октября',
      'ноября',
      'декабря',
    ];
    const weekdays = [
      'понедельник',
      'вторник',
      'среда',
      'четверг',
      'пятница',
      'суббота',
      'воскресенье',
    ];
    final local = date.toLocal();
    return '${local.day} ${months[local.month - 1]}, ${weekdays[local.weekday - 1]}';
  }
}
