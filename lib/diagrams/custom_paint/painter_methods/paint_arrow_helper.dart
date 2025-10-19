import 'dart:math' show cos, sin, pi;

import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_arrow_head.dart';
import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';

import '../../models/diagram_painter_config.dart';
import '../painter_constants.dart';
import 'axis/label_align.dart';
import 'diagram_lines/paint_diagram_lines.dart';
import 'diagram_lines/paint_label_text.dart';

void paintArrowHelper(
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
  bool arrowBothEnds = false, // NEW
}) {
  // Normalize scaling
  final widthAndHeight = config.painterSize.width;
  final normalize = normalizeToDiagramArea ? 1 - (kAxisIndent * 2) : 1.0;
  final widthAndHeightNormalized = widthAndHeight * normalize;
  final indent = widthAndHeight * kAxisIndent;

  Offset computeOffset(Offset pos) {
    final dx = pos.dx * widthAndHeightNormalized;
    final dy = pos.dy * widthAndHeightNormalized;
    if (normalizeToDiagramArea) {
      return Offset(dx + indent * 1.5, dy + indent * 0.50);
    } else {
      return Offset(dx, dy);
    }
  }

  // Make the arrow centered on `origin`
  final halfLen = length / 2;
  final startPos = Offset(
    origin.dx - halfLen * cos(angle),
    origin.dy - halfLen * sin(angle),
  );
  final endPos = Offset(
    origin.dx + halfLen * cos(angle),
    origin.dy + halfLen * sin(angle),
  );

  final mainColor = color ?? config.colorScheme.primary;

  // Create path
  final path = Path()
    ..moveTo(computeOffset(startPos).dx, computeOffset(startPos).dy)
    ..lineTo(computeOffset(endPos).dx, computeOffset(endPos).dy);

  // Apply style
  Path applyCurveStyle(Path inputPath) {
    switch (style) {
      case CurveStyle.dashed:
        return dashPath(
          inputPath,
          dashArray: CircularIntervalList<double>(<double>[8.0, 5.0]),
        );
      case CurveStyle.dotted:
        return dashPath(
          inputPath,
          dashArray: CircularIntervalList<double>(<double>[2.0, 4.0]),
        );
      case CurveStyle.bold:
      case CurveStyle.standard:
        return inputPath;
    }
  }

  final paint = Paint()
    ..color = mainColor
    ..strokeWidth =
        (style == CurveStyle.bold ? strokeWidth * 2 : strokeWidth) *
        config.averageRatio
    ..style = PaintingStyle.stroke;

  final styledPath = applyCurveStyle(path);
  canvas.drawPath(styledPath, paint);

  // ---- Arrowheads ----
  final endOffset = computeOffset(endPos);
  final startOffset = computeOffset(startPos);

  // Arrow at end
  paintArrowHead(
    config,
    canvas,
    color: mainColor,
    positionOfArrow: endOffset,
    rotationAngle: angle + (pi / 2),
  );

  // Arrow at start (if enabled)
  if (arrowBothEnds) {
    paintArrowHead(
      config,
      canvas,
      color: mainColor,
      positionOfArrow: startOffset,
      rotationAngle: angle - (pi / 2),
    );
  }

  // ---- Label ----
  if (label != null) {
    paintLabelText(canvas, config, label, origin, labelAlign: labelAlign);
  }
}
