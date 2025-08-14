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
      bool paintBackground = false,
      Color? backgroundColor,
    }) {
  fontSize *= config.averageRatio;

  final defaultStyle = TextStyle(
    color: config.colorScheme.onSurface,
    fontSize: fontSize,
  );

  style = style?.copyWith(
    color: style.color ?? config.colorScheme.onSurface,
    fontSize: style.fontSize ?? fontSize,
  ) ?? defaultStyle;

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
  final adjustment = textPainter.height / 1.6;

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

  // Axis text overrides (as-is)
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

  // 🟢 Rotate around label's anchor point
  final rotationCenter = Offset(position.dx * width, position.dy * height);
  canvas.translate(rotationCenter.dx, rotationCenter.dy);
  canvas.rotate(angle);
  canvas.translate(-rotationCenter.dx, -rotationCenter.dy);

  // 🟡 Optional Background
  if (paintBackground) {
    const padding = 1.0;
    final bgRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        baseOffset.dx - padding,
        baseOffset.dy - padding,
        textPainter.width + padding * 2,
        textPainter.height + padding * 2,
      ),
      const Radius.circular(6),
    );

    final bgPaint = Paint()
      ..color = backgroundColor ?? config.colorScheme.scrim
      ..style = PaintingStyle.fill;

    canvas.drawRRect(bgRect, bgPaint);
  }

  // Draw text
  textPainter.paint(canvas, baseOffset);
  canvas.restore();
}
