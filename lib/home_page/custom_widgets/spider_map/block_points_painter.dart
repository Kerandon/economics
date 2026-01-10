import 'dart:math';

import 'package:flutter/material.dart';

class BlockPointsPainter extends CustomPainter {
  final String centerText;
  final List<String> points;
  final Color centerColor;
  final Color pointColor;
  final double radius;

  BlockPointsPainter({
    required this.centerText,
    required this.points,
    required this.centerColor,
    required this.pointColor,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final linePaint = Paint()
      ..color = Colors.grey[400]!
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;
    final boxPaint = Paint()..style = PaintingStyle.fill;

    for (int i = 0; i < points.length; i++) {
      final angle = (2 * pi * i) / points.length;
      final pointOffset = Offset(
        center.dx + radius * cos(angle),
        center.dy + radius * sin(angle),
      );

      canvas.drawLine(center, pointOffset, linePaint);
      boxPaint.color = pointColor;
      _drawModernBox(canvas, pointOffset, points[i], boxPaint, isCenter: false);
    }

    boxPaint.color = centerColor;
    _drawModernBox(canvas, center, centerText, boxPaint, isCenter: true);
  }

  void _drawModernBox(
    Canvas canvas,
    Offset position,
    String text,
    Paint paint, {
    bool isCenter = false,
  }) {
    final textSpan = TextSpan(
      text: text,
      style: TextStyle(
        color: isCenter
            ? Colors.white
            : Colors.black, // Adjust color based on your theme logic
        fontSize: isCenter ? 18 : 14,
        fontWeight: isCenter ? FontWeight.bold : FontWeight.w500,
      ),
    );

    final textPainter = TextPainter(
      text: textSpan,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    // 1. INCREASE THIS: 90 is too small for 22pt font.
    // Let it go up to 150-180 so long words don't break.
    textPainter.layout(minWidth: 0, maxWidth: 180);

    // 2. ADAPTIVE PADDING: Use a percentage of font size or fixed larger values
    final hPadding = isCenter ? 24.0 : 18.0;
    final vPadding = isCenter ? 16.0 : 12.0;

    // 3. THE BOX CALCULATION:
    final rect = Rect.fromCenter(
      center: position,
      // We use the ACTUAL measured width and height of the laid-out text
      width: textPainter.width + hPadding,
      height: textPainter.height + vPadding,
    );

    // Draw Shadow
    canvas.drawShadow(
      Path()
        ..addRRect(RRect.fromRectAndRadius(rect, const Radius.circular(12))),
      Colors.black.withOpacity(0.5),
      3.0,
      true,
    );

    // Draw the Box
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(12)),
      paint,
    );

    // Paint the Text exactly in the middle of the box
    textPainter.paint(
      canvas,
      Offset(
        position.dx - (textPainter.width / 2),
        position.dy - (textPainter.height / 2),
      ),
    );
  }

  @override
  bool shouldRepaint(covariant BlockPointsPainter oldDelegate) => false;
}
