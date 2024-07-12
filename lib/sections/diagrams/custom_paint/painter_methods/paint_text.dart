import 'package:flutter/material.dart';
import '../../enums/axis_label_margin.dart';
import '../../enums/curve_align.dart';
import '../../enums/indent.dart';
import '../painter_constants.dart';

void paintText(
  Size size,
  Canvas canvas,
  String text,
  Offset position, {
  Color color = Colors.white,
  double fontSize = kFontSize,
  double angle = 0,

  /// To align the label at the end of a curve
  CurveAlign? customAlign,

  /// To label chart axis
  Axis? axis,
  AxisLabelMargin axisMargin = AxisLabelMargin.close,
  Indent indent = Indent.center,
}) {
  final width = size.width;
  final height = size.height;

  final textStyle = TextStyle(
    color: color,
    fontSize: fontSize,
  );
  final textSpan = TextSpan(
    text: text,
    style: textStyle,
  );
  final textPainter = TextPainter(
    text: textSpan,
    textDirection: TextDirection.ltr,
  );

  textPainter.layout(
    minWidth: 0,
    maxWidth: size.width,
  );

  /// Aligns the labels on the end of curves
  Offset offset = const Offset(0, 0);

  if (customAlign != null) {
    double xAlign = 0;
    double yAlign = 0;
    const adjustment = 6.0;
    switch (customAlign) {
      case CurveAlign.center:
        xAlign = -textPainter.width / 2;
        yAlign = -textPainter.height / 2;
        break;
      case CurveAlign.centerLeft:
        xAlign = -textPainter.width - adjustment;
        yAlign = -textPainter.height / 2;
        break;
      case CurveAlign.centerRight:
        xAlign = adjustment;
        yAlign = -textPainter.height / 2;
      case CurveAlign.centerTop:
        xAlign = -textPainter.width / 2;
        yAlign = -textPainter.height - adjustment;
      case CurveAlign.centerBottom:
        xAlign = -textPainter.width / 2;
        yAlign = textPainter.height - adjustment;
    }
    offset = Offset(
      (position.dx * size.width) + xAlign,
      (position.dy * size.height) + yAlign,
    );
  }
  final widthIndent = kAxisIndent * width;
  final heightIndent = kAxisIndent * height;
  final textWidth = textPainter.width;
  double textHeight = textPainter.height;

  /// Aligns the labels on chart axis
  if (axis == Axis.vertical) {
    /// Add on a margin to the axis
    switch (axisMargin) {
      case AxisLabelMargin.close:
        textHeight = textHeight * 1.5;
      case AxisLabelMargin.middle:
        textHeight = textHeight * 2.5;
      case AxisLabelMargin.far:
        textHeight = textHeight * 3.6;
    }

    /// Centers text
    final centerTextOnVerticalAxis =
        (height - (heightIndent * 1.5) - textWidth) / 2;

    /// Main code to align text on chart axis
    switch (indent) {
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
    double horizontalAxis = (height - heightIndent + textHeight / 2);
    switch (axisMargin) {
      case AxisLabelMargin.close:
        horizontalAxis = horizontalAxis + textHeight * 0.50;
      case AxisLabelMargin.middle:
        horizontalAxis = horizontalAxis + textHeight * 1.5;
      case AxisLabelMargin.far:
        horizontalAxis = horizontalAxis + textHeight * 2.6;
    }

    /// Centers text
    final centerTextOnHorizontalAxis =
        ((width - (widthIndent * 1.5) - textWidth) / 2) + widthIndent;

    switch (indent) {
      case Indent.start:
        offset = Offset(widthIndent, horizontalAxis);
      case Indent.center:
        offset = Offset(centerTextOnHorizontalAxis, horizontalAxis);
      case Indent.end:
        offset = Offset(width - (widthIndent / 2) - textWidth, horizontalAxis);
    }
  }

  canvas.save();
  final pivot = textPainter.size.centerLeft(offset);
  canvas.translate(pivot.dx, pivot.dy);
  canvas.rotate(angle);
  canvas.translate(-pivot.dx, -pivot.dy);
  textPainter.paint(canvas, offset);
  canvas.restore();
}
