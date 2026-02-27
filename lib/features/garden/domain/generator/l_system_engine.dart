import 'dart:math';

/// L-System string rewriting engine.
///
/// Takes an axiom string and production rules, iterates them [depth] times,
/// then interprets the result into a list of [LSegment]s (line segments with
/// position, angle, thickness).
///
/// Standard L-System symbols:
/// - F: draw forward
/// - +: turn right by [angle]
/// - -: turn left by [angle]
/// - [: push state (position + angle)
/// - ]: pop state
class LSystemEngine {
  const LSystemEngine._();

  /// Expand the axiom string using the production rules for [depth] iterations.
  static String expand(
    String axiom,
    Map<String, String> rules,
    int depth,
  ) {
    var current = axiom;
    for (var i = 0; i < depth; i++) {
      final buf = StringBuffer();
      for (final ch in current.split('')) {
        buf.write(rules[ch] ?? ch);
      }
      current = buf.toString();
    }
    return current;
  }

  /// Interpret the L-System string into drawable segments.
  ///
  /// [stepLength] — distance per F command.
  /// [angleIncrement] — turn angle in radians.
  /// [startX], [startY] — starting position.
  /// [startAngle] — initial direction (radians, 0 = up, pi/2 = right).
  /// [thicknessDecay] — how much thickness reduces per branch push.
  /// [rng] — optional random number generator for variation.
  static List<LSegment> interpret(
    String lString, {
    required double stepLength,
    required double angleIncrement,
    double startX = 0,
    double startY = 0,
    double startAngle = -pi / 2, // Default: pointing up.
    double startThickness = 8.0,
    double thicknessDecay = 0.7,
    double lengthDecay = 0.85,
    Random? rng,
  }) {
    final segments = <LSegment>[];
    final stack = <_TurtleState>[];

    var x = startX;
    var y = startY;
    var angle = startAngle;
    var thickness = startThickness;
    var length = stepLength;
    var depth = 0;

    for (final ch in lString.split('')) {
      switch (ch) {
        case 'F':
          // Add slight random variation for organic feel
          final variation = rng != null ? (rng.nextDouble() - 0.5) * 0.15 : 0.0;
          final actualLength = length * (1.0 + variation);
          final actualAngle = angle + (rng != null ? (rng.nextDouble() - 0.5) * 0.08 : 0.0);

          final nx = x + cos(actualAngle) * actualLength;
          final ny = y + sin(actualAngle) * actualLength;

          segments.add(LSegment(
            x1: x,
            y1: y,
            x2: nx,
            y2: ny,
            thickness: thickness,
            depth: depth,
          ));

          x = nx;
          y = ny;

        case '+':
          angle += angleIncrement;

        case '-':
          angle -= angleIncrement;

        case '[':
          stack.add(_TurtleState(x, y, angle, thickness, length));
          thickness *= thicknessDecay;
          length *= lengthDecay;
          depth++;

        case ']':
          if (stack.isNotEmpty) {
            final state = stack.removeLast();
            x = state.x;
            y = state.y;
            angle = state.angle;
            thickness = state.thickness;
            length = state.length;
            depth--;
          }
      }
    }

    return segments;
  }
}

/// A single line segment produced by the L-System turtle.
class LSegment {
  const LSegment({
    required this.x1,
    required this.y1,
    required this.x2,
    required this.y2,
    required this.thickness,
    required this.depth,
  });

  final double x1, y1, x2, y2;
  final double thickness;
  final int depth;

  /// Midpoint of the segment.
  double get midX => (x1 + x2) / 2;
  double get midY => (y1 + y2) / 2;

  /// Length of the segment.
  double get length => sqrt(pow(x2 - x1, 2) + pow(y2 - y1, 2));
}

class _TurtleState {
  _TurtleState(this.x, this.y, this.angle, this.thickness, this.length);

  final double x, y, angle, thickness, length;
}
