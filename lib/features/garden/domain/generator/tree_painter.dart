import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../../../../core/database/enums.dart';
import 'color_resolver.dart';
import 'plant_params.dart';

/// CustomPainter that renders trees using archetype-specific algorithms.
///
/// Each archetype uses a dedicated drawing method to produce a truly
/// distinct visual form:
/// - **Oak** — recursive fractal branching, wide dome canopy
/// - **Sakura** — curved bezier branches, pink blossom clusters, petals
/// - **Pine** — layered triangular tiers on a straight trunk
/// - **Willow** — upward branches with cascading drooping strands
/// - **Baobab** — massive bottle-shaped trunk (bezier outline)
/// - **Palm** — curved trunk with ring marks + radiating fronds
class TreePainter extends CustomPainter {
  TreePainter({required this.params});

  final GenerationParams params;

  // ────────────────────────────────────────────────────────────
  // Dispatch
  // ────────────────────────────────────────────────────────────

  @override
  void paint(Canvas canvas, Size size) {
    if (params.isShortPerfect) _drawAura(canvas, size);

    switch (params.archetype) {
      case SeedArchetype.oak:
        _paintOak(canvas, size);
      case SeedArchetype.sakura:
        _paintSakura(canvas, size);
      case SeedArchetype.pine:
        _paintPine(canvas, size);
      case SeedArchetype.willow:
        _paintWillow(canvas, size);
      case SeedArchetype.baobab:
        _paintBaobab(canvas, size);
      case SeedArchetype.palm:
        _paintPalm(canvas, size);
    }
  }

  @override
  bool shouldRepaint(TreePainter old) =>
      params.seed != old.params.seed ||
      params.completionPct != old.params.completionPct ||
      params.maxStreak != old.params.maxStreak ||
      params.archetype != old.params.archetype;

  // ────────────────────────────────────────────────────────────
  // Shared helpers
  // ────────────────────────────────────────────────────────────

  List<Color> get _leafColors => ColorResolver.leafGradient(
        morningRatio: params.morningRatio,
        afternoonRatio: params.afternoonRatio,
        eveningRatio: params.eveningRatio,
      );

  /// Tapered branch segment rendered as a filled trapezoid — looks far more
  /// natural than a constant-width stroke.
  void _drawTaperedBranch(
    Canvas canvas,
    double x1, double y1,
    double x2, double y2,
    double w1, double w2,
    Color color,
  ) {
    final dx = x2 - x1;
    final dy = y2 - y1;
    final len = sqrt(dx * dx + dy * dy);
    if (len < 0.5) return;

    final nx = -dy / len;
    final ny = dx / len;

    final path = Path()
      ..moveTo(x1 + nx * w1 / 2, y1 + ny * w1 / 2)
      ..lineTo(x2 + nx * w2 / 2, y2 + ny * w2 / 2)
      ..lineTo(x2 - nx * w2 / 2, y2 - ny * w2 / 2)
      ..lineTo(x1 - nx * w1 / 2, y1 - ny * w1 / 2)
      ..close();

    canvas.drawPath(
      path,
      Paint()
        ..color = color
        ..style = PaintingStyle.fill,
    );
  }

  /// Horizontal bark-texture lines across a segment.
  void _drawBarkLines(Canvas canvas, double x1, double y1, double x2,
      double y2, double width, Random rng) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.6
      ..color = ColorResolver.trunkColorDark.withValues(alpha: 0.25);

    final dx = x2 - x1;
    final dy = y2 - y1;
    final len = sqrt(dx * dx + dy * dy);
    if (len < 5) return;

    final nx = -dy / len;
    final ny = dx / len;

    final n = (len / 8).round().clamp(2, 12);
    for (var i = 0; i < n; i++) {
      final t = (i + 0.5) / n;
      final mx = x1 + dx * t;
      final my = y1 + dy * t;
      final w = width * (1 - t * 0.35) * 0.35;
      canvas.drawLine(
        Offset(mx + nx * w, my + ny * w),
        Offset(mx - nx * w, my - ny * w),
        paint,
      );
    }
  }

  /// Overlapping soft ovals forming a leaf cluster.
  void _drawLeafCluster(Canvas canvas, double cx, double cy, double radius,
      Color color, Random rng, int count) {
    final paint = Paint()..style = PaintingStyle.fill;
    for (var i = 0; i < count; i++) {
      final ox = (rng.nextDouble() - 0.5) * radius * 1.4;
      final oy = (rng.nextDouble() - 0.5) * radius * 1.2;
      final r = radius * (0.4 + rng.nextDouble() * 0.5);
      paint.color = color.withValues(alpha: 0.45 + rng.nextDouble() * 0.45);
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(cx + ox, cy + oy),
          width: r * 2,
          height: r * (1.2 + rng.nextDouble() * 0.6),
        ),
        paint,
      );
    }
  }

  void _drawAura(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height * 0.85);
    final glowPaint = Paint()
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 30)
      ..shader = ui.Gradient.radial(
        center,
        size.width * 0.35,
        [const Color(0x40FFD700), const Color(0x00FFD700)],
      );
    canvas.drawCircle(center, size.width * 0.35, glowPaint);
  }

  /// Trunk drawn as a chain of small tapered segments following a
  /// quadratic bezier — gives a natural curve.
  void _drawCurvedTrunk(Canvas canvas, double x1, double y1, double x2,
      double y2, double width, Random rng,
      {double curveAmount = 1.0}) {
    const segs = 10;
    final ctrlX =
        (x1 + x2) / 2 + (rng.nextDouble() - 0.5) * width * curveAmount * 2;
    final ctrlY = (y1 + y2) / 2;

    for (var i = 0; i < segs; i++) {
      final t1 = i / segs;
      final t2 = (i + 1) / segs;
      final px1 = _qBez(x1, ctrlX, x2, t1);
      final py1 = _qBez(y1, ctrlY, y2, t1);
      final px2 = _qBez(x1, ctrlX, x2, t2);
      final py2 = _qBez(y1, ctrlY, y2, t2);

      final w1 = width * (1 - t1 * 0.4);
      final w2 = width * (1 - t2 * 0.4);
      _drawTaperedBranch(
        canvas, px1, py1, px2, py2, w1, w2,
        Color.lerp(ColorResolver.trunkColorDark, ColorResolver.trunkColorLight,
            t1 * 0.4)!,
      );
    }
  }

  // ── Bezier helpers ─────────────────────────────────

  double _qBez(double p0, double p1, double p2, double t) =>
      (1 - t) * (1 - t) * p0 + 2 * (1 - t) * t * p1 + t * t * p2;

  double _qBezDeriv(double p0, double p1, double p2, double t) =>
      2 * (1 - t) * (p1 - p0) + 2 * t * (p2 - p1);

  double _cBez(double p0, double p1, double p2, double p3, double t) {
    final u = 1 - t;
    return u * u * u * p0 +
        3 * u * u * t * p1 +
        3 * u * t * t * p2 +
        t * t * t * p3;
  }

  // ══════════════════════════════════════════════════════════
  //  OAK — recursive fractal branching, wide dome canopy
  // ══════════════════════════════════════════════════════════

  void _paintOak(Canvas canvas, Size size) {
    final rng = Random(params.seed);
    final s = params.scaleFactor;
    final l = params.lushness;

    final cx = size.width / 2;
    final baseY = size.height * 0.88;
    final trunkH = size.height * 0.28 * s;
    final trunkW = 14.0 * s;

    final topX = cx + (rng.nextDouble() - 0.5) * 8 * s;
    final topY = baseY - trunkH;

    // Trunk with mild natural curve
    _drawCurvedTrunk(canvas, cx, baseY, topX, topY, trunkW, rng);
    _drawBarkLines(canvas, cx, baseY, topX, topY, trunkW, rng);

    // Exposed roots
    _drawRoots(canvas, cx, baseY, trunkW, rng, s);

    // Collect leaf tip positions via recursive branching
    final tips = <Offset>[];
    final numMajor = 2 + rng.nextInt(2);
    for (var i = 0; i < numMajor; i++) {
      final a = -pi / 2 +
          (i - (numMajor - 1) / 2) * 0.65 +
          (rng.nextDouble() - 0.5) * 0.15;
      _oakBranch(canvas, topX, topY, a, trunkH * 0.55, trunkW * 0.50, 0,
          3 + (l * 2).round(), rng, s, tips);
    }

    // Draw dome canopy from collected leaf tips
    final leafR = (6.0 + l * 12.0) * s;
    final colors = _leafColors;
    for (final tip in tips) {
      final c = colors[rng.nextInt(colors.length)];
      _drawLeafCluster(
          canvas, tip.dx, tip.dy, leafR, c, rng, (2 + l * 3).round());
    }

    // Soft shadow under canopy
    if (tips.isNotEmpty) {
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(cx, topY + 4 * s),
          width: leafR * 4,
          height: leafR * 1.4,
        ),
        Paint()
          ..color = const Color(0x14000000)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6),
      );
    }
  }

  void _oakBranch(Canvas canvas, double x, double y, double angle,
      double length, double thick, int depth, int maxD, Random rng, double s,
      List<Offset> tips) {
    if (depth >= maxD || thick < 0.8) return;

    final a = angle + (rng.nextDouble() - 0.5) * 0.12;
    final len = length * (0.95 + (rng.nextDouble() - 0.5) * 0.1);
    final ex = x + cos(a) * len;
    final ey = y + sin(a) * len;

    final c = Color.lerp(ColorResolver.trunkColorDark,
        ColorResolver.trunkColorLight, (depth / maxD).clamp(0.0, 0.8))!;
    _drawTaperedBranch(canvas, x, y, ex, ey, thick, thick * 0.65, c);

    if (depth >= maxD - 2) tips.add(Offset(ex, ey));

    // Gnarled knot at fork
    if (depth >= 1 && depth < maxD - 1 && rng.nextDouble() > 0.6) {
      canvas.drawCircle(
        Offset(ex, ey),
        thick * 0.38,
        Paint()
          ..color = ColorResolver.trunkColorDark.withValues(alpha: 0.3)
          ..style = PaintingStyle.fill,
      );
    }

    final nc = depth < 2 ? 2 + rng.nextInt(2) : 1 + rng.nextInt(2);
    for (var i = 0; i < nc; i++) {
      final ca = a + (i - (nc - 1) / 2) * (0.38 + rng.nextDouble() * 0.2);
      _oakBranch(canvas, ex, ey, ca, length * (0.58 + rng.nextDouble() * 0.12),
          thick * (0.55 + rng.nextDouble() * 0.1), depth + 1, maxD, rng, s, tips);
    }
  }

  void _drawRoots(Canvas canvas, double cx, double baseY, double trunkW,
      Random rng, double scale) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..color = ColorResolver.trunkColorDark.withValues(alpha: 0.50);

    final numRoots = 3 + rng.nextInt(3);
    for (var i = 0; i < numRoots; i++) {
      final side = rng.nextBool() ? -1.0 : 1.0;
      paint.strokeWidth = trunkW * (0.12 + rng.nextDouble() * 0.12);
      final rootLen = trunkW * (0.8 + rng.nextDouble() * 1.2);
      final path = Path()
        ..moveTo(cx + side * trunkW * 0.15, baseY)
        ..quadraticBezierTo(
          cx + side * rootLen * 0.6,
          baseY + rootLen * 0.15,
          cx + side * rootLen,
          baseY + rootLen * 0.04,
        );
      canvas.drawPath(path, paint);
    }
  }

  // ══════════════════════════════════════════════════════════
  //  SAKURA — curved bezier branches, cherry blossoms, petals
  // ══════════════════════════════════════════════════════════

  void _paintSakura(Canvas canvas, Size size) {
    final rng = Random(params.seed);
    final s = params.scaleFactor;
    final l = params.lushness;

    final cx = size.width / 2;
    final baseY = size.height * 0.88;
    final trunkH = size.height * 0.32 * s;
    final trunkW = 10.0 * s;

    // Slightly leaning trunk
    final lean = (rng.nextDouble() - 0.5) * 14 * s;
    final topX = cx + lean;
    final topY = baseY - trunkH;
    _drawCurvedTrunk(canvas, cx, baseY, topX, topY, trunkW, rng);

    final blossomPts = <Offset>[];

    // Graceful curved branches
    final nb = 3 + rng.nextInt(3);
    for (var i = 0; i < nb; i++) {
      final a = -pi / 2 +
          (i - (nb - 1) / 2) * 0.55 +
          (rng.nextDouble() - 0.5) * 0.2;
      _sakuraBranch(canvas, topX, topY, a, trunkH * 0.50, trunkW * 0.38, 0,
          3 + (l * 2).round(), rng, s, blossomPts);
    }

    // Draw blossom clusters at collected positions
    for (final p in blossomPts) {
      _drawBlossomCluster(canvas, p.dx, p.dy, (5 + l * 9) * s, rng);
    }

    // Falling petals
    _drawFallingPetals(canvas, size, (4 + l * 12).round(), rng, s);
  }

  void _sakuraBranch(Canvas canvas, double x, double y, double angle,
      double length, double thick, int depth, int maxD, Random rng, double s,
      List<Offset> blossoms) {
    if (depth >= maxD || thick < 0.6) return;

    // Curved segment via two halves with curve offset
    final curve = (rng.nextDouble() - 0.5) * 0.3;
    final midA = angle + curve;
    final midX = x + cos(midA) * length * 0.5;
    final midY = y + sin(midA) * length * 0.5;
    final endA = angle + curve * 0.4;
    final ex = midX + cos(endA) * length * 0.5;
    final ey = midY + sin(endA) * length * 0.5;

    final c = Color.lerp(ColorResolver.trunkColorDark,
        const Color(0xFF8B7355), (depth / maxD).clamp(0.0, 1.0))!;
    _drawTaperedBranch(canvas, x, y, midX, midY, thick, thick * 0.8, c);
    _drawTaperedBranch(
        canvas, midX, midY, ex, ey, thick * 0.8, thick * 0.55, c);

    if (depth >= maxD - 2) {
      blossoms.add(Offset(ex, ey));
      if (rng.nextDouble() > 0.35) blossoms.add(Offset(midX, midY));
    }

    final nc = 1 + rng.nextInt(2);
    for (var i = 0; i < nc; i++) {
      final ca =
          endA + (i - (nc - 1) / 2) * 0.45 + (rng.nextDouble() - 0.5) * 0.2;
      _sakuraBranch(canvas, ex, ey, ca,
          length * (0.58 + rng.nextDouble() * 0.1), thick * 0.52,
          depth + 1, maxD, rng, s, blossoms);
    }
  }

  void _drawBlossomCluster(
      Canvas canvas, double cx, double cy, double size, Random rng) {
    final paint = Paint()..style = PaintingStyle.fill;
    final count = 5 + rng.nextInt(7);

    for (var i = 0; i < count; i++) {
      final ox = (rng.nextDouble() - 0.5) * size * 2;
      final oy = (rng.nextDouble() - 0.5) * size * 2;
      final r = size * (0.2 + rng.nextDouble() * 0.35);

      final petalColor = Color.lerp(
        const Color(0xFFFFB7C5),
        const Color(0xFFFFE4EC),
        rng.nextDouble(),
      )!;

      // 5-petal flower: overlapping rotated ovals
      final fc = Offset(cx + ox, cy + oy);
      for (var p = 0; p < 5; p++) {
        final pa = p * (2 * pi / 5) + rng.nextDouble() * 0.3;
        final pr = r * 0.45;
        paint.color =
            petalColor.withValues(alpha: 0.40 + rng.nextDouble() * 0.45);
        canvas.drawOval(
          Rect.fromCenter(
            center: Offset(fc.dx + cos(pa) * pr, fc.dy + sin(pa) * pr),
            width: r * 0.7,
            height: r * 0.5,
          ),
          paint,
        );
      }
      // Yellow stamen center
      paint.color = const Color(0xFFFFF176).withValues(alpha: 0.65);
      canvas.drawCircle(fc, r * 0.12, paint);
    }
  }

  void _drawFallingPetals(
      Canvas canvas, Size size, int count, Random rng, double scale) {
    final paint = Paint()..style = PaintingStyle.fill;
    for (var i = 0; i < count; i++) {
      final x = size.width * 0.12 + rng.nextDouble() * size.width * 0.76;
      final y = size.height * 0.15 + rng.nextDouble() * size.height * 0.65;
      final r = (1.5 + rng.nextDouble() * 3) * scale;
      final rot = rng.nextDouble() * pi;

      paint.color = Color.lerp(
        const Color(0xFFFFB7C5),
        const Color(0xFFFFD9E3),
        rng.nextDouble(),
      )!
          .withValues(alpha: 0.20 + rng.nextDouble() * 0.35);

      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(rot);
      canvas.drawOval(
        Rect.fromCenter(center: Offset.zero, width: r * 2, height: r),
        paint,
      );
      canvas.restore();
    }
  }

  // ══════════════════════════════════════════════════════════
  //  PINE — conical tiered silhouette with needle texture
  // ══════════════════════════════════════════════════════════

  void _paintPine(Canvas canvas, Size size) {
    final rng = Random(params.seed);
    final s = params.scaleFactor;
    final l = params.lushness;

    final cx = size.width / 2;
    final baseY = size.height * 0.88;
    final treeH = size.height * 0.72 * s;
    final trunkW = 8.0 * s;
    final topY = baseY - treeH;

    // Straight trunk
    _drawTaperedBranch(canvas, cx, baseY, cx, topY, trunkW, trunkW * 0.35,
        ColorResolver.trunkColorDark);
    _drawBarkLines(canvas, cx, baseY, cx, topY, trunkW, rng);

    // Layered triangular foliage tiers — classic conical pine silhouette
    final numTiers = (5 + l * 4).round();
    final maxCanopyW = size.width * 0.38 * s;
    final foliageBottom = baseY - treeH * 0.15;
    final foliageTop = topY - treeH * 0.04;
    final colors = _leafColors;

    for (var tier = 0; tier < numTiers; tier++) {
      final t = tier / numTiers;
      final tierY = foliageBottom + (foliageTop - foliageBottom) * t;
      final tierW = maxCanopyW * (1 - t * 0.88);
      final tierH = treeH * 0.14 * (1 - t * 0.3);
      final ox = (rng.nextDouble() - 0.5) * 4 * s;

      // Shadow layer (darker, slightly offset)
      canvas.drawPath(
        Path()
          ..moveTo(cx + ox - tierW * 0.48, tierY + tierH * 0.25)
          ..lineTo(cx + ox, tierY - tierH * 0.75)
          ..lineTo(cx + ox + tierW * 0.48, tierY + tierH * 0.25)
          ..close(),
        Paint()
          ..color = colors[0].withValues(alpha: 0.25)
          ..style = PaintingStyle.fill,
      );

      // Main foliage triangle
      final foliagePath = Path()
        ..moveTo(cx + ox - tierW * 0.5, tierY + tierH * 0.2)
        ..lineTo(cx + ox, tierY - tierH * 0.8)
        ..lineTo(cx + ox + tierW * 0.5, tierY + tierH * 0.2)
        ..close();

      final foliageColor =
          colors[tier % colors.length].withValues(alpha: 0.55 + l * 0.35);
      canvas.drawPath(
        foliagePath,
        Paint()
          ..color = foliageColor
          ..style = PaintingStyle.fill,
      );

      // Needle texture: small darker strokes inside the triangle
      final needlePaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.8 * s
        ..strokeCap = StrokeCap.round;
      final needleCount = (3 + l * 5).round();
      for (var n = 0; n < needleCount; n++) {
        // Random point inside triangle (barycentric coords)
        final r1 = rng.nextDouble();
        final r2 = rng.nextDouble();
        final sqrtR1 = sqrt(r1);
        final px = (1 - sqrtR1) * (cx + ox - tierW * 0.5) +
            sqrtR1 * (1 - r2) * (cx + ox) +
            sqrtR1 * r2 * (cx + ox + tierW * 0.5);
        final py = (1 - sqrtR1) * (tierY + tierH * 0.2) +
            sqrtR1 * (1 - r2) * (tierY - tierH * 0.8) +
            sqrtR1 * r2 * (tierY + tierH * 0.2);

        needlePaint.color = Color.lerp(foliageColor,
            ColorResolver.trunkColorDark, 0.3 + rng.nextDouble() * 0.2)!;
        final nLen = (3 + rng.nextDouble() * 5) * s;
        final nAngle = -pi / 2 + (rng.nextDouble() - 0.5) * 0.6;
        canvas.drawLine(
          Offset(px, py),
          Offset(px + cos(nAngle) * nLen, py + sin(nAngle) * nLen),
          needlePaint,
        );
      }
    }

    // Top tuft
    final topColor = colors[1].withValues(alpha: 0.8);
    canvas.drawPath(
      Path()
        ..moveTo(cx, foliageTop - treeH * 0.06)
        ..lineTo(cx - 5 * s, foliageTop + 3 * s)
        ..lineTo(cx + 5 * s, foliageTop + 3 * s)
        ..close(),
      Paint()
        ..color = topColor
        ..style = PaintingStyle.fill,
    );
  }

  // ══════════════════════════════════════════════════════════
  //  WILLOW — cascading curtain of drooping strands
  // ══════════════════════════════════════════════════════════

  void _paintWillow(Canvas canvas, Size size) {
    final rng = Random(params.seed);
    final s = params.scaleFactor;
    final l = params.lushness;

    final cx = size.width / 2;
    final baseY = size.height * 0.88;
    final trunkH = size.height * 0.30 * s;
    final trunkW = 10.0 * s;

    final topX = cx + (rng.nextDouble() - 0.5) * 6 * s;
    final topY = baseY - trunkH;

    _drawCurvedTrunk(canvas, cx, baseY, topX, topY, trunkW, rng);
    _drawBarkLines(canvas, cx, baseY, topX, topY, trunkW, rng);

    // Main upward branches
    final nb = 5 + rng.nextInt(4);
    final branchLen = trunkH * 0.45;
    for (var i = 0; i < nb; i++) {
      final angle = -pi / 2 +
          (i - (nb - 1) / 2) * 0.38 +
          (rng.nextDouble() - 0.5) * 0.12;
      final bLen = branchLen * (0.55 + rng.nextDouble() * 0.45);
      final bx = topX + cos(angle) * bLen;
      final by = topY + sin(angle) * bLen;
      final bThick = trunkW * (0.28 + rng.nextDouble() * 0.12);

      _drawTaperedBranch(canvas, topX, topY, bx, by, bThick, bThick * 0.5,
          ColorResolver.trunkColorLight);

      // Cascading strands from branch tip
      final ns = (5 + l * 9).round();
      for (var j = 0; j < ns; j++) {
        _drawWillowStrand(canvas, bx, by, rng, s, l);
      }
    }
  }

  void _drawWillowStrand(Canvas canvas, double sx, double sy, Random rng,
      double scale, double lushness) {
    final colors = _leafColors;
    final strandLen = (25 + rng.nextDouble() * 55) * scale;
    final swayX = (rng.nextDouble() - 0.5) * 28 * scale;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = (0.8 + rng.nextDouble() * 0.8) * scale
      ..strokeCap = StrokeCap.round
      ..color = colors[rng.nextInt(colors.length)]
          .withValues(alpha: 0.22 + rng.nextDouble() * 0.35);

    canvas.drawPath(
      Path()
        ..moveTo(sx, sy)
        ..cubicTo(
          sx + swayX * 0.3,
          sy + strandLen * 0.25,
          sx + swayX * 0.8,
          sy + strandLen * 0.65,
          sx + swayX * 0.7,
          sy + strandLen,
        ),
      paint,
    );

    // Small oval leaves along the strand
    if (lushness > 0.4) {
      final leafPaint = Paint()..style = PaintingStyle.fill;
      final nl = (2 + lushness * 4).round();
      for (var k = 0; k < nl; k++) {
        final t = (k + 1) / (nl + 1);
        final lx = sx + swayX * t * 0.7 + (rng.nextDouble() - 0.5) * 3;
        final ly = sy + strandLen * t;
        leafPaint.color = colors[rng.nextInt(colors.length)]
            .withValues(alpha: 0.30 + rng.nextDouble() * 0.40);
        canvas.drawOval(
          Rect.fromCenter(
            center: Offset(lx, ly),
            width: 3 * scale,
            height: 5.5 * scale,
          ),
          leafPaint,
        );
      }
    }
  }

  // ══════════════════════════════════════════════════════════
  //  BAOBAB — massive bottle-shaped trunk, stubby crown
  // ══════════════════════════════════════════════════════════

  void _paintBaobab(Canvas canvas, Size size) {
    final rng = Random(params.seed);
    final s = params.scaleFactor;
    final l = params.lushness;

    final cx = size.width / 2;
    final baseY = size.height * 0.88;
    final treeH = size.height * 0.62 * s;
    final topY = baseY - treeH;

    final baseW = 22.0 * s;
    final bulgeW = 32.0 * s;
    final topW = 15.0 * s;
    final bulgeY = baseY - treeH * 0.42;

    // Build bottle-shaped trunk outline (cubic bezier silhouette)
    final trunkPath = Path();

    // Left edge
    trunkPath.moveTo(cx - baseW / 2, baseY);
    trunkPath.cubicTo(
      cx - baseW / 2 - 3 * s, baseY - treeH * 0.18,
      cx - bulgeW / 2, bulgeY + treeH * 0.12,
      cx - bulgeW / 2, bulgeY,
    );
    trunkPath.cubicTo(
      cx - bulgeW / 2, bulgeY - treeH * 0.14,
      cx - topW / 2 - 2 * s, topY + treeH * 0.1,
      cx - topW / 2, topY,
    );

    trunkPath.lineTo(cx + topW / 2, topY);

    // Right edge (mirror)
    trunkPath.cubicTo(
      cx + topW / 2 + 2 * s, topY + treeH * 0.1,
      cx + bulgeW / 2, bulgeY - treeH * 0.14,
      cx + bulgeW / 2, bulgeY,
    );
    trunkPath.cubicTo(
      cx + bulgeW / 2, bulgeY + treeH * 0.12,
      cx + baseW / 2 + 3 * s, baseY - treeH * 0.18,
      cx + baseW / 2, baseY,
    );
    trunkPath.close();

    // Gradient fill for 3D roundness
    canvas.drawPath(
      trunkPath,
      Paint()
        ..style = PaintingStyle.fill
        ..shader = ui.Gradient.linear(
          Offset(cx - bulgeW / 2, 0),
          Offset(cx + bulgeW / 2, 0),
          [
            ColorResolver.trunkColorDark,
            ColorResolver.trunkColorLight,
            ColorResolver.trunkColorLight,
            ColorResolver.trunkColorDark,
          ],
          [0.0, 0.35, 0.65, 1.0],
        ),
    );

    // Subtle outline
    canvas.drawPath(
      trunkPath,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.8
        ..color = ColorResolver.trunkColorDark.withValues(alpha: 0.30),
    );

    // Horizontal bark creases
    final barkPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.7
      ..color = ColorResolver.trunkColorDark.withValues(alpha: 0.18);
    for (var i = 0; i < 10; i++) {
      final t = 0.08 + i * 0.08;
      final ly = baseY - treeH * t;
      final halfW = _baobabHalfWidth(t, baseW, bulgeW, topW) * 0.82;
      final waviness = (rng.nextDouble() - 0.5) * 3 * s;
      canvas.drawLine(
        Offset(cx - halfW + waviness, ly),
        Offset(cx + halfW - waviness, ly),
        barkPaint,
      );
    }

    // Short stubby branches at crown
    final nb = 4 + rng.nextInt(3);
    final colors = _leafColors;
    for (var i = 0; i < nb; i++) {
      final angle = -pi / 2 +
          (i - (nb - 1) / 2) * 0.6 +
          (rng.nextDouble() - 0.5) * 0.35;
      final bLen = treeH * (0.06 + rng.nextDouble() * 0.08);
      final bStartX = cx + (rng.nextDouble() - 0.5) * topW * 0.4;
      final bx = bStartX + cos(angle) * bLen;
      final by = topY + sin(angle) * bLen;
      final bThick = (3.5 + rng.nextDouble() * 3) * s;

      _drawTaperedBranch(canvas, bStartX, topY, bx, by, bThick,
          bThick * 0.45, ColorResolver.trunkColorLight);

      final clR = (5 + l * 8) * s;
      _drawLeafCluster(canvas, bx, by, clR, colors[rng.nextInt(colors.length)],
          rng, (2 + l * 2).round());
    }
  }

  double _baobabHalfWidth(
      double t, double baseW, double bulgeW, double topW) {
    if (t < 0.42) {
      final lt = t / 0.42;
      return (baseW + (bulgeW - baseW) * sin(lt * pi / 2)) / 2;
    } else {
      final lt = (t - 0.42) / 0.58;
      return (bulgeW + (topW - bulgeW) * lt) / 2;
    }
  }

  // ══════════════════════════════════════════════════════════
  //  PALM — curved trunk with rings, crown of radiating fronds
  // ══════════════════════════════════════════════════════════

  void _paintPalm(Canvas canvas, Size size) {
    final rng = Random(params.seed);
    final s = params.scaleFactor;
    final l = params.lushness;

    final cx = size.width / 2;
    final baseY = size.height * 0.88;
    final treeH = size.height * 0.68 * s;
    final topY = baseY - treeH;

    // S-curve trunk via cubic bezier
    final curve1 = (rng.nextDouble() - 0.5) * 28 * s;
    final curve2 = -curve1 * 0.55;

    final trunkPts = <Offset>[];
    const numSegs = 18;
    for (var i = 0; i <= numSegs; i++) {
      final t = i / numSegs;
      final px =
          _cBez(cx, cx + curve1, cx + curve2, cx + curve1 * 0.25, t);
      final py =
          _cBez(baseY, baseY - treeH * 0.28, baseY - treeH * 0.72, topY, t);
      trunkPts.add(Offset(px, py));
    }

    // Draw trunk segments with taper
    final trunkW = 9.0 * s;
    for (var i = 0; i < trunkPts.length - 1; i++) {
      final t = i / trunkPts.length;
      final w1 = trunkW * (1 - t * 0.55);
      final w2 = trunkW * (1 - (t + 1 / trunkPts.length) * 0.55);
      _drawTaperedBranch(
        canvas, trunkPts[i].dx, trunkPts[i].dy,
        trunkPts[i + 1].dx, trunkPts[i + 1].dy, w1, w2,
        Color.lerp(
            ColorResolver.trunkColorDark, const Color(0xFFA8946D), t)!,
      );
    }

    // Ring marks
    final ringPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8
      ..color = ColorResolver.trunkColorDark.withValues(alpha: 0.30);
    for (var i = 2; i < trunkPts.length - 1; i += 2) {
      final p = trunkPts[i];
      final t = i / trunkPts.length;
      final w = trunkW * (1 - t * 0.55) * 0.45;
      canvas.drawLine(
          Offset(p.dx - w, p.dy), Offset(p.dx + w, p.dy), ringPaint);
    }

    // Crown center
    final crownX = trunkPts.last.dx;
    final crownY = trunkPts.last.dy;

    // Coconuts (drawn before fronds so they peek through)
    if (l > 0.4) {
      final coconutPaint = Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0xFF8B6914);
      final nc = 2 + rng.nextInt(3);
      for (var i = 0; i < nc; i++) {
        final ca = (rng.nextDouble() - 0.5) * pi * 0.8;
        final cr = (2.5 + rng.nextDouble() * 2) * s;
        canvas.drawCircle(
          Offset(crownX + cos(ca) * 6 * s,
              crownY + 4 * s + rng.nextDouble() * 5 * s),
          cr,
          coconutPaint,
        );
      }
    }

    // Fronds radiating from crown
    final numFronds = (7 + l * 6).round();
    final frondLen = treeH * (0.22 + l * 0.12);
    final colors = _leafColors;
    for (var i = 0; i < numFronds; i++) {
      final baseAngle = (i / numFronds) * 2 * pi - pi / 2;
      final angle = baseAngle + (rng.nextDouble() - 0.5) * 0.35;
      final fLen = frondLen * (0.65 + rng.nextDouble() * 0.35);
      final droop = 0.35 + rng.nextDouble() * 0.35;
      _drawPalmFrond(canvas, crownX, crownY, angle, fLen, droop,
          colors[rng.nextInt(colors.length)], rng, s);
    }
  }

  void _drawPalmFrond(Canvas canvas, double sx, double sy, double angle,
      double length, double droop, Color color, Random rng, double scale) {
    // Spine: curve from crown outward then droop under gravity
    final endX = sx + cos(angle) * length;
    final endY = sy + sin(angle) * length + length * droop;
    final ctrlX = sx + cos(angle) * length * 0.55;
    final ctrlY = sy + sin(angle) * length * 0.25;

    // Draw spine
    canvas.drawPath(
      Path()
        ..moveTo(sx, sy)
        ..quadraticBezierTo(ctrlX, ctrlY, endX, endY),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.2 * scale
        ..strokeCap = StrokeCap.round
        ..color = Color.lerp(color, ColorResolver.trunkColorLight, 0.35)!,
    );

    // Leaflets along spine (feathery look)
    final leafPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4 * scale
      ..strokeCap = StrokeCap.round;

    final numLeaflets = 8 + rng.nextInt(6);
    for (var i = 1; i < numLeaflets; i++) {
      final t = i / numLeaflets;
      final px = _qBez(sx, ctrlX, endX, t);
      final py = _qBez(sy, ctrlY, endY, t);

      final spineAngle = atan2(
          _qBezDeriv(sy, ctrlY, endY, t), _qBezDeriv(sx, ctrlX, endX, t));
      final leafletLen = length * 0.14 * (1 - t * 0.55);

      leafPaint.color =
          color.withValues(alpha: 0.30 + rng.nextDouble() * 0.45);

      // Left leaflet
      final la = spineAngle - pi / 2 + 0.25;
      canvas.drawLine(Offset(px, py),
          Offset(px + cos(la) * leafletLen, py + sin(la) * leafletLen), leafPaint);
      // Right leaflet
      final ra = spineAngle + pi / 2 - 0.25;
      canvas.drawLine(Offset(px, py),
          Offset(px + cos(ra) * leafletLen, py + sin(ra) * leafletLen), leafPaint);
    }
  }
}
