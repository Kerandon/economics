import 'package:flutter/material.dart';
import '../../enums/shade_type.dart';
import '../../models/custom_bezier.dart';
import '../painter_constants.dart';

/// for pointsAndBeziers, takes [Offset] and [CustomBezier]
void paintShading(
    Canvas canvas, Size size, ShadeType shade, List<dynamic> pointsAndBeziers) {



  final width = size.width;
  final height = size.height;
  final normalize = 1 - (kAxisIndent * 1.5);



  final paint = Paint()
    ..style = PaintingStyle.fill
    ..color = shade.setShadeColor();

  if (pointsAndBeziers.isEmpty) return;

  final path = Path();
  bool isFirst = true;

  for (int i = 0; i < pointsAndBeziers.length; i++) {
    final item = pointsAndBeziers[i];

    if (item is Offset) {
      final x = item.dx * width * normalize + (kAxisIndent * width);
      final y = item.dy * height * normalize + (kAxisIndent * (height / 2));
      if (isFirst) {
        path.moveTo(x, y);
        isFirst = false;
      } else {
        path.lineTo(x, y);
      }
    } else if (item is CustomBezier) {
      final controlX = item.control.dx * width * normalize + (kAxisIndent * width);
      final controlY = item.control.dy * height * normalize + (kAxisIndent * (height / 2));
      final endPointX = item.endPoint.dx * width * normalize + (kAxisIndent * width);
      final endPointY = item.endPoint.dy * height * normalize + (kAxisIndent * (height / 2));
      path.quadraticBezierTo(controlX, controlY, endPointX, endPointY);
    }
  }

  path.close();
  canvas.drawPath(path, paint);
}
