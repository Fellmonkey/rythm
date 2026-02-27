import 'dart:math';

import 'package:flutter/material.dart';

import 'color_resolver.dart';
import 'plant_params.dart';

/// CustomPainter for moss/pebble landscape (0-39% completion).
///
/// Instead of a naïve random scatter the moss is built in layers:
/// 1. **Organic patches** — coherent elliptical regions with soft edges.
/// 2. **Texture layer** — small varied-shape elements biased toward centres.
/// 3. **Detail layer** — tiny leaf / frond paths for fine organic feel.
/// 4. **Pebbles** — 3-D shaded ovals with highlight and shadow.
/// 5. **Connecting tendrils** — thin curved paths between patches.
class MossPainter extends CustomPainter {
  MossPainter({required this.params});

  final GenerationParams params;

  @override
  void paint(Canvas canvas, Size size) {
    final rng = Random(params.seed);
    final scale = params.scaleFactor;

    final centerX = size.width / 2;
    final baseY = size.height * 0.85;

    // Draw aura if short-perfect
    if (params.isShortPerfect) {
      canvas.drawCircle(
        Offset(centerX, baseY),
        size.width * 0.25,
        Paint()
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 15)
          ..color = const Color(0x25FFD700),
      );
    }

    // ── 1. Generate patch centres ────────────────────────
    final numPatches =
        (2 + (params.absoluteCompletions * 0.15).round()).clamp(2, 5);
    final patches = <_MossPatch>[];
    for (var i = 0; i < numPatches; i++) {
      patches.add(_MossPatch(
        cx: centerX + (rng.nextDouble() - 0.5) * size.width * 0.5,
        cy: baseY + (rng.nextDouble() - 0.5) * size.height * 0.12,
        rx: (18 + rng.nextDouble() * 22) * scale,
        ry: (10 + rng.nextDouble() * 12) * scale,
      ));
    }

    // ── 2. Connecting tendrils between patches ───────────
    _drawTendrils(canvas, patches, rng, scale);

    // ── 3. Pebbles ───────────────────────────────────────
    _drawPebbles(canvas, centerX, baseY, size, rng, scale);

    // ── 4. Moss patches (layered rendering) ──────────────
    for (final patch in patches) {
      _drawMossPatch(canvas, patch, rng, scale);
    }

    // ── 5. Sleeping bulb if 0 completions ────────────────
    if (params.absoluteCompletions == 0) {
      _drawSleepingBulb(canvas, size, centerX, baseY, scale);
    }
  }

  // ── Moss patch rendering ─────────────────────────────

  void _drawMossPatch(
      Canvas canvas, _MossPatch patch, Random rng, double scale) {
    // --- Base layer: large soft blurred fill ---
    final basePaint = Paint()
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);

    for (var i = 0; i < 3; i++) {
      final ox = (rng.nextDouble() - 0.5) * patch.rx * 0.4;
      final oy = (rng.nextDouble() - 0.5) * patch.ry * 0.3;
      final color = rng.nextBool()
          ? ColorResolver.mossGreen
          : ColorResolver.mossGreenLight;
      basePaint.color = color.withValues(alpha: 0.18 + rng.nextDouble() * 0.12);
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(patch.cx + ox, patch.cy + oy),
          width: patch.rx * (1.6 + rng.nextDouble() * 0.4),
          height: patch.ry * (1.4 + rng.nextDouble() * 0.4),
        ),
        basePaint,
      );
    }

    // --- Mid layer: small clumps biased toward centre ---
    final midPaint = Paint()..style = PaintingStyle.fill;
    final midCount = (8 + params.absoluteCompletions * 0.6).round().clamp(6, 22);
    for (var i = 0; i < midCount; i++) {
      final angle = rng.nextDouble() * 2 * pi;
      final dist = rng.nextDouble() * rng.nextDouble(); // centre bias
      final mx = patch.cx + cos(angle) * dist * patch.rx;
      final my = patch.cy + sin(angle) * dist * patch.ry;
      final r = (3 + rng.nextDouble() * 6) * scale * (1 - dist * 0.5);

      final color = rng.nextBool()
          ? ColorResolver.mossGreen
          : ColorResolver.mossGreenLight;
      midPaint.color = color.withValues(alpha: 0.30 + rng.nextDouble() * 0.35);

      // Slightly irregular shapes: use a rounded rect with random radii
      canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromCenter(
            center: Offset(mx, my),
            width: r * (1.2 + rng.nextDouble() * 0.6),
            height: r * (0.8 + rng.nextDouble() * 0.5),
          ),
          topLeft: Radius.circular(r * (0.3 + rng.nextDouble() * 0.7)),
          topRight: Radius.circular(r * (0.3 + rng.nextDouble() * 0.7)),
          bottomLeft: Radius.circular(r * (0.3 + rng.nextDouble() * 0.7)),
          bottomRight: Radius.circular(r * (0.3 + rng.nextDouble() * 0.7)),
        ),
        midPaint,
      );
    }

    // --- Detail layer: tiny leaf / frond shapes at edges ---
    final detailPaint = Paint()..style = PaintingStyle.fill;
    final detailCount =
        (4 + params.absoluteCompletions * 0.3).round().clamp(3, 14);
    for (var i = 0; i < detailCount; i++) {
      final angle = rng.nextDouble() * 2 * pi;
      final dist = 0.4 + rng.nextDouble() * 0.6; // toward edge
      final dx = patch.cx + cos(angle) * dist * patch.rx;
      final dy = patch.cy + sin(angle) * dist * patch.ry;
      final leafAngle = angle + pi + (rng.nextDouble() - 0.5) * 1.2;
      final leafLen = (3 + rng.nextDouble() * 5) * scale;

      final color = Color.lerp(
        ColorResolver.mossGreen,
        ColorResolver.mossGreenLight,
        rng.nextDouble(),
      )!;
      detailPaint.color = color.withValues(alpha: 0.4 + rng.nextDouble() * 0.4);

      // Tiny leaf shape (pointed oval)
      canvas.drawPath(
        Path()
          ..moveTo(dx, dy)
          ..quadraticBezierTo(
            dx + cos(leafAngle - 0.35) * leafLen * 0.65,
            dy + sin(leafAngle - 0.35) * leafLen * 0.65,
            dx + cos(leafAngle) * leafLen,
            dy + sin(leafAngle) * leafLen,
          )
          ..quadraticBezierTo(
            dx + cos(leafAngle + 0.35) * leafLen * 0.65,
            dy + sin(leafAngle + 0.35) * leafLen * 0.65,
            dx,
            dy,
          ),
        detailPaint,
      );
    }

    // --- Highlight dots (dew / light reflections) ---
    final hlPaint = Paint()..style = PaintingStyle.fill;
    final hlCount = 2 + rng.nextInt(3);
    for (var i = 0; i < hlCount; i++) {
      final hx =
          patch.cx + (rng.nextDouble() - 0.5) * patch.rx * 1.2;
      final hy =
          patch.cy + (rng.nextDouble() - 0.5) * patch.ry * 0.8;
      hlPaint.color = const Color(0xFFDDFFDD)
          .withValues(alpha: 0.12 + rng.nextDouble() * 0.12);
      canvas.drawCircle(
        Offset(hx, hy),
        (1 + rng.nextDouble() * 2) * scale,
        hlPaint,
      );
    }
  }

  // ── Tendrils ─────────────────────────────────────────

  void _drawTendrils(
      Canvas canvas, List<_MossPatch> patches, Random rng, double scale) {
    if (patches.length < 2) return;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = (0.8 + rng.nextDouble() * 0.6) * scale
      ..strokeCap = StrokeCap.round
      ..color = ColorResolver.mossGreen.withValues(alpha: 0.18);

    for (var i = 0; i < patches.length - 1; i++) {
      final a = patches[i];
      final b = patches[i + 1];
      final midX = (a.cx + b.cx) / 2 + (rng.nextDouble() - 0.5) * 15 * scale;
      final midY = (a.cy + b.cy) / 2 + (rng.nextDouble() - 0.5) * 8 * scale;

      canvas.drawPath(
        Path()
          ..moveTo(a.cx, a.cy)
          ..quadraticBezierTo(midX, midY, b.cx, b.cy),
        paint,
      );

      // Small dots along tendril
      final dotPaint = Paint()
        ..style = PaintingStyle.fill
        ..color = ColorResolver.mossGreenLight.withValues(alpha: 0.2);
      for (var t = 0.2; t < 0.85; t += 0.15 + rng.nextDouble() * 0.15) {
        final u = 1 - t;
        final px = u * u * a.cx + 2 * u * t * midX + t * t * b.cx;
        final py = u * u * a.cy + 2 * u * t * midY + t * t * b.cy;
        canvas.drawCircle(
          Offset(px + (rng.nextDouble() - 0.5) * 3, py),
          (1.5 + rng.nextDouble() * 2) * scale,
          dotPaint,
        );
      }
    }
  }

  // ── Pebbles ──────────────────────────────────────────

  void _drawPebbles(Canvas canvas, double centerX, double baseY, Size size,
      Random rng, double scale) {
    final count =
        (3 + params.absoluteCompletions * 0.4).round().clamp(2, 10);

    for (var i = 0; i < count; i++) {
      final px = centerX + (rng.nextDouble() - 0.5) * size.width * 0.55;
      final py = baseY + (rng.nextDouble() - 0.5) * size.height * 0.10;
      final pw = (7 + rng.nextDouble() * 14) * scale;
      final ph = pw * (0.45 + rng.nextDouble() * 0.25);

      final rect = Rect.fromCenter(center: Offset(px, py), width: pw, height: ph);

      // Shadow
      canvas.drawOval(
        rect.shift(Offset(1.5 * scale, 1.5 * scale)),
        Paint()
          ..color = const Color(0x18000000)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2),
      );

      // Main body with gradient (3-D roundness)
      canvas.drawOval(
        rect,
        Paint()
          ..style = PaintingStyle.fill
          ..shader = LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [ColorResolver.pebbleLight, ColorResolver.pebbleGrey],
          ).createShader(rect),
      );

      // Highlight spot
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(px - pw * 0.15, py - ph * 0.15),
          width: pw * 0.3,
          height: ph * 0.25,
        ),
        Paint()
          ..color = const Color(0x20FFFFFF)
          ..style = PaintingStyle.fill,
      );
    }
  }

  // ── Sleeping bulb ────────────────────────────────────

  void _drawSleepingBulb(
      Canvas canvas, Size size, double cx, double cy, double scale) {
    // Bulb body
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(cx, cy - 6 * scale),
        width: 20 * scale,
        height: 28 * scale,
      ),
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0xFF9E8B7E),
    );

    // Subtle shading on bulb
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(cx - 3 * scale, cy - 10 * scale),
        width: 8 * scale,
        height: 14 * scale,
      ),
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0x18FFFFFF),
    );

    // Tiny sprout tip
    canvas.drawPath(
      Path()
        ..moveTo(cx, cy - 20 * scale)
        ..quadraticBezierTo(
          cx + 4 * scale,
          cy - 30 * scale,
          cx + 2 * scale,
          cy - 36 * scale,
        ),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2 * scale
        ..strokeCap = StrokeCap.round
        ..color = ColorResolver.mossGreen.withValues(alpha: 0.5),
    );

    // Small leaf at sprout tip
    final leafColor = ColorResolver.mossGreen.withValues(alpha: 0.4);
    canvas.drawPath(
      Path()
        ..moveTo(cx + 2 * scale, cy - 36 * scale)
        ..quadraticBezierTo(
          cx + 7 * scale,
          cy - 40 * scale,
          cx + 5 * scale,
          cy - 34 * scale,
        ),
      Paint()
        ..style = PaintingStyle.fill
        ..color = leafColor,
    );
  }

  @override
  bool shouldRepaint(MossPainter oldDelegate) =>
      params.seed != oldDelegate.params.seed ||
      params.absoluteCompletions != oldDelegate.params.absoluteCompletions;
}

/// Internal data class for a moss patch region.
class _MossPatch {
  const _MossPatch({
    required this.cx,
    required this.cy,
    required this.rx,
    required this.ry,
  });

  final double cx, cy; // centre
  final double rx, ry; // radii
}
