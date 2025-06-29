import 'package:flutter/material.dart';
import '../../enums/axis_label_margin.dart';

import '../../enums/indent.dart';
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
      AxisLabelMargin? axisLabelMargin,
      Indent? axisIndent,
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
    maxWidth: width,
  );

  Offset offset = Offset(position.dx * width, position.dy * height);

  double xAlign = 0;
  double yAlign = 0;
  final adjustment = textPainter.height / 2;

  switch (labelAlign) {
    case LabelAlign.center:
      xAlign = -textPainter.width / 2;
      yAlign = -textPainter.height / 2;
      break;
    case LabelAlign.centerLeft:
      xAlign = -textPainter.width - adjustment;
      yAlign = -textPainter.height / 2;
      break;
    case LabelAlign.centerRight:
      xAlign = adjustment;
      yAlign = -textPainter.height / 2;
      break;
    case LabelAlign.centerTop:
      xAlign = -textPainter.width / 2;
      yAlign = -textPainter.height - adjustment;
      break;
    case LabelAlign.centerBottom:
      xAlign = -textPainter.width / 2;
      yAlign = textPainter.height - adjustment;
      break;
  }

  offset = Offset(
    (position.dx * width) + xAlign,
    (position.dy * height) + yAlign,
  );

  if (axis != null) {
    final widthIndent = kAxisIndent * width;
    final heightIndent = kAxisIndent * height;
    final textWidth = textPainter.width;
    double textHeight = textPainter.height;

    // Handle vertical axis
    if (axis == Axis.vertical) {
      switch (axisLabelMargin!) {
        case AxisLabelMargin.close:
          textHeight *= 1.5;
          break;
        case AxisLabelMargin.middle:
          textHeight *= 3.0;
          break;
        case AxisLabelMargin.far:
          textHeight *= 5;
          break;
      }

      final centerTextOnVerticalAxis =
          (height - (heightIndent * 1.5) - textWidth) / 2;

      switch (axisIndent!) {
        case Indent.start:
          offset = Offset(
            widthIndent - textHeight,
            height - heightIndent * 1.1,
          );
          break;
        case Indent.center:
          offset = Offset(
            widthIndent - textHeight,
            height - (heightIndent * 1.1) - centerTextOnVerticalAxis,
          );
          break;
        case Indent.end:
          offset = Offset(
            widthIndent - textHeight,
            heightIndent / 2 + textWidth,
          );
          break;
      }
    }

    // Handle horizontal axis
    else if (axis == Axis.horizontal) {
      double horizontalAxis = (height - heightIndent + textHeight);

      switch (axisLabelMargin!) {
        case AxisLabelMargin.close:
          horizontalAxis += textHeight * 0;
          break;
        case AxisLabelMargin.middle:
          horizontalAxis += textHeight * 1.0;
          break;
        case AxisLabelMargin.far:
          horizontalAxis += textHeight * 2.0;
          break;
      }

      final centerTextOnHorizontalAxis =
          ((width - (widthIndent * 1.5) - textWidth) / 2) + widthIndent;

      switch (axisIndent!) {
        case Indent.start:
          offset = Offset(widthIndent, horizontalAxis);
          break;
        case Indent.center:
          offset = Offset(centerTextOnHorizontalAxis, horizontalAxis);
          break;
        case Indent.end:
          offset = Offset(width - (widthIndent / 2) - textWidth, horizontalAxis);
          break;
      }
    }
  }

  canvas.save();

  // Pivot logic
  final pivot = textPainter.size.centerLeft(offset);

  canvas.translate(pivot.dx, pivot.dy);
  canvas.rotate(angle);
  canvas.translate(-pivot.dx, -pivot.dy);

  textPainter.paint(canvas, offset);
  canvas.restore();
}
