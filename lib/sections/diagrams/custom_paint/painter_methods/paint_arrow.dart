import 'package:flutter/material.dart';

import '../custom_rotate.dart';

void paintArrow(Size size, Canvas canvas, Offset position,
    {Color color = Colors.white,
    scale = 0.10,
    double angle = 0,
    bool hideArrowStick = false,
    double arrowStickExtension = 0,
    bool oppositeArrowHead = false}) {
  final Paint paint = Paint()..color = color;
  final width = size.width;
  final height = size.height;

  const double arrowStickWidth = 0.01;
  final double extension = (arrowStickExtension * width) / 2;

  /// Arrow-head

  const double arrowHeadWidth = 0.20;
  Path path = paintArrowHead(canvas, size, paint,
      extension: extension,
      arrowHeadWidth: arrowHeadWidth,
      drawOpposite: oppositeArrowHead);

  if (!hideArrowStick) {
    /// Add the arrow stick
    path.addRect(
      Rect.fromPoints(
        Offset(width - (width * arrowHeadWidth) + extension,
            height * (0.50 + arrowStickWidth)),
        Offset(
          (width * arrowHeadWidth) - extension,
          height * (0.50 - arrowStickWidth),
        ),
      ),
    );
  }

  /// Change position, scale, rotation
  canvas.save();
  canvas.translate(position.dx * width, position.dy * height);
  canvas.scale(scale);
  customRotate(canvas, width * 0.50, height * 0.50, angle);
  canvas.drawPath(path, paint);
  canvas.restore();
}

Path paintArrowHead(Canvas canvas, Size size, Paint paint,
    {required double extension,
    required double arrowHeadWidth,
    required bool drawOpposite}) {
  final width = size.width;
  final height = size.height;
  final endWidth = (1 - arrowHeadWidth) * width;
  final headHeight = width * (arrowHeadWidth / 2.5);

  final path = Path()
    ..moveTo(width + extension, height / 2)
    ..lineTo(endWidth + extension, (height / 2) - headHeight)
    ..lineTo(endWidth + extension, (height / 2) + headHeight)
    ..close(); // Close the path for the arrowhead

// If drawOpposite is true, draw an arrow facing the opposite direction
  if (drawOpposite) {
    path
      ..moveTo(-extension, height / 2)
      ..lineTo((width * arrowHeadWidth) - extension, (height / 2) - headHeight)
      ..lineTo((width * arrowHeadWidth - extension), (height / 2) + headHeight)
      ..close(); // Close the path for the opposite arrowhead
  }

  return path;
}
