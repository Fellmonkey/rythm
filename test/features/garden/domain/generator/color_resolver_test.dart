import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:rythm/features/garden/domain/generator/color_resolver.dart';

void main() {
  // ── Static color constants ──────────────────────────────────────

  group('ColorResolver static colors', () {
    test('trunkColorLight is correct', () {
      expect(ColorResolver.trunkColorLight, equals(const Color(0xFF8B6F47)));
    });

    test('mossGreen is correct', () {
      expect(ColorResolver.mossGreen, equals(const Color(0xFF7BA05B)));
    });
  });

  // ── leafColorAt ─────────────────────────────────────────────────

  group('ColorResolver.leafColorAt', () {
    test('t=0.0 with morningRatio=1.0 is weighted towards sageGreen', () {
      final color = ColorResolver.leafColorAt(
        0.0,
        morningRatio: 1.0,
        afternoonRatio: 0.0,
        eveningRatio: 0.0,
      );

      // sageGreen = 0xFF8FAF7A.
      // At t=0.0 the color is _blendWithWeight(morning, 1.0).
      // weight=1.0 → blend(neutral, sageGreen, 1.0) = sageGreen itself.
      const sageGreen = Color(0xFF8FAF7A);
      expect(color, equals(sageGreen));
    });

    test('t=1.0 with afternoonRatio=1.0 is weighted towards warmAmber', () {
      final color = ColorResolver.leafColorAt(
        1.0,
        morningRatio: 0.0,
        afternoonRatio: 1.0,
        eveningRatio: 0.0,
      );

      // At t=1.0 the color is _blendWithWeight(afternoon, 1.0).
      // weight=1.0 → blend(neutral, warmAmber, 1.0) = warmAmber itself.
      const warmAmber = Color(0xFFD4A767);
      expect(color, equals(warmAmber));
    });

    test('t=0.5 with eveningRatio=1.0 is weighted towards softLavender', () {
      final color = ColorResolver.leafColorAt(
        0.5,
        morningRatio: 0.0,
        afternoonRatio: 0.0,
        eveningRatio: 1.0,
      );

      // At t=0.5 (boundary: t < 0.5 is false, enters else branch).
      // localT = (0.5 - 0.5) * 2.0 = 0.0
      // c1 = _blendWithWeight(evening, 1.0) = softLavender
      // result = lerp(c1, c2, 0.0) = c1 = softLavender
      const softLavender = Color(0xFFB8A9D4);
      expect(color, equals(softLavender));
    });

    test('equal ratios produce a color distinct from any pure archetype', () {
      final color = ColorResolver.leafColorAt(
        0.0,
        morningRatio: 0.33,
        afternoonRatio: 0.33,
        eveningRatio: 0.33,
      );

      // With low weight the colors are blended towards neutral.
      // Result should not be exactly any of the pure archetype colors.
      const sageGreen = Color(0xFF8FAF7A);
      const warmAmber = Color(0xFFD4A767);
      const softLavender = Color(0xFFB8A9D4);

      expect(color, isNot(equals(sageGreen)));
      expect(color, isNot(equals(warmAmber)));
      expect(color, isNot(equals(softLavender)));
    });
  });

  // ── leafGradient ────────────────────────────────────────────────

  group('ColorResolver.leafGradient', () {
    test('returns exactly 3 colors', () {
      final gradient = ColorResolver.leafGradient(
        morningRatio: 0.5,
        afternoonRatio: 0.3,
        eveningRatio: 0.2,
      );
      expect(gradient, hasLength(3));
    });

    test('gradient[0] matches leafColorAt(0.0)', () {
      const mr = 0.6;
      const ar = 0.2;
      const er = 0.2;

      final gradient = ColorResolver.leafGradient(
        morningRatio: mr,
        afternoonRatio: ar,
        eveningRatio: er,
      );

      final expected = ColorResolver.leafColorAt(
        0.0,
        morningRatio: mr,
        afternoonRatio: ar,
        eveningRatio: er,
      );

      expect(gradient[0], equals(expected));
    });

    test('gradient[1] matches leafColorAt(0.5)', () {
      const mr = 0.6;
      const ar = 0.2;
      const er = 0.2;

      final gradient = ColorResolver.leafGradient(
        morningRatio: mr,
        afternoonRatio: ar,
        eveningRatio: er,
      );

      final expected = ColorResolver.leafColorAt(
        0.5,
        morningRatio: mr,
        afternoonRatio: ar,
        eveningRatio: er,
      );

      expect(gradient[1], equals(expected));
    });

    test('gradient[2] matches leafColorAt(1.0)', () {
      const mr = 0.6;
      const ar = 0.2;
      const er = 0.2;

      final gradient = ColorResolver.leafGradient(
        morningRatio: mr,
        afternoonRatio: ar,
        eveningRatio: er,
      );

      final expected = ColorResolver.leafColorAt(
        1.0,
        morningRatio: mr,
        afternoonRatio: ar,
        eveningRatio: er,
      );

      expect(gradient[2], equals(expected));
    });
  });
}
