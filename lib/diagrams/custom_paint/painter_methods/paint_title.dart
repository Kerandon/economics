import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_text.dart';
import 'package:flutter/material.dart';

import '../../models/diagram_painter_config.dart';
import '../i_diagram_canvas.dart';
import '../painter_constants.dart';

void paintTitle(
  DiagramPainterConfig config,
  IDiagramCanvas canvas, // Made nullable
  String label,
) {
  paintText(
    config,
    canvas,
    label,
    const Offset(0.5, -0.10), // Typically centered top
    fontSize: kFontMedium,
    style: TextStyle(
      fontStyle: FontStyle.italic,
      color: config.colorScheme.secondary,
    ),
  );
}
