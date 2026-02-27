import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:rythm/features/garden/domain/generator/l_system_engine.dart';

void main() {
  // ── expand ──────────────────────────────────────────────────────

  group('LSystemEngine.expand', () {
    test('depth=0 returns axiom unchanged', () {
      expect(
        LSystemEngine.expand('F', {'F': 'FF'}, 0),
        equals('F'),
      );
    });

    test('depth=1 with rule F→FF expands F to FF', () {
      expect(
        LSystemEngine.expand('F', {'F': 'FF'}, 1),
        equals('FF'),
      );
    });

    test('depth=2 with rule F→FF expands F to FFFF', () {
      expect(
        LSystemEngine.expand('F', {'F': 'FF'}, 2),
        equals('FFFF'),
      );
    });

    test('non-rule symbols pass through unchanged', () {
      expect(
        LSystemEngine.expand('F+G', {'F': 'FF'}, 1),
        equals('FF+G'),
      );
    });

    test('empty rules returns axiom unchanged', () {
      expect(
        LSystemEngine.expand('F+G', {}, 1),
        equals('F+G'),
      );
    });

    test('multiple rules applied simultaneously', () {
      final rules = {'F': 'FF', 'G': 'F+G'};
      expect(
        LSystemEngine.expand('FG', rules, 1),
        equals('FFF+G'),
      );
    });
  });

  // ── interpret ───────────────────────────────────────────────────

  group('LSystemEngine.interpret', () {
    test('single F produces exactly 1 segment', () {
      final segments = LSystemEngine.interpret(
        'F',
        stepLength: 10,
        angleIncrement: pi / 4,
      );
      expect(segments, hasLength(1));
    });

    test('FF produces 2 sequential segments', () {
      final segments = LSystemEngine.interpret(
        'FF',
        stepLength: 10,
        angleIncrement: pi / 4,
      );
      expect(segments, hasLength(2));

      // Second segment starts where first ends.
      expect(segments[1].x1, closeTo(segments[0].x2, 1e-9));
      expect(segments[1].y1, closeTo(segments[0].y2, 1e-9));
    });

    test('F+F produces 2 segments with a turn between them', () {
      const angle = pi / 4;
      final segments = LSystemEngine.interpret(
        'F+F',
        stepLength: 10,
        angleIncrement: angle,
      );
      expect(segments, hasLength(2));

      // Second segment starts where first ends.
      expect(segments[1].x1, closeTo(segments[0].x2, 1e-9));
      expect(segments[1].y1, closeTo(segments[0].y2, 1e-9));

      // First segment goes straight up (default angle = -pi/2).
      // After +, angle becomes -pi/2 + pi/4 = -pi/4.
      // Verify second segment heads in a different direction than first.
      final dx0 = segments[0].x2 - segments[0].x1;
      final dy0 = segments[0].y2 - segments[0].y1;
      final dx1 = segments[1].x2 - segments[1].x1;
      final dy1 = segments[1].y2 - segments[1].y1;

      final dir0 = atan2(dy0, dx0);
      final dir1 = atan2(dy1, dx1);

      // The directions should differ by the angle increment.
      expect((dir1 - dir0).abs(), closeTo(angle, 1e-9));
    });

    test('F[+F]F — push/pop produces 3 segments, '
        '3rd continues from position before branch', () {
      final segments = LSystemEngine.interpret(
        'F[+F]F',
        stepLength: 10,
        angleIncrement: pi / 4,
        startX: 0,
        startY: 0,
      );
      expect(segments, hasLength(3));

      // After the first F, the turtle is at (firstEnd).
      // The [ saves that state; +F draws a branch; ] pops back.
      // The third F should start from the same position as the first F ended.
      expect(segments[2].x1, closeTo(segments[0].x2, 1e-9));
      expect(segments[2].y1, closeTo(segments[0].y2, 1e-9));
    });

    test('thickness decays inside brackets', () {
      final segments = LSystemEngine.interpret(
        'F[F]',
        stepLength: 10,
        angleIncrement: pi / 4,
        startThickness: 8.0,
        thicknessDecay: 0.7,
      );
      expect(segments, hasLength(2));

      // First segment drawn before '[' has original thickness.
      expect(segments[0].thickness, closeTo(8.0, 1e-9));
      // Segment inside brackets has decayed thickness.
      expect(segments[1].thickness, closeTo(8.0 * 0.7, 1e-9));
    });

    test('depth increments inside brackets', () {
      final segments = LSystemEngine.interpret(
        'F[F]F',
        stepLength: 10,
        angleIncrement: pi / 4,
      );
      expect(segments, hasLength(3));

      expect(segments[0].depth, equals(0));
      expect(segments[1].depth, equals(1)); // inside [ ]
      expect(segments[2].depth, equals(0)); // after ]
    });

    test('empty string produces 0 segments', () {
      final segments = LSystemEngine.interpret(
        '',
        stepLength: 10,
        angleIncrement: pi / 4,
      );
      expect(segments, isEmpty);
    });

    test('determinism: same input without rng always produces same output', () {
      List<LSegment> run() => LSystemEngine.interpret(
            'F[+F]-F',
            stepLength: 10,
            angleIncrement: pi / 6,
            startX: 5,
            startY: 5,
          );

      final a = run();
      final b = run();

      expect(a.length, equals(b.length));
      for (var i = 0; i < a.length; i++) {
        expect(a[i].x1, equals(b[i].x1));
        expect(a[i].y1, equals(b[i].y1));
        expect(a[i].x2, equals(b[i].x2));
        expect(a[i].y2, equals(b[i].y2));
        expect(a[i].thickness, equals(b[i].thickness));
        expect(a[i].depth, equals(b[i].depth));
      }
    });

    test('reproducibility: same Random seed produces identical segments', () {
      List<LSegment> run() => LSystemEngine.interpret(
            'FF[+F][-F]F',
            stepLength: 10,
            angleIncrement: pi / 6,
            rng: Random(42),
          );

      final a = run();
      final b = run();

      expect(a.length, equals(b.length));
      for (var i = 0; i < a.length; i++) {
        expect(a[i].x1, equals(b[i].x1));
        expect(a[i].y1, equals(b[i].y1));
        expect(a[i].x2, equals(b[i].x2));
        expect(a[i].y2, equals(b[i].y2));
      }
    });
  });

  // ── LSegment computed properties ────────────────────────────────

  group('LSegment', () {
    test('midX is average of x1 and x2', () {
      const seg = LSegment(
        x1: 0, y1: 0, x2: 10, y2: 0, thickness: 1, depth: 0,
      );
      expect(seg.midX, equals(5.0));
    });

    test('midY is average of y1 and y2', () {
      const seg = LSegment(
        x1: 0, y1: 4, x2: 0, y2: 10, thickness: 1, depth: 0,
      );
      expect(seg.midY, equals(7.0));
    });

    test('length computed correctly for horizontal segment', () {
      const seg = LSegment(
        x1: 0, y1: 0, x2: 3, y2: 4, thickness: 1, depth: 0,
      );
      expect(seg.length, closeTo(5.0, 1e-9));
    });

    test('length is zero for point segment', () {
      const seg = LSegment(
        x1: 5, y1: 5, x2: 5, y2: 5, thickness: 1, depth: 0,
      );
      expect(seg.length, equals(0.0));
    });
  });
}
