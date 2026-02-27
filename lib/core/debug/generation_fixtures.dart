import '../database/enums.dart';
import '../../features/garden/domain/generator/plant_params.dart';

// ── Completion levels ──────────────────────────────────────

/// A named completion tier used to build the fixture matrix.
class CompletionLevel {
  const CompletionLevel(this.name, this.pct, this.abs, this.streak, this.objectType);
  final String name;
  final double pct;
  final int abs;
  final int streak;
  final GardenObjectType objectType;
}

/// Five tiers from zero to high.
const completionLevels = [
  CompletionLevel('zero', 0, 0, 0, GardenObjectType.sleepingBulb),
  CompletionLevel('low', 20, 4, 2, GardenObjectType.moss),
  CompletionLevel('mid', 55, 15, 5, GardenObjectType.bush),
  CompletionLevel('threshold', 80, 5, 5, GardenObjectType.tree),
  CompletionLevel('high', 95, 28, 20, GardenObjectType.tree),
];

// ── Time distributions ─────────────────────────────────────

/// A named time-of-day distribution preset.
class TimeDistribution {
  const TimeDistribution(this.name, this.morning, this.afternoon, this.evening);
  final String name;
  final double morning;
  final double afternoon;
  final double evening;
}

/// Four presets: pure morning / afternoon / evening + mixed.
const timeDistributions = [
  TimeDistribution('morning', 1.0, 0.0, 0.0),
  TimeDistribution('afternoon', 0.0, 1.0, 0.0),
  TimeDistribution('evening', 0.0, 0.0, 1.0),
  TimeDistribution('mixed', 0.4, 0.35, 0.25),
];

// ── Fixture matrix ─────────────────────────────────────────

/// 6 archetypes × 5 levels × 4 distributions = 120 params
/// + 6 short-perfect (one per archetype) = **126 total**.
final List<GenerationParams> allFixtures = _buildMatrix();

List<GenerationParams> _buildMatrix() {
  final result = <GenerationParams>[];
  var seed = 1000;

  for (final archetype in SeedArchetype.values) {
    for (final level in completionLevels) {
      for (final dist in timeDistributions) {
        result.add(GenerationParams(
          archetype: archetype,
          completionPct: level.pct,
          absoluteCompletions: level.abs,
          maxStreak: level.streak,
          morningRatio: dist.morning,
          afternoonRatio: dist.afternoon,
          eveningRatio: dist.evening,
          seed: seed++,
          isShortPerfect: false,
          objectType: level.objectType,
        ));
      }
    }
    // Short-perfect fixture for each archetype.
    result.add(GenerationParams(
      archetype: archetype,
      completionPct: 100,
      absoluteCompletions: 5,
      maxStreak: 5,
      morningRatio: 0.4,
      afternoonRatio: 0.35,
      eveningRatio: 0.25,
      seed: seed++,
      isShortPerfect: true,
      objectType: GardenObjectType.tree,
    ));
  }

  return result;
}

// ── Helpers for lookup ─────────────────────────────────────

/// Fixtures filtered by [archetype].
List<GenerationParams> fixturesForArchetype(SeedArchetype archetype) =>
    allFixtures.where((p) => p.archetype == archetype).toList();

/// All short-perfect fixtures (one per archetype).
List<GenerationParams> get shortPerfectFixtures =>
    allFixtures.where((p) => p.isShortPerfect).toList();
