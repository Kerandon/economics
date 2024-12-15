import 'package:flutter/material.dart';
import '../../enums/shade_type.dart';
import '../../models/custom_bezier.dart';

/// for pointsAndBeziers, takes [Offset] and [CustomBezier]
void paintShading(
    Canvas canvas, Size size, ShadeType shade, List<dynamic> pointsAndBeziers) {
  final width = size.width;
  final height = size.height;
  final paint = Paint()
    ..style = PaintingStyle.fill
    ..color = shade.setShadeColor().withOpacity(0.60);

  if (pointsAndBeziers.isEmpty) return;

  final path = Path();
  bool isFirst = true;

  for (int i = 0; i < pointsAndBeziers.length; i++) {
    final item = pointsAndBeziers[i];

    if (item is Offset) {
      final x = item.dx * width;
      final y = item.dy * height;
      if (isFirst) {
        path.moveTo(x, y);
        isFirst = false;
      } else {
        path.lineTo(x, y);
      }
    } else if (item is CustomBezier) {
      final controlX = item.control.dx * width;
      final controlY = item.control.dy * height;
      final endPointX = item.endPoint.dx * width;
      final endPointY = item.endPoint.dy * height;
      path.quadraticBezierTo(controlX, controlY, endPointX, endPointY);
    }
  }

  path.close();
  canvas.drawPath(path, paint);
}
