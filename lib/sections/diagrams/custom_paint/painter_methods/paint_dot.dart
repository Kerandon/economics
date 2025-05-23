import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_text.dart';
import 'package:economics_app/sections/diagrams/enums/label_align.dart';
import 'package:economics_app/sections/diagrams/models/diagram_painter_config.dart';
import 'package:flutter/material.dart';

import '../painter_constants.dart';

void paintDot(
  DiagramPainterConfig config,
  Canvas canvas, {
  required Offset pos,
  double radius = kDotRadius,
  Color color = Colors.white,
  String? label,
  LabelAlign? labelAlign,
}) {
  color = config.colorScheme.onSurface;
  final size = config.painterSize;
  final width = config.painterSize.width;
  final height = config.painterSize.height;
  final normalize = 1 - (kAxisIndent * 1.5);
  final r = radius * config.averageRatio;
  final paint = Paint()
    ..color = color
    ..style = PaintingStyle.fill;
  canvas.drawCircle(
      Offset(
        ((pos.dx * size.width) * normalize) + (width * kAxisIndent),
        (pos.dy * size.height) * normalize + (height * (kAxisIndent / 2)),
      ),
      r,
      paint);
  if (label?.isNotEmpty == true) {
    paintText(
      config,
      canvas,
      label!,
      Offset(pos.dx * normalize + (kAxisIndent), (pos.dy * normalize) + (kAxisIndent/2)),
      fontSize: kFontSize,
      labelAlign: labelAlign ?? LabelAlign.centerTop,
    );
  }
}
