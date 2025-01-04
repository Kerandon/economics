import 'package:flutter/material.dart';

import '../../enums/label_align.dart';
import '../../models/diagram_painter_config.dart';
import '../painter_constants.dart';
import 'paint_text.dart';

void paintLabelLine(DiagramPainterConfig config, Canvas canvas, String text,
    Offset p1, Offset p2,
    {LabelAlign textAlign = LabelAlign.center, bool removeDot = false}) {
  final width = config.appSize.width;
  final height = config.appSize.height;
  final paint = Paint()
    ..strokeCap = StrokeCap.round
    ..strokeWidth = kLabelLineWidth / 2
    ..color = config.colorScheme.onSurface;
  canvas.save();
  canvas.drawLine(Offset(p1.dx * width, p1.dy * height),
      Offset(p2.dx * width, p2.dy * height), paint);
  paintText(config, canvas, text, Offset(p2.dx, p2.dy), curveAlign: textAlign);

  if (!removeDot) {
    canvas.drawCircle(Offset(p1.dx * width, p1.dy * height), 3, paint);
  }

  canvas.restore();
}
