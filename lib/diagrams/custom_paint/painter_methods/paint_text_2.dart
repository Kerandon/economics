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
  IDiagramCanvas canvas,
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

  // --- 1. Variable Setup & Normalization Logic ---
  const leftMarginRatio = 1.0;
  const rightMarginRatio = 1.0;
  const topMarginRatio = kTopAxisIndent;
  const bottomMarginRatio = kBottomAxisIndent;

  final bool isDarkTheme = config.colorScheme.brightness == Brightness.dark;
  final Color surfaceColor = isDarkTheme ? Colors.black : Colors.white;
  final Color onSurfaceColor = isDarkTheme ? Colors.white : Colors.black87;

  final effectiveStyle =
      (style ?? TextStyle(color: onSurfaceColor, fontSize: fontSize)).copyWith(
        fontSize: (style?.fontSize ?? fontSize) * config.averageRatio,
        color: style?.color ?? onSurfaceColor,
      );

  final normalizedWidthRatio =
      1.0 - (leftMarginRatio + rightMarginRatio) * kAxisIndent;
  final normalizedHeightRatio =
      1.0 - (topMarginRatio + bottomMarginRatio) * kAxisIndent;

  // Calculate the Anchor Point (w, h)
  double w = normalize
      ? (width * normalizedWidthRatio) * position.dx +
            (leftMarginRatio * kAxisIndent * width)
      : width * position.dx;

  double h = normalize
      ? (height * normalizedHeightRatio) * position.dy +
            (topMarginRatio * kAxisIndent * height)
      : height * position.dy;

  final drawPos = Offset(w, h);

  // --- 2. Measure Text ---
  final textPainter = TextPainter(
    text: TextSpan(text: label, style: effectiveStyle),
    textDirection: TextDirection.ltr,
  )..layout();

  // --- 3. Calculate Pivot/Alignment Offsets ---
  double alignmentX = 0;
  if (horizontalPivot == LabelPivot.center) alignmentX = textPainter.width / 2;
  if (horizontalPivot == LabelPivot.right) alignmentX = textPainter.width;

  double alignmentY = 0;
  if (verticalPivot == LabelPivot.middle) alignmentY = textPainter.height / 2;
  if (verticalPivot == LabelPivot.bottom) alignmentY = textPainter.height;

  // --- 4. Draw Pointer Line ---
  if (pointerLine != null) {
    final lineEndX = normalize
        ? (width * normalizedWidthRatio) * pointerLine.dx +
              (leftMarginRatio * kAxisIndent * width)
        : width * pointerLine.dx;
    final lineEndY = normalize
        ? (height * normalizedHeightRatio) * pointerLine.dy +
              (topMarginRatio * kAxisIndent * height)
        : height * pointerLine.dy;

    final endPos = Offset(lineEndX, lineEndY);
    final lineColor = effectiveStyle.color ?? onSurfaceColor;
    final lineWidth = kCurveWidth / 5;

    canvas.drawLine(drawPos, endPos, lineColor, lineWidth);
    canvas.drawDot(endPos, lineColor, radius: 2.0, fill: true);
  }

  // --- 5. Draw Background Box & Text ---
  const double paddingX = 6.0;
  const double paddingY = 2.0;

  if (angle == 0) {
    // OPTIMIZATION: Use absolute coordinates for non-rotated text.
    // This fixes coordinate drift issues on PDF exports.
    final absoluteTopLeft = Offset(
      drawPos.dx - alignmentX,
      drawPos.dy - alignmentY,
    );

    final boxRect = Rect.fromLTWH(
      absoluteTopLeft.dx - paddingX / 2,
      absoluteTopLeft.dy - paddingY / 2,
      textPainter.width + paddingX,
      textPainter.height + paddingY,
    );

    canvas.drawRect(boxRect, surfaceColor, fill: true);
    canvas.drawText(
      label,
      absoluteTopLeft,
      effectiveStyle.fontSize!,
      effectiveStyle.color!,
    );
  } else {
    // Use transformation matrix for rotated text.
    canvas.save();
    canvas.translate(drawPos.dx, drawPos.dy);
    canvas.rotate(angle);

    final relativeTopLeft = Offset(-alignmentX, -alignmentY);

    final boxRect = Rect.fromLTWH(
      relativeTopLeft.dx - paddingX / 2,
      relativeTopLeft.dy - paddingY / 2,
      textPainter.width + paddingX,
      textPainter.height + paddingY,
    );

    canvas.drawRect(boxRect, surfaceColor, fill: true);
    canvas.drawText(
      label,
      relativeTopLeft,
      effectiveStyle.fontSize!,
      effectiveStyle.color!,
    );
    canvas.restore();
  }
}
