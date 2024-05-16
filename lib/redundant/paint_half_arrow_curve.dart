// import 'dart:math' as math;
// import 'package:flutter/material.dart';
//
// import '../custom_rotate.dart';
//
// void paintHalfArrowCurve(Canvas canvas, Size size,
//     {color = Colors.white,
//       double angle = 0,
//       Offset? pos,
//       bool leftArrow = true,
//       bool rightArrow = false,
//       double scale = 1,
//       int sweep = 1}) {
//   final width = size.width;
//   final height = size.height;
//   final baseWidth = size.width * scale;
//   final baseHeight = size.height * scale;
//   pos ??= const Offset(0, 0);
//
//   /// Change position, scale, rotation
//   canvas.save();
//   final curvedArrowPaint = Paint()
//     ..style = PaintingStyle.stroke
//     ..strokeWidth = 1
//     ..color = color;
//
//   final rect = Rect.fromCenter(
//       center: Offset(width * 0.50, height * 0.50),
//       width: baseWidth / 2,
//       height: baseHeight / 4);
//   final curvedArrowPath = Path()
//     ..addArc(rect, 0, math.pi / sweep); // Quarter pi angle
//
//   // Adjust the canvas transformation to keep it centered when scaling
//   final centerX = width / 2;
//   final centerY = height / 2;
//   canvas.translate(centerX, centerY);
//   canvas.scale(scale);
//   canvas.translate(-centerX, -centerY);
//   canvas.translate(pos.dx, pos.dy);
//   customRotate(canvas, width * 0.50, height * 0.50, angle);
//
//   canvas.drawPath(curvedArrowPath, curvedArrowPaint);
//
//   if (leftArrow) {
//     // Calculate the position for the left arrowhead
//     final leftArrowPos = calculateArcEnd(rect, 0);
//     canvas.save();
//     canvas.translate(leftArrowPos.dx, leftArrowPos.dy);
//     paintCurvedArrowHead(canvas, size, Offset(0, 0));
//     canvas.restore();
//   }
//   if (rightArrow) {
//     // Calculate the position for the right arrowhead
//     final rightArrowPos =
//     calculateArcEnd(rect, math.pi / sweep); // Adjusted sweep angle
//     canvas.save();
//     canvas.translate(rightArrowPos.dx, rightArrowPos.dy);
//     canvas.rotate(math.pi * 2); // Rotate the right arrow by 180 degrees
//     paintCurvedArrowHead(canvas, size, Offset(0, 0));
//     canvas.restore();
//   }
//
//   canvas.restore();
// }
//
// Offset calculateArcEnd(Rect rect, double angle) {
//   final radiusX = rect.width / 2;
//   final radiusY = rect.height / 2;
//   final centerX = rect.center.dx;
//   final centerY = rect.center.dy;
//
//   final x = centerX + radiusX * math.cos(angle);
//   final y = centerY + radiusY * math.sin(angle);
//
//   return Offset(x, y);
// }
//
// void paintCurvedArrowHead(Canvas canvas, Size size, Offset startPos,
//     {Color color = Colors.white}) {
//   final width = size.width;
//   final height = size.height;
//   final paint = Paint()
//     ..style = PaintingStyle.fill
//     ..color = color;
//
//   final widthAdjustment = width * 0.015;
//   final heightAdjustment = height * 0.02;
//
//   final path = Path()
//     ..moveTo(startPos.dx, startPos.dy - heightAdjustment)
//     ..lineTo(startPos.dx - widthAdjustment, startPos.dy)
//     ..lineTo(startPos.dx + widthAdjustment, startPos.dy)
//     ..close();
//   canvas.save();
//   canvas.drawPath(path, paint);
//   canvas.restore();
// }
