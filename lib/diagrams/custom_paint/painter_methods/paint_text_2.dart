import 'package:flutter/material.dart';

import 'axis/label_align.dart';
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

  // Use crisp black/white logic: if background is dark, text should be white, and vice versa.
  // Bypass config.colorScheme.surface if you want "Perfect White".
  final bool isDarkTheme = config.colorScheme.brightness == Brightness.dark;
  final Color perfectSurface = isDarkTheme ? Colors.black : Colors.white;
  final Color perfectOnSurface = isDarkTheme ? Colors.white : Colors.black87;

  style =
      style?.copyWith(
        color: style.color ?? perfectOnSurface,
        fontSize: (style.fontSize ?? kFontMedium) * config.averageRatio,
      ) ??
      TextStyle(color: perfectOnSurface, fontSize: fontSize);

  final textSpan = TextSpan(text: label, style: style);
  final textPainter = TextPainter(
    text: textSpan,
    textDirection: TextDirection.ltr,
  )..layout(minWidth: 0, maxWidth: width);

  // --- Calculate Alignment Offsets ---
  double alignmentX = 0;
  if (horizontalPivot == LabelPivot.center) alignmentX = textPainter.width / 2;
  if (horizontalPivot == LabelPivot.right) alignmentX = textPainter.width;

  double alignmentY = 0;
  if (verticalPivot == LabelPivot.middle) alignmentY = textPainter.height / 2;
  if (verticalPivot == LabelPivot.bottom) alignmentY = textPainter.height;

  // --- Compute text offset ---
  const leftMarginRatio = 1.5;
  const rightMarginRatio = 0.5;
  const topMarginRatio = 0.5;
  const bottomMarginRatio = 1.5;

  final normalizedWidthRatio =
      1.0 - (leftMarginRatio + rightMarginRatio) * kAxisIndent;
  final normalizedHeightRatio =
      1.0 - (topMarginRatio + bottomMarginRatio) * kAxisIndent;

  double w = normalize
      ? (width * normalizedWidthRatio) * position.dx +
            (leftMarginRatio * kAxisIndent * width)
      : width * position.dx;

  double h = normalize
      ? (height - 2 * kAxisIndent * height - textPainter.height) * position.dy +
            (kAxisIndent / 2 * height) +
            (textPainter.height / 2)
      : height * position.dy;

  final offset = Offset(w - alignmentX, h - alignmentY);

  // --- 1. Draw Pointer Line ---
  if (pointerLine != null) {
    final xStartOffset = leftMarginRatio * kAxisIndent * width;
    final yStartOffset = topMarginRatio * kAxisIndent * height;

    final lineEndX = normalize
        ? (width * normalizedWidthRatio) * pointerLine.dx + xStartOffset
        : width * pointerLine.dx;
    final lineEndY = normalize
        ? (height * normalizedHeightRatio) * pointerLine.dy + yStartOffset
        : height * pointerLine.dy;

    final linePaint = Paint()
      ..color = style.color ?? perfectOnSurface
      ..strokeWidth = kCurveWidth / 6
      ..isAntiAlias = true;

    final startPos = offset + Offset(alignmentX, alignmentY);
    canvas.drawLine(startPos, Offset(lineEndX, lineEndY), linePaint);
    canvas.drawCircle(Offset(lineEndX, lineEndY), 2.5, linePaint);
  }

  // --- 2. Draw Background Box (Perfect White/Black) ---
  // Increased padding slightly for a "magazine" feel
  const double paddingX = 6.0;
  const double paddingY = 2.0;

  final boxPaintFill = Paint()
    ..style = PaintingStyle.fill
    ..color = perfectSurface;

  final boxRect = Rect.fromLTWH(
    offset.dx - paddingX / 2,
    offset.dy - paddingY / 2,
    textPainter.width + paddingX,
    textPainter.height + paddingY,
  );

  // Draw as RRect (Rounded Rectangle) for a modern look
  canvas.drawRRect(
    RRect.fromRectAndRadius(boxRect, const Radius.circular(4)),
    boxPaintFill,
  );

  // --- 3. Draw Text (with Rotation support) ---
  canvas.save();
  final pivotPoint = offset + Offset(alignmentX, alignmentY);
  canvas.translate(pivotPoint.dx, pivotPoint.dy);
  canvas.rotate(angle);
  canvas.translate(-pivotPoint.dx, -pivotPoint.dy);
  textPainter.paint(canvas, offset);
  canvas.restore();
}
