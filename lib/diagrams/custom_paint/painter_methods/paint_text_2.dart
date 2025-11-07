import 'package:flutter/material.dart';

import 'axis/label_align.dart';
import '../../models/diagram_painter_config.dart';
import '../painter_constants.dart';
enum LabelPivot {
  left,    // text starts at anchor, grows right
  center,  // text centered on anchor
  right,   // text ends at anchor, grows left
  top,     // text aligned to top of anchor
  middle,  // text vertically centered
  bottom,  // text aligned to bottom of anchor
}
void paintText2(
    DiagramPainterConfig config,
    Canvas canvas,
    String label,
    Offset position, {
      Offset? pointerLine,
      double fontSize = kFontMedium,
      TextStyle? style,
      double angle = 0,
      LabelPivot horizontalPivot = LabelPivot.center,
      LabelPivot verticalPivot = LabelPivot.middle,
      bool normalize = true,
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
    fontSize: (style.fontSize ?? kFontMedium) * config.averageRatio,
  ) ??
      defaultStyle;

  final textSpan = TextSpan(text: label, style: style);
  final textPainter = TextPainter(
    text: textSpan,
    textDirection: TextDirection.ltr,
  );
  textPainter.layout(minWidth: 0, maxWidth: width);

  // Horizontal alignment offset
  double alignmentX = 0;
  switch (horizontalPivot) {
    case LabelPivot.left:
      alignmentX = 0;
      break;
    case LabelPivot.center:
      alignmentX = textPainter.width / 2;
      break;
    case LabelPivot.right:
      alignmentX = textPainter.width;
      break;
    default:
      alignmentX = textPainter.width / 2;
  }

  // Vertical alignment offset
  double alignmentY = 0;
  switch (verticalPivot) {
    case LabelPivot.top:
      alignmentY = 0;
      break;
    case LabelPivot.middle:
      alignmentY = textPainter.height / 2;
      break;
    case LabelPivot.bottom:
      alignmentY = textPainter.height;
      break;
    default:
      alignmentY = textPainter.height / 2;
  }

  // --- Compute text offset (already correct) ---
  final leftMarginRatio = 1.5;
  final rightMarginRatio = 0.5;
  final topMarginRatio = 0.5;
  final bottomMarginRatio = 1.5;

  // Normalized width/height of the drawable chart area
  final normalizedWidthRatio = 1.0 - leftMarginRatio * kAxisIndent - rightMarginRatio * kAxisIndent;
  final normalizedHeightRatio = 1.0 - topMarginRatio * kAxisIndent - bottomMarginRatio * kAxisIndent;

  // X calculation for text
  double w = normalize
      ? (width * normalizedWidthRatio) * position.dx + leftMarginRatio * kAxisIndent * width
      : width * position.dx;

  // H calculation for text (slightly complex due to vertical alignment logic)
  // Let's rely on the original logic for H for now, as you stated it's correct.
  double h = normalize
      ? (height - 2 * kAxisIndent * height - textPainter.height) * position.dy +
      (kAxisIndent / 2 * height) +
      textPainter.height / 2
      : height * position.dy;

  final offset = Offset(w - alignmentX, h - alignmentY);
  // ---------------------------------------------


  // Draw pointer line if provided
  if (pointerLine != null) {
    // --- START: CORRECTED POINTER LINE LOGIC ---
    // The normalized chart area starts at 1.5*kAxisIndent (left) and 0.5*kAxisIndent (top)
    // and has a total normalized width/height matching the text's area.

    final normalizedChartWidth = width * normalizedWidthRatio;
    final normalizedChartHeight = height * normalizedHeightRatio;
    final xStartOffset = leftMarginRatio * kAxisIndent * width;
    final yStartOffset = topMarginRatio * kAxisIndent * height;

    final lineEndX = normalize
        ? normalizedChartWidth * pointerLine.dx + xStartOffset
        : width * pointerLine.dx;
    final lineEndY = normalize
        ? normalizedChartHeight * pointerLine.dy + yStartOffset
        : height * pointerLine.dy;

    // --- END: CORRECTED POINTER LINE LOGIC ---

    final linePaint = Paint()
      ..color = config.colorScheme.onSurface
      ..strokeWidth = kCurveWidth / 5;

    final startPos = offset + Offset(alignmentX, alignmentY);
    canvas.drawLine(startPos, Offset(lineEndX, lineEndY), linePaint);
    canvas.drawCircle(Offset(lineEndX, lineEndY), 3, linePaint);
  }

  // Draw background box aligned perfectly with text
  final textBoxPadding = 0.50;
  final boxPaintFill = Paint()
    ..style = PaintingStyle.fill
    ..color = config.colorScheme.surface;

  final boxRect = Rect.fromLTWH(
    offset.dx - textBoxPadding / 2,
    offset.dy - textBoxPadding / 2,
    textPainter.width + textBoxPadding,
    textPainter.height + textBoxPadding,
  );

  canvas.drawRect(boxRect, boxPaintFill);

  // Draw rotated text
  canvas.save();
  final pivotPoint = offset + Offset(alignmentX, alignmentY);
  canvas.translate(pivotPoint.dx, pivotPoint.dy);
  canvas.rotate(angle);
  canvas.translate(-pivotPoint.dx, -pivotPoint.dy);
  textPainter.paint(canvas, offset);
  canvas.restore();
}