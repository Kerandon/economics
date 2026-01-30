import 'dart:math' show sin, cos, pi;

import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_arrow_head.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_text_2.dart';
import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';

import '../../models/diagram_painter_config.dart';
import '../i_diagram_canvas.dart';
import '../painter_constants.dart';

import 'diagram_lines/paint_diagram_lines.dart';

void paintLineSegment(
  DiagramPainterConfig config,
  IDiagramCanvas canvas, { // Unified interface
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

  // Calculate Start and End points of the segment
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

  // --- 1. Draw the Main Line ---
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

  // --- 2. Draw End Marks (Arrows or Ticks) ---
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
    case LineEndStyle.none:
      break;
  }

  // --- 3. Primary Label ---
  if (label != null) {
    final Offset midNormalized = Offset(
      (startPos.dx + endPos.dx) / 2,
      (startPos.dy + endPos.dy) / 2,
    );
    final double labelOffsetPx = widthAndHeight * 0.04;
    final Offset perpUnit = Offset(-sin(angle), cos(angle));

    // Calculate displacement for the label so it doesn't overlap the line
    Offset deltaNormalized = (labelAlign == LabelAlign.centerTop)
        ? perpUnit * -labelOffsetPx / widthAndHeight
        : (labelAlign == LabelAlign.centerBottom)
        ? perpUnit * labelOffsetPx / widthAndHeight
        : Offset.zero;

    paintText2(
      config,
      canvas,
      label,
      midNormalized + deltaNormalized,
      fontSize: kFontSmall,
      horizontalPivot: LabelPivot.center,
      verticalPivot: LabelPivot.middle,
      normalize: normalizeToDiagramArea,
      style: TextStyle(color: mainColor),
    );
  }

  // --- 4. Secondary Label ---
  if (secondaryLabel != null && secondaryLabelPos != null) {
    paintText2(
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

/// Updated Right Angle Marker Helper
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
