import 'package:economics_app/sections/diagrams/custom_paint/painter_constants.dart';
import 'package:flutter/material.dart';

import '../custom_rotate.dart';

void paintRightAngleArrowCurves(
  Canvas canvas,
  Size size, {
  required double xPosL,
  required double xPosR,
  required double yPos,
  Color color = Colors.white,
  double strokeWidth = kCurveWidth,
  double curveHeight = 0.20,
  double angle = 0,
  double scale = 1,
  bool showLeftArrow = false,
  bool showRightArrow = false,
  bool removeFirstAngle = false,
  bool removeSecondAngle = false,
  bool flipHorizontally = false,
  bool flipVertically = false,
}) {
  final width = size.width;
  final height = size.height;
  final linePaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = color
    ..strokeWidth = strokeWidth;

  final widthL = xPosL * width;
  final widthR = xPosR * width;
  final heightPoints = yPos * height;
  final heightsTop = (yPos * height) - (curveHeight * height);

  final path = Path()
    ..moveTo(widthL, heightPoints)
    ..lineTo(widthL, heightsTop);
  if (!removeFirstAngle) {
    path.lineTo(widthR, heightsTop);
  }
  if (!removeSecondAngle) {
    path.lineTo(widthR, heightPoints);
  }

  canvas.save();

  if (flipVertically) {
    canvas.scale(1, -1);
    canvas.translate(0, -height);
  }
  if (flipHorizontally) {
    canvas.scale(-1, 1);
    canvas.translate(-width, 0);
  }

  customRotate(canvas, width / 2, height / 2, angle);
  canvas.translate(
      (width / 2) - (width / 2) * scale, (height / 2) - (height / 2) * scale);
  canvas.scale(scale);

  if (showLeftArrow) {

  }
  if (showRightArrow) {

  }
  canvas.drawPath(path, linePaint);

  canvas.restore();
}

