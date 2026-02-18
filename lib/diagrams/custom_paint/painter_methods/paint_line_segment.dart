import 'dart:math' show sin, cos, pi, sqrt, atan2;

import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_arrow_head.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_text.dart';
import 'package:flutter/material.dart';

import '../../models/diagram_painter_config.dart';
import '../i_diagram_canvas.dart';
import '../painter_constants.dart';

void paintLineSegment(
  DiagramPainterConfig config,
  IDiagramCanvas canvas, {
  required Offset origin,
  double angle = 0,
  double length = 0.10,
  double strokeWidth = kCurveWidthSlim,
  CurveStyle style = CurveStyle.standard,
  Color? color,
  String? label,
  LabelAlign labelAlign = LabelAlign.centerTop,
  bool normalizeToDiagramArea = true,
  LineEndStyle endStyle = LineEndStyle.arrow,
  String? secondaryLabel,
  Offset? secondaryLabelPos,
  double secondaryLabelAngle = 0,
  LabelPivot horizontalPivot = LabelPivot.center,
  LabelPivot verticalPivot = LabelPivot.middle,
}) {
  final widthAndHeight = config.painterSize.width;
  final normalize = normalizeToDiagramArea ? 1 - (kAxisIndent * 2) : 1.0;
  final widthAndHeightNormalized = widthAndHeight * normalize;
  final indent = widthAndHeight * kAxisIndent;

  Offset computeOffset(Offset pos) {
    final dx = pos.dx * widthAndHeightNormalized;
    final dy = pos.dy * widthAndHeightNormalized;
    return normalizeToDiagramArea
        ? Offset(dx + indent, dy + indent * kTopAxisIndent)
        : Offset(dx, dy);
  }

  // Calculate Start and End points
  final halfLen = length / 2;
  final startPos = Offset(
    origin.dx - halfLen * cos(angle),
    origin.dy - halfLen * sin(angle),
  );
  final endPos = Offset(
    origin.dx + halfLen * cos(angle),
    origin.dy + halfLen * sin(angle),
  );

  final mainColor = color ?? config.colorScheme.onSurface;
  final effectiveStrokeWidth =
      (style == CurveStyle.bold ? strokeWidth * 2 : strokeWidth) *
      config.averageRatio;

  final startOffset = computeOffset(startPos);
  final endOffset = computeOffset(endPos);

  // Standard Line
  if (style == CurveStyle.dashed || style == CurveStyle.dotted) {
    canvas.drawDashedLine(
      startOffset,
      endOffset,
      mainColor,
      effectiveStrokeWidth,
    );
  } else {
    canvas.drawLine(startOffset, endOffset, mainColor, effectiveStrokeWidth);
  }

  // --- 2. Draw End Marks ---
  switch (endStyle) {
    case LineEndStyle.arrow:
      paintArrowHead(
        config,
        canvas,
        color: mainColor,
        positionOfArrow: endOffset,
        rotationAngle: angle + (pi / 2),
      );
      break;
    case LineEndStyle.arrowBothEnds:
      paintArrowHead(
        config,
        canvas,
        color: mainColor,
        positionOfArrow: endOffset,
        rotationAngle: angle + (pi / 2),
      );
      paintArrowHead(
        config,
        canvas,
        color: mainColor,
        positionOfArrow: startOffset,
        rotationAngle: angle - (pi / 2),
      );
      break;
    case LineEndStyle.arrowRightAngles:
      _paintRightAngleMarker(
        config,
        canvas,
        color: mainColor,
        position: endOffset,
        lineAngle: angle,
        strokeWidth: effectiveStrokeWidth,
      );
      _paintRightAngleMarker(
        config,
        canvas,
        color: mainColor,
        position: startOffset,
        lineAngle: angle,
        strokeWidth: effectiveStrokeWidth,
      );
      break;
    case LineEndStyle.circlesOnEnd:
      final double dotRadius = effectiveStrokeWidth * 2.5;
      canvas.drawDot(startOffset, mainColor, radius: dotRadius, fill: true);
      canvas.drawDot(endOffset, mainColor, radius: dotRadius, fill: true);

      break;
    case LineEndStyle.none:
      break;
  }

  // --- 3. Labels (Unchanged) ---
  if (label != null) {
    final Offset midNormalized = Offset(
      (startPos.dx + endPos.dx) / 2,
      (startPos.dy + endPos.dy) / 2,
    );
    final double labelOffsetPx = widthAndHeight * 0.04;
    final Offset perpUnit = Offset(-sin(angle), cos(angle));

    Offset deltaNormalized = (labelAlign == LabelAlign.centerTop)
        ? perpUnit * -labelOffsetPx / widthAndHeight
        : (labelAlign == LabelAlign.centerBottom)
        ? perpUnit * labelOffsetPx / widthAndHeight
        : Offset.zero;

    paintText(
      config,
      canvas,
      label,
      midNormalized + deltaNormalized,
      fontSize: kFontTiny,
      horizontalPivot: LabelPivot.center,
      verticalPivot: LabelPivot.middle,
      normalize: normalizeToDiagramArea,
      style: TextStyle(color: mainColor),
    );
  }

  // --- 4. Secondary Label ---
  if (secondaryLabel != null && secondaryLabelPos != null) {
    paintText(
      config,
      canvas,
      secondaryLabel,
      secondaryLabelPos,
      angle: secondaryLabelAngle,
      horizontalPivot: horizontalPivot,
      verticalPivot: verticalPivot,
      normalize: normalizeToDiagramArea,
      style: TextStyle(color: mainColor),
    );
  }
}

/// Helper: Draws a curly brace using manual Bezier approximation
/// compatible with IDiagramCanvas (using drawLine).
void _paintCurlyBrace(
  DiagramPainterConfig config,
  IDiagramCanvas canvas,
  Offset start,
  Offset end,
  Color color,
  double strokeWidth,
) {
  // 1. Calculate Geometry for Transform
  final dx = end.dx - start.dx;
  final dy = end.dy - start.dy;
  final length = sqrt(dx * dx + dy * dy);
  final angle = atan2(dy, dx);

  // 2. Configure Brace Shape
  // 'q' is the vertical height of the brace curve (the "bulge")
  final double q = 10.0 * config.averageRatio;

  // 3. Define Bezier Math Helper
  // Returns a point on a cubic curve at time t [0..1]
  Offset cubicPoint(double t, Offset p0, Offset p1, Offset p2, Offset p3) {
    final u = 1 - t;
    final tt = t * t;
    final uu = u * u;
    final uuu = uu * u;
    final ttt = tt * t;

    // Cubic Bezier formula: P = (1-t)^3*P0 + 3(1-t)^2*t*P1 + 3(1-t)t^2*P2 + t^3*P3
    return p0 * uuu + p1 * 3 * uu * t + p2 * 3 * u * tt + p3 * ttt;
  }

  // 4. Generate Segments
  // We perform the calculation relative to a flat line (0,0) -> (length,0)
  // and use canvas.rotate to handle the angle.
  final List<Offset> points = [];
  const int segments = 20; // smoothness

  // -- First Half (Start -> Peak) --
  // P0(0,0) -> P3(length/2, -q)
  for (int i = 0; i <= segments; i++) {
    final t = i / segments;
    points.add(
      cubicPoint(
        t,
        Offset.zero, // Start
        Offset(length * 0.25, 0), // Control 1 (Flat start)
        Offset(length * 0.25, -q), // Control 2 (Curve up)
        Offset(length * 0.5, -q), // End (Peak)
      ),
    );
  }

  // -- Second Half (Peak -> End) --
  // P0(length/2, -q) -> P3(length, 0)
  for (int i = 0; i <= segments; i++) {
    final t = i / segments;
    points.add(
      cubicPoint(
        t,
        Offset(length * 0.5, -q), // Start (Peak)
        Offset(length * 0.75, -q), // Control 1 (Curve down)
        Offset(length * 0.75, 0), // Control 2 (Flat end)
        Offset(length, 0), // End
      ),
    );
  }

  // 5. Draw
  canvas.save();
  canvas.translate(start.dx, start.dy);
  canvas.rotate(angle);

  // Draw the connected lines
  for (int i = 0; i < points.length - 1; i++) {
    canvas.drawLine(points[i], points[i + 1], color, strokeWidth);
  }

  canvas.restore();
}

void _paintRightAngleMarker(
  DiagramPainterConfig config,
  IDiagramCanvas canvas, {
  required Color color,
  required Offset position,
  required double lineAngle,
  required double strokeWidth,
}) {
  const double markerLengthNormalized = 0.020;
  final double halfMarkerLen =
      markerLengthNormalized / 2 * config.painterSize.width;
  final double markerAngle = lineAngle + (pi / 2);

  final markerStart = Offset(
    position.dx - halfMarkerLen * cos(markerAngle),
    position.dy - halfMarkerLen * sin(markerAngle),
  );
  final markerEnd = Offset(
    position.dx + halfMarkerLen * cos(markerAngle),
    position.dy + halfMarkerLen * sin(markerAngle),
  );

  canvas.drawLine(markerStart, markerEnd, color, strokeWidth);
}

/// Helper to draw a curly brace (tweezer) between two points
