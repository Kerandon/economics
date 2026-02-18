import 'package:flutter/material.dart';

import '../../../models/diagram_painter_config.dart';
import '../../diagrams/demand_diagram.dart';
import '../../i_diagram_canvas.dart';
import '../../painter_constants.dart';
import '../paint_diagram_dash_lines.dart';
import '../paint_text.dart';

void paintAxisLabels(
  DiagramPainterConfig config,
  IDiagramCanvas canvas, {
  required CustomAxis axis,
  required String label,
  Offset offsetAdjustment = Offset.zero, // Default to no extra shift
}) {
  // Pass the raw constant. paintText will scale it by averageRatio.
  const double fontSize = kFontMedium;
  final effectiveColor = config.colorScheme.onSurface;

  // 1. Define Base Positions (The standard "tight" positions)
  // Y-Axis Base: Slightly left of the y-axis (-0.04) and near the top (0.05)
  const yBase = Offset(-0.04, 0.05);

  // X-Axis Base: At the far right (1.0) and slightly below the axis (1.04)
  const xBase = Offset(1.0, 1.04);

  if (axis == CustomAxis.y) {
    // Apply base + adjustment
    paintText(
      config,
      canvas,
      label,
      yBase + offsetAdjustment,
      fontSize: fontSize,
      horizontalPivot: LabelPivot.right,
      verticalPivot: LabelPivot.bottom,
      normalize: true,
      style: TextStyle(color: effectiveColor, fontStyle: FontStyle.italic),
    );
  } else {
    // Apply base + adjustment
    paintText(
      config,
      canvas,
      label,
      xBase + offsetAdjustment,
      fontSize: fontSize,
      horizontalPivot: LabelPivot.right,
      verticalPivot: LabelPivot.top,
      normalize: true,
      style: TextStyle(color: effectiveColor, fontStyle: FontStyle.italic),
    );
  }
}
