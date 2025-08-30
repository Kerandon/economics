import 'package:flutter/material.dart';
import 'shade_type.dart';
import '../../models/custom_bezier.dart';
import '../painter_constants.dart';

/// for pointsAndBeziers, takes [Offset] and [CustomBezier]
void paintShading(
  Canvas canvas,
  Size size,
  ShadeType shade,
  List<dynamic> pointsAndBeziers, {
  bool striped = true,
  double stripeSpacing = 9.0,
  bool invertStripes = false, // NEW parameter
}) {
  final width = size.width;
  final height = size.height;
  final normalize = 1 - (kAxisIndent * 2);

  final fillPaint = Paint()
    ..style = PaintingStyle.fill
    ..color = shade.setShadeColor();

  if (pointsAndBeziers.isEmpty) return;

  final path = Path();
  bool isFirst = true;

  Offset toCanvasCoords(double dx, double dy) {
    final x = dx * width * normalize + (kAxisIndent * width);
    final y = dy * height * normalize + (kAxisIndent * (height / 2));
    return Offset(x, y);
  }

  for (final item in pointsAndBeziers) {
    if (item is Offset) {
      final point = toCanvasCoords(item.dx, item.dy);
      if (isFirst) {
        path.moveTo(point.dx, point.dy);
        isFirst = false;
      } else {
        path.lineTo(point.dx, point.dy);
      }
    } else if (item is CustomBezier) {
      final control = toCanvasCoords(item.control.dx, item.control.dy);
      final endPoint = toCanvasCoords(item.endPoint.dx, item.endPoint.dy);
      path.quadraticBezierTo(control.dx, control.dy, endPoint.dx, endPoint.dy);
    }
  }

  path.close();

  if (striped) {
    canvas.save();
    canvas.clipPath(path);

    final stripePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = shade.setShadeColor().withAlpha(150);

    if (invertStripes) {
      // Draw stripes from bottom-left to top-right
      for (double y = size.height * 2; y > -size.height; y -= stripeSpacing) {
        canvas.drawLine(
          Offset(0, y),
          Offset(size.width, y - size.width),
          stripePaint,
        );
      }
    } else {
      // Original direction: top-left to bottom-right
      for (double y = -size.height; y < size.height * 2; y += stripeSpacing) {
        canvas.drawLine(
          Offset(0, y),
          Offset(size.width, y + size.width),
          stripePaint,
        );
      }
    }

    canvas.restore();
  } else {
    canvas.drawPath(path, fillPaint);
  }
}
