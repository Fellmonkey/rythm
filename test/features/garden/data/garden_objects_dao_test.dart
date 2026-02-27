import 'package:flutter_test/flutter_test.dart';
import 'package:rythm/core/database/app_database.dart';

import '../../../fixtures/test_db.dart';
import '../../../fixtures/test_factories.dart';

void main() {
  late AppDatabase db;

  setUp(() async {
    db = createTestDatabase();
    // Insert habits for FK constraints
    await db.habitsDao.insertHabit(makeHabitCompanion(name: 'Habit 1'));
    await db.habitsDao.insertHabit(makeHabitCompanion(name: 'Habit 2'));
  });

  tearDown(() async {
    await db.close();
  });

  group('GardenObjectsDao', () {
    test('insert + getObjectsForMonth', () async {
      await db.gardenObjectsDao.insertObject(
        makeGardenObjectCompanion(habitId: 1, year: 2026, month: 1),
      );
      await db.gardenObjectsDao.insertObject(
        makeGardenObjectCompanion(habitId: 2, year: 2026, month: 1),
      );
      await db.gardenObjectsDao.insertObject(
        makeGardenObjectCompanion(habitId: 1, year: 2026, month: 2),
      );

      final janObjects = await db.gardenObjectsDao.getObjectsForMonth(2026, 1);
      expect(janObjects, hasLength(2));

      final febObjects = await db.gardenObjectsDao.getObjectsForMonth(2026, 2);
      expect(febObjects, hasLength(1));
    });

    test('getObjectForHabitMonth returns exact match or null', () async {
      await db.gardenObjectsDao.insertObject(
        makeGardenObjectCompanion(
          habitId: 1,
          year: 2026,
          month: 1,
          completionPct: 75.0,
        ),
      );

      final found =
          await db.gardenObjectsDao.getObjectForHabitMonth(1, 2026, 1);
      expect(found, isNotNull);
      expect(found!.completionPct, 75.0);

      final notFound =
          await db.gardenObjectsDao.getObjectForHabitMonth(1, 2026, 2);
      expect(notFound, isNull);
    });

    test('getAllObjects ordered year desc, month desc', () async {
      await db.gardenObjectsDao.insertObject(
        makeGardenObjectCompanion(habitId: 1, year: 2026, month: 1),
      );
      await db.gardenObjectsDao.insertObject(
        makeGardenObjectCompanion(habitId: 1, year: 2025, month: 12),
      );
      await db.gardenObjectsDao.insertObject(
        makeGardenObjectCompanion(habitId: 1, year: 2026, month: 3),
      );

      final all = await db.gardenObjectsDao.getAllObjects();
      expect(all, hasLength(3));
      // 2026/3 → 2026/1 → 2025/12
      expect(all[0].year, 2026);
      expect(all[0].month, 3);
      expect(all[1].year, 2026);
      expect(all[1].month, 1);
      expect(all[2].year, 2025);
      expect(all[2].month, 12);
    });

    test('updatePngPath', () async {
      final id = await db.gardenObjectsDao.insertObject(
        makeGardenObjectCompanion(habitId: 1, year: 2026, month: 1),
      );

      await db.gardenObjectsDao.updatePngPath(id, '/path/to/image.png');

      final obj =
          await db.gardenObjectsDao.getObjectForHabitMonth(1, 2026, 1);
      expect(obj!.pngPath, '/path/to/image.png');
    });

    test('deleteObjectsForHabit only deletes for that habit', () async {
      await db.gardenObjectsDao.insertObject(
        makeGardenObjectCompanion(habitId: 1, year: 2026, month: 1),
      );
      await db.gardenObjectsDao.insertObject(
        makeGardenObjectCompanion(habitId: 2, year: 2026, month: 1),
      );

      await db.gardenObjectsDao.deleteObjectsForHabit(1);

      final all = await db.gardenObjectsDao.getAllObjects();
      expect(all, hasLength(1));
      expect(all.first.habitId, 2);
    });

    test('deleteAllObjects', () async {
      await db.gardenObjectsDao.insertObject(
        makeGardenObjectCompanion(habitId: 1, year: 2026, month: 1),
      );
      await db.gardenObjectsDao.insertObject(
        makeGardenObjectCompanion(habitId: 2, year: 2026, month: 2),
      );

      await db.gardenObjectsDao.deleteAllObjects();

      expect(await db.gardenObjectsDao.getAllObjects(), isEmpty);
    });
  });
}
