import 'dart:ui';

import 'package:economics_app/app/custom_paint/painter_constants.dart';
import 'package:economics_app/app/custom_paint/painter_methods/paint_dashed_line.dart';
import 'package:economics_app/app/custom_paint/painter_methods/paint_text.dart';

void paintDiagramDashedLines(Size size, Canvas canvas,
    {required double yAxisStartPos, required double xAxisEndPos}) {
  final width = size.width;
  final height = size.height;
  paintDashedLine(
      canvas: canvas,
      p1: Offset(width * kAxisIndent, height * yAxisStartPos),
      p2: Offset(
          width * kAxisIndent + (width * xAxisEndPos), height * yAxisStartPos));


  paintText(size, canvas, 'PLe',
      fontSize: 12,
      Offset(width * kAxisIndent - kTextLineAdjustment, height * yAxisStartPos), alignToLeft: true );

      paintDashedLine(
      canvas: canvas,
      p1: Offset(
          (width * kAxisIndent) + width * xAxisEndPos, height * yAxisStartPos),
      p2: Offset((width * kAxisIndent) + width * xAxisEndPos,
          height - (height * kAxisIndent)));
}
