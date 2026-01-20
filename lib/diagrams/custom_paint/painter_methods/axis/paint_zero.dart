import 'dart:ui';
import 'package:flutter/material.dart';

import '../../../models/diagram_painter_config.dart';
import '../../i_diagram_canvas.dart';
import '../../painter_constants.dart';
import '../paint_text_2.dart';

void paintZero(
  DiagramPainterConfig config,
  Canvas? canvas, {
  IDiagramCanvas? iCanvas,
}) {
  final widthAndHeight = config.painterSize.width;
  final indent = widthAndHeight * kAxisIndent;
  final fontSize = kFontMedium * config.averageRatio;

  // Adjusted offset for the '0' at the origin
  final pos = Offset(indent * 0.90, widthAndHeight - indent * kBottomAxisIndent);

  if (iCanvas != null) {
    iCanvas.drawText('0', pos, fontSize, config.colorScheme.onSurface);
  } else if (canvas != null) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: '0',
        style: TextStyle(
          color: config.colorScheme.onSurface,
          fontSize: fontSize,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter.paint(canvas, pos);
  }
}
