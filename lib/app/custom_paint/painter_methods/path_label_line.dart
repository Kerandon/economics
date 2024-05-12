import 'package:economics_app/app/custom_paint/painter_methods/paint_text.dart';
import 'package:flutter/material.dart';

import '../paint_enums/custom_align.dart';
import '../painter_constants.dart';

void paintLabelLine(Canvas canvas, Size size, String text, Offset p1, Offset p2,
    {Color lineColor = Colors.white,
    Color fontColor = Colors.white,
    CustomAlign textAlign = CustomAlign.center,
    bool removeDot = false}) {
  final paint = Paint()
    ..strokeCap = StrokeCap.round
    ..strokeWidth = kLabelLineWidth
    ..color = lineColor;
  canvas.save();
  canvas.drawLine(p1, p2, paint);
  paintText(size, canvas, text, Offset(p2.dx, p2.dy),
      align: textAlign, color: fontColor);

  if (!removeDot) {
    canvas.drawCircle(p1, 3, paint);
  }

  canvas.restore();
}
