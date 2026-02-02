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
}) {
  // Pass the raw constant. paintText2 will scale it by averageRatio.
  const double fontSize = kFontMedium;
  final effectiveColor = config.colorScheme.onSurface;

  if (axis == CustomAxis.y) {
    paintText(
      config,
      canvas,
      label,
      const Offset(-0.04, 0.05), // Slightly more padding
      fontSize: fontSize,
      horizontalPivot: LabelPivot.right,
      verticalPivot: LabelPivot.bottom,
      normalize: true,
      style: TextStyle(color: effectiveColor, fontStyle: FontStyle.italic),
    );
  } else {
    paintText(
      config,
      canvas,
      label,
      const Offset(1.0, 1.04),
      fontSize: fontSize,
      horizontalPivot: LabelPivot.right,
      verticalPivot: LabelPivot.top,
      normalize: true,
      style: TextStyle(color: effectiveColor, fontStyle: FontStyle.italic),
    );
  }
}
