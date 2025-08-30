import 'package:flutter/material.dart';

import 'axis/label_align.dart';
import '../../models/diagram_painter_config.dart';
import '../painter_constants.dart';

void paintTextNormalizedWithinAxis(
  DiagramPainterConfig config,
  Canvas canvas,
  String label,
  Offset position, {
  Offset? pointerLine,
  double fontSize = kFontSize,
  TextStyle? style,
  double angle = 0,
  LabelAlign align = LabelAlign.center,
}) {
  final width = config.painterSize.width;
  final height = config.painterSize.height;
  fontSize *= config.averageRatio;

  final defaultStyle = TextStyle(
    color: config.colorScheme.onSurface,
    fontSize: fontSize,
  );

  style =
      style?.copyWith(
        color: style.color ?? config.colorScheme.onSurface,
        fontSize: (style.fontSize ?? kFontSize) * config.averageRatio,
      ) ??
      defaultStyle;

  final normalizedWidth = width - ((kAxisIndent * 1.5) * width);
  final normalizedHeight = height - ((kAxisIndent * 1.5) * height);

  final textSpan = TextSpan(text: label, style: style);
  final textPainter = TextPainter(
    text: textSpan,
    textDirection: TextDirection.ltr,
  );

  textPainter.layout(minWidth: 0, maxWidth: normalizedWidth);

  double alignmentX = 0;
  double alignmentY = 0;
  switch (align) {
    case LabelAlign.center:
      alignmentX = textPainter.width / 2;
      alignmentY = textPainter.height / 2;
    case LabelAlign.centerLeft:
      alignmentX = textPainter.width;
      alignmentY = textPainter.height / 2;
    case LabelAlign.centerRight:
      alignmentX = -textPainter.width;
      alignmentY = textPainter.height / 2;
    case LabelAlign.centerTop:
      alignmentX = textPainter.width / 2;
      alignmentY = 0;
    case LabelAlign.centerBottom:
      alignmentX = textPainter.width / 2;
      alignmentY = textPainter.height;
  }

  /// First get the position, second align to the right to start from the YAxis, third center the text
  final w =
      (normalizedWidth * position.dx) + (kAxisIndent * width) - alignmentX;

  /// First get the position, second align to the top of the YAxis, third center the text
  final h =
      (normalizedHeight * position.dy) +
      ((kAxisIndent / 2) * height) -
      alignmentY;
  //(kAxisIndent / 2) * height - (textPainter.height / 2) + normalizedHeight;

  Offset offset = Offset(w, h);

  /// Start pos centered for textbox fill and line
  final startPos = Offset(
    w + (textPainter.width / 2),
    h + (textPainter.height / 2),
  );
  if (pointerLine != null) {
    final lineEndX = (normalizedWidth * pointerLine.dx) + (kAxisIndent * width);
    final lineEndY =
        (normalizedHeight * pointerLine.dy) + ((kAxisIndent / 2) * height);
    final linePaint = Paint()
      ..color = config.colorScheme.onSurface
      ..strokeWidth = kCurveWidth / 5;
    canvas.drawLine(startPos, Offset(lineEndX, lineEndY), linePaint);

    canvas.drawCircle(Offset(lineEndX, lineEndY), 3, linePaint);
  }

  /// White background box

  final textBoxPadding = 15 * config.averageRatio;
  final boxPaintFill = Paint()
    ..style = PaintingStyle.fill
    ..color = config.colorScheme.surface;
  final boxPathFill = Path()
    ..addRect(
      Rect.fromCenter(
        center: startPos,
        width: textPainter.width + textBoxPadding,
        height: textPainter.height + textBoxPadding,
      ),
    );
  canvas.drawPath(boxPathFill, boxPaintFill);

  canvas.save();

  // Pivot logic
  final pivot = textPainter.size.centerLeft(offset);

  canvas.translate(pivot.dx, pivot.dy);
  canvas.rotate(angle);
  canvas.translate(-pivot.dx, -pivot.dy);

  textPainter.paint(canvas, offset);
  canvas.restore();
}
