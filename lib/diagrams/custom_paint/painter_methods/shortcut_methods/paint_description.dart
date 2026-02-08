import 'package:economics_app/diagrams/custom_paint/painter_constants.dart';
import 'package:flutter/material.dart';

import '../../../models/diagram_painter_config.dart';
import '../../i_diagram_canvas.dart';
import '../paint_text.dart';

void paintDescription(
  DiagramPainterConfig config,
  IDiagramCanvas canvas,
  String text, {
  // CHANGED: 0.98 puts it just above the bottom edge of the canvas.
  double yPos = 0.95,
  double fontSize = kFontSizeAverageRatioSmall,
  double horizontalPadding = 20.0,
}) {
  // 1. Calculate Safe Width
  final double maxWidth = (config.painterSize.width - (horizontalPadding * 2))
      .clamp(0.0, double.infinity);

  // 2. Call existing paintText
  paintText(
    config,
    canvas,
    text,
    shape: DiagramShape.square,
    Offset(0.50, yPos),

    // Formatting
    style: TextStyle(
      fontSize: fontSize,
      height: 1.3,
      color: config.colorScheme.onSurface,
    ),
    textAlign: TextAlign.center,

    // Layout Logic
    ignoreIndent: true, // Use 0.0 - 1.0 absolute coordinates
    maxWidth: maxWidth,
    normalize: true,

    // CHANGED: Grow text UPWARDS from the bottom point
    verticalPivot: LabelPivot.bottom,
  );
}
