
import 'package:flutter/material.dart';

import '../../models/diagram_painter_config.dart';
import '../painter_constants.dart';

void paintTextNormalizedWithinAxis(
    DiagramPainterConfig config,
    Canvas canvas,
    String label,
    Offset position, {
      double fontSize = kFontSize,
      TextStyle? style,
      double angle = 0,
    }) {
  final width = config.painterSize.width;
  final height = config.painterSize.height;
  fontSize *= config.averageRatio;

  final defaultStyle = TextStyle(
    color: config.colorScheme.onSurface,
    fontSize: fontSize,
  );

  style = style?.copyWith(
    color: style.color ?? config.colorScheme.onSurface,
    fontSize: style.fontSize ?? fontSize,
  ) ??
      defaultStyle;

  final normalizedWidth = width - ((kAxisIndent * 1.5) * width);
  final normalizedHeight = height - ((kAxisIndent * 1.5) * height);


  final textSpan = TextSpan(
    text: label,
    style: style,
  );
  final textPainter = TextPainter(
    text: textSpan,
    textDirection: TextDirection.ltr,
  );

  textPainter.layout(
    minWidth: 0,
    maxWidth: normalizedWidth,
  );

  /// First get the position, second align to the right to start from the YAxis, third center the text
  final w = (normalizedWidth * position.dx) +
      (kAxisIndent * width) -
      (textPainter.width / 2);

  /// First get the position, second align to the top of the YAxis, third center the text
  final h = (kAxisIndent / 2) * height - (textPainter.height / 2) + normalizedHeight;


  Offset offset = Offset(w, h);

  canvas.save();

  // Pivot logic
  final pivot = textPainter.size.centerLeft(offset);

  canvas.translate(pivot.dx, pivot.dy);
  canvas.rotate(angle);
  canvas.translate(-pivot.dx, -pivot.dy);

  textPainter.paint(canvas, offset);
  canvas.restore();
}
