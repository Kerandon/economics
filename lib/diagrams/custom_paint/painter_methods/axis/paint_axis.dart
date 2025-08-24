import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_axis_lines.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_diagram_dash_lines.dart';
import 'package:flutter/material.dart';
import '../../models/diagram_painter_config.dart';
import '../painter_constants.dart';
import 'add_axis_numerical_labels.dart';
import 'paint_text.dart';

void paintAxis(
  DiagramPainterConfig config,
  Canvas canvas, {
  String? yAxisLabel,
  String? xAxisLabel,
  bool addNumericalAxis = false,
}) {
  paintAxisLines(config, canvas);

  final widthAndHeight = config.painterSize.width;

  if (yAxisLabel != null) {
    _paintAxisLabels(config, canvas, axis: CustomAxis.y, label: 'Y LABEL');
  }
  if (xAxisLabel != null) {
    _paintAxisLabels(config, canvas, axis: CustomAxis.x, label: 'X LABEL');
  }
  if (addNumericalAxis == true) {
    addAxisNumericalLabels(
      config,
      canvas,
      axis: Axis.horizontal,
      incrementValue: 50,
      totalIncrements: 5,
    );
    addAxisNumericalLabels(config, canvas, axis: Axis.vertical);
  }
  paintText(
    config,
    canvas,
    '0',
    Offset(kAxisIndent - 0.03, (1 - kAxisIndent) + 0.03),
  );
}

void _paintAxisLabels(
  DiagramPainterConfig config,
  Canvas canvas, {
  required CustomAxis axis,
  required String label,
}) {
  final widthAndHeight = config.painterSize.width;
  final fontSize = kFontSize * config.averageRatio;
  final indent = widthAndHeight * kAxisIndent;
  final paddingFromAxis = indent / 3;
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


  switch (axis) {
    case CustomAxis.x:
      pos = Offset(
        widthAndHeight - (indent * 0.50) - textPainter.width,
        widthAndHeight - (indent * 1.5) + paddingFromAxis,
      );

    case CustomAxis.y:
      pos = Offset((indent * 1.5) - textPainter.width - paddingFromAxis, indent * 0.50);
  }

  textPainter.paint(canvas, pos);
}
