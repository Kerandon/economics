import 'package:flutter/material.dart';

import '../i_diagram_canvas.dart';

import '../../models/diagram_painter_config.dart';
import '../painter_constants.dart';

// Ensure LabelPivot is defined (as per your request)
enum LabelPivot { left, center, right, top, middle, bottom }

// 1. Update Enum: Add 'none'
enum DiagramShape {
  none, // Just text (Transparent background, no border)
  square, // Rectangle with background & border
  circle, // Capsule/Oval
  diamond, // Rhombus
}

void paintText(
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
  bool ignoreIndent = false,
  DiagramShape shape = DiagramShape.none,
  double? maxWidth,
  TextAlign textAlign = TextAlign.center,
  bool showBackground = true,
  // NEW: Precise padding control (dx for horizontal, dy for vertical)
  Offset textPadding = Offset.zero,
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

  // 2. Normalization
  Offset toPixels(Offset pos) {
    if (!normalize) return pos;
    if (ignoreIndent) return Offset(width * pos.dx, height * pos.dy);
    const leftMarginRatio = 1.0;
    const topMarginRatio = kTopAxisIndent;
    final normalizedWidthRatio = 1.0 - (2.0 * kAxisIndent);
    final normalizedHeightRatio =
        1.0 - ((kTopAxisIndent + kBottomAxisIndent) * kAxisIndent);
    return Offset(
      (width * normalizedWidthRatio) * pos.dx +
          (leftMarginRatio * kAxisIndent * width),
      (height * normalizedHeightRatio) * pos.dy +
          (topMarginRatio * kAxisIndent * height),
    );
  }

  // Apply the normalized position PLUS the manual pixel padding
  final drawPos = toPixels(position) + (textPadding * config.averageRatio);

  // 3. Measure Text
  final textPainter = TextPainter(
    text: TextSpan(text: label, style: effectiveStyle),
    textAlign: textAlign,
    textDirection: TextDirection.ltr,
  );

  double calculatedMaxWidth = maxWidth ?? double.infinity;
  if (calculatedMaxWidth < 0) calculatedMaxWidth = 0;
  textPainter.layout(minWidth: 0, maxWidth: calculatedMaxWidth);

  // 4. Calculate Pivot Shifts
  double shiftX = 0;
  if (horizontalPivot == LabelPivot.center) shiftX = textPainter.width / 2;
  if (horizontalPivot == LabelPivot.right) shiftX = textPainter.width;

  double shiftY = 0;
  if (verticalPivot == LabelPivot.middle) shiftY = textPainter.height / 2;
  if (verticalPivot == LabelPivot.bottom) shiftY = textPainter.height;

  // 5. Pointer Line (Uses drawPos which now includes padding)
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

  // 6. Draw Background Shape & Text
  canvas.save();
  canvas.translate(drawPos.dx, drawPos.dy);
  if (angle != 0) canvas.rotate(angle);

  final relativeTopLeft = Offset(-shiftX, -shiftY);
  // Increase box padding slightly for better aesthetics
  final padX = 4.0 * config.averageRatio;
  final padY = 2.0 * config.averageRatio;

  final textRect = Rect.fromLTWH(
    relativeTopLeft.dx - (padX / 2),
    relativeTopLeft.dy - (padY / 2),
    textPainter.width + padX,
    textPainter.height + padY,
  );

  // Shape logic remains the same...
  switch (shape) {
    case DiagramShape.circle:
      final inflated = textRect.inflate(textRect.height * 0.4);
      final radius = Radius.circular(inflated.height / 2);
      if (showBackground)
        canvas.drawRRect(inflated, radius, surfaceColor, fill: true);
      canvas.drawRRect(inflated, radius, onSurfaceColor, fill: false);
      break;
    case DiagramShape.diamond:
      final inflated = textRect.inflate(textRect.width * 0.35);
      final points = [
        Offset(inflated.center.dx, inflated.top),
        Offset(inflated.right, inflated.center.dy),
        Offset(inflated.center.dx, inflated.bottom),
        Offset(inflated.left, inflated.center.dy),
        Offset(inflated.center.dx, inflated.top),
      ];
      if (showBackground) canvas.drawPath(points, surfaceColor, fill: true);
      canvas.drawPath(points, onSurfaceColor, fill: false);
      break;
    case DiagramShape.square:
      if (showBackground) canvas.drawRect(textRect, surfaceColor, fill: true);
      canvas.drawRect(textRect, onSurfaceColor, fill: false);
      break;
    case DiagramShape.none:
      if (showBackground) canvas.drawRect(textRect, surfaceColor, fill: true);
      break;
  }

  // 7. Paint Text
  canvas.paintTextPainter(textPainter, relativeTopLeft);
  canvas.restore();
}
