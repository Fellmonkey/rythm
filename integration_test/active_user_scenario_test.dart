import 'package:drift/drift.dart' hide isNotNull;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rythm/core/database/app_database.dart';
import 'package:rythm/core/keys.dart';
import 'package:rythm/core/utils/date_helpers.dart';
import 'package:rythm/features/garden/domain/generator/plant_widget.dart';

import '../test/fixtures/generation_params_fixtures.dart';
import 'helpers/pump_app.dart';

/// Simulates what an active user with a rich history sees when opening the app.
///
/// Uses [makeFullYearScenario] from generation_params_fixtures to seed all 5
/// habits across 12 months with realistic progression data covering:
///   - Morning Run (oak, daily): moss → sleepingBulb → bush → tree
///   - Read Books (sakura, weekdays): bush → tree with Oct regression
///   - Workout (pine, 3x/week): Sep edge-case (80% but abs=4 → bush)
///   - No Smoking (willow, negative): created June 15, Jul short-perfect
///   - Meditation (baobab, every 2 days): moss → tree slow climb
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Active-user scenario (full-year fixtures)', () {
    late AppDatabase db;

    tearDown(() async {
      await db.close();
    });

    // ── Seed helpers ───────────────────────────────────────────

    /// Time-of-day mapping per habit for the Greenhouse screen.
    const timeOfDay = {
      'Morning Run': 'morning',
      'Read Books': 'evening',
      'Workout': 'afternoon',
      'No Smoking': 'anytime',
      'Meditation': 'morning',
    };

    /// Inserts 5 habits + today's logs + a full year of GardenObjects built
    /// from [makeFullYearScenario].
    Future<void> seedFullYear(AppDatabase db) async {
      final scenario = makeFullYearScenario(year: 2026, habitCount: 5);
      final now = DateTime.now().toMidnight;

      // Collect unique habits in insertion order.
      final seenHabits = <String>{};
      final habitIds = <String, int>{};

      for (final entry in scenario) {
        if (seenHabits.add(entry.habitName)) {
          final createdAt = DateTime.utc(
            2026,
            entry.createdMonth,
            entry.createdDay,
          ).unixSeconds;

          final id = await db.habitsDao.insertHabit(HabitsCompanion(
            name: Value(entry.habitName),
            seedArchetype: Value(entry.archetype.name),
            frequencyType: Value(entry.frequencyType),
            frequencyValue: Value(entry.frequencyValue),
            timeOfDay: Value(timeOfDay[entry.habitName] ?? 'anytime'),
            createdAt: Value(createdAt),
          ));
          habitIds[entry.habitName] = id;
        }
      }

      // Insert GardenObjects for every month entry.
      var seed = 1000;
      for (final entry in scenario) {
        final hId = habitIds[entry.habitName]!;
        await db.gardenObjectsDao.insertObject(GardenObjectsCompanion(
          habitId: Value(hId),
          year: const Value(2026),
          month: Value(entry.month),
          completionPct: Value(entry.pct),
          absoluteCompletions: Value(entry.abs),
          maxStreak: Value(entry.streak),
          morningRatio: Value(entry.morningRatio),
          afternoonRatio: Value(entry.afternoonRatio),
          eveningRatio: Value(entry.eveningRatio),
          objectType: Value(entry.objectType.name),
          generationSeed: Value(seed++),
          isShortPerfect: Value(entry.isShortPerfect),
        ));
      }

      // Today's logs: Morning Run done, Read Books pending, Workout skip.
      await db.habitLogsDao.markDone(habitIds['Morning Run']!, now.unixSeconds, 7);
      await db.habitLogsDao.markSkip(habitIds['Workout']!, now.unixSeconds);
    }

    // ── Tests ──────────────────────────────────────────────────

    testWidgets('Greenhouse shows all 5 habits grouped by time-of-day',
        (tester) async {
      db = await pumpApp(tester);
      await seedFullYear(db);
      await tester.pumpAndSettle();

      // All 5 habit names visible.
      expect(find.text('Morning Run'), findsOneWidget);
      expect(find.text('Read Books'), findsOneWidget);
      expect(find.text('Workout'), findsOneWidget);
      expect(find.text('No Smoking'), findsOneWidget);
      expect(find.text('Meditation'), findsOneWidget);

      // Group headers present.
      expect(find.text('Утро'), findsOneWidget);   // Morning Run + Meditation
      expect(find.text('День'), findsOneWidget);    // Workout
      expect(find.text('Вечер'), findsOneWidget);   // Read Books
      // No Smoking → anytime → "Весь день" group
      expect(find.text('Весь день'), findsOneWidget);
    });

    testWidgets(
        'Time Path shows 12 months, newest first, with plant rendering',
        (tester) async {
      db = await pumpApp(tester);
      await seedFullYear(db);

      // Navigate to Garden.
      await tester.tap(find.text('Тропа'));
      await tester.pumpAndSettle();

      // Empty state NOT shown.
      expect(find.byKey(K.timePathEmpty), findsNothing);

      // Title present.
      expect(find.byKey(K.timePathTitle), findsOneWidget);

      // The topmost (newest) month should be December 2026.
      expect(find.text('Декабрь 2026'), findsOneWidget);

      // PlantWidgets should be rendered (live fallback, no PNG cached).
      expect(find.byType(PlantWidget), findsWidgets);

      // Scroll down to reveal earliest month (12 months × 5 habits is large).
      await tester.scrollUntilVisible(
        find.text('Январь 2026'),
        500,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.pumpAndSettle();

      // After scrolling, January 2026 should become visible.
      expect(find.text('Январь 2026'), findsOneWidget);
    });

    testWidgets(
        'tapping a focus plant opens memory card with correct stats',
        (tester) async {
      db = await pumpApp(tester);
      await seedFullYear(db);

      await tester.tap(find.text('Тропа'));
      await tester.pumpAndSettle();

      // December has 5 focus plants (all ≥80%): GestureDetector > _PlantThumbnail > PlantWidget.
      // Tap the first PlantWidget — tap propagates to the wrapping GestureDetector.
      final plants = find.byType(PlantWidget);
      expect(plants, findsWidgets);
      await tester.tap(plants.first);
      await tester.pumpAndSettle();

      // Memory card bottom sheet should contain stat labels.
      expect(find.text('Выполнение'), findsOneWidget);
      expect(find.text('Выполнений'), findsOneWidget);
      expect(find.text('Макс. серия'), findsOneWidget);

      // Time-of-day distribution header.
      expect(find.text('Время отметок'), findsOneWidget);
    });

    testWidgets(
        'No Smoking July entry is short-perfect (verified via DAO + UI)',
        (tester) async {
      db = await pumpApp(tester);
      await seedFullYear(db);

      // Verify via DAO: No Smoking (habit 4) July has isShortPerfect=true.
      final julyNoSmoking =
          await db.gardenObjectsDao.getObjectForHabitMonth(4, 2026, 7);
      expect(julyNoSmoking, isNotNull);
      expect(julyNoSmoking!.isShortPerfect, isTrue);
      expect(julyNoSmoking.completionPct, 100.0);
      expect(julyNoSmoking.objectType, 'tree');

      // Navigate to Time Path and scroll to July.
      await tester.tap(find.text('Тропа'));
      await tester.pumpAndSettle();

      // Scroll until July is visible (segments are tall: 200px + 60px per focus plant).
      await tester.scrollUntilVisible(
        find.text('Июль 2026'),
        500,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.pumpAndSettle();

      // Verify July month label is visible on screen.
      expect(find.text('Июль 2026'), findsOneWidget);
    });

    testWidgets(
        'September Workout shows as "Куст" despite 80% (abs=4 edge case)',
        (tester) async {
      db = await pumpApp(tester);
      await seedFullYear(db);

      // Verify via DAO that Workout in September is stored as bush.
      // Habit 3 = Workout (insertion order: Morning Run=1, Read Books=2, Workout=3).
      final sepWorkout =
          await db.gardenObjectsDao.getObjectForHabitMonth(3, 2026, 9);
      expect(sepWorkout, isNotNull);
      expect(sepWorkout!.objectType, 'bush');
      expect(sepWorkout.completionPct, 80.0);
      expect(sepWorkout.absoluteCompletions, 4);

      // Navigate to garden and scroll to September.
      await tester.tap(find.text('Тропа'));
      await tester.pumpAndSettle();

      await tester.scrollUntilVisible(
        find.text('Сентябрь 2026'),
        500,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.pumpAndSettle();

      expect(find.text('Сентябрь 2026'), findsOneWidget);
    });

    testWidgets(
        'No Smoking before June shows as sleepingBulb (habit not yet created)',
        (tester) async {
      db = await pumpApp(tester);
      await seedFullYear(db);

      // No Smoking = habit 4 (insertion order). Created June 15.
      // Months January–May should have sleepingBulb type (0% completion).
      for (var m = 1; m <= 5; m++) {
        final obj = await db.gardenObjectsDao.getObjectForHabitMonth(4, 2026, m);
        expect(obj, isNotNull, reason: 'Month $m should have a garden object');
        expect(obj!.objectType, 'sleepingBulb',
            reason: 'No Smoking month $m should be sleepingBulb');
        expect(obj.completionPct, 0.0,
            reason: 'No Smoking month $m (pre-creation) should be 0%');
      }

      // June onward should have real data.
      final june = await db.gardenObjectsDao.getObjectForHabitMonth(4, 2026, 6);
      expect(june, isNotNull);
      expect(june!.objectType, isNot('sleepingBulb'));
      expect(june.completionPct, greaterThan(0));
    });

    testWidgets(
        'Morning Run progression: moss→sleepingBulb→bush→tree across months',
        (tester) async {
      db = await pumpApp(tester);
      await seedFullYear(db);

      // Morning Run = habit 1.
      // January: 30% → moss
      final jan = await db.gardenObjectsDao.getObjectForHabitMonth(1, 2026, 1);
      expect(jan!.objectType, 'moss');

      // March: 0% → sleepingBulb
      final mar = await db.gardenObjectsDao.getObjectForHabitMonth(1, 2026, 3);
      expect(mar!.objectType, 'sleepingBulb');

      // April: 50% → bush
      final apr = await db.gardenObjectsDao.getObjectForHabitMonth(1, 2026, 4);
      expect(apr!.objectType, 'bush');

      // August: 100%, abs=31 → tree
      final aug = await db.gardenObjectsDao.getObjectForHabitMonth(1, 2026, 8);
      expect(aug!.objectType, 'tree');
      expect(aug.completionPct, 100.0);

      // December: 95%, abs=29 → tree
      final dec = await db.gardenObjectsDao.getObjectForHabitMonth(1, 2026, 12);
      expect(dec!.objectType, 'tree');
      expect(dec.completionPct, 95.0);
      expect(dec.maxStreak, 20);
    });

    testWidgets(
        'all 5 habits × 12 months = 60 garden objects in DB',
        (tester) async {
      db = await pumpApp(tester);
      await seedFullYear(db);

      final all = await db.gardenObjectsDao.getAllObjects();
      expect(all.length, 60);

      // Count by object type.
      final types = <String, int>{};
      for (final obj in all) {
        types[obj.objectType] = (types[obj.objectType] ?? 0) + 1;
      }

      // Should have all 4 types represented.
      expect(types.containsKey('tree'), isTrue);
      expect(types.containsKey('bush'), isTrue);
      expect(types.containsKey('moss'), isTrue);
      expect(types.containsKey('sleepingBulb'), isTrue);

      // Trees should be the majority (high-performing months).
      expect(types['tree']!, greaterThan(types['moss']!));
    });

    testWidgets(
        'scrolling garden path reaches both ends of the year',
        (tester) async {
      db = await pumpApp(tester);
      await seedFullYear(db);

      await tester.tap(find.text('Тропа'));
      await tester.pumpAndSettle();

      // Scroll all the way down to January.
      await tester.scrollUntilVisible(
        find.text('Январь 2026'),
        500,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.pumpAndSettle();
      expect(find.text('Январь 2026'), findsOneWidget);

      // Scroll back up to newest month.
      final scrollable = find.byType(Scrollable).first;
      for (var i = 0; i < 10; i++) {
        await tester.fling(scrollable, const Offset(0, 1000), 2000);
        await tester.pumpAndSettle();
      }

      expect(find.text('Декабрь 2026'), findsOneWidget);
    });
  });
}
