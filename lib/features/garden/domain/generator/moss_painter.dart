import 'dart:math';

import 'package:flutter/material.dart';

import 'color_resolver.dart';
import 'plant_params.dart';

/// CustomPainter for moss/pebble landscape (0-39% completion).
/// Cheap to render: overlapping semi-transparent circles + smooth oval pebbles.
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
      final glowPaint = Paint()
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 15)
        ..color = const Color(0x25FFD700);
      canvas.drawCircle(Offset(centerX, baseY), size.width * 0.25, glowPaint);
    }

    // ── Pebbles (smooth oval primitives) ──
    final pebbleCount = (4 + params.absoluteCompletions * 0.5).round().clamp(3, 12);
    final pebblePaint = Paint()..style = PaintingStyle.fill;

    for (var i = 0; i < pebbleCount; i++) {
      final px = centerX + (rng.nextDouble() - 0.5) * size.width * 0.5;
      final py = baseY + (rng.nextDouble() - 0.5) * size.height * 0.12;
      final pw = (8.0 + rng.nextDouble() * 16.0) * scale;
      final ph = pw * (0.5 + rng.nextDouble() * 0.3);

      // Gradient from light to dark for 3D feel
      pebblePaint.shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          ColorResolver.pebbleLight,
          ColorResolver.pebbleGrey,
        ],
      ).createShader(Rect.fromCenter(
        center: Offset(px, py),
        width: pw,
        height: ph,
      ));

      canvas.drawOval(
        Rect.fromCenter(center: Offset(px, py), width: pw, height: ph),
        pebblePaint,
      );
    }

    // ── Moss pad (overlapping semi-transparent circles) ──
    final mossCount = (8 + params.absoluteCompletions * 0.8).round().clamp(6, 25);
    final mossPaint = Paint()..style = PaintingStyle.fill;

    for (var i = 0; i < mossCount; i++) {
      final mx = centerX + (rng.nextDouble() - 0.5) * size.width * 0.45;
      final my = baseY + (rng.nextDouble() - 0.5) * size.height * 0.1;
      final radius = (5.0 + rng.nextDouble() * 12.0) * scale;

      // Alternate between two moss greens
      final color = rng.nextBool()
          ? ColorResolver.mossGreen
          : ColorResolver.mossGreenLight;
      mossPaint.color = color.withValues(alpha: 0.25 + rng.nextDouble() * 0.35);

      canvas.drawCircle(Offset(mx, my), radius, mossPaint);
    }

    // ── Sleeping bulb if 0 completions ──
    if (params.absoluteCompletions == 0) {
      _drawSleepingBulb(canvas, size, centerX, baseY, scale);
    }
  }

  void _drawSleepingBulb(
      Canvas canvas, Size size, double cx, double cy, double scale) {
    final bulbPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = const Color(0xFF9E8B7E); // Sleeping brown

    // Bulb body
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(cx, cy - 6 * scale),
        width: 20 * scale,
        height: 28 * scale,
      ),
      bulbPaint,
    );

    // Tiny sprout tip
    final sproutPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2 * scale
      ..strokeCap = StrokeCap.round
      ..color = ColorResolver.mossGreen.withValues(alpha: 0.5);

    final path = Path()
      ..moveTo(cx, cy - 20 * scale)
      ..quadraticBezierTo(cx + 4 * scale, cy - 30 * scale, cx + 2 * scale, cy - 36 * scale);
    canvas.drawPath(path, sproutPaint);
  }

  @override
  bool shouldRepaint(MossPainter oldDelegate) =>
      params.seed != oldDelegate.params.seed;
}
