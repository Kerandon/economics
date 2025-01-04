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
  double angle = 0,

  // /// To align the label at the end of a curve
  LabelAlign curveAlign = LabelAlign.center,

  /// To label chart axis
  Axis? axis,
  AxisLabelMargin? axisLabelMargin,
  Indent? axisIndent,
}) {
  fontSize *= config.averageRatio;

  if (axis != null) {
    axisLabelMargin = AxisLabelMargin.far;
    axisIndent = Indent.end;
  }

  final width = config.painterSize.width;
  final height = config.painterSize.height;

  final textStyle = TextStyle(
    color: config.colorScheme.onSurface,
    fontSize: fontSize,
  );
  final textSpan = TextSpan(
    text: label,
    style: textStyle,
  );
  final textPainter = TextPainter(
    text: textSpan,
    textDirection: TextDirection.ltr,
  );

  textPainter.layout(
    minWidth: 0,
    maxWidth: width,
  );

  /// Aligns the labels on the end of curves
  Offset offset = Offset(position.dx * width, position.dy);

  double xAlign = 0;
  double yAlign = 0;
  const adjustment = 6.0;
  switch (curveAlign) {
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
    case LabelAlign.centerTop:
      xAlign = -textPainter.width / 2;
      yAlign = -textPainter.height - adjustment;
    case LabelAlign.centerBottom:
      xAlign = -textPainter.width / 2;
      yAlign = textPainter.height - adjustment;
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

    /// Aligns the labels on chart axis
    if (axis == Axis.vertical) {
      /// Add on a margin to the axis
      switch (axisLabelMargin!) {
        case AxisLabelMargin.close:
          textHeight = textHeight * 2.5;
        case AxisLabelMargin.middle:
          textHeight = textHeight * 2.5;
        case AxisLabelMargin.far:
          textHeight = textHeight * 2.5;
      }

      /// Centers text
      final centerTextOnVerticalAxis =
          (height - (heightIndent * 1.5) - textWidth) / 2;

      /// Main code to align text on chart axis
      switch (axisIndent!) {
        case Indent.start:
          offset = Offset(
            widthIndent - textHeight,
            height - heightIndent * 1.1,
          );
        case Indent.center:
          offset = Offset(
            widthIndent - textHeight,
            height - (heightIndent * 1.1) - centerTextOnVerticalAxis,
          );
        case Indent.end:
          offset = Offset(
            widthIndent - textHeight,
            heightIndent / 2 + textWidth,
          );
      }
    } else if (axis == Axis.horizontal) {
      double horizontalAxis = (height - heightIndent + textHeight);
      switch (axisLabelMargin!) {
        case AxisLabelMargin.close:
          horizontalAxis = horizontalAxis + textHeight * 1.00;
        case AxisLabelMargin.middle:
          horizontalAxis = horizontalAxis + textHeight * 1.00;
        case AxisLabelMargin.far:
          horizontalAxis = horizontalAxis + textHeight * 1.00;
      }

      /// Centers text
      final centerTextOnHorizontalAxis =
          ((width - (widthIndent * 1.5) - textWidth) / 2) + widthIndent;

      switch (axisIndent!) {
        case Indent.start:
          offset = Offset(widthIndent, horizontalAxis);
        case Indent.center:
          offset = Offset(centerTextOnHorizontalAxis, horizontalAxis);
        case Indent.end:
          offset =
              Offset(width - (widthIndent / 2) - textWidth, horizontalAxis);
      }
    }
  }

  canvas.save();
  final pivot = textPainter.size.centerLeft(offset);

  canvas.translate(pivot.dx, pivot.dy);
  canvas.rotate(angle);
  canvas.translate(-pivot.dx, -pivot.dy);

  canvas.translate(position.dx, position.dy);

  textPainter.paint(canvas, offset);
  canvas.restore();
}
