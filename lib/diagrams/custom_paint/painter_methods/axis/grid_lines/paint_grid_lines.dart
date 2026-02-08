import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/grid_lines/draw_dashed_line_for_grid.dart';
import 'package:flutter/material.dart';

import '../../../i_diagram_canvas.dart';

import '../../../../models/diagram_painter_config.dart';
import '../../../painter_constants.dart';
import '../../paint_text.dart';

void paintGridLines(
  DiagramPainterConfig config,
  IDiagramCanvas canvas, {
  double? xMaxValue,
  double? yMaxValue,
  int? xDivisions,
  int? yDivisions,
  Color? color,
  double strokeWidth = 2.0,
  GridLineStyle gridLineStyle = GridLineStyle.full,
  int decimalPlaces = 1,
  double? fontSize, // ✅ NEW: Allow manual override
}) {
  if (xMaxValue == null ||
      yMaxValue == null ||
      xDivisions == null ||
      yDivisions == null) {
    return;
  }

  final widthAndHeight = config.painterSize.width;
  final indent = widthAndHeight * kAxisIndent;
  final labelIndent = widthAndHeight * 0.025;
  final kIndentLength = widthAndHeight * 0.015;

  final effectiveColor = color ?? config.colorScheme.onSurface;
  final effectiveWidth = strokeWidth * config.averageRatio;

  // ✅ FIX: Use kFontSizeAverageRatio by default (much bigger), or the user's override
  final baseFontSize = fontSize ?? kFontSizeAverageRatioSmall;
  final effectiveFontSize = baseFontSize * config.averageRatio;

  final indentXLeft = indent;
  final indentYBottom = widthAndHeight - (indent * kBottomAxisIndent);
  final indentXRight = widthAndHeight * (1 - kAxisIndent);
  final indentYTop = indent * kTopAxisIndent;

  final yStepValue = yMaxValue / yDivisions;
  final yStepSize = (indentYBottom - indentYTop) / yDivisions;
  final xStepValue = xMaxValue / xDivisions;
  final xStepSize = (indentXRight - indentXLeft) / xDivisions;

  // Y-axis
  for (int i = 1; i <= yDivisions; i++) {
    final y = indentYBottom - (i * yStepSize);
    final yLabel = (i * yStepValue).toStringAsFixed(decimalPlaces);
    final pStart = Offset(indentXLeft, y);
    final pEnd = Offset(indentXRight, y);

    _drawGridLineByStyle(
      canvas,
      gridLineStyle,
      pStart,
      pEnd,
      Offset(indentXLeft - kIndentLength, y),
      effectiveColor,
      effectiveWidth,
    );

    paintText(
      config,
      canvas,
      yLabel,
      Offset(indentXLeft - labelIndent, y),
      fontSize: effectiveFontSize, // Use the larger size
      horizontalPivot: LabelPivot.right,
      verticalPivot: LabelPivot.middle,
      normalize: false,
      style: TextStyle(color: effectiveColor),
    );
  }

  // X-axis
  for (int i = 1; i <= xDivisions; i++) {
    final x = indentXLeft + (i * xStepSize);
    final xLabel = (i * xStepValue).toStringAsFixed(decimalPlaces);
    final pStart = Offset(x, indentYBottom);
    final pEnd = Offset(x, indentYTop);

    _drawGridLineByStyle(
      canvas,
      gridLineStyle,
      pStart,
      pEnd,
      Offset(x, indentYBottom + kIndentLength),
      effectiveColor,
      effectiveWidth,
    );

    paintText(
      config,
      canvas,
      xLabel,
      Offset(x, indentYBottom + labelIndent),
      fontSize: effectiveFontSize, // Use the larger size
      horizontalPivot: LabelPivot.center,
      verticalPivot: LabelPivot.top,
      normalize: false,
      style: TextStyle(color: effectiveColor),
    );
  }
}

/// Private helper to clean up the switch logic for grid line styles
void _drawGridLineByStyle(
  IDiagramCanvas canvas,
  GridLineStyle style,
  Offset start,
  Offset end,
  Offset indentEnd,
  Color color,
  double width,
) {
  switch (style) {
    case GridLineStyle.full:
      canvas.drawLine(start, end, color, width);
      break;
    case GridLineStyle.dashes:
      canvas.drawDashedLine(start, end, color, width);
      break;
    case GridLineStyle.indents:
      canvas.drawLine(start, indentEnd, color, width);
      break;
    case GridLineStyle.none:
      break;
  }
}
