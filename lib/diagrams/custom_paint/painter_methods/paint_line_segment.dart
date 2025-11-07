
import 'dart:math' show sin, cos, pi;

import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_arrow_head.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_text_2.dart';
import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';

import '../../models/diagram_painter_config.dart';
import '../painter_constants.dart';
import 'axis/label_align.dart';
import 'diagram_lines/paint_diagram_lines.dart';

void paintLineSegment(
    DiagramPainterConfig config,
    Canvas canvas, {
      required Offset origin,
      double angle = 0, // in radians
      double length = 0.10,
      double strokeWidth = kCurveWidthSlim,
      CurveStyle style = CurveStyle.standard,
      Color? color,
      String? label,
      LabelAlign labelAlign = LabelAlign.centerTop,
      bool normalizeToDiagramArea = true,
      LineEndStyle endStyle = LineEndStyle.arrow, // NOW INCLUDES arrowRightAngles
      // --- NEW: secondary text support ---
      String? secondaryLabel,
      Offset? secondaryLabelPos,
      double secondaryLabelAngle = 0,
      LabelPivot horizontalPivot = LabelPivot.center,
      LabelPivot verticalPivot = LabelPivot.middle,
    }) {
  // --- 1. Normalization and Setup ---
  final widthAndHeight = config.painterSize.width;
  final normalize = normalizeToDiagramArea ? 1 - (kAxisIndent * 2) : 1.0;
  final widthAndHeightNormalized = widthAndHeight * normalize;
  final indent = widthAndHeight * kAxisIndent;
  const pi = 3.14159265359;

  Offset computeOffset(Offset pos) {
    final dx = pos.dx * widthAndHeightNormalized;
    final dy = pos.dy * widthAndHeightNormalized;
    if (normalizeToDiagramArea) {
      return Offset(dx + indent * 1.5, dy + indent * 0.50);
    } else {
      return Offset(dx, dy);
    }
  }

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

  // --- 2. Draw Line Path ---
  final path = Path()
    ..moveTo(computeOffset(startPos).dx, computeOffset(startPos).dy)
    ..lineTo(computeOffset(endPos).dx, computeOffset(endPos).dy);

  // Assuming dashPath and CircularIntervalList are defined elsewhere
  Path applyCurveStyle(Path inputPath) {
    switch (style) {
      case CurveStyle.dashed:
      // return dashPath(inputPath, dashArray: CircularIntervalList<double>(<double>[8.0, 5.0]));
        return inputPath;
      case CurveStyle.dotted:
      // return dashPath(inputPath, dashArray: CircularIntervalList<double>(<double>[2.0, 4.0]));
        return inputPath;
      case CurveStyle.bold:
      case CurveStyle.standard:
        return inputPath;
    }
  }

  final paint = Paint()
    ..color = mainColor
    ..strokeWidth = effectiveStrokeWidth
    ..style = PaintingStyle.stroke;

  final styledPath = applyCurveStyle(path);
  canvas.drawPath(styledPath, paint);

  // --- 3. Draw End Marks ---
  final endOffset = computeOffset(endPos);
  final startOffset = computeOffset(startPos);

  switch (endStyle) {
    case LineEndStyle.arrow:
      paintArrowHead(config, canvas,
          color: mainColor,
          positionOfArrow: endOffset,
          rotationAngle: angle + (pi / 2));
      break;

    case LineEndStyle.arrowBothEnds:
      paintArrowHead(config, canvas,
          color: mainColor,
          positionOfArrow: endOffset,
          rotationAngle: angle + (pi / 2));
      paintArrowHead(config, canvas,
          color: mainColor,
          positionOfArrow: startOffset,
          rotationAngle: angle - (pi / 2));
      break;

    case LineEndStyle.arrowRightAngles: // ⭐ IMPLEMENTATION
      _paintRightAngleMarker(config, canvas,
          color: mainColor,
          position: endOffset,
          lineAngle: angle,
          strokeWidth: effectiveStrokeWidth);
      _paintRightAngleMarker(config, canvas,
          color: mainColor,
          position: startOffset,
          lineAngle: angle,
          strokeWidth: effectiveStrokeWidth);
      break;

    case LineEndStyle.none:
      break;
  }
// --- 4. Label ---
  if (label != null) {
    // 1. Calculate midpoint in normalized coordinates
    final Offset midNormalized = Offset(
      (startPos.dx + endPos.dx) / 2,
      (startPos.dy + endPos.dy) / 2,
    );

    // ⭐ Adjusted label offset for clearer spacing (Increased to 0.05)
    double labelOffsetPx = config.painterSize.width * 0.04;

    final bool usingDiagramNormalize = normalizeToDiagramArea;
    final double normalizeFactor = usingDiagramNormalize ? (1.0 - (kAxisIndent * 2)) : 1.0;
    final double deltaNormalizedScalar = labelOffsetPx / (config.painterSize.width * normalizeFactor);

    // Perpendicular unit vector (in normalized coordinate space)
    final Offset perpUnit = Offset(-sin(angle), cos(angle));
    Offset deltaNormalized;

    switch (labelAlign) {
      case LabelAlign.centerTop:
      // ⭐ FIX 1: Multiply by -1 to invert the direction relative to Canvas Y-axis.
      // centerTop means above the line (negative Y in diagram space),
      // which often corresponds to positive Canvas Y-axis when perpendicular to a horizontal line.
      // We use perpUnit * -1 to flip the offset direction, which corrects the alignment.
        deltaNormalized = perpUnit * deltaNormalizedScalar * -1;
        break;

      case LabelAlign.centerBottom:
      // ⭐ FIX 1: Multiply by +1 (or leave as is) for centerBottom.
      // centerBottom means below the line (positive Y in diagram space).
        deltaNormalized = perpUnit * deltaNormalizedScalar * 1;
        break;

      default:
      // ⭐ FIX 2: Ensure it's exactly centered on the line for any other alignment choice
        deltaNormalized = Offset.zero;
        break;
    }

    final Offset labelNormalizedPos = midNormalized + deltaNormalized;

    // Use paintText2
    paintText2(
      fontSize: kFontSmall,
      config,
      canvas,
      label,
      labelNormalizedPos,
      angle: 0,
      horizontalPivot: LabelPivot.center,
      verticalPivot: LabelPivot.middle,
      normalize: true,
    );
  }


  // --- 5. Secondary Label (optional) ---
  if (secondaryLabel != null && secondaryLabelPos != null) {
    paintText2(
      config,
      canvas,
      secondaryLabel,
      secondaryLabelPos,
      angle: secondaryLabelAngle,
      horizontalPivot: horizontalPivot,
      verticalPivot: verticalPivot,
    );
  }
}
enum LineEndStyle {
  /// No special termination, just the line itself.
  none,
  /// Standard single arrowhead at the 'endPos'.
  arrow,
  /// Arrowheads at both start and end (like a vector).
  arrowBothEnds,
  /// A perpendicular line segment at both ends, visually extending measurement bounds.
  arrowRightAngles, // ⭐ NEW STYLE
}/// Draws a small line segment perpendicular to the main line (90 degrees).
void _paintRightAngleMarker(
    DiagramPainterConfig config,
    Canvas canvas, {
      required Color color,
      required Offset position,
      required double lineAngle, // Angle of the main line
      required double strokeWidth,
    }) {
  const double markerLengthNormalized = 0.020; // Increased size for visibility
  final double halfMarkerLen = markerLengthNormalized / 2 * config.painterSize.width;
  const pi = 3.14159265359;

  // Angle of the marker line is perpendicular to the main line
  final double markerAngle = lineAngle + (pi / 2);

  // Calculate the start and end of the marker line
  final markerStart = Offset(
    position.dx - halfMarkerLen * cos(markerAngle),
    position.dy - halfMarkerLen * sin(markerAngle),
  );
  final markerEnd = Offset(
    position.dx + halfMarkerLen * cos(markerAngle),
    position.dy + halfMarkerLen * sin(markerAngle),
  );

  final markerPaint = Paint()
    ..color = color
    ..strokeWidth = strokeWidth
    ..style = PaintingStyle.stroke;

  canvas.drawLine(markerStart, markerEnd, markerPaint);
}