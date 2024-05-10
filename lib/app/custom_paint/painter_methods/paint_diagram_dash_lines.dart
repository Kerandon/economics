import 'dart:ui';

import 'package:economics_app/app/custom_paint/custom_align.dart';
import 'package:economics_app/app/custom_paint/painter_constants.dart';
import 'package:economics_app/app/custom_paint/painter_methods/paint_dashed_line.dart';
import 'package:economics_app/app/custom_paint/painter_methods/paint_text.dart';

void paintDiagramDashedLines(Size size, Canvas canvas,
    {required double yAxisStartPos,
    required double xAxisEndPos,
    required yLabel,
    required xLabel}) {
  final width = size.width;
  final height = size.height;

  /// Dashed line from Y axis
  paintDashedLine(
      canvas: canvas,
      p1: Offset(width * kAxisIndent, height * yAxisStartPos),
      p2: Offset(
          width * kAxisIndent + (width * xAxisEndPos), height * yAxisStartPos));

  /// Y axis label
  paintText(
    size,
    canvas,
    yLabel,
    fontSize: 12,
    Offset(width * kAxisIndent - kTextLineAdjustment, height * yAxisStartPos),
    align: CustomAlign.centerLeft,
  );

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
  paintText(
    size,
    canvas,
    xLabel,
    fontSize: 12,
    Offset(
      (width * kAxisIndent) + width * xAxisEndPos,
      height - (height * kAxisIndent) + kTextLineAdjustment,
    ),
    align: CustomAlign.centerBottom,
  );
}
