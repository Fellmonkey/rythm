import 'dart:convert';

import '../../../core/database/app_database.dart';
import '../../../core/database/enums.dart';
import '../../../core/utils/date_helpers.dart';

/// Check if a habit is expected to be performed on [today].
bool isExpectedToday(Habit habit, DateTime today) {
  final freqType = FrequencyType.fromString(habit.frequencyType);
  switch (freqType) {
    case FrequencyType.daily:
      return true;
    case FrequencyType.weekdays:
      final weekdays = parseWeekdays(habit.frequencyValue);
      return weekdays.contains(today.weekday);
    case FrequencyType.xPerWeek:
      // Simplification: always show for x_per_week
      return true;
    case FrequencyType.everyXDays:
      final x = parseXValue(habit.frequencyValue);
      final created = dateFromUnix(habit.createdAt);
      final diff = today.toMidnight.difference(created.toMidnight).inDays;
      return diff % x == 0;
    case FrequencyType.negative:
      return true;
  }
}

/// Parse weekday list from JSON frequency value.
/// Returns [1,2,3,4,5] (Mon-Fri) as default.
List<int> parseWeekdays(String json) {
  try {
    final decoded = jsonDecode(json);
    if (decoded is Map && decoded.containsKey('days')) {
      return (decoded['days'] as List).cast<int>();
    }
    if (decoded is List) return decoded.cast<int>();
  } catch (_) {}
  return [1, 2, 3, 4, 5];
}

/// Parse a single integer value from JSON frequency value.
/// Returns 1 as default.
int parseXValue(String json) {
  try {
    final decoded = jsonDecode(json);
    if (decoded is Map && decoded.containsKey('x')) {
      return decoded['x'] as int;
    }
    if (decoded is int) return decoded;
  } catch (_) {}
  return 1;
}
