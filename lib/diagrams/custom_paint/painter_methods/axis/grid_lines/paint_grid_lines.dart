import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/grid_lines/draw_dashed_line_for_grid.dart';
import 'package:flutter/material.dart';

import 'grid_line_style.dart';
import '../../../../models/diagram_painter_config.dart';
import '../../../painter_constants.dart';

void paintGridLines(
  DiagramPainterConfig config,
  Canvas canvas, {
  double? xMaxValue,
  double? yMaxValue,
  int? xDivisions,
  int? yDivisions,
  Color? color,
  double strokeWidth = 2.0,
  GridLineStyle gridLineStyle = GridLineStyle.full,
  int decimalPlaces = 1,
}) {
  final widthAndHeight = config.painterSize.width;
  final indent = widthAndHeight * kAxisIndent;
  var labelIndent = widthAndHeight * 0.025;
  var kIndentLength = widthAndHeight * 0.015;
  final gridPaint = Paint()
    ..color = color ?? config.colorScheme.onSurface
    ..strokeWidth = strokeWidth * config.averageRatio;

  final textPainter = TextPainter(textDirection: TextDirection.ltr);

  final indentXLeft = indent * 1.5;
  final indentYBottom = widthAndHeight - (indent * 1.5);
  final indentXRight = widthAndHeight * (1 - (kAxisIndent * 0.50));
  final indentYTop = indent * 0.50;

  if (xMaxValue == null ||
      yMaxValue == null ||
      xDivisions == null ||
      yDivisions == null) {
    return;
  }

  final yStepValue = yMaxValue / yDivisions;
  final yStepSize = (indentYBottom - indentYTop) / yDivisions;

  final xStepValue = xMaxValue / xDivisions;
  final xStepSize = (indentXRight - indentXLeft) / xDivisions;

  // ✅ Y-axis gridlines or ticks
  for (int i = 1; i <= yDivisions; i++) {
    final y = indentYBottom - (i * yStepSize);

    if (gridLineStyle == GridLineStyle.full) {
      canvas.drawLine(
        Offset(indentXLeft, y),
        Offset(indentXRight, y),
        gridPaint,
      );
    } else if (gridLineStyle == GridLineStyle.dashes) {
      drawDashedLineForGrid(
        canvas,
        Offset(indentXLeft, y),
        Offset(indentXRight, y),
        gridPaint,
      );
    } else if (gridLineStyle == GridLineStyle.indents) {
      // Draw short tick mark (little indent) on the Y-axis
      canvas.drawLine(
        Offset(indentXLeft, y),
        Offset(indentXLeft - kIndentLength, y),
        gridPaint,
      );
    }

    // ✅ Draw label
    final yLabel = (i * yStepValue).toStringAsFixed(decimalPlaces);
    textPainter.text = TextSpan(
      text: yLabel,
      style: TextStyle(
        color: config.colorScheme.onSurface,
        fontSize: kFontSize * config.averageRatio,
      ),
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        indentXLeft - textPainter.width - labelIndent,
        y - textPainter.height / 2,
      ),
    );
  }

  // ✅ X-axis gridlines or ticks
  for (int i = 1; i <= xDivisions; i++) {
    final x = indentXLeft + (i * xStepSize);

    if (gridLineStyle == GridLineStyle.full) {
      canvas.drawLine(
        Offset(x, indentYBottom),
        Offset(x, indentYTop),
        gridPaint,
      );
    } else if (gridLineStyle == GridLineStyle.dashes) {
      drawDashedLineForGrid(
        canvas,
        Offset(x, indentYBottom),
        Offset(x, indentYTop),
        gridPaint,
      );
    } else if (gridLineStyle == GridLineStyle.indents) {
      // Draw short tick mark on the X-axis
      canvas.drawLine(
        Offset(x, indentYBottom),
        Offset(x, indentYBottom + kIndentLength),
        gridPaint,
      );
    }

    // ✅ Draw label
    final xLabel = (i * xStepValue).toStringAsFixed(decimalPlaces);
    textPainter.text = TextSpan(
      text: xLabel,
      style: TextStyle(
        color: config.colorScheme.onSurface,
        fontSize: kFontSize * config.averageRatio,
      ),
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(x - textPainter.width / 2, indentYBottom + labelIndent),
    );
  }
}
