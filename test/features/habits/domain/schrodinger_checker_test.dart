import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rythm/core/database/app_database.dart';
import 'package:rythm/core/utils/date_helpers.dart';
import 'package:rythm/features/habits/domain/schrodinger_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../fixtures/test_db.dart';
import '../../../fixtures/test_factories.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late AppDatabase db;
  late MockSharedPreferences mockPrefs;
  late SchrodingerChecker checker;

  setUp(() async {
    db = createTestDatabase();
    mockPrefs = MockSharedPreferences();
    when(() => mockPrefs.setInt(any(), any())).thenAnswer((_) async => true);

    checker = SchrodingerChecker(
      habitsDao: db.habitsDao,
      habitLogsDao: db.habitLogsDao,
      prefs: mockPrefs,
    );
  });

  tearDown(() async {
    await db.close();
  });

  group('SchrodingerChecker', () {
    test('no lastOpened returns empty result and sets lastOpened', () async {
      when(() => mockPrefs.getInt('last_opened_at')).thenReturn(null);

      final result = await checker.checkPendingNegativeHabits();

      expect(result, isEmpty);
      verify(() => mockPrefs.setInt('last_opened_at', any())).called(1);
    });

    test('lastOpened < 3 days ago returns empty result', () async {
      final yesterday = DateTime.now().toMidnight.subtract(
            const Duration(days: 1),
          );
      when(() => mockPrefs.getInt('last_opened_at'))
          .thenReturn(yesterday.unixSeconds);

      final result = await checker.checkPendingNegativeHabits();

      expect(result, isEmpty);
    });

    test('lastOpened >= 3 days + negative habit without logs returns pending',
        () async {
      final fiveDaysAgo = DateTime.now().toMidnight.subtract(
            const Duration(days: 5),
          );
      when(() => mockPrefs.getInt('last_opened_at'))
          .thenReturn(fiveDaysAgo.unixSeconds);

      // Insert a negative habit
      await db.habitsDao.insertHabit(makeHabitCompanion(
        name: 'No Smoking',
        frequencyType: 'negative',
      ));

      final result = await checker.checkPendingNegativeHabits();

      expect(result, hasLength(1));
      expect(result.first.habit.name, 'No Smoking');
      expect(result.first.pendingDates, hasLength(5));
    });

    test('gap with partial logs returns only days without logs', () async {
      final fiveDaysAgo = DateTime.now().toMidnight.subtract(
            const Duration(days: 5),
          );
      when(() => mockPrefs.getInt('last_opened_at'))
          .thenReturn(fiveDaysAgo.unixSeconds);

      final habitId = await db.habitsDao.insertHabit(makeHabitCompanion(
        name: 'No Smoking',
        frequencyType: 'negative',
      ));

      // Add done logs for 2 of the 5 days
      final day1 = fiveDaysAgo.add(const Duration(days: 1));
      final day3 = fiveDaysAgo.add(const Duration(days: 3));
      await db.habitLogsDao.markDone(habitId, day1.unixSeconds, 8);
      await db.habitLogsDao.markDone(habitId, day3.unixSeconds, 14);

      final result = await checker.checkPendingNegativeHabits();

      expect(result, hasLength(1));
      // 5 days total minus 2 with logs = 3 pending
      expect(result.first.pendingDates, hasLength(3));
    });

    test('non-negative habits are ignored', () async {
      final fiveDaysAgo = DateTime.now().toMidnight.subtract(
            const Duration(days: 5),
          );
      when(() => mockPrefs.getInt('last_opened_at'))
          .thenReturn(fiveDaysAgo.unixSeconds);

      // Insert a daily (non-negative) habit
      await db.habitsDao.insertHabit(makeHabitCompanion(
        name: 'Morning Run',
        frequencyType: 'daily',
      ));

      final result = await checker.checkPendingNegativeHabits();

      expect(result, isEmpty);
    });

    test('confirmHeld creates done logs', () async {
      final habitId = await db.habitsDao.insertHabit(makeHabitCompanion(
        name: 'No Smoking',
        frequencyType: 'negative',
      ));

      final dates = [
        DateTime.utc(2026, 1, 1),
        DateTime.utc(2026, 1, 2),
        DateTime.utc(2026, 1, 3),
      ];

      await checker.confirmHeld(habitId, dates);

      final logs = await db.habitLogsDao.getAllLogs();
      expect(logs, hasLength(3));
      for (final log in logs) {
        expect(log.status, 'done');
        expect(log.habitId, habitId);
      }
    });

    test('confirmFailed creates fail logs', () async {
      final habitId = await db.habitsDao.insertHabit(makeHabitCompanion(
        name: 'No Smoking',
        frequencyType: 'negative',
      ));

      final dates = [
        DateTime.utc(2026, 1, 1),
        DateTime.utc(2026, 1, 2),
      ];

      await checker.confirmFailed(habitId, dates);

      final logs = await db.habitLogsDao.getAllLogs();
      expect(logs, hasLength(2));
      for (final log in logs) {
        expect(log.status, 'fail');
        expect(log.habitId, habitId);
      }
    });
  });
}
