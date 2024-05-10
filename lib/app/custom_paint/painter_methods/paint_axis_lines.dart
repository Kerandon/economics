import 'package:economics_app/app/custom_paint/painter_constants.dart';
import 'package:flutter/material.dart';

void paintAxisLines(Size size, Canvas canvas,
    {Color color = Colors.white, double strokeWidth = kAxisWidth}) {
  final double width = size.width;
  final double height = size.height;

  final axisPaint = Paint()
    ..color = color
    ..strokeWidth = kAxisWidth;

  final startYOffset = Offset(width * kAxisIndent, height * kAxisIndent / 2);
  final endYOffset = Offset(width * kAxisIndent, height * (1 - kAxisIndent));
  final startXOffset = Offset(width * kAxisIndent, height * (1 - kAxisIndent));
  final endXOffset =
      Offset(width * (1 - kAxisIndent / 2), height * (1 - kAxisIndent));
  canvas
    ..drawLine(startYOffset, endYOffset, axisPaint)
    ..drawLine(startXOffset, endXOffset, axisPaint);

  /// Arrow-head

  final path = Path();
  final paint = Paint()..color = Colors.white;

  final arrowWidth = kAxisArrowHeadWidth * size.width;
  final arrowHeight = (kAxisArrowHeadWidth * 1.5) * size.width;

  /// Y Axis Arrow
  path
    ..moveTo(startYOffset.dx, startYOffset.dy - arrowHeight)
    ..lineTo(startYOffset.dx + arrowWidth, startYOffset.dy)
    ..lineTo(startYOffset.dx - arrowWidth, startYOffset.dy);

  /// X Axis Arrow
  path
    ..moveTo(endXOffset.dx + arrowHeight, endXOffset.dy)
    ..lineTo(endXOffset.dx, endXOffset.dy + arrowWidth)
    ..lineTo(endXOffset.dx, endXOffset.dy - arrowWidth);

  canvas.save();
  canvas.drawPath(path, paint);
  canvas.restore();
}
