import 'package:flutter/material.dart';
import '../../diagram_enums/custom_align.dart';
import '../painter_constants.dart';
import 'paint_text.dart';

void paintLabelLine(Canvas canvas, Size size, String text, Offset p1, Offset p2,
    {Color lineColor = Colors.white,
    Color fontColor = Colors.white,
    CustomAlign textAlign = CustomAlign.center,
    bool removeDot = false}) {
  final width = size.width;
  final height = size.height;
  final paint = Paint()
    ..strokeCap = StrokeCap.round
    ..strokeWidth = kLabelLineWidth / 2
    ..color = lineColor;
  canvas.save();
  canvas.drawLine(Offset(p1.dx * width, p1.dy * height),
      Offset(p2.dx * width, p2.dy * height), paint);
  paintText(size, canvas, text, Offset(p2.dx, p2.dy),
      align: textAlign, color: fontColor);

  if (!removeDot) {
    canvas.drawCircle(Offset(p1.dx * width, p1.dy * height), 3, paint);
  }

  canvas.restore();
}
