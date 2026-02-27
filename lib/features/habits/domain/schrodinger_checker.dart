import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/enums.dart';
import '../../../core/utils/date_helpers.dart';
import '../data/habit_logs_dao.dart';
import '../data/habits_dao.dart';

/// Schrödinger's Cat mechanic for negative habits.
///
/// If a negative habit has no log entries for ≥ 3 days and the user hasn't
/// opened the app, those days are left in a "grey zone". On next app open,
/// a confirmation popup should be shown.
class SchrodingerChecker {
  SchrodingerChecker({
    required this.habitsDao,
    required this.habitLogsDao,
    required this.prefs,
  });

  final HabitsDao habitsDao;
  final HabitLogsDao habitLogsDao;
  final SharedPreferences prefs;

  static const _lastOpenedKey = 'last_opened_at';

  /// Check for negative habits that need confirmation.
  /// Returns a list of (habit, pendingDates) pairs that need user input.
  Future<List<PendingNegativeHabit>> checkPendingNegativeHabits() async {
    final now = DateTime.now().toMidnight;
    final lastOpened = _getLastOpened();
    final result = <PendingNegativeHabit>[];

    // Update last opened to now
    await _setLastOpened(now);

    if (lastOpened == null) return result;

    final daysSinceOpen = now.difference(lastOpened).inDays;
    if (daysSinceOpen < 3) return result;

    // Get all active negative habits
    final habits = await habitsDao.getActiveHabits();
    final negativeHabits = habits
        .where((h) => FrequencyType.fromString(h.frequencyType) == FrequencyType.negative)
        .toList();

    for (final habit in negativeHabits) {
      final pendingDates = <DateTime>[];

      // Check each day since last opened
      for (var d = 1; d <= daysSinceOpen; d++) {
        final day = lastOpened.add(Duration(days: d));
        if (day.isAfter(now)) break;

        final dayTs = day.unixSeconds;
        final logs = await habitLogsDao.getLogsForDate(dayTs);
        final hasLog = logs.any((l) => l.habitId == habit.id);

        if (!hasLog) {
          pendingDates.add(day);
        }
      }

      if (pendingDates.isNotEmpty) {
        result.add(PendingNegativeHabit(
          habit: habit,
          pendingDates: pendingDates,
        ));
      }
    }

    return result;
  }

  /// Confirm that the user held the negative habit for the pending dates.
  Future<void> confirmHeld(int habitId, List<DateTime> dates) async {
    for (final date in dates) {
      await habitLogsDao.markDone(habitId, date.unixSeconds, date.hour);
    }
  }

  /// Mark the negative habit as failed for the pending dates (freeze plant).
  Future<void> confirmFailed(int habitId, List<DateTime> dates) async {
    for (final date in dates) {
      await habitLogsDao.markFail(habitId, date.unixSeconds);
    }
  }

  DateTime? _getLastOpened() {
    final ts = prefs.getInt(_lastOpenedKey);
    return ts != null ? dateFromUnix(ts) : null;
  }

  Future<void> _setLastOpened(DateTime date) async {
    await prefs.setInt(_lastOpenedKey, date.unixSeconds);
  }
}

/// A negative habit with dates that need user confirmation.
class PendingNegativeHabit {
  const PendingNegativeHabit({
    required this.habit,
    required this.pendingDates,
  });

  final Habit habit;
  final List<DateTime> pendingDates;
}
