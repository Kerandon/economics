import 'dart:math';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_arrow_head.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/diagram_lines/paint_label_text.dart';
import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';
import '../../i_diagram_canvas.dart';
import '../../../models/custom_bezier.dart';
import '../../../models/diagram_painter_config.dart';
import '../../painter_constants.dart';
import '../paint_text_2.dart';

void paintDiagramLines(
  DiagramPainterConfig config,
  IDiagramCanvas canvas, { // Unified interface
  required Offset startPos,
  List<CustomBezier>? bezierPoints,
  List<Offset>? polylineOffsets,
  Color? color,
  double strokeWidth = kCurveWidth,
  String? label1,
  String? label2,
  LabelAlign label1Align = LabelAlign.centerTop,
  LabelAlign label2Align = LabelAlign.centerBottom,
  bool arrowOnStart = false,
  bool arrowOnEnd = false,
  double arrowOnStartAngle = 0,
  double arrowOnEndAngle = 0,
  bool circleAtEnd = false,
  bool circleAtStart = false,
  double circleRadius = 10,
  CurveStyle curveStyle = CurveStyle.standard,
  bool normalizeToDiagramArea = true,
  Color? backgroundColor,
}) {
  // 1. Math and Normalization
  final double widthAndHeight = config.painterSize.width;
  final double normalize = normalizeToDiagramArea ? 1 - (kAxisIndent * 2) : 1.0;
  final double widthAndHeightNormalized = widthAndHeight * normalize;
  final double indent = widthAndHeight * kAxisIndent;
  final Color mainColor = color ?? config.colorScheme.primary;

  Offset computeOffset(Offset pos) {
    final dx = pos.dx * widthAndHeightNormalized;
    final dy = pos.dy * widthAndHeightNormalized;
    return normalizeToDiagramArea
        ? Offset(dx + indent, dy + indent * kTopAxisIndent)
        : Offset(dx, dy);
  }

  final double effectiveWidth =
      (curveStyle == CurveStyle.bold ? strokeWidth * 2 : strokeWidth) *
      config.averageRatio;
  final Offset start = computeOffset(startPos);

  // 2. Build the Path Points
  // We collect points for simple lines, but for beziers we can now just use drawPath
  // if we add quadraticBezierTo to the interface, OR continue using the flattened points
  // for maximum consistency between Flutter and PDF.

  final List<Offset> points = [start];
  if (polylineOffsets != null) {
    for (var p in polylineOffsets) {
      points.add(computeOffset(p));
    }
  } else if (bezierPoints != null) {
    // We'll use your flattening logic to ensure the PDF and Flutter curves
    // look identical (since PDF graphics don't always handle quadratic beziers
    // the exact same way as Flutter's engine).
    Offset lastPoint = start;
    for (var b in bezierPoints) {
      final control = computeOffset(b.control);
      final endPoint = computeOffset(b.endPoint);
      for (double t = 0.05; t <= 1.0; t += 0.05) {
        // Smoother steps
        final x =
            (1 - t) * (1 - t) * lastPoint.dx +
            2 * (1 - t) * t * control.dx +
            t * t * endPoint.dx;
        final y =
            (1 - t) * (1 - t) * lastPoint.dy +
            2 * (1 - t) * t * control.dy +
            t * t * endPoint.dy;
        points.add(Offset(x, y));
      }
      lastPoint = endPoint;
    }
  }

  // 3. Draw the Curve/Line
  if (curveStyle == CurveStyle.dashed || curveStyle == CurveStyle.dotted) {
    // For dashed curves, we draw segment by segment
    for (int i = 0; i < points.length - 1; i++) {
      canvas.drawDashedLine(
        points[i],
        points[i + 1],
        mainColor,
        effectiveWidth,
      );
    }
  } else {
    canvas.drawPath(points, mainColor, fill: false);
  }

  // 4. Labels (using our new pivot system)
  if (label1 != null) {
    _paintDiagramLabel(
      config,
      canvas,
      label1,
      startPos,
      label1Align,
      mainColor,
      normalizeToDiagramArea,
    );
  }

  final lastLogicalPos = polylineOffsets != null
      ? polylineOffsets.last
      : bezierPoints!.last.endPoint;
  final Offset end = computeOffset(lastLogicalPos);

  if (label2 != null) {
    _paintDiagramLabel(
      config,
      canvas,
      label2,
      lastLogicalPos,
      label2Align,
      mainColor,
      normalizeToDiagramArea,
    );
  }

  // 5. Arrows and Dots
  if (arrowOnStart) {
    paintArrowHead(
      config,
      canvas,
      color: mainColor,
      positionOfArrow: start,
      rotationAngle: arrowOnStartAngle,
    );
  }

  if (arrowOnEnd) {
    double finalAngle = arrowOnEndAngle;
    if (finalAngle == 0) {
      final Offset reference = (bezierPoints != null)
          ? computeOffset(bezierPoints.last.control)
          : start;
      finalAngle = atan2(end.dy - reference.dy, end.dx - reference.dx);
    }
    paintArrowHead(
      config,
      canvas,
      color: mainColor,
      positionOfArrow: end,
      rotationAngle: finalAngle,
    );
  }

  final r = circleRadius * config.averageRatio;
  if (circleAtStart) canvas.drawDot(start, mainColor, radius: r);
  if (circleAtEnd) canvas.drawDot(end, mainColor, radius: r);
}

/// Helper to map your LabelAlign to the new Pivot system
void _paintDiagramLabel(
  DiagramPainterConfig config,
  IDiagramCanvas canvas,
  String label,
  Offset logicalPos,
  LabelAlign align,
  Color color,
  bool normalize,
) {
  LabelPivot horizontal = LabelPivot.center;
  LabelPivot vertical = LabelPivot.middle;

  // Standard economic label mapping
  switch (align) {
    case LabelAlign.centerTop:
      vertical = LabelPivot.bottom;
      break;
    case LabelAlign.centerBottom:
      vertical = LabelPivot.top;
      break;
    case LabelAlign.centerLeft:
      horizontal = LabelPivot.right;
      break;
    case LabelAlign.centerRight:
      horizontal = LabelPivot.left;
      break;
    case LabelAlign.center:
      break;
  }

  paintText2(
    config,
    canvas,
    label,
    logicalPos,
    horizontalPivot: horizontal,
    verticalPivot: vertical,
    normalize: normalize,
    style: TextStyle(color: color, fontWeight: FontWeight.bold),
  );
}
