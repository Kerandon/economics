


import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_text.dart';
import 'package:flutter/material.dart';

import '../../models/diagram_painter_config.dart';
import '../painter_constants.dart';

void paintTitle(
  DiagramPainterConfig config,
  Canvas canvas,
  String label,
) {
  paintText(config, canvas, label, Offset(0.50, 0.0),
      fontSize: kFontSize * 1.5, style: TextStyle(fontStyle: FontStyle.italic, color: config.colorScheme.secondary));
}
