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
  Canvas? canvas, {
  IDiagramCanvas? iCanvas, // 👈 Bridge added
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
  const pi = 3.14159265359;

  Offset computeOffset(Offset pos) {
    final dx = pos.dx * widthAndHeightNormalized;
    final dy = pos.dy * widthAndHeightNormalized;
    return normalizeToDiagramArea
        ? Offset(dx + indent, dy + indent * kTopAxisIndent)
        : Offset(dx, dy);
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

  final startOffset = computeOffset(startPos);
  final endOffset = computeOffset(endPos);

  // --- 1. Draw Line ---
  if (iCanvas != null) {
    if (style == CurveStyle.dashed || style == CurveStyle.dotted) {
      iCanvas.drawDashedLine(
        startOffset,
        endOffset,
        mainColor,
        effectiveStrokeWidth,
      );
    } else {
      iCanvas.drawLine(startOffset, endOffset, mainColor, effectiveStrokeWidth);
    }
  } else if (canvas != null) {
    final paint = Paint()
      ..color = mainColor
      ..strokeWidth = effectiveStrokeWidth
      ..style = PaintingStyle.stroke;

    // Simplified for brevity, standard path drawing
    canvas.drawLine(startOffset, endOffset, paint);
  }

  // --- 2. Draw End Marks ---
  switch (endStyle) {
    case LineEndStyle.arrow:
      paintArrowHead(
        config,
        canvas,
        iCanvas: iCanvas,
        color: mainColor,
        positionOfArrow: endOffset,
        rotationAngle: angle + (pi / 2),
      );
      break;
    case LineEndStyle.arrowBothEnds:
      paintArrowHead(
        config,
        canvas,
        iCanvas: iCanvas,
        color: mainColor,
        positionOfArrow: endOffset,
        rotationAngle: angle + (pi / 2),
      );
      paintArrowHead(
        config,
        canvas,
        iCanvas: iCanvas,
        color: mainColor,
        positionOfArrow: startOffset,
        rotationAngle: angle - (pi / 2),
      );
      break;
    case LineEndStyle.arrowRightAngles:
      _paintRightAngleMarker(
        config,
        canvas,
        iCanvas: iCanvas,
        color: mainColor,
        position: endOffset,
        lineAngle: angle,
        strokeWidth: effectiveStrokeWidth,
      );
      _paintRightAngleMarker(
        config,
        canvas,
        iCanvas: iCanvas,
        color: mainColor,
        position: startOffset,
        lineAngle: angle,
        strokeWidth: effectiveStrokeWidth,
      );
      break;
    case LineEndStyle.none:
      break;
  }

  // --- 3. Label ---
  if (label != null) {
    final Offset midNormalized = Offset(
      (startPos.dx + endPos.dx) / 2,
      (startPos.dy + endPos.dy) / 1.98,
    );
    final double labelOffsetPx = config.painterSize.width * 0.06;
    final Offset perpUnit = Offset(-sin(angle), cos(angle));

    Offset deltaNormalized = (labelAlign == LabelAlign.centerTop)
        ? perpUnit * -labelOffsetPx / config.painterSize.width
        : (labelAlign == LabelAlign.centerBottom)
        ? perpUnit * labelOffsetPx / config.painterSize.width
        : Offset.zero;

    paintText2(
      config,
      canvas,
      label,
      midNormalized + deltaNormalized,
      iCanvas: iCanvas,
      fontSize: kFontSmall,
      horizontalPivot: LabelPivot.center,
      verticalPivot: LabelPivot.middle,
      normalize: true,
    );
  }

  // --- 4. Secondary Label ---
  if (secondaryLabel != null && secondaryLabelPos != null) {
    paintText2(
      config,
      canvas,
      secondaryLabel,
      secondaryLabelPos,
      iCanvas: iCanvas,
      angle: secondaryLabelAngle,
      horizontalPivot: horizontalPivot,
      verticalPivot: verticalPivot,
    );
  }
}

void _paintRightAngleMarker(
  DiagramPainterConfig config,
  Canvas? canvas, {
  IDiagramCanvas? iCanvas, // 👈 Added bridge
  required Color color,
  required Offset position,
  required double lineAngle,
  required double strokeWidth,
}) {
  const double markerLengthNormalized = 0.020;
  final double halfMarkerLen =
      markerLengthNormalized / 2 * config.painterSize.width;
  const pi = 3.14159265359;

  final double markerAngle = lineAngle + (pi / 2);

  final markerStart = Offset(
    position.dx - halfMarkerLen * cos(markerAngle),
    position.dy - halfMarkerLen * sin(markerAngle),
  );
  final markerEnd = Offset(
    position.dx + halfMarkerLen * cos(markerAngle),
    position.dy + halfMarkerLen * sin(markerAngle),
  );

  if (iCanvas != null) {
    iCanvas.drawLine(markerStart, markerEnd, color, strokeWidth);
  } else if (canvas != null) {
    final markerPaint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;
    canvas.drawLine(markerStart, markerEnd, markerPaint);
  }
}
