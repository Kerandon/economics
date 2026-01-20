import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/grid_lines/draw_dashed_line_for_grid.dart';
import 'package:flutter/material.dart';

import '../../../i_diagram_canvas.dart';

import '../../../../models/diagram_painter_config.dart';
import '../../../painter_constants.dart';

void paintGridLines(
  DiagramPainterConfig config,
  Canvas? canvas, { // 👈 Changed to Canvas?
  IDiagramCanvas? iCanvas,
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

  final effectiveColor = color ?? config.colorScheme.onSurface;
  final effectiveWidth = strokeWidth * config.averageRatio;
  final fontSize = kFontVerySmall * config.averageRatio;

  final indentXLeft = indent;
  final indentYBottom = widthAndHeight - (indent * kBottomAxisIndent);
  final indentXRight = widthAndHeight * (1 - (kAxisIndent));
  final indentYTop = indent * kTopAxisIndent;

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

  // ✅ Y-axis gridlines/ticks and labels
  for (int i = 1; i <= yDivisions; i++) {
    final y = indentYBottom - (i * yStepSize);
    final yLabel = (i * yStepValue).toStringAsFixed(decimalPlaces);
    final pStart = Offset(indentXLeft, y);
    final pEnd = Offset(indentXRight, y);

    if (iCanvas != null) {
      if (gridLineStyle == GridLineStyle.full) {
        iCanvas.drawLine(pStart, pEnd, effectiveColor, effectiveWidth);
      } else if (gridLineStyle == GridLineStyle.dashes) {
        iCanvas.drawDashedLine(pStart, pEnd, effectiveColor, effectiveWidth);
      } else if (gridLineStyle == GridLineStyle.indents) {
        iCanvas.drawLine(
          pStart,
          Offset(indentXLeft - kIndentLength, y),
          effectiveColor,
          effectiveWidth,
        );
      }
      iCanvas.drawText(
        yLabel,
        Offset(indentXLeft - labelIndent, y),
        fontSize,
        effectiveColor,
        align: TextAlign.right,
      );
    } else if (canvas != null) {
      // 👈 Added null check
      final gridPaint = Paint()
        ..color = effectiveColor
        ..strokeWidth = effectiveWidth;
      if (gridLineStyle == GridLineStyle.full) {
        canvas.drawLine(pStart, pEnd, gridPaint);
      } else if (gridLineStyle == GridLineStyle.dashes) {
        drawDashedLineForGrid(canvas, pStart, pEnd, gridPaint);
      } else if (gridLineStyle == GridLineStyle.indents) {
        canvas.drawLine(
          pStart,
          Offset(indentXLeft - kIndentLength, y),
          gridPaint,
        );
      }

      final textPainter = TextPainter(textDirection: TextDirection.ltr);
      textPainter.text = TextSpan(
        text: yLabel,
        style: TextStyle(color: effectiveColor, fontSize: fontSize),
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
  }

  // ✅ X-axis gridlines/ticks and labels
  for (int i = 1; i <= xDivisions; i++) {
    final x = indentXLeft + (i * xStepSize);
    final xLabel = (i * xStepValue).toStringAsFixed(decimalPlaces);
    final pStart = Offset(x, indentYBottom);
    final pEnd = Offset(x, indentYTop);

    if (iCanvas != null) {
      if (gridLineStyle == GridLineStyle.full) {
        iCanvas.drawLine(pStart, pEnd, effectiveColor, effectiveWidth);
      } else if (gridLineStyle == GridLineStyle.dashes) {
        iCanvas.drawDashedLine(pStart, pEnd, effectiveColor, effectiveWidth);
      } else if (gridLineStyle == GridLineStyle.indents) {
        iCanvas.drawLine(
          pStart,
          Offset(x, indentYBottom + kIndentLength),
          effectiveColor,
          effectiveWidth,
        );
      }
      iCanvas.drawText(
        xLabel,
        Offset(x, indentYBottom + labelIndent),
        fontSize,
        effectiveColor,
        align: TextAlign.center,
      );
    } else if (canvas != null) {
      // 👈 Added null check
      final gridPaint = Paint()
        ..color = effectiveColor
        ..strokeWidth = effectiveWidth;
      if (gridLineStyle == GridLineStyle.full) {
        canvas.drawLine(pStart, pEnd, gridPaint);
      } else if (gridLineStyle == GridLineStyle.dashes) {
        drawDashedLineForGrid(canvas, pStart, pEnd, gridPaint);
      } else if (gridLineStyle == GridLineStyle.indents) {
        canvas.drawLine(
          pStart,
          Offset(x, indentYBottom + kIndentLength),
          gridPaint,
        );
      }

      final textPainter = TextPainter(textDirection: TextDirection.ltr);
      textPainter.text = TextSpan(
        text: xLabel,
        style: TextStyle(color: effectiveColor, fontSize: fontSize),
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(x - textPainter.width / 2, indentYBottom + labelIndent),
      );
    }
  }
}
