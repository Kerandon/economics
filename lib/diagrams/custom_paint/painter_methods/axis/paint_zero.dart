import 'dart:ui';
import 'package:flutter/material.dart';

import '../../../models/diagram_painter_config.dart';
import '../../i_diagram_canvas.dart';
import '../../painter_constants.dart';
import '../paint_text_2.dart';

void paintZero(DiagramPainterConfig config, IDiagramCanvas canvas) {
  final widthAndHeight = config.painterSize.width;
  final indent = widthAndHeight * kAxisIndent;
  final fontSize =
      kFontTiny * config.averageRatio; // Standard origin label size

  // The exact mathematical origin point (intersection of axes)
  final origin = Offset(indent, widthAndHeight - (indent * kBottomAxisIndent));

  // We nudge the '0' slightly so it doesn't overlap the axis lines
  final nudge = widthAndHeight * 0.01;

  paintText2(
    config,
    canvas,
    '0',
    Offset(origin.dx - nudge, origin.dy + nudge),
    fontSize: fontSize,
    horizontalPivot: LabelPivot.right, // Grows to the left of the anchor
    verticalPivot: LabelPivot.top, // Grows downward from the anchor
    normalize: false, // Uses raw pixel coordinates
    style: TextStyle(color: config.colorScheme.onSurface),
  );
}
