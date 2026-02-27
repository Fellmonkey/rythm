import 'dart:math';

import 'package:flutter/material.dart';

import 'color_resolver.dart';
import 'l_system_engine.dart';
import 'plant_params.dart';

/// CustomPainter for bush-type plants (40-79% completion).
/// Uses a shallow L-System (depth 3-4) for lush, spread-out forms.
class BushPainter extends CustomPainter {
  BushPainter({required this.params});

  final GenerationParams params;

  @override
  void paint(Canvas canvas, Size size) {
    final rng = Random(params.seed);
    final scale = params.scaleFactor;
    final lushness = params.lushness;

    final baseStep = size.height * 0.045 * scale;
    final baseThickness = 3.0 * scale + 1.5;

    // Bush L-System: dense, low-growing
    final lString = LSystemEngine.expand(
      'F',
      {'F': 'F[+F]F[-F]F[+F][-F]'},
      3,
    );

    final segments = LSystemEngine.interpret(
      lString,
      stepLength: baseStep,
      angleIncrement: 30 * pi / 180,
      startX: size.width / 2,
      startY: size.height * 0.9,
      startThickness: baseThickness,
      thicknessDecay: 0.72,
      lengthDecay: 0.70,
      rng: rng,
    );

    if (segments.isEmpty) return;

    final leafColors = ColorResolver.leafGradient(
      morningRatio: params.morningRatio,
      afternoonRatio: params.afternoonRatio,
      eveningRatio: params.eveningRatio,
    );

    // Draw aura if short-perfect
    if (params.isShortPerfect) {
      final center = Offset(size.width / 2, size.height * 0.85);
      final glowPaint = Paint()
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 20)
        ..color = const Color(0x30FFD700);
      canvas.drawCircle(center, size.width * 0.3, glowPaint);
    }

    // Draw stems (thin brown)
    final stemPaint = Paint()
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    for (final seg in segments) {
      final t = (seg.depth / 4.0).clamp(0.0, 1.0);
      stemPaint
        ..strokeWidth = seg.thickness
        ..color = Color.lerp(
          ColorResolver.trunkColorDark,
          ColorResolver.trunkColorLight,
          t,
        )!;
      canvas.drawLine(
        Offset(seg.x1, seg.y1),
        Offset(seg.x2, seg.y2),
        stemPaint,
      );
    }

    // Draw foliage clusters at tips
    final maxDepth = segments.map((s) => s.depth).reduce(max);
    final foliagePaint = Paint()..style = PaintingStyle.fill;

    for (final seg in segments) {
      if (seg.depth >= maxDepth - 1) {
        // Mix colors from the gradient
        final colorIndex = rng.nextInt(leafColors.length);
        foliagePaint.color = leafColors[colorIndex]
            .withValues(alpha: 0.5 + rng.nextDouble() * 0.4);

        final radius = (4.0 + lushness * 10.0) * scale;
        final count = (2 + lushness * 2).round();

        for (var i = 0; i < count; i++) {
          final ox = (rng.nextDouble() - 0.5) * radius * 2;
          final oy = (rng.nextDouble() - 0.5) * radius * 1.5;
          canvas.drawOval(
            Rect.fromCenter(
              center: Offset(seg.x2 + ox, seg.y2 + oy),
              width: radius * (0.7 + rng.nextDouble() * 0.6),
              height: radius * (0.6 + rng.nextDouble() * 0.5),
            ),
            foliagePaint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(BushPainter oldDelegate) =>
      params.seed != oldDelegate.params.seed;
}
