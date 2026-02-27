import 'package:flutter_test/flutter_test.dart';
import 'package:rythm/core/database/enums.dart';
import 'package:rythm/features/garden/domain/generator/plant_params.dart';

import '../../../../fixtures/generation_params_fixtures.dart';

/// Helper to build a [GenerationParams] with only the fields under test.
GenerationParams _params({
  int absoluteCompletions = 0,
  int maxStreak = 0,
}) {
  return GenerationParams(
    archetype: SeedArchetype.oak,
    completionPct: 50.0,
    absoluteCompletions: absoluteCompletions,
    maxStreak: maxStreak,
    morningRatio: 0.33,
    afternoonRatio: 0.34,
    eveningRatio: 0.33,
    seed: 1,
    isShortPerfect: false,
  );
}

void main() {
  // ── scaleFactor ─────────────────────────────────────────────────

  group('GenerationParams.scaleFactor', () {
    test('absoluteCompletions=0 → clamped to 0.4', () {
      expect(_params(absoluteCompletions: 0).scaleFactor, closeTo(0.4, 1e-9));
    });

    test('absoluteCompletions=12 → clamped to 0.4', () {
      // 12 / 30 = 0.4 exactly
      expect(
        _params(absoluteCompletions: 12).scaleFactor,
        closeTo(0.4, 1e-9),
      );
    });

    test('absoluteCompletions=15 → 0.5', () {
      expect(
        _params(absoluteCompletions: 15).scaleFactor,
        closeTo(0.5, 1e-9),
      );
    });

    test('absoluteCompletions=30 → 1.0', () {
      expect(
        _params(absoluteCompletions: 30).scaleFactor,
        closeTo(1.0, 1e-9),
      );
    });

    test('absoluteCompletions=60 → clamped to 1.0', () {
      expect(
        _params(absoluteCompletions: 60).scaleFactor,
        closeTo(1.0, 1e-9),
      );
    });
  });

  // ── lushness ────────────────────────────────────────────────────

  group('GenerationParams.lushness', () {
    test('maxStreak=0 → clamped to 0.3', () {
      expect(_params(maxStreak: 0).lushness, closeTo(0.3, 1e-9));
    });

    test('maxStreak=6 → clamped to 0.3', () {
      // 6 / 20 = 0.3 exactly
      expect(_params(maxStreak: 6).lushness, closeTo(0.3, 1e-9));
    });

    test('maxStreak=10 → 0.5', () {
      expect(_params(maxStreak: 10).lushness, closeTo(0.5, 1e-9));
    });

    test('maxStreak=20 → 1.0', () {
      expect(_params(maxStreak: 20).lushness, closeTo(1.0, 1e-9));
    });

    test('maxStreak=40 → clamped to 1.0', () {
      expect(_params(maxStreak: 40).lushness, closeTo(1.0, 1e-9));
    });
  });

  // ── canvasSize ──────────────────────────────────────────────────

  group('GenerationParams.canvasSize', () {
    test('canvasSize is 800', () {
      expect(GenerationParams.canvasSize, equals(800.0));
    });
  });

  // ── center ──────────────────────────────────────────────────────

  group('GenerationParams.center', () {
    test('center is Offset(400, 680)', () {
      final p = _params();
      expect(p.center, equals(const Offset(400, 680)));
    });
  });

  // ── Fixtures ────────────────────────────────────────────────────

  group('generation_params_fixtures', () {
    test('allFixtures has 126 entries', () {
      expect(allFixtures, hasLength(126));
    });

    test('shortPerfectFixtures has 6 entries (one per archetype)', () {
      expect(shortPerfectFixtures, hasLength(6));

      // Each archetype should appear exactly once.
      final archetypes =
          shortPerfectFixtures.map((p) => p.archetype).toSet();
      expect(archetypes, equals(SeedArchetype.values.toSet()));
    });
  });
}
