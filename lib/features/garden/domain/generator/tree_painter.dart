import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'color_resolver.dart';
import 'l_system_engine.dart';
import 'plant_params.dart';

import '../../../../core/database/enums.dart';

/// CustomPainter that renders a tree using L-System generated segments.
/// Supports 4 archetypes: Oak, Willow, Sakura, Pine.
class TreePainter extends CustomPainter {
  TreePainter({required this.params});

  final GenerationParams params;

  @override
  void paint(Canvas canvas, Size size) {
    final rng = Random(params.seed);
    final scale = params.scaleFactor;
    final lushness = params.lushness;

    // Scale step length based on canvas size and plant scale
    final baseStep = size.height * 0.08 * scale;
    final baseThickness = 6.0 * scale + 2.0;

    // Get L-System config for archetype
    final config = _getArchetypeConfig(params.archetype);

    // Generate L-System string
    final lString = LSystemEngine.expand(
      config.axiom,
      config.rules,
      config.depth,
    );

    // Interpret into segments
    final segments = LSystemEngine.interpret(
      lString,
      stepLength: baseStep,
      angleIncrement: config.angle,
      startX: size.width / 2,
      startY: size.height * 0.88,
      startThickness: baseThickness,
      thicknessDecay: config.thicknessDecay,
      lengthDecay: config.lengthDecay,
      rng: rng,
    );

    if (segments.isEmpty) return;

    // Get leaf colors
    final leafColors = ColorResolver.leafGradient(
      morningRatio: params.morningRatio,
      afternoonRatio: params.afternoonRatio,
      eveningRatio: params.eveningRatio,
    );

    // Find Y bounds for color interpolation
    final minY = segments.map((s) => min(s.y1, s.y2)).reduce(min);
    final maxY = segments.map((s) => max(s.y1, s.y2)).reduce(max);
    final yRange = maxY - minY;

    // Draw aura glow if short-perfect
    if (params.isShortPerfect) {
      _drawAura(canvas, size, segments, minY);
    }

    // Draw trunk segments (low depth = thick trunk)
    final trunkPaint = Paint()
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    for (final seg in segments) {
      if (seg.depth <= 1) {
        trunkPaint
          ..strokeWidth = seg.thickness
          ..color = Color.lerp(
            ColorResolver.trunkColorDark,
            ColorResolver.trunkColorLight,
            (seg.depth / 2.0).clamp(0.0, 1.0),
          )!;
        canvas.drawLine(
          Offset(seg.x1, seg.y1),
          Offset(seg.x2, seg.y2),
          trunkPaint,
        );
      }
    }

    // Draw branch segments
    final branchPaint = Paint()
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    for (final seg in segments) {
      if (seg.depth > 1) {
        final branchColor = Color.lerp(
          ColorResolver.trunkColorLight,
          leafColors[1],
          ((seg.depth - 1) / 4.0).clamp(0.0, 1.0),
        )!;
        branchPaint
          ..strokeWidth = seg.thickness
          ..color = branchColor;
        canvas.drawLine(
          Offset(seg.x1, seg.y1),
          Offset(seg.x2, seg.y2),
          branchPaint,
        );
      }
    }

    // Draw leaves at branch tips (high depth segments)
    final maxDepth = segments.map((s) => s.depth).reduce(max);
    final leafPaint = Paint()..style = PaintingStyle.fill;

    for (final seg in segments) {
      if (seg.depth >= maxDepth - 1 && seg.length > 0) {
        // Normalized vertical position for color
        final t = yRange > 0 ? 1.0 - ((seg.midY - minY) / yRange) : 0.5;
        final color = ColorResolver.leafColorAt(
          t,
          morningRatio: params.morningRatio,
          afternoonRatio: params.afternoonRatio,
          eveningRatio: params.eveningRatio,
        );

        // Leaf size depends on lushness
        final leafSize = (3.0 + lushness * 8.0) * scale;

        if (params.archetype == SeedArchetype.sakura) {
          // Sakura: draw round clusters of small circles
          _drawSakuraBlossoms(canvas, seg, color, leafSize, rng);
        } else if (params.archetype == SeedArchetype.willow) {
          // Willow: draw drooping leaf strands
          _drawWillowLeaves(canvas, seg, color, leafSize, rng);
        } else {
          // Oak, Pine, etc: soft elliptical leaf clusters
          leafPaint.color = color.withValues(alpha: 0.7 + rng.nextDouble() * 0.3);

          // Draw overlapping circles for a soft canopy
          final count = (2 + lushness * 3).round();
          for (var i = 0; i < count; i++) {
            final ox = (rng.nextDouble() - 0.5) * leafSize * 1.5;
            final oy = (rng.nextDouble() - 0.5) * leafSize * 1.2;
            canvas.drawOval(
              Rect.fromCenter(
                center: Offset(seg.x2 + ox, seg.y2 + oy),
                width: leafSize * (0.8 + rng.nextDouble() * 0.5),
                height: leafSize * (0.6 + rng.nextDouble() * 0.4),
              ),
              leafPaint,
            );
          }
        }
      }
    }
  }

  void _drawSakuraBlossoms(
      Canvas canvas, LSegment seg, Color color, double size, Random rng) {
    final paint = Paint()..style = PaintingStyle.fill;
    // Sakura blossoms are lighter/pinker
    final blossomColor = Color.lerp(color, const Color(0xFFFFB7C5), 0.6)!;

    final count = 3 + rng.nextInt(4);
    for (var i = 0; i < count; i++) {
      final ox = (rng.nextDouble() - 0.5) * size * 2;
      final oy = (rng.nextDouble() - 0.5) * size * 2;
      final radius = size * (0.3 + rng.nextDouble() * 0.4);
      paint.color = blossomColor.withValues(alpha: 0.5 + rng.nextDouble() * 0.5);
      canvas.drawCircle(Offset(seg.x2 + ox, seg.y2 + oy), radius, paint);
    }
  }

  void _drawWillowLeaves(
      Canvas canvas, LSegment seg, Color color, double size, Random rng) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    // Draw drooping strands
    final count = 2 + rng.nextInt(3);
    for (var i = 0; i < count; i++) {
      paint.color = color.withValues(alpha: 0.4 + rng.nextDouble() * 0.4);
      final startX = seg.x2 + (rng.nextDouble() - 0.5) * size;
      final startY = seg.y2;
      final endX = startX + (rng.nextDouble() - 0.5) * size * 0.5;
      final endY = startY + size * (1.0 + rng.nextDouble() * 1.5);

      final path = Path()
        ..moveTo(startX, startY)
        ..quadraticBezierTo(
          startX + (rng.nextDouble() - 0.5) * size * 0.8,
          (startY + endY) / 2,
          endX,
          endY,
        );
      canvas.drawPath(path, paint);
    }
  }

  void _drawAura(
      Canvas canvas, Size size, List<LSegment> segments, double minY) {
    // Soft golden glow around the base
    final center = Offset(size.width / 2, size.height * 0.85);
    final glowPaint = Paint()
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 30)
      ..shader = ui.Gradient.radial(
        center,
        size.width * 0.35,
        [
          const Color(0x40FFD700),
          const Color(0x00FFD700),
        ],
      );
    canvas.drawCircle(center, size.width * 0.35, glowPaint);
  }

  @override
  bool shouldRepaint(TreePainter oldDelegate) =>
      params.seed != oldDelegate.params.seed;
}

/// Per-archetype L-System configuration.
class _ArchetypeConfig {
  const _ArchetypeConfig({
    required this.axiom,
    required this.rules,
    required this.depth,
    required this.angle,
    this.thicknessDecay = 0.68,
    this.lengthDecay = 0.82,
  });

  final String axiom;
  final Map<String, String> rules;
  final int depth;
  final double angle; // radians
  final double thicknessDecay;
  final double lengthDecay;
}

_ArchetypeConfig _getArchetypeConfig(SeedArchetype archetype) {
  return switch (archetype) {
    SeedArchetype.oak => _ArchetypeConfig(
        axiom: 'F',
        rules: {'F': 'FF+[+F-F-F]-[-F+F+F]'},
        depth: 4,
        angle: 25 * pi / 180,
        thicknessDecay: 0.65,
        lengthDecay: 0.80,
      ),
    SeedArchetype.willow => _ArchetypeConfig(
        axiom: 'F',
        rules: {'F': 'FF-[-F+F]+[+F-F]'},
        depth: 4,
        angle: 30 * pi / 180,
        thicknessDecay: 0.60,
        lengthDecay: 0.78,
      ),
    SeedArchetype.sakura => _ArchetypeConfig(
        axiom: 'F',
        rules: {'F': 'F[+F]F[-F]+F'},
        depth: 4,
        angle: 28 * pi / 180,
        thicknessDecay: 0.65,
        lengthDecay: 0.75,
      ),
    SeedArchetype.pine => _ArchetypeConfig(
        axiom: 'F',
        rules: {'F': 'FF[++F][-F][+F][-FF]'},
        depth: 3,
        angle: 20 * pi / 180,
        thicknessDecay: 0.70,
        lengthDecay: 0.70,
      ),
    SeedArchetype.baobab => _ArchetypeConfig(
        axiom: 'F',
        rules: {'F': 'FF+[+F-F]-[-F+F+F]'},
        depth: 3,
        angle: 32 * pi / 180,
        thicknessDecay: 0.55,
        lengthDecay: 0.85,
      ),
    SeedArchetype.palm => _ArchetypeConfig(
        axiom: 'F',
        rules: {'F': 'F[+F][-F]F'},
        depth: 4,
        angle: 35 * pi / 180,
        thicknessDecay: 0.80,
        lengthDecay: 0.65,
      ),
  };
}
