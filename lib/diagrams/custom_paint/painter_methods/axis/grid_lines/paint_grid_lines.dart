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
  double? fontSize,
  bool showBackground = true, // 👈 Pass through to paintText
}) {
  if (xMaxValue == null ||
      yMaxValue == null ||
      xDivisions == null ||
      yDivisions == null)
    return;

  final size = config.painterSize.width;
  final indent = size * kAxisIndent;
  final labelIndent = size * 0.025;
  final kIndentLength = size * 0.015;

  final effectiveColor = color ?? config.colorScheme.onSurface;
  final effectiveWidth = strokeWidth * config.averageRatio;
  final effectiveFontSize =
      (fontSize ?? kFontSizeAverageRatioSmall) * config.averageRatio;

  final indentXLeft = indent;
  final indentXRight = size * (1 - kAxisIndent);
  final indentYTop = indent * kTopAxisIndent;
  final indentYBottom = size - (indent * kBottomAxisIndent);

  final yStepSize = (indentYBottom - indentYTop) / yDivisions;
  final xStepSize = (indentXRight - indentXLeft) / xDivisions;

  // Y-axis
  for (int i = 1; i <= yDivisions; i++) {
    final y = indentYBottom - (i * yStepSize);
    final val = (i * (yMaxValue / yDivisions)).toStringAsFixed(decimalPlaces);

    _drawGridLineByStyle(
      canvas,
      gridLineStyle,
      Offset(indentXLeft, y),
      Offset(indentXRight, y),
      Offset(indentXLeft - kIndentLength, y),
      effectiveColor,
      effectiveWidth,
    );

    paintText(
      config,
      canvas,
      val,
      Offset(indentXLeft - labelIndent, y),
      fontSize: effectiveFontSize,
      horizontalPivot: LabelPivot.right,
      verticalPivot: LabelPivot.middle,
      normalize: false,
      showBackground: showBackground, // 👈 Applied here
      style: TextStyle(color: effectiveColor),
    );
  }

  // X-axis
  for (int i = 1; i <= xDivisions; i++) {
    final x = indentXLeft + (i * xStepSize);
    final val = (i * (xMaxValue / xDivisions)).toStringAsFixed(decimalPlaces);

    _drawGridLineByStyle(
      canvas,
      gridLineStyle,
      Offset(x, indentYBottom),
      Offset(x, indentYTop),
      Offset(x, indentYBottom + kIndentLength),
      effectiveColor,
      effectiveWidth,
    );

    paintText(
      config,
      canvas,
      val,
      Offset(x, indentYBottom + labelIndent),
      fontSize: effectiveFontSize,
      horizontalPivot: LabelPivot.center,
      verticalPivot: LabelPivot.top,
      normalize: false,
      showBackground: showBackground, // 👈 Applied here
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
      // This draws the small "tick" mark outside the axis
      canvas.drawLine(start, indentEnd, color, width);
      break;
    case GridLineStyle.none:
      break;
  }
}
