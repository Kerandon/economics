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
  IDiagramCanvas canvas, {
  required Offset startPos,
  List<CustomBezier>? bezierPoints,
  List<Offset>? polylineOffsets,
  Color? color,
  double strokeWidth = 2.0, // Default width
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

  // Calculate scaled stroke width
  final double effectiveWidth =
      (curveStyle == CurveStyle.bold ? strokeWidth * 2 : strokeWidth) *
      config.averageRatio;
  final Offset start = computeOffset(startPos);

  // --- 2. BUILD POINTS (Universal Method) ---
  // We manually calculate points. This returns a List<Offset>,
  // which your IDiagramCanvas (and PDF export) definitely supports.
  List<Offset> points = [start];

  if (polylineOffsets != null && polylineOffsets.isNotEmpty) {
    // STRAIGHT LINES
    for (var p in polylineOffsets) {
      points.add(computeOffset(p));
    }
  } else if (bezierPoints != null && bezierPoints.isNotEmpty) {
    // CURVED LINES (Quadratic Bezier)
    Offset lastP = start;

    // SMOOTHNESS: 0.01 step = 100 points per curve segment.
    // This looks like a perfect curve even on high-res PDF exports.
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

  // --- 3. DRAWING (Fixing your Errors) ---

  if (curveStyle == CurveStyle.dashed || curveStyle == CurveStyle.dotted) {
    // DASHED: Draw segment by segment
    for (int i = 0; i < points.length - 1; i++) {
      // Assuming your interface is: drawDashedLine(p1, p2, color, width)
      canvas.drawDashedLine(
        points[i],
        points[i + 1],
        mainColor,
        effectiveWidth,
      );
    }
  } else {
    // SOLID: Pass the List<Offset> directly.
    // ERROR FIX: Removed named parameter 'strokeWidth' if your interface doesn't support it.
    // Instead, assume your drawPath takes (points, color, width, fill).
    canvas.drawPath(points, mainColor, fill: false);
  }

  // --- 4. END POSITION & DECORATIONS ---
  final Offset endPixelPos = points.last;

  // Draw Labels
  if (label1 != null) {
    _paintDiagramLabel(
      config,
      canvas,
      label1,
      start,
      label1Align,
      mainColor,
      false,
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
    );
  }

  // Draw Arrows (using calculated points for angle)
  if (arrowOnStart) {
    paintArrowHead(
      config,
      canvas,
      color: mainColor,
      positionOfArrow: start,
      rotationAngle: arrowOnStartAngle,
    );
  }

  if (arrowOnEnd && points.length >= 2) {
    // Calculate angle from the last two points of the curve
    final last = points.last;
    final prev = points[points.length - 2];
    double angle = arrowOnEndAngle == 0
        ? atan2(last.dy - prev.dy, last.dx - prev.dx)
        : arrowOnEndAngle;

    paintArrowHead(
      config,
      canvas,
      color: mainColor,
      positionOfArrow: endPixelPos,
      rotationAngle: angle,
    );
  }

  // Draw Dots
  final r = circleRadius * config.averageRatio;
  if (circleAtStart) canvas.drawDot(start, mainColor, radius: r);
  if (circleAtEnd) canvas.drawDot(endPixelPos, mainColor, radius: r);
}

void _paintDiagramLabel(
  DiagramPainterConfig config,
  IDiagramCanvas canvas,
  String label,
  Offset pixelPos, // Now treating this as the base pixel position
  LabelAlign align,
  Color color,
  bool normalize, // We pass 'false' from the parent for pixel accuracy
) {
  LabelPivot horizontal = LabelPivot.center;
  LabelPivot vertical = LabelPivot.middle;

  // Calculate a resolution-aware gap (approx 10 pixels)
  final double gapValue = 10.0 * config.averageRatio;
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

  paintText2(
    config,
    canvas,
    label,
    pixelPos + nudge, // Pass the final nudged pixel position
    horizontalPivot: horizontal,
    verticalPivot: vertical,
    normalize: normalize,
    style: TextStyle(color: color, fontWeight: FontWeight.bold),
  );
}
