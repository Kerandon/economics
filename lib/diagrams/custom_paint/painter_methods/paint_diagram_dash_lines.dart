import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_dashed_line.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_dot.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_solid_line.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_text_2.dart';
import 'package:flutter/material.dart';
import '../../models/diagram_painter_config.dart';
import '../diagrams/demand_diagram.dart';
import '../i_diagram_canvas.dart';
import '../painter_constants.dart';

void paintDiagramDashedLines(
  DiagramPainterConfig config,
  IDiagramCanvas canvas, { // Unified interface
  required double yAxisStartPos,
  required double xAxisEndPos,
  String? yLabel,
  String? xLabel,
  bool hideYLine = false,
  bool hideXLine = false,
  bool makeDashed = true,
  Color? color,
  bool showDotAtIntersection = false,
  double dotRadius = kDotRadius,
  Color? dotColor,
}) {
  final c = color ?? config.colorScheme.onSurface;
  final width = config.painterSize.width;

  // 1. Core Coordinate Math
  final top = kAxisIndent * kTopAxisIndent;
  final bottom = 1 - (kAxisIndent * kBottomAxisIndent);
  final left = kAxisIndent;
  final spanY = bottom - top;

  // Convert normalized 0.0-1.0 to absolute pixel coordinates
  final yPos = (top + yAxisStartPos * spanY) * width;
  final xEndPos = (left + xAxisEndPos * spanY) * width;
  final axisLeft = left * width;
  final axisBottom = bottom * width;

  final strokeWidth = 1.5 * config.averageRatio;

  // 2. Draw the Lines
  if (!hideYLine) {
    final p1 = Offset(axisLeft, yPos);
    final p2 = Offset(xEndPos, yPos);

    if (makeDashed) {
      canvas.drawDashedLine(p1, p2, c, strokeWidth);
    } else {
      canvas.drawLine(p1, p2, c, strokeWidth);
    }
  }

  if (!hideXLine) {
    final p1 = Offset(xEndPos, yPos);
    final p2 = Offset(xEndPos, axisBottom);

    // Vertical equilibrium lines are almost always dashed
    canvas.drawDashedLine(p1, p2, c, strokeWidth);
  }

  // 3. Labels (Now using the pivot system)
  if (yLabel != null) {
    _paintTextForDashedLines(
      config,
      canvas,
      yLabel,
      yAxisStartPos,
      CustomAxis.y,
    );
  }
  if (xLabel != null) {
    _paintTextForDashedLines(config, canvas, xLabel, xAxisEndPos, CustomAxis.x);
  }

  // 4. Dot at Intersection
  if (showDotAtIntersection) {
    final r = dotRadius * config.averageRatio * 0.60;
    final intersection = Offset(xEndPos, yPos);
    canvas.drawDot(intersection, dotColor ?? c, radius: r, fill: true);
  }
}

/// Simplified Helper using paintText2 and Pivots
void _paintTextForDashedLines(
  DiagramPainterConfig config,
  IDiagramCanvas canvas,
  String label,
  double pos, // 0.0 to 1.0 position along the span
  CustomAxis axis,
) {
  const padding = 0.015; // Normalized padding

  if (axis == CustomAxis.x) {
    // X-Axis labels (Quantities)
    // We anchor at the bottom of the diagram area
    paintText2(
      config,
      canvas,
      label,
      Offset(pos, 1.0 + padding), // Positioned just below the X-axis
      horizontalPivot: LabelPivot.center,
      verticalPivot: LabelPivot.top,
      normalize: true,
      style: TextStyle(color: config.colorScheme.onSurface),
    );
  } else {
    // Y-Axis labels (Prices)
    // We anchor at the left of the diagram area
    paintText2(
      config,
      canvas,
      label,
      Offset(0.0 - padding, pos), // Positioned just to the left of the Y-axis
      horizontalPivot: LabelPivot.right,
      verticalPivot: LabelPivot.middle,
      normalize: true,
      style: TextStyle(color: config.colorScheme.onSurface),
    );
  }
}
