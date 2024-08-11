import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_dashed_line.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_text.dart';
import 'package:flutter/material.dart';
import '../../enums/curve_align.dart';
import '../painter_constants.dart';

void paintDiagramDashedLines(
  Size size,
  Canvas canvas, {
  required double yAxisStartPos,
  required double xAxisEndPos,
  String? yLabel,
  String? xLabel,
  bool hideYLine = false,
  bool hideXLine = false,
  Color color = Colors.white,
}) {
  if (!hideYLine) {
    /// Dashed line from Y axis
    paintDashedLine(
        color: color,
        size: size,
        canvas: canvas,
        p1: Offset(kAxisIndent, yAxisStartPos),
        p2: Offset(xAxisEndPos + kAxisIndent, yAxisStartPos));

    if (yLabel != null) {
      /// Y axis label
      paintText(
        size,
        canvas,
        yLabel,
        fontSize: kLabelFontSize,
        Offset(kAxisIndent, yAxisStartPos),
        curveAlign: CurveAlign.centerLeft,
      );
    }
  }

  if (!hideXLine) {
    /// Dashed line to X axis
    paintDashedLine(
      color: color,
      size: size,
      canvas: canvas,
      p1: Offset(kAxisIndent + xAxisEndPos, yAxisStartPos),
      p2: Offset(
        kAxisIndent + xAxisEndPos,
        1 - (1 * kAxisIndent),
      ),
    );

    /// X axis label
    if (xLabel != null) {
      paintText(
        size,
        canvas,
        xLabel,
        fontSize: kLabelFontSize,
        Offset(kAxisIndent + xAxisEndPos, 1 - kAxisIndent),
        curveAlign: CurveAlign.centerBottom,
      );
    }
  }
}
