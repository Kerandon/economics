import 'package:economics_app/custom_paint/custom_paint_axis.dart';
import 'package:flutter/material.dart';

class CustomPainterPPC extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const adjustment = 0.10;
    final width = size.width;
    final height = size.height;
    final widthIndent = width * adjustment;
    final heightIndent = height * adjustment;
    final adjustedWidth = width - widthIndent;
    final adjustedHeight = height - (height * adjustment);
    var paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    var path = Path()

      ///Draw the X and Y axis
      ..moveTo(widthIndent, heightIndent)
      ..lineTo(widthIndent, adjustedHeight)
      ..lineTo(adjustedWidth, adjustedHeight)

      ///Draw the curve
      ..moveTo(widthIndent, heightIndent * 3)
      ..quadraticBezierTo(width - (widthIndent * 3), adjustedHeight / 3,
          width - (widthIndent * 3), adjustedHeight)
      ..moveTo(widthIndent, heightIndent);
    canvas.drawPath(path, paint);

    addXAxis('Good B', size, canvas);
    addYAxis('Good A', size, canvas);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
