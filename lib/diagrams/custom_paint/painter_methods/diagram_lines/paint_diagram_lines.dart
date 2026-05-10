import 'dart:math';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_arrow_head.dart';
import 'package:flutter/material.dart';
import '../../i_diagram_canvas.dart';
import '../../../models/custom_bezier.dart';
import '../../../models/diagram_painter_config.dart';
import '../../painter_constants.dart';
import '../paint_text.dart';

enum DiagramFlowArrow {
  none,
  forward, // Points in the direction of the line (Start -> End)
  backward, // Points opposite to the line (End -> Start)
}

void paintDiagramLines(
  DiagramPainterConfig config,
  IDiagramCanvas canvas, {
  required Offset startPos,
  List<CustomBezier>? bezierPoints,
  List<Offset>? polylineOffsets,
  Color? color,
  double strokeWidth = kCurveWidth,

  // LABELS
  String? label1,
  String? label2,
  String? middleLabel,
  LabelAlign label1Align = LabelAlign.centerTop,
  LabelAlign label2Align = LabelAlign.centerBottom,
  LabelAlign middleLabelAlign = LabelAlign.center,

  double labelPadding = 12.0,

  // ARROWS
  bool arrowOnStart = false,
  bool arrowOnEnd = false,
  double arrowOnStartAngle = 0,
  double arrowOnEndAngle = 0,
  DiagramFlowArrow flowArrow = DiagramFlowArrow.none,
  int flowArrowCount = 1,

  // DECORATION
  bool circleAtEnd = false,
  bool circleAtStart = false,
  double circleRadius = 10,
  CurveStyle curveStyle = CurveStyle.standard,
  bool normalizeToDiagramArea = true,
  DiagramTextType textType = DiagramTextType.axisLabels,
}) {
  // --- 1. CONFIG & MATH ---
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

  // Calculate width once
  final double effectiveWidth =
      (curveStyle == CurveStyle.bold ? strokeWidth * 2 : strokeWidth) *
      config.averageRatio;

  final Offset start = computeOffset(startPos);

  // --- 2. BUILD POINTS ---
  List<Offset> points = [start];

  if (polylineOffsets != null && polylineOffsets.isNotEmpty) {
    for (var p in polylineOffsets) {
      points.add(computeOffset(p));
    }
  } else if (bezierPoints != null && bezierPoints.isNotEmpty) {
    Offset lastP = start;
    const double step = 0.01;
    for (var b in bezierPoints) {
      final control = computeOffset(b.control);
      final endPoint = computeOffset(b.endPoint);
      for (double t = step; t <= 1.0; t += step) {
        final double u = 1 - t;
        final double tt = t * t;
        final double uu = u * u;
        final double x =
            uu * lastP.dx + 2 * u * t * control.dx + tt * endPoint.dx;
        final double y =
            uu * lastP.dy + 2 * u * t * control.dy + tt * endPoint.dy;
        points.add(Offset(x, y));
      }
      lastP = endPoint;
    }
  }

  // --- 3. DRAW LINE (UPDATED) ---
  if (curveStyle == CurveStyle.dashed || curveStyle == CurveStyle.dotted) {
    // 1. Define dash and gap lengths based on the chosen style
    final double dashOn = curveStyle == CurveStyle.dotted
        ? effectiveWidth
        : 12.0;
    final double dashOff = curveStyle == CurveStyle.dotted
        ? effectiveWidth * 1.5
        : 8.0;

    double currentDashLength = 0.0;
    bool isDrawing = true;

    // 2. Walk through all segments (macro polylines OR micro bezier steps)
    for (int i = 0; i < points.length - 1; i++) {
      final p1 = points[i];
      final p2 = points[i + 1];
      final double segmentDist = (p2 - p1).distance;

      if (segmentDist == 0) continue; // Skip 0-length segments

      final Offset direction = (p2 - p1) / segmentDist; // Unit vector
      double walked = 0.0;

      // 3. Step along the current segment in dash/gap increments
      while (walked < segmentDist) {
        final double remainingInSegment = segmentDist - walked;
        final double requiredForState =
            (isDrawing ? dashOn : dashOff) - currentDashLength;

        // Take the smaller step: finish the segment, or finish the dash/gap
        final double step = remainingInSegment < requiredForState
            ? remainingInSegment
            : requiredForState;

        if (isDrawing) {
          final Offset startDraw = p1 + (direction * walked);
          final Offset endDraw = startDraw + (direction * step);
          canvas.drawLine(startDraw, endDraw, mainColor, effectiveWidth);
        }

        walked += step;
        currentDashLength += step;

        // Toggle state if we completed a dash or gap
        if (currentDashLength >= (isDrawing ? dashOn : dashOff)) {
          isDrawing = !isDrawing;
          currentDashLength = 0.0;
        }
      }
    }
  } else {
    // Solid line
    for (int i = 0; i < points.length - 1; i++) {
      canvas.drawLine(points[i], points[i + 1], mainColor, effectiveWidth);
    }
  }
  // --- 4. CALCULATE PATH METRICS ---
  double totalLength = 0;
  List<double> dists = [0];

  if ((flowArrow != DiagramFlowArrow.none || middleLabel != null) &&
      points.length >= 2) {
    for (int i = 0; i < points.length - 1; i++) {
      final d = (points[i + 1] - points[i]).distance;
      totalLength += d;
      dists.add(totalLength);
    }
  }

  List<dynamic> getPointAndAngleAtFraction(double fraction) {
    final double targetDist = totalLength * fraction;
    int index = 0;
    while (index < dists.length - 1 && dists[index + 1] < targetDist) {
      index++;
    }

    final segmentStart = points[index];
    final segmentEnd = points[index + 1];
    final segmentDist = dists[index + 1] - dists[index];
    final double progress =
        (targetDist - dists[index]) / (segmentDist == 0 ? 1 : segmentDist);

    final pos = Offset.lerp(segmentStart, segmentEnd, progress)!;
    final angle =
        atan2(
          segmentEnd.dy - segmentStart.dy,
          segmentEnd.dx - segmentStart.dx,
        ) +
        (pi / 2);

    return [pos, angle];
  }

  // --- 5. DRAW FLOW ARROWS ---
  if (flowArrow != DiagramFlowArrow.none && points.length >= 2) {
    final int count = flowArrowCount.clamp(1, 3);
    for (int k = 1; k <= count; k++) {
      final double fraction = k / (count + 1);
      final data = getPointAndAngleAtFraction(fraction);
      final Offset pos = data[0];
      double angle = data[1];

      if (flowArrow == DiagramFlowArrow.backward) angle += pi;

      paintArrowHead(
        config,
        canvas,
        color: mainColor,
        positionOfArrow: pos,
        rotationAngle: angle,
        scale: 1.4,
        isCentered: true,
      );
    }
  }

  // --- 6. DRAW END/START ARROWS ---
  double getCorrectedAngle(Offset a, Offset b) {
    return atan2(b.dy - a.dy, b.dx - a.dx) + (pi / 2);
  }

  final Offset endPixelPos = points.last;
  if (arrowOnEnd && points.length >= 2) {
    final int lookBack = points.length > 5 ? 2 : 1;
    final p1 = points[points.length - 1 - lookBack];
    final p2 = points.last;

    final double angle = arrowOnEndAngle != 0
        ? arrowOnEndAngle
        : getCorrectedAngle(p1, p2);

    paintArrowHead(
      config,
      canvas,
      color: mainColor,
      positionOfArrow: endPixelPos,
      rotationAngle: angle,
      scale: 1.2,
      isCentered: false,
    );
  }

  if (arrowOnStart) {
    paintArrowHead(
      config,
      canvas,
      color: mainColor,
      positionOfArrow: start,
      rotationAngle: arrowOnStartAngle,
      scale: 1.0,
      isCentered: false,
    );
  }

  // --- 7. DRAW LABELS ---
  if (label1 != null) {
    _paintDiagramLabel(
      config,
      canvas,
      label1,
      start,
      label1Align,
      mainColor,
      false,
      labelPadding,
      textType: textType,
    );
  }

  if (label2 != null) {
    _paintDiagramLabel(
      config,
      canvas,
      label2,
      endPixelPos,
      label2Align,
      mainColor,
      false,
      labelPadding,
      textType: textType,
    );
  }

  if (middleLabel != null && points.length >= 2) {
    final data = getPointAndAngleAtFraction(0.5);
    final Offset midPos = data[0];

    _paintDiagramLabel(
      config,
      canvas,
      middleLabel,
      midPos,
      middleLabelAlign,
      mainColor,
      false,
      labelPadding,
    );
  }

  // --- 8. DOTS ---
  final r = circleRadius * config.averageRatio;
  if (circleAtStart) canvas.drawDot(start, mainColor, radius: r);
  if (circleAtEnd) canvas.drawDot(endPixelPos, mainColor, radius: r);
}

void _paintDiagramLabel(
  DiagramPainterConfig config,
  IDiagramCanvas canvas,
  String label,
  Offset pixelPos,
  LabelAlign align,
  Color color,
  bool normalize,
  double padding, {
  DiagramTextType textType = DiagramTextType.axisNames,
}) {
  LabelPivot horizontal = LabelPivot.center;
  LabelPivot vertical = LabelPivot.middle;

  final double gapValue = padding * config.averageRatio;
  Offset nudge = Offset.zero;

  switch (align) {
    case LabelAlign.centerTop:
      horizontal = LabelPivot.center;
      vertical = LabelPivot.bottom;
      nudge = Offset(0, -gapValue);
      break;
    case LabelAlign.centerBottom:
      horizontal = LabelPivot.center;
      vertical = LabelPivot.top;
      nudge = Offset(0, gapValue);
      break;
    case LabelAlign.left:
      horizontal = LabelPivot.right;
      vertical = LabelPivot.middle;
      nudge = Offset(-gapValue, 0);
      break;
    case LabelAlign.right:
      horizontal = LabelPivot.left;
      vertical = LabelPivot.middle;
      nudge = Offset(gapValue, 0);
      break;
    case LabelAlign.topLeft:
      horizontal = LabelPivot.right;
      vertical = LabelPivot.bottom;
      nudge = Offset(-gapValue, -gapValue);
      break;
    case LabelAlign.topRight:
      horizontal = LabelPivot.left;
      vertical = LabelPivot.bottom;
      nudge = Offset(gapValue, -gapValue);
      break;
    case LabelAlign.bottomLeft:
      horizontal = LabelPivot.right;
      vertical = LabelPivot.top;
      nudge = Offset(-gapValue, gapValue);
      break;
    case LabelAlign.bottomRight:
      horizontal = LabelPivot.left;
      vertical = LabelPivot.top;
      nudge = Offset(gapValue, gapValue);
      break;
    case LabelAlign.center:
      horizontal = LabelPivot.center;
      vertical = LabelPivot.middle;
      nudge = Offset.zero;
      break;
  }

  paintText(
    config,
    canvas,
    label,
    pixelPos + nudge,
    horizontalPivot: horizontal,
    verticalPivot: vertical,
    normalize: normalize,
    type: textType,
  );
}
