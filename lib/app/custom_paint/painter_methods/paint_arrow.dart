import 'package:flutter/material.dart';

import '../custom_rotate.dart';

void paintArrow(Size size, Canvas canvas, Offset position,
    {Color color = Colors.white, scale = 0.08, double angle = 0}) {
  final Paint axisPaint = Paint()..color = color;
  final width = size.width;
  final height = size.height;

  const double arrowHeadWidth = 0.70;
  const double arrowHeadHeight = 0.35;
  const double arrowHeadIndent = 0.10;
  const double arrowStickWidth = 0.02;

  /// Arrow-head
  final path = Path()
    ..moveTo(width * arrowHeadWidth, height * arrowHeadHeight)
    ..lineTo(width, height * 0.50)
    ..lineTo(width * arrowHeadWidth, height * (1 - arrowHeadHeight))

    /// Arrow head base slopes in
    //..lineTo(width * arrowHeadWidth + (width * arrowHeadIndent), height * 0.50)
    ..close();

  /// Add the arrow stick
  path.addRect(
    Rect.fromPoints(
      Offset(width * arrowHeadWidth + (width * arrowHeadIndent),
          height * (0.50 + arrowStickWidth)),
      Offset(
        0,
        height * (0.50 - arrowStickWidth),
      ),
    ),
  );

  /// Change position, scale, rotation
  canvas.save();
  canvas.translate(position.dx, position.dy);
  canvas.scale(scale);
  customRotate(canvas, width * 0.50, height * 0.50, angle);
  canvas.drawPath(path, axisPaint);
  canvas.restore();
}
