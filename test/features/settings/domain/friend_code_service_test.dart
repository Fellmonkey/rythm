import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:rythm/features/settings/domain/friend_code_service.dart';

import '../../../fixtures/test_db.dart';
import '../../../fixtures/test_factories.dart';

void main() {
  group('FriendCodeService.decodeCode', () {
    test('valid code with RYTHM: prefix decodes to GuestGarden', () {
      // Build a valid code manually
      final service = _buildCodeManually(
        habitName: 'Test',
        archetype: 'oak',
        year: 2026,
        month: 1,
        pct: 85.0,
        withPrefix: true,
      );

      final result = FriendCodeService.decodeCode(service);
      expect(result, isNotNull);
      expect(result!.entries, hasLength(1));
      expect(result.entries.first.habitName, 'Test');
      expect(result.entries.first.completionPct, 85.0);
    });

    test('valid code without prefix also works', () {
      final code = _buildCodeManually(
        habitName: 'Test',
        archetype: 'oak',
        year: 2026,
        month: 1,
        pct: 50.0,
        withPrefix: false,
      );

      final result = FriendCodeService.decodeCode(code);
      expect(result, isNotNull);
      expect(result!.entries.first.completionPct, 50.0);
    });

    test('garbage string returns null', () {
      expect(FriendCodeService.decodeCode('not-valid-base64!!!'), isNull);
    });

    test('empty string returns null', () {
      expect(FriendCodeService.decodeCode(''), isNull);
    });
  });

  group('FriendCodeService round-trip', () {
    test('generateCode → decodeCode preserves all fields', () async {
      final db = createTestDatabase();

      final habitId = await db.habitsDao.insertHabit(
        makeHabitCompanion(name: 'Morning Run', seedArchetype: 'sakura'),
      );

      await db.gardenObjectsDao.insertObject(makeGardenObjectCompanion(
        habitId: habitId,
        year: 2026,
        month: 1,
        completionPct: 85.0,
        absoluteCompletions: 26,
        maxStreak: 15,
        morningRatio: 0.7,
        afternoonRatio: 0.2,
        eveningRatio: 0.1,
        objectType: 'tree',
        generationSeed: 42,
        isShortPerfect: false,
      ));

      final service = FriendCodeService(
        habitsDao: db.habitsDao,
        gardenObjectsDao: db.gardenObjectsDao,
      );

      final code = await service.generateCode();
      expect(code.startsWith('RYTHM:'), isTrue);

      final garden = FriendCodeService.decodeCode(code);
      expect(garden, isNotNull);
      expect(garden!.entries, hasLength(1));

      final e = garden.entries.first;
      expect(e.habitName, 'Morning Run');
      expect(e.archetype, 'sakura');
      expect(e.year, 2026);
      expect(e.month, 1);
      expect(e.completionPct, 85.0);
      expect(e.absoluteCompletions, 26);
      expect(e.maxStreak, 15);
      expect(e.morningRatio, 0.7);
      expect(e.afternoonRatio, 0.2);
      expect(e.eveningRatio, 0.1);
      expect(e.objectType, 'tree');
      expect(e.generationSeed, 42);
      expect(e.isShortPerfect, false);

      await db.close();
    });
  });

  group('qualifiesForCrossPollination', () {
    test('avg completion = 80.0 qualifies', () {
      final garden = GuestGarden(entries: [
        _entry(pct: 80.0),
        _entry(pct: 80.0),
      ]);
      expect(FriendCodeService.qualifiesForCrossPollination(garden), isTrue);
    });

    test('avg completion = 79.9 does not qualify', () {
      final garden = GuestGarden(entries: [
        _entry(pct: 79.9),
        _entry(pct: 79.9),
      ]);
      expect(FriendCodeService.qualifiesForCrossPollination(garden), isFalse);
    });

    test('empty entries returns false', () {
      final garden = GuestGarden(entries: []);
      expect(FriendCodeService.qualifiesForCrossPollination(garden), isFalse);
    });

    test('mixed entries averaging exactly 80.0 qualifies', () {
      final garden = GuestGarden(entries: [
        _entry(pct: 70.0),
        _entry(pct: 90.0),
      ]);
      expect(FriendCodeService.qualifiesForCrossPollination(garden), isTrue);
    });
  });

  group('GuestGarden.byMonth', () {
    test('groups entries correctly by (year, month)', () {
      final garden = GuestGarden(entries: [
        _entry(year: 2026, month: 1, habitName: 'A'),
        _entry(year: 2026, month: 1, habitName: 'B'),
        _entry(year: 2026, month: 2, habitName: 'C'),
      ]);

      final grouped = garden.byMonth;
      expect(grouped, hasLength(2));
      expect(grouped[(2026, 1)], hasLength(2));
      expect(grouped[(2026, 2)], hasLength(1));
    });
  });
}

/// Helper to create a GuestGardenEntry with minimal fields.
GuestGardenEntry _entry({
  String habitName = 'Test',
  String archetype = 'oak',
  int year = 2026,
  int month = 1,
  double pct = 50.0,
}) {
  return GuestGardenEntry(
    habitName: habitName,
    archetype: archetype,
    year: year,
    month: month,
    completionPct: pct,
    absoluteCompletions: 15,
    maxStreak: 5,
    morningRatio: 0.33,
    afternoonRatio: 0.33,
    eveningRatio: 0.34,
    objectType: 'bush',
    generationSeed: 42,
    isShortPerfect: false,
  );
}

/// Build a valid friend code string manually for testing decodeCode.
String _buildCodeManually({
  required String habitName,
  required String archetype,
  required int year,
  required int month,
  required double pct,
  required bool withPrefix,
}) {
  final payload = {
    'v': 1,
    'data': [
      {
        'habitName': habitName,
        'archetype': archetype,
        'year': year,
        'month': month,
        'pct': pct,
        'abs': 15,
        'streak': 5,
        'mR': 0.33,
        'aR': 0.33,
        'eR': 0.34,
        'type': 'bush',
        'seed': 42,
        'sp': false,
      }
    ],
  };

  final jsonStr = jsonEncode(payload);
  final encoded = base64Encode(utf8.encode(jsonStr));
  return withPrefix ? 'RYTHM:$encoded' : encoded;
}
