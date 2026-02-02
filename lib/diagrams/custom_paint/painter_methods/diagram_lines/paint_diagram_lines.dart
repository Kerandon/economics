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
      double strokeWidth = 5.0,

      // LABELS
      String? label1,
      String? label2,
      String? middleLabel,
      LabelAlign label1Align = LabelAlign.centerTop,
      LabelAlign label2Align = LabelAlign.centerBottom,
      LabelAlign middleLabelAlign = LabelAlign.center,

      double labelPadding = 18.0,

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
    for (int i = 0; i < points.length - 1; i++) {
      canvas.drawDashedLine(
        points[i],
        points[i + 1],
        mainColor,
        effectiveWidth,
      );
    }
  } else {
    // FIX: Instead of drawPath (which ignores width in your interface),
    // we draw connected line segments. Since drawLine accepts width,
    // this respects your strokeWidth parameter.
    for (int i = 0; i < points.length - 1; i++) {
      canvas.drawLine(
        points[i],
        points[i + 1],
        mainColor,
        effectiveWidth,
      );
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
    double padding,
    ) {
  LabelPivot horizontal = LabelPivot.center;
  LabelPivot vertical = LabelPivot.middle;

  final double gapValue = padding * config.averageRatio;
  Offset nudge = Offset.zero;

  switch (align) {
    case LabelAlign.centerTop:
      vertical = LabelPivot.bottom;
      nudge = Offset(0, -gapValue);
      break;
    case LabelAlign.centerBottom:
      vertical = LabelPivot.top;
      nudge = Offset(0, gapValue);
      break;
    case LabelAlign.centerLeft:
      horizontal = LabelPivot.right;
      nudge = Offset(-gapValue, 0);
      break;
    case LabelAlign.centerRight:
      horizontal = LabelPivot.left;
      nudge = Offset(gapValue, 0);
      break;
    case LabelAlign.center:
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
    style: TextStyle(color: color, fontWeight: FontWeight.bold),
  );
}