import 'package:flutter/material.dart';

import '../i_diagram_canvas.dart';

import '../../models/diagram_painter_config.dart';
import '../painter_constants.dart';

enum LabelPivot {
  left, // text starts at anchor, grows right
  center, // text centered on anchor
  right, // text ends at anchor, grows left
  top, // text aligned to top of anchor
  middle, // text vertically centered
  bottom, // text aligned to bottom of anchor
}
void paintText2(
    DiagramPainterConfig config,
    Canvas? canvas,
    String label,
    Offset position, {
      IDiagramCanvas? iCanvas,
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

  // 1. Setup Style and TextPainter
  final bool isDarkTheme = config.colorScheme.brightness == Brightness.dark;
  final Color perfectSurface = isDarkTheme ? Colors.black : Colors.white;
  final Color perfectOnSurface = isDarkTheme ? Colors.white : Colors.black87;

  style = style?.copyWith(
    color: style.color ?? perfectOnSurface,
    fontSize: (style.fontSize ?? kFontMedium) * config.averageRatio,
  ) ??
      TextStyle(color: perfectOnSurface, fontSize: fontSize * config.averageRatio);

  final textPainter = TextPainter(
    text: TextSpan(text: label, style: style),
    textDirection: TextDirection.ltr,
  )..layout(minWidth: 0, maxWidth: width);

  // 2. Calculate Alignment Offsets
  // These determine the point on the text box that connects to the "position"
  double alignmentX = 0;
  if (horizontalPivot == LabelPivot.center) alignmentX = textPainter.width / 2;
  if (horizontalPivot == LabelPivot.right) alignmentX = textPainter.width;

  double alignmentY = 0;
  // CHANGED: alignmentY should be positive to move the 'top' of the text
  // relative to the anchor point.
  if (verticalPivot == LabelPivot.middle) alignmentY = textPainter.height / 2;
  if (verticalPivot == LabelPivot.bottom) alignmentY = textPainter.height;

  // 3. Normalize Position Coordinates
  const leftMarginRatio = 1.0;
  const rightMarginRatio = 1.0;
  const topMarginRatio = kTopAxisIndent;
  const bottomMarginRatio = kBottomAxisIndent;

  final normalizedWidthRatio = 1.0 - (leftMarginRatio + rightMarginRatio) * kAxisIndent;
  final normalizedHeightRatio = 1.0 - (topMarginRatio + bottomMarginRatio) * kAxisIndent;

  double w = normalize
      ? (width * normalizedWidthRatio) * position.dx + (leftMarginRatio * kAxisIndent * width)
      : width * position.dx;

  // REMOVED: The manual (textPainter.height / 2) adjustment here.
  // Let alignmentY handle the centering.
  double h = normalize
      ? (height * normalizedHeightRatio) * position.dy + (topMarginRatio * kAxisIndent * height)
      : height * position.dy;

  // The 'offset' is the Top-Left corner where the TextPainter will start drawing
  final offset = Offset(w - alignmentX, h - alignmentY);

  // 4. Draw Pointer Line
  if (pointerLine != null) {
    final lineEndX = normalize
        ? (width * normalizedWidthRatio) * pointerLine.dx + (leftMarginRatio * kAxisIndent * width)
        : width * pointerLine.dx;
    final lineEndY = normalize
        ? (height * normalizedHeightRatio) * pointerLine.dy + (topMarginRatio * kAxisIndent * height)
        : height * pointerLine.dy;

    // The line starts at the anchor point (w, h), which is the visual center of the text
    final startPos = Offset(w, h);
    final endPos = Offset(lineEndX, lineEndY);
    final lineColor = style.color ?? perfectOnSurface;
    final lineWidth = kCurveWidth / 5;

    if (iCanvas != null) {
      iCanvas.drawLine(startPos, endPos, lineColor, lineWidth);
      iCanvas.drawRect(Rect.fromCenter(center: endPos, width: 3, height: 3), lineColor, fill: true);
    } else if (canvas != null) {
      final linePaint = Paint()
        ..color = lineColor
        ..strokeWidth = lineWidth
        ..isAntiAlias = true;
      canvas.drawLine(startPos, endPos, linePaint);
      canvas.drawCircle(endPos, 3, linePaint);
    }
  }

  // 5. Draw Background Box
  const double paddingX = 6.0;
  const double paddingY = 2.0;
  final boxRect = Rect.fromLTWH(
    offset.dx - paddingX / 2,
    offset.dy - paddingY / 2,
    textPainter.width + paddingX,
    textPainter.height + paddingY,
  );

  if (iCanvas != null) {
    iCanvas.drawRect(boxRect, perfectSurface, fill: true);
  } else if (canvas != null) {
    final boxPaintFill = Paint()
      ..style = PaintingStyle.fill
      ..color = perfectSurface;
    canvas.drawRRect(
      RRect.fromRectAndRadius(boxRect, const Radius.circular(4)),
      boxPaintFill,
    );
  }

  // 6. Draw Text
  if (iCanvas != null) {
    TextAlign pdfAlign = TextAlign.left;
    if (horizontalPivot == LabelPivot.center) pdfAlign = TextAlign.center;
    if (horizontalPivot == LabelPivot.right) pdfAlign = TextAlign.right;

    iCanvas.drawText(
      label,
      offset,
      style.fontSize ?? fontSize,
      style.color ?? perfectOnSurface,
      align: pdfAlign,
    );
  } else if (canvas != null) {
    canvas.save();
    // Pivot for rotation is the anchor point (center of the text)
    canvas.translate(w, h);
    canvas.rotate(angle);
    // Move back by the alignment to find the top-left for the painter
    canvas.translate(-alignmentX, -alignmentY);
    textPainter.paint(canvas, Offset.zero);
    canvas.restore();
  }
}
