import 'package:flutter/material.dart';

import '../../../models/diagram_painter_config.dart';
import '../../painter_constants.dart';
import '../axis/label_align.dart';

void paintLabelText(
  Canvas canvas,
  DiagramPainterConfig config,
  String label,
  Offset pos, {
  Color? backgroundColor,
  LabelAlign labelAlign = LabelAlign.center,
}) {
  final widthAndHeight = config.painterSize.width;
  final fontSize = kFontMedium * config.averageRatio;
  final padding = widthAndHeight * 0.01;

  /// Text Painter Methods
  final style = TextStyle(
    color: config.colorScheme.onSurface,
    fontSize: fontSize,
  );
  final textSpan = TextSpan(text: label, style: style);
  final textPainter = TextPainter(
    text: textSpan,
    textDirection: TextDirection.ltr,
  );
  textPainter.layout(minWidth: 0, maxWidth: widthAndHeight);
  Offset baseOffset = Offset(pos.dx * widthAndHeight, pos.dy * widthAndHeight);

  double dx = 0;
  double dy = 0;

  switch (labelAlign) {
    case LabelAlign.center:
      dx = -textPainter.width / 2;
      dy = -textPainter.height / 2;
      break;
    case LabelAlign.centerLeft:
      dx = -textPainter.width - padding;
      dy = -textPainter.height / 2;
      break;
    case LabelAlign.centerRight:
      dx = padding;
      dy = -textPainter.height / 2;
      break;
    case LabelAlign.centerTop:
      dx = -textPainter.width / 2;
      dy = -textPainter.height - padding;
      break;
    case LabelAlign.centerBottom:
      dx = -textPainter.width / 2;
      dy = padding;
      break;
  }

  baseOffset = baseOffset.translate(dx, dy);
  if (backgroundColor != null) {
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
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    canvas.drawRRect(bgRect, bgPaint);
  }

  textPainter.paint(canvas, baseOffset);
}
