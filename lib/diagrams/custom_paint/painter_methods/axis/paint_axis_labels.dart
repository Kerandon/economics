import 'package:flutter/material.dart';

import '../../../models/diagram_painter_config.dart';
import '../../diagrams/demand_diagram.dart';
import '../../i_diagram_canvas.dart';
import '../../painter_constants.dart';
import '../paint_diagram_dash_lines.dart';

void paintAxisLabels(
  DiagramPainterConfig config,
  Canvas? canvas, { // 👈 Changed to nullable
  IDiagramCanvas? iCanvas, // 👈 Added bridge
  required CustomAxis axis,
  required String label,
  double labelPadding = kLabelPadding,
}) {
  final widthAndHeight = config.painterSize.width;
  final fontSize = kFontMedium * config.averageRatio;
  final indent = widthAndHeight * kAxisIndent * 1.05;
  final effectiveColor = config.colorScheme.onSurface;

  // 1. Calculate the position (Math remains identical for both)
  Offset pos = Offset(0, 0);
  var labelPad = widthAndHeight * labelPadding;

  // We still need a TextPainter here to calculate the width/height
  // for positioning, even if we are drawing to PDF.
  final textPainter = TextPainter(
    text: TextSpan(
      text: label,
      style: TextStyle(color: effectiveColor, fontSize: fontSize),
    ),
    textDirection: TextDirection.ltr,
  )..layout();

  final pushXLabelToRight = widthAndHeight * 0.02;
  final pushXLabelDown = widthAndHeight * 0.01;
  final pushYLabelRight = widthAndHeight * 0.01;
  final pushYLabelUp = widthAndHeight * 0.03;

  switch (axis) {
    case CustomAxis.x:
      pos = Offset(
        widthAndHeight - (indent) - textPainter.width + pushXLabelToRight,
        (widthAndHeight - (indent * kBottomAxisIndent) + labelPad) + pushXLabelDown,
      );
      break;
    case CustomAxis.y:
      pos = Offset(indent - textPainter.width - labelPad - pushYLabelRight, indent * kTopAxisIndent - pushYLabelUp);
      break;
  }

  // 2. Painting Logic
  if (iCanvas != null) {
    // PDF Vector Path
    // Note: We use the calculated 'pos' but specify alignment
    // to match the TextPainter's layout behavior.
    iCanvas.drawText(
      label,
      pos,
      fontSize,
      effectiveColor,
      align: TextAlign.left,
    );
  } else if (canvas != null) {
    // Standard Flutter Path
    textPainter.paint(canvas, pos);
  }
}
