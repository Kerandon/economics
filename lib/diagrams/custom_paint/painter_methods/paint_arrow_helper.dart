

import 'dart:math';

import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_arrow_head.dart';
import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';

import '../../models/diagram_painter_config.dart';
import '../painter_constants.dart';
import 'axis/label_align.dart';
import 'diagram_lines/paint_diagram_lines.dart';
import 'diagram_lines/paint_label_text.dart';
void paintArrowHelperRedundant(
    DiagramPainterConfig config,
    Canvas canvas, {
      required Offset origin,
      required double angle, // in radians
      double length = 0.080, // total arrow length (normalized)
      double strokeWidth = kCurveWidth,
      CurveStyle style = CurveStyle.standard,
      Color? color,
      String? label,
      LabelAlign labelAlign = LabelAlign.centerTop,
      bool normalizeToDiagramArea = true,
      bool arrowBothEnds = false,
      bool isDimensionLine = false, // ⭐ NEW PROPERTY FOR DIMENSION LINE STYLE
    }) {
  // Normalize scaling (No change here)
  final widthAndHeight = config.painterSize.width;
  final normalize = normalizeToDiagramArea ? 1 - (kAxisIndent * 2) : 1.0;
  final widthAndHeightNormalized = widthAndHeight * normalize;
  final indent = widthAndHeight * kAxisIndent;

  // Assume pi is defined (final pi = 3.14159265359;)
  const double tickLength = 0.008; // Normalized length for the tick mark

  Offset computeOffset(Offset pos) {
    final dx = pos.dx * widthAndHeightNormalized;
    final dy = pos.dy * widthAndHeightNormalized;
    if (normalizeToDiagramArea) {
      return Offset(dx + indent * 1.5, dy + indent * 0.50);
    } else {
      return Offset(dx, dy);
    }
  }

  // Calculate start/end positions (No change here)
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

  // Draw the main line segment (No change here)
  final path = Path()
    ..moveTo(computeOffset(startPos).dx, computeOffset(startPos).dy)
    ..lineTo(computeOffset(endPos).dx, computeOffset(endPos).dy);

  Path applyCurveStyle(Path inputPath) { /* ... existing logic ... */ return inputPath; }

  final paint = Paint()
    ..color = mainColor
    ..strokeWidth =
        (style == CurveStyle.bold ? strokeWidth * 2 : strokeWidth) *
            config.averageRatio
    ..style = PaintingStyle.stroke;

  final styledPath = applyCurveStyle(path);
  canvas.drawPath(styledPath, paint);

  // ---- End Marks (Arrowheads / Ticks) ----
  final endOffset = computeOffset(endPos);
  final startOffset = computeOffset(startPos);

  if (isDimensionLine) {
    // ⭐ LOGIC FOR DIMENSION LINE (TICK MARKS)

    // Draw tick at start
    paintDimensionTick(
      config, canvas,
      color: mainColor,
      position: startOffset,
      lineAngle: angle,
      tickLength: tickLength,
      strokeWidth: paint.strokeWidth,
    );

    // Draw tick at end
    paintDimensionTick(
      config, canvas,
      color: mainColor,
      position: endOffset,
      lineAngle: angle,
      tickLength: tickLength,
      strokeWidth: paint.strokeWidth,
    );
  } else {
    // LOGIC FOR STANDARD ARROWHEADS

    // Arrow at end
    // NOTE: This assumes paintArrowHead exists elsewhere.
    paintArrowHead(
      config, canvas,
      color: mainColor,
      positionOfArrow: endOffset,
      rotationAngle: angle + (pi / 2),
    );

    // Arrow at start (if enabled)
    if (arrowBothEnds) {
      paintArrowHead(
        config, canvas,
        color: mainColor,
        positionOfArrow: startOffset,
        rotationAngle: angle - (pi / 2),
      );
    }
  }

  // ---- Label ---- (No change here)
  if (label != null) {
    paintLabelText(canvas, config, label, origin, labelAlign: labelAlign);
  }
}

// 🛠️ REQUIRED NEW HELPER FUNCTION STUB
void paintDimensionTick(
    DiagramPainterConfig config,
    Canvas canvas, {
      required Color color,
      required Offset position,
      required double lineAngle, // Angle of the main line
      required double tickLength, // Normalized length of the perpendicular tick
      required double strokeWidth,
    }) {
  // A dimension tick is perpendicular to the main line.
  // The angle of the tick line is the main line angle plus pi/2 (90 degrees).
  final double tickAngle = lineAngle + (pi / 2);
  final double halfTickLen = tickLength / 2 * config.painterSize.width;

  // Calculate the start and end of the tick mark
  final tickStart = Offset(
    position.dx - halfTickLen * cos(tickAngle),
    position.dy - halfTickLen * sin(tickAngle),
  );
  final tickEnd = Offset(
    position.dx + halfTickLen * cos(tickAngle),
    position.dy + halfTickLen * sin(tickAngle),
  );

  final tickPaint = Paint()
    ..color = color
    ..strokeWidth = strokeWidth
    ..style = PaintingStyle.stroke;

  canvas.drawLine(tickStart, tickEnd, tickPaint);
}