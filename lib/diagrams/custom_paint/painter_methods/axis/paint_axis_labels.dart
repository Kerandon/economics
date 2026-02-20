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
  Offset offsetAdjustment = Offset.zero,
  bool showBackground = true, // 👈 New property passed from paintAxis
}) {
  const double fontSize = kFontMedium;
  final effectiveColor = config.colorScheme.onSurface;

  // 1. Determine Base Position & Pivots based on Axis
  final bool isYAxis = axis == CustomAxis.y;

  // Y-Axis Base: Slightly left (-0.04) and near the top (0.05)
  // X-Axis Base: At the far right (1.0) and slightly below (1.04)
  final Offset basePos = isYAxis
      ? const Offset(-0.04, 0.05)
      : const Offset(1.0, 1.04);

  final horizontalPivot = isYAxis ? LabelPivot.right : LabelPivot.right;
  final verticalPivot = isYAxis ? LabelPivot.bottom : LabelPivot.top;

  // 2. Execute Painting
  paintText(
    config,
    canvas,
    label,
    basePos + offsetAdjustment,
    fontSize: fontSize,
    horizontalPivot: horizontalPivot,
    verticalPivot: verticalPivot,
    normalize: true,
    showBackground: showBackground, // 👈 Logic applied here
    style: TextStyle(color: effectiveColor, fontStyle: FontStyle.italic),
  );
}
