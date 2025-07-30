import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../enums/label_align.dart';
import '../../models/diagram_painter_config.dart';
import '../painter_constants.dart';

void paintText(
    DiagramPainterConfig config,
    Canvas canvas,
    String label,
    Offset position, {
      double fontSize = kFontSize,
      TextStyle? style,
      double angle = 0,
      LabelAlign labelAlign = LabelAlign.center,
      Axis? axis,
      bool? yLabelIsVertical,
    }) {
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

  final width = config.painterSize.width;
  final height = config.painterSize.height;

  final textSpan = TextSpan(text: label, style: style);
  final textPainter = TextPainter(
    text: textSpan,
    textDirection: TextDirection.ltr,
  );
  textPainter.layout(minWidth: 0, maxWidth: width);

  Offset baseOffset = Offset(position.dx * width, position.dy * height);

  double dx = 0;
  double dy = 0;
  final adjustment = textPainter.height / 2;

  switch (labelAlign) {
    case LabelAlign.center:
      dx = -textPainter.width / 2;
      dy = -textPainter.height / 2;
      break;
    case LabelAlign.centerLeft:
      dx = -textPainter.width - adjustment;
      dy = -textPainter.height / 2;
      break;
    case LabelAlign.centerRight:
      dx = adjustment;
      dy = -textPainter.height / 2;
      break;
    case LabelAlign.centerTop:
      dx = -textPainter.width / 2;
      dy = -textPainter.height - adjustment;
      break;
    case LabelAlign.centerBottom:
      dx = -textPainter.width / 2;
      dy = adjustment;
      break;
  }

  baseOffset = baseOffset.translate(dx, dy);

  // Axis text overrides (kept as-is for labels along axes)
  if (axis != null) {
    final widthIndent = kAxisIndent * width;
    final heightIndent = kAxisIndent * height;
    final textWidth = textPainter.width;
    final textYIndent = kAxisTextIndent * (config.painterSize.width);

    if (axis == Axis.vertical) {
      baseOffset = Offset(
        -textWidth + widthIndent - textYIndent,
        heightIndent / 2,
      );

      if (yLabelIsVertical == true) {
        baseOffset = Offset(
          widthIndent - textYIndent,
          heightIndent / 2 + textWidth,
        );
        angle = math.pi / -2;
      }
    } else if (axis == Axis.horizontal) {
      double horizontalAxis = height - heightIndent + kAxisTextIndent;
      horizontalAxis += kAxisTextIndent * width;
      baseOffset = Offset(width - (widthIndent / 2) - textWidth, horizontalAxis);
    }
  }

  canvas.save();

  // 🟢 Fix: Rotate around actual label anchor point (before alignment offset)
  final rotationCenter = Offset(position.dx * width, position.dy * height);

  canvas.translate(rotationCenter.dx, rotationCenter.dy);
  canvas.rotate(angle);
  canvas.translate(-rotationCenter.dx, -rotationCenter.dy);

  textPainter.paint(canvas, baseOffset);
  canvas.restore();
}
