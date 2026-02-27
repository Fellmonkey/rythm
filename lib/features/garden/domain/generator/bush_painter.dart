import 'dart:math';

import 'package:flutter/material.dart';

import 'color_resolver.dart';
import 'plant_params.dart';

/// CustomPainter for bush-type plants (40-79% completion).
///
/// Uses an organic **mound profile** instead of L-system:
/// 1. Multiple thin stems radiate from a low base.
/// 2. A layered elliptical canopy fills a dome-shaped boundary.
/// 3. Interior highlights and optional berry/flower dots add detail.
class BushPainter extends CustomPainter {
  BushPainter({required this.params});

  final GenerationParams params;

  @override
  void paint(Canvas canvas, Size size) {
    final rng = Random(params.seed);
    final s = params.scaleFactor;
    final l = params.lushness;

    final cx = size.width / 2;
    final baseY = size.height * 0.88;

    // Mound profile
    final moundW = size.width * 0.42 * s;
    final moundH = size.height * 0.28 * s;
    final moundCenterY = baseY - moundH * 0.55;

    // Draw aura if short-perfect
    if (params.isShortPerfect) {
      canvas.drawCircle(
        Offset(cx, baseY * 0.92),
        size.width * 0.3,
        Paint()
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 20)
          ..color = const Color(0x30FFD700),
      );
    }

    // ── 1. Stems ──────────────────────────────────────────
    final numStems = 5 + rng.nextInt(4);
    final stemPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    for (var i = 0; i < numStems; i++) {
      final angle = -pi / 2 +
          (i - (numStems - 1) / 2) * 0.35 +
          (rng.nextDouble() - 0.5) * 0.15;
      final stemLen = moundH * (0.5 + rng.nextDouble() * 0.5);
      final stemW = (1.5 + rng.nextDouble() * 1.5) * s;

      stemPaint
        ..strokeWidth = stemW
        ..color = Color.lerp(
          ColorResolver.trunkColorDark,
          ColorResolver.trunkColorLight,
          rng.nextDouble() * 0.6,
        )!;

      // Curved stem via quadratic bezier
      final endX = cx + cos(angle) * stemLen * 0.7;
      final endY = baseY + sin(angle) * stemLen;
      final ctrlX = cx + cos(angle) * stemLen * 0.3 +
          (rng.nextDouble() - 0.5) * 6 * s;
      final ctrlY = baseY + sin(angle) * stemLen * 0.5;

      canvas.drawPath(
        Path()
          ..moveTo(cx + (rng.nextDouble() - 0.5) * 4 * s, baseY)
          ..quadraticBezierTo(ctrlX, ctrlY, endX, endY),
        stemPaint,
      );
    }

    // ── 2. Layered foliage dome ───────────────────────────
    final colors = ColorResolver.leafGradient(
      morningRatio: params.morningRatio,
      afternoonRatio: params.afternoonRatio,
      eveningRatio: params.eveningRatio,
    );

    // Base layer — large soft blobs with blur
    final basePaint = Paint()
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
    final baseCount = (4 + l * 4).round();
    for (var i = 0; i < baseCount; i++) {
      final ox = (rng.nextDouble() - 0.5) * moundW * 1.2;
      final oy = (rng.nextDouble() - 0.5) * moundH * 0.8;
      basePaint.color = colors[rng.nextInt(colors.length)]
          .withValues(alpha: 0.25 + rng.nextDouble() * 0.2);
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(cx + ox, moundCenterY + oy),
          width: moundW * (0.5 + rng.nextDouble() * 0.4),
          height: moundH * (0.4 + rng.nextDouble() * 0.3),
        ),
        basePaint,
      );
    }

    // Middle layer — denser, smaller clusters inside the mound
    final midPaint = Paint()..style = PaintingStyle.fill;
    final midCount = (10 + l * 15).round();
    for (var i = 0; i < midCount; i++) {
      // Points biased toward center of the mound
      final angle = rng.nextDouble() * 2 * pi;
      final dist = rng.nextDouble() * rng.nextDouble(); // bias toward center
      final ox = cos(angle) * dist * moundW;
      final oy = sin(angle) * dist * moundH * 0.7;

      final r = (4 + rng.nextDouble() * 8) * s * (1 - dist * 0.4);
      midPaint.color = colors[rng.nextInt(colors.length)]
          .withValues(alpha: 0.35 + rng.nextDouble() * 0.45);

      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(cx + ox, moundCenterY + oy),
          width: r * (1.3 + rng.nextDouble() * 0.5),
          height: r * (0.9 + rng.nextDouble() * 0.4),
        ),
        midPaint,
      );
    }

    // Detail layer — small leaf-like shapes at surface
    final detailPaint = Paint()..style = PaintingStyle.fill;
    final detailCount = (6 + l * 10).round();
    for (var i = 0; i < detailCount; i++) {
      final angle = rng.nextDouble() * 2 * pi;
      final dist = 0.5 + rng.nextDouble() * 0.5; // biased to edge
      final ox = cos(angle) * dist * moundW * 0.9;
      final oy = sin(angle) * dist * moundH * 0.6;
      final leafAngle = angle + (rng.nextDouble() - 0.5) * 0.8;
      final leafSize = (3 + rng.nextDouble() * 5) * s;

      detailPaint.color = colors[rng.nextInt(colors.length)]
          .withValues(alpha: 0.5 + rng.nextDouble() * 0.4);

      // Tiny leaf path (pointed oval)
      final lx = cx + ox;
      final ly = moundCenterY + oy;
      canvas.drawPath(
        Path()
          ..moveTo(lx, ly)
          ..quadraticBezierTo(
            lx + cos(leafAngle - 0.4) * leafSize * 0.7,
            ly + sin(leafAngle - 0.4) * leafSize * 0.7,
            lx + cos(leafAngle) * leafSize,
            ly + sin(leafAngle) * leafSize,
          )
          ..quadraticBezierTo(
            lx + cos(leafAngle + 0.4) * leafSize * 0.7,
            ly + sin(leafAngle + 0.4) * leafSize * 0.7,
            lx,
            ly,
          ),
        detailPaint,
      );
    }

    // Highlight specks — tiny bright dots suggesting light on leaves
    final hlPaint = Paint()..style = PaintingStyle.fill;
    final hlCount = (4 + l * 6).round();
    for (var i = 0; i < hlCount; i++) {
      final ox = (rng.nextDouble() - 0.5) * moundW * 1.4;
      final oy = (rng.nextDouble() - 0.7) * moundH * 0.8; // biased upward
      hlPaint.color = colors[rng.nextInt(colors.length)]
          .withValues(alpha: 0.15 + rng.nextDouble() * 0.15);
      canvas.drawCircle(
        Offset(cx + ox, moundCenterY + oy),
        (1.5 + rng.nextDouble() * 2.5) * s,
        hlPaint,
      );
    }

    // ── 3. Optional berries / small flowers ──────────────
    if (l > 0.5) {
      final berryPaint = Paint()..style = PaintingStyle.fill;
      final berryCount = (2 + l * 5).round();
      for (var i = 0; i < berryCount; i++) {
        final angle = rng.nextDouble() * 2 * pi;
        final dist = 0.3 + rng.nextDouble() * 0.6;
        final bx = cx + cos(angle) * dist * moundW * 0.8;
        final by = moundCenterY + sin(angle) * dist * moundH * 0.5;
        final br = (1.5 + rng.nextDouble() * 2) * s;

        // Small berry: darker saturated color
        berryPaint.color = Color.lerp(
          colors[rng.nextInt(colors.length)],
          const Color(0xFFCC4466),
          0.4 + rng.nextDouble() * 0.3,
        )!.withValues(alpha: 0.6 + rng.nextDouble() * 0.3);

        canvas.drawCircle(Offset(bx, by), br, berryPaint);
        // Tiny highlight
        berryPaint.color = const Color(0x40FFFFFF);
        canvas.drawCircle(
            Offset(bx - br * 0.25, by - br * 0.25), br * 0.3, berryPaint);
      }
    }

    // ── 4. Ground shadow ─────────────────────────────────
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(cx, baseY + 2 * s),
        width: moundW * 1.6,
        height: 6 * s,
      ),
      Paint()
        ..color = const Color(0x10000000)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4),
    );
  }

  @override
  bool shouldRepaint(BushPainter oldDelegate) =>
      params.seed != oldDelegate.params.seed ||
      params.completionPct != oldDelegate.params.completionPct ||
      params.maxStreak != oldDelegate.params.maxStreak;
}
