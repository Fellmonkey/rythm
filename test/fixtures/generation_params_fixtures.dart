import 'package:rythm/core/database/enums.dart';
import 'package:rythm/features/garden/domain/generator/plant_params.dart';

// Re-export shared fixture data so existing tests keep working.
export 'package:rythm/core/debug/generation_fixtures.dart';

// ── Full-year scenario ─────────────────────────────────────

/// A single month entry in the full-year scenario.
class MonthScenarioEntry {
  const MonthScenarioEntry({
    required this.habitName,
    required this.archetype,
    required this.frequencyType,
    required this.frequencyValue,
    required this.month,
    required this.pct,
    required this.abs,
    required this.streak,
    required this.objectType,
    required this.morningRatio,
    required this.afternoonRatio,
    required this.eveningRatio,
    this.isShortPerfect = false,
    this.createdMonth = 1,
    this.createdDay = 1,
  });

  final String habitName;
  final SeedArchetype archetype;
  final String frequencyType;
  final String frequencyValue;
  final int month;
  final double pct;
  final int abs;
  final int streak;
  final GardenObjectType objectType;
  final double morningRatio;
  final double afternoonRatio;
  final double eveningRatio;
  final bool isShortPerfect;
  final int createdMonth;
  final int createdDay;
}

/// Build a full-year scenario for [year] with up to 5 habits.
///
/// Returns a flat list of month entries.
/// Use [habitCount] to limit (1–5). Extra habits beyond count are omitted.
List<MonthScenarioEntry> makeFullYearScenario({
  int year = 2026,
  int habitCount = 5,
}) {
  final entries = <MonthScenarioEntry>[];

  // Habit1: daily, oak
  //                   Jan   Feb   Mar   Apr   May   Jun   Jul   Aug   Sep   Oct   Nov   Dec
  final h1Pcts =     [30.0, 40.0,  0.0, 50.0, 60.0, 70.0, 75.0,100.0, 85.0, 80.0, 90.0, 95.0];
  final h1Abs  =     [   9,   11,    0,   15,   19,   21,   23,   31,   26,   25,   27,   29];
  final h1Streaks =  [   3,    5,    0,    7,    9,   11,   12,   31,   15,   13,   17,   20];
  final h1Types = [
    GardenObjectType.moss, GardenObjectType.bush, GardenObjectType.sleepingBulb,
    GardenObjectType.bush, GardenObjectType.bush, GardenObjectType.bush,
    GardenObjectType.bush, GardenObjectType.tree, GardenObjectType.tree,
    GardenObjectType.tree, GardenObjectType.tree, GardenObjectType.tree,
  ];

  if (habitCount >= 1) {
    for (var m = 1; m <= 12; m++) {
      entries.add(MonthScenarioEntry(
        habitName: 'Morning Run',
        archetype: SeedArchetype.oak,
        frequencyType: 'daily',
        frequencyValue: '{}',
        month: m,
        pct: h1Pcts[m - 1],
        abs: h1Abs[m - 1],
        streak: h1Streaks[m - 1],
        objectType: h1Types[m - 1],
        morningRatio: 0.8,
        afternoonRatio: 0.1,
        eveningRatio: 0.1,
      ));
    }
  }

  // Habit2: weekdays (Mon-Fri), sakura
  final h2Pcts =    [45.0, 50.0, 55.0, 60.0, 70.0, 80.0, 85.0, 90.0, 80.0, 75.0, 85.0, 90.0];
  final h2Abs =     [  10,   11,   12,   13,   15,   18,   19,   20,   18,   17,   19,   20];
  final h2Streaks = [   4,    5,    5,    6,    8,   10,   12,   14,   10,    9,   12,   14];
  final h2Types = [
    GardenObjectType.bush, GardenObjectType.bush, GardenObjectType.bush,
    GardenObjectType.bush, GardenObjectType.bush, GardenObjectType.tree,
    GardenObjectType.tree, GardenObjectType.tree, GardenObjectType.tree,
    GardenObjectType.bush, GardenObjectType.tree, GardenObjectType.tree,
  ];

  if (habitCount >= 2) {
    for (var m = 1; m <= 12; m++) {
      entries.add(MonthScenarioEntry(
        habitName: 'Read Books',
        archetype: SeedArchetype.sakura,
        frequencyType: 'weekdays',
        frequencyValue: '{"days":[1,2,3,4,5]}',
        month: m,
        pct: h2Pcts[m - 1],
        abs: h2Abs[m - 1],
        streak: h2Streaks[m - 1],
        objectType: h2Types[m - 1],
        morningRatio: 0.1,
        afternoonRatio: 0.2,
        eveningRatio: 0.7,
      ));
    }
  }

  // Habit3: 3x/week, pine — Sep edge case: 80% but abs=4 → bush
  final h3Pcts =    [60.0, 65.0, 70.0, 75.0, 80.0, 85.0, 90.0, 95.0, 80.0, 70.0, 85.0, 90.0];
  final h3Abs =     [   8,    9,   10,   10,   11,   12,   13,   13,    4,   10,   12,   13];
  final h3Streaks = [   3,    4,    5,    5,    6,    7,    8,    9,    3,    5,    7,    8];
  final h3Types = [
    GardenObjectType.bush, GardenObjectType.bush, GardenObjectType.bush,
    GardenObjectType.bush, GardenObjectType.tree, GardenObjectType.tree,
    GardenObjectType.tree, GardenObjectType.tree, GardenObjectType.bush,
    GardenObjectType.bush, GardenObjectType.tree, GardenObjectType.tree,
  ];

  if (habitCount >= 3) {
    for (var m = 1; m <= 12; m++) {
      entries.add(MonthScenarioEntry(
        habitName: 'Workout',
        archetype: SeedArchetype.pine,
        frequencyType: 'xPerWeek',
        frequencyValue: '{"x":3}',
        month: m,
        pct: h3Pcts[m - 1],
        abs: h3Abs[m - 1],
        streak: h3Streaks[m - 1],
        objectType: h3Types[m - 1],
        morningRatio: 0.3,
        afternoonRatio: 0.5,
        eveningRatio: 0.2,
      ));
    }
  }

  // Habit4: negative, willow — created June 15, Jul = short-perfect
  final h4Pcts =    [90.0, 85.0,100.0, 80.0, 75.0, 70.0,100.0, 85.0, 90.0, 95.0,100.0, 90.0];
  final h4Abs =     [  28,   24,   31,   24,   23,   11,   31,   26,   27,   29,   30,   28];
  final h4Streaks = [  15,   12,   31,   13,   11,    8,   31,   14,   16,   20,   30,   18];
  final h4Types = [
    GardenObjectType.tree, GardenObjectType.tree, GardenObjectType.tree,
    GardenObjectType.tree, GardenObjectType.bush, GardenObjectType.bush,
    GardenObjectType.tree, GardenObjectType.tree, GardenObjectType.tree,
    GardenObjectType.tree, GardenObjectType.tree, GardenObjectType.tree,
  ];
  // Habit4 created June 15 (month 6, day 15). Before June, habit doesn't exist
  // so only months 6–12 should produce real data.
  // We include all 12 months in the scenario but mark creation.

  if (habitCount >= 4) {
    for (var m = 1; m <= 12; m++) {
      entries.add(MonthScenarioEntry(
        habitName: 'No Smoking',
        archetype: SeedArchetype.willow,
        frequencyType: 'negative',
        frequencyValue: '{}',
        month: m,
        pct: m < 6 ? 0 : h4Pcts[m - 1],
        abs: m < 6 ? 0 : h4Abs[m - 1],
        streak: m < 6 ? 0 : h4Streaks[m - 1],
        objectType: m < 6 ? GardenObjectType.sleepingBulb : h4Types[m - 1],
        morningRatio: 0.33,
        afternoonRatio: 0.33,
        eveningRatio: 0.34,
        isShortPerfect: m == 7,
        createdMonth: 6,
        createdDay: 15,
      ));
    }
  }

  // Habit5: everyXDays (every 2 days), baobab
  final h5Pcts =    [20.0, 25.0, 30.0, 40.0, 50.0, 60.0, 70.0, 80.0, 75.0, 80.0, 85.0, 90.0];
  final h5Abs =     [   3,    4,    5,    6,    8,   10,   11,   13,   12,   13,   14,   14];
  final h5Streaks = [   2,    2,    3,    3,    4,    5,    6,    8,    6,    8,    9,   10];
  final h5Types = [
    GardenObjectType.moss, GardenObjectType.moss, GardenObjectType.moss,
    GardenObjectType.bush, GardenObjectType.bush, GardenObjectType.bush,
    GardenObjectType.bush, GardenObjectType.tree, GardenObjectType.bush,
    GardenObjectType.tree, GardenObjectType.tree, GardenObjectType.tree,
  ];

  if (habitCount >= 5) {
    for (var m = 1; m <= 12; m++) {
      entries.add(MonthScenarioEntry(
        habitName: 'Meditation',
        archetype: SeedArchetype.baobab,
        frequencyType: 'everyXDays',
        frequencyValue: '{"x":2}',
        month: m,
        pct: h5Pcts[m - 1],
        abs: h5Abs[m - 1],
        streak: h5Streaks[m - 1],
        objectType: h5Types[m - 1],
        morningRatio: 0.5,
        afternoonRatio: 0.3,
        eveningRatio: 0.2,
      ));
    }
  }

  return entries;
}

/// Convert a [MonthScenarioEntry] to [GenerationParams].
GenerationParams entryToParams(MonthScenarioEntry e, {int seed = 42}) {
  return GenerationParams(
    archetype: e.archetype,
    completionPct: e.pct,
    absoluteCompletions: e.abs,
    maxStreak: e.streak,
    morningRatio: e.morningRatio,
    afternoonRatio: e.afternoonRatio,
    eveningRatio: e.eveningRatio,
    seed: seed,
    isShortPerfect: e.isShortPerfect,
    objectType: e.objectType,
  );
}
