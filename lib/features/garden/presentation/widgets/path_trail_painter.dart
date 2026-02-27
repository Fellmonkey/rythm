import 'dart:math';

import 'package:flutter/material.dart';

/// Draws a winding path (trail) down the center of the Time Path screen.
/// Each month segment gets a portion of the path with organic Bezier curves.
class PathTrailPainter extends CustomPainter {
  PathTrailPainter({
    required this.segmentCount,
    required this.isDark,
  });

  final int segmentCount;
  final bool isDark;

  @override
  void paint(Canvas canvas, Size size) {
    if (segmentCount <= 0) return;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round
      ..color = isDark
          ? const Color(0xFF2A3A4E)
          : const Color(0xFFD4CEC3);

    // Dot pattern for the path
    final dotPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = isDark
          ? const Color(0xFF3A4A5E)
          : const Color(0xFFC4BEB3);

    final centerX = size.width / 2;
    const amplitude = 60.0;

    // Draw dotted winding path
    for (var i = 0; i < segmentCount * 20; i++) {
      final t = i / (segmentCount * 20.0);
      final y = t * size.height;
      final waveX = centerX + sin(t * pi * 2 * segmentCount) * amplitude;

      if (i % 3 == 0) {
        canvas.drawCircle(Offset(waveX, y), 2.5, dotPaint);
      }
    }

    // Draw subtle guide line
    final path = Path();
    path.moveTo(centerX, 0);

    for (var i = 0; i < segmentCount; i++) {
      final y0 = (i / segmentCount) * size.height;
      final y1 = ((i + 1) / segmentCount) * size.height;
      final midY = (y0 + y1) / 2;
      final dir = i.isEven ? 1.0 : -1.0;

      path.cubicTo(
        centerX + amplitude * dir,
        y0 + (midY - y0) * 0.3,
        centerX - amplitude * dir,
        y0 + (midY - y0) * 0.7,
        centerX,
        midY,
      );
      path.cubicTo(
        centerX - amplitude * dir,
        midY + (y1 - midY) * 0.3,
        centerX + amplitude * dir,
        midY + (y1 - midY) * 0.7,
        centerX,
        y1,
      );
    }

    paint
      ..color = (isDark
              ? const Color(0xFF2A3A4E)
              : const Color(0xFFD4CEC3))
          .withValues(alpha: 0.3)
      ..strokeWidth = 2;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(PathTrailPainter oldDelegate) =>
      segmentCount != oldDelegate.segmentCount ||
      isDark != oldDelegate.isDark;
}
