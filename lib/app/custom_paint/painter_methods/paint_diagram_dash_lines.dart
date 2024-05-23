import 'dart:ui';

import 'package:economics_app/app/custom_paint/paint_enums/custom_align.dart';
import 'package:economics_app/app/custom_paint/painter_constants.dart';
import 'package:economics_app/app/custom_paint/painter_methods/paint_dashed_line.dart';
import 'package:economics_app/app/custom_paint/painter_methods/paint_text.dart';

void paintDiagramDashedLines(
  Size size,
  Canvas canvas, {
  required double yAxisStartPos,
  required double xAxisEndPos,
  String? yLabel,
  String? xLabel,
  bool hideYLine = false,
  bool hideXLine = false,
}) {
  final width = size.width;
  final height = size.height;

  if (!hideYLine) {
    /// Dashed line from Y axis
    paintDashedLine(
        canvas: canvas,
        p1: Offset(width * kAxisIndent, height * yAxisStartPos),
        p2: Offset(width * kAxisIndent + (width * xAxisEndPos),
            height * yAxisStartPos));

    if (yLabel != null) {
      /// Y axis label
      paintText(
        size,
        canvas,
        yLabel,
        fontSize: kLabelFontSize,
        Offset(
            width * kAxisIndent - kTextLineAdjustment, height * yAxisStartPos),
        align: CustomAlign.centerLeft,
      );
    }
  }

  if (!hideXLine) {
    /// Dashed line to X axis
    paintDashedLine(
      canvas: canvas,
      p1: Offset(
          (width * kAxisIndent) + width * xAxisEndPos, height * yAxisStartPos),
      p2: Offset(
        (width * kAxisIndent) + width * xAxisEndPos,
        height - (height * kAxisIndent),
      ),
    );

    /// X axis label
    if (xLabel != null) {
      paintText(
        size,
        canvas,
        xLabel,
        fontSize: kLabelFontSize,
        Offset(
          (width * kAxisIndent) + width * xAxisEndPos,
          height - (height * kAxisIndent) + kTextLineAdjustment,
        ),
        align: CustomAlign.centerBottom,
      );
    }
  }
}
