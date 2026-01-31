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

  // 1. Setup Scaling & Colors
  final double scaledFontSize =
      (style?.fontSize ?? fontSize) * config.averageRatio;
  final bool isDarkTheme = config.colorScheme.brightness == Brightness.dark;
  final Color surfaceColor = isDarkTheme ? Colors.black : Colors.white;
  final Color onSurfaceColor = isDarkTheme ? Colors.white : Colors.black87;

  final effectiveStyle = (style ?? TextStyle(color: onSurfaceColor)).copyWith(
    fontSize: scaledFontSize,
  );

  // 2. Normalization Logic
  Offset toPixels(Offset pos) {
    if (!normalize) return pos; // Use raw pixels if already calculated
    const leftMarginRatio = 1.0;
    const topMarginRatio = kTopAxisIndent;
    final normalizedWidthRatio = 1.0 - (2.0 * kAxisIndent);
    final normalizedHeightRatio =
        1.0 - ((kTopAxisIndent + kBottomAxisIndent) * kAxisIndent);

    double px =
        (width * normalizedWidthRatio) * pos.dx +
        (leftMarginRatio * kAxisIndent * width);
    double py =
        (height * normalizedHeightRatio) * pos.dy +
        (topMarginRatio * kAxisIndent * height);
    return Offset(px, py);
  }

  final drawPos = toPixels(position);

  // 3. Measure Text
  final textPainter = TextPainter(
    text: TextSpan(text: label, style: effectiveStyle),
    textDirection: TextDirection.ltr,
  )..layout();

  // 4. Calculate Pivot Shifts
  // These shifts determine how the text block sits relative to drawPos
  double shiftX = 0;
  if (horizontalPivot == LabelPivot.center) shiftX = textPainter.width / 2;
  if (horizontalPivot == LabelPivot.right) shiftX = textPainter.width;

  double shiftY = 0;
  if (verticalPivot == LabelPivot.middle) shiftY = textPainter.height / 2;
  if (verticalPivot == LabelPivot.bottom) shiftY = textPainter.height;

  // 5. Pointer Line (unchanged)
  if (pointerLine != null) {
    final endPos = toPixels(pointerLine);
    final lineColor = effectiveStyle.color ?? onSurfaceColor;
    final lineWidth = (kCurveWidth / 5) * config.averageRatio;
    canvas.drawLine(drawPos, endPos, lineColor, lineWidth);
    canvas.drawDot(
      endPos,
      lineColor,
      radius: kDotRadius * config.averageRatio,
      fill: true,
    );
  }

  // 6. Draw Text & Background Box
  // REDUCED PADDING: High-res PDFs look better with tighter boxes
  final double padX = 2.0 * config.averageRatio;
  final double padY = 1.0 * config.averageRatio;

  if (angle == 0) {
    // textTopLeft is where the actual ink starts
    final textTopLeft = Offset(drawPos.dx - shiftX, drawPos.dy - shiftY);

    // CRITICAL FIX: The background box should be flush with the pivot logic.
    // We only apply padding IF we want a margin around the text.
    // If text looks too far away, we ensure the box doesn't push the anchor.
    final boxRect = Rect.fromLTWH(
      textTopLeft.dx - (padX / 2),
      textTopLeft.dy - (padY / 2),
      textPainter.width + padX,
      textPainter.height + padY,
    );

    canvas.drawRect(boxRect, surfaceColor, fill: true);
    canvas.drawText(label, textTopLeft, scaledFontSize, effectiveStyle.color!);
  } else {
    canvas.save();
    canvas.translate(drawPos.dx, drawPos.dy);
    canvas.rotate(angle);

    final relativeTopLeft = Offset(-shiftX, -shiftY);
    final boxRect = Rect.fromLTWH(
      relativeTopLeft.dx - (padX / 2),
      relativeTopLeft.dy - (padY / 2),
      textPainter.width + padX,
      textPainter.height + padY,
    );

    canvas.drawRect(boxRect, surfaceColor, fill: true);
    canvas.drawText(
      label,
      relativeTopLeft,
      scaledFontSize,
      effectiveStyle.color!,
    );
    canvas.restore();
  }
}
