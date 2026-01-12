import 'package:flutter/material.dart';

import '../../../models/diagram_painter_config.dart';
import '../../painter_constants.dart';
import '../paint_diagram_dash_lines.dart';

void paintAxisLabels(
  DiagramPainterConfig config,
  Canvas canvas, {
  required CustomAxis axis,
  required String label,
  double labelPadding = kLabelPadding,
}) {
  final widthAndHeight = config.painterSize.width;
  final fontSize = kFontMedium * config.averageRatio;
  final indent = widthAndHeight * kAxisIndent * 1.05;

  Offset pos = Offset(0, 0);

  /// Text Painter Methods
  final style = TextStyle(
    color: config.colorScheme.onSurface,
    fontSize: fontSize,
  );
  final textSpan = TextSpan(text: label, style: style);
  final textPainter = TextPainter(
    text: textSpan,
    textDirection: TextDirection.ltr,
  );
  textPainter.layout(minWidth: 0, maxWidth: widthAndHeight);
  var labelPad = widthAndHeight * labelPadding;
  switch (axis) {
    case CustomAxis.x:
      pos = Offset(
        widthAndHeight - (indent * 0.50) - textPainter.width,
        widthAndHeight - (1.5 * indent) + labelPad,
      );

    case CustomAxis.y:
      pos = Offset(
        indent * 1.5 -
            textPainter.width -
            labelPad,
        indent * 0.50,
      );
  }

  textPainter.paint(canvas, pos);
}
