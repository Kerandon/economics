import 'dart:math' show sin, cos, pi, sqrt, atan2;

import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_arrow_head.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_text.dart';
import 'package:flutter/material.dart';

import '../../models/diagram_painter_config.dart';
import '../i_diagram_canvas.dart';
import '../painter_constants.dart';
import 'dart:math';
import 'dart:ui';
// Assuming you have your specific imports for DiagramPainterConfig, IDiagramCanvas, etc.

/// Defines where the label sits relative to the line's center.

void paintLineSegment(
  DiagramPainterConfig config,
  IDiagramCanvas canvas, {
  required Offset origin,
  double angle = 0,
  double length = 0.10,
  double strokeWidth = kCurveWidth,
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

  // --- 1. Calculate Geometry ---
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

  double effectiveStrokeWidth =
      (style == CurveStyle.bold ? strokeWidth * 2 : strokeWidth * 0.90) *
      config.averageRatio;

  // ✨ NEW: Reduce line thickness by 50% if an arrow is painted
  if (endStyle == LineEndStyle.arrow ||
      endStyle == LineEndStyle.arrowBothEnds) {
    effectiveStrokeWidth *= 0.3;
  }

  final startOffset = computeOffset(startPos);
  final endOffset = computeOffset(endPos);

  // --- 2. Draw Line ---
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

  // --- 3. Draw End Marks ---
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
      final double dotRadius = effectiveStrokeWidth * 1;
      canvas.drawDot(startOffset, mainColor, radius: dotRadius, fill: true);
      canvas.drawDot(endOffset, mainColor, radius: dotRadius, fill: true);
      break;
    case LineEndStyle.none:
      break;
  }

  // --- 4. Draw Primary Label (Updated) ---
  if (label != null) {
    // 1. Find the absolute center of the line segment
    final Offset midNormalized = Offset(
      (startPos.dx + endPos.dx) / 2,
      (startPos.dy + endPos.dy) / 2,
    );

    // 2. Define spacing: Distance from the line center to the text box edge
    //    3% of canvas size usually looks balanced.
    final double paddingPx = widthAndHeight * 0.02;
    final double paddingNorm = paddingPx / widthAndHeight;

    Offset deltaNormalized;
    LabelPivot hPivot;
    LabelPivot vPivot;

    // 3. Determine Shift and Pivot based on Alignment
    //    Key Concept: If we shift UP, we pivot at the BOTTOM of the text.
    //    If we shift LEFT, we pivot at the RIGHT of the text.
    switch (labelAlign) {
      case LabelAlign.centerTop:
        deltaNormalized = Offset(0, -paddingNorm);
        hPivot = LabelPivot.center;
        vPivot = LabelPivot.bottom;
        break;
      case LabelAlign.centerBottom:
        deltaNormalized = Offset(0, paddingNorm);
        hPivot = LabelPivot.center;
        vPivot = LabelPivot.top;
        break;
      case LabelAlign.left:
        deltaNormalized = Offset(-paddingNorm, 0);
        hPivot = LabelPivot.right;
        vPivot = LabelPivot.middle;
        break;
      case LabelAlign.right:
        deltaNormalized = Offset(paddingNorm, 0);
        hPivot = LabelPivot.left;
        vPivot = LabelPivot.middle;
        break;
      case LabelAlign.topLeft:
        deltaNormalized = Offset(-paddingNorm, -paddingNorm);
        hPivot = LabelPivot.right;
        vPivot = LabelPivot.bottom;
        break;
      case LabelAlign.topRight:
        deltaNormalized = Offset(paddingNorm, -paddingNorm);
        hPivot = LabelPivot.left;
        vPivot = LabelPivot.bottom;
        break;
      case LabelAlign.bottomLeft:
        deltaNormalized = Offset(-paddingNorm, paddingNorm);
        hPivot = LabelPivot.right;
        vPivot = LabelPivot.top;
        break;
      case LabelAlign.bottomRight:
        deltaNormalized = Offset(paddingNorm, paddingNorm);
        hPivot = LabelPivot.left;
        vPivot = LabelPivot.top;
        break;
      case LabelAlign.center:
        deltaNormalized = Offset.zero;
        hPivot = LabelPivot.center;
        vPivot = LabelPivot.middle;
        break;
    }

    paintText(
      config,
      canvas,
      label,
      midNormalized + deltaNormalized,
      fontSize: kFontTiny,
      horizontalPivot: hPivot,
      verticalPivot: vPivot,
      normalize: normalizeToDiagramArea,
      style: TextStyle(color: mainColor),
    );
  }

  // --- 5. Draw Secondary Label ---
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

// --- Helper Functions ---

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

void _paintCurlyBrace(
  DiagramPainterConfig config,
  IDiagramCanvas canvas,
  Offset start,
  Offset end,
  Color color,
  double strokeWidth,
) {
  final dx = end.dx - start.dx;
  final dy = end.dy - start.dy;
  final length = sqrt(dx * dx + dy * dy);
  final angle = atan2(dy, dx);
  final double q = 10.0 * config.averageRatio;

  Offset cubicPoint(double t, Offset p0, Offset p1, Offset p2, Offset p3) {
    final u = 1 - t;
    final tt = t * t;
    final uu = u * u;
    final uuu = uu * u;
    final ttt = tt * t;
    return p0 * uuu + p1 * 3 * uu * t + p2 * 3 * u * tt + p3 * ttt;
  }

  final List<Offset> points = [];
  const int segments = 20;

  for (int i = 0; i <= segments; i++) {
    final t = i / segments;
    points.add(
      cubicPoint(
        t,
        Offset.zero,
        Offset(length * 0.25, 0),
        Offset(length * 0.25, -q),
        Offset(length * 0.5, -q),
      ),
    );
  }

  for (int i = 0; i <= segments; i++) {
    final t = i / segments;
    points.add(
      cubicPoint(
        t,
        Offset(length * 0.5, -q),
        Offset(length * 0.75, -q),
        Offset(length * 0.75, 0),
        Offset(length, 0),
      ),
    );
  }

  canvas.save();
  canvas.translate(start.dx, start.dy);
  canvas.rotate(angle);
  for (int i = 0; i < points.length - 1; i++) {
    canvas.drawLine(points[i], points[i + 1], color, strokeWidth);
  }
  canvas.restore();
}
