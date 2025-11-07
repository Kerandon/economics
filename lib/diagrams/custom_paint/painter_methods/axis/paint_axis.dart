import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/paint_axis_labels.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/paint_axis_lines.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/paint_zero.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_diagram_dash_lines.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/grid_lines/grid_line_style.dart';
import 'package:flutter/material.dart';
import '../../../models/diagram_painter_config.dart';

void paintAxis(
  DiagramPainterConfig config,
  Canvas canvas, {
  String? yAxisLabel,
  String? xAxisLabel,
  double? xMaxValue, // Custom max value for the X-axis
  double? yMaxValue, // Custom max value for the Y-axis
  int? xDivisions, // Custom number of divisions for the X-axis
  int? yDivisions, // Custom number of divisions for the Y-axis
  bool drawGridlines =
      false, // Option to draw full grid lines or just tick marks
  int decimalPlaces = 0,
  GridLineStyle gridLineStyle = GridLineStyle.full, //
}) {
  paintAxisLines(
    config,
    canvas,
    yMaxValue: yMaxValue,
    yDivisions: yDivisions,
    xMaxValue: xMaxValue,
    xDivisions: xDivisions,
    decimalPlaces: decimalPlaces,
    gridLineStyle: gridLineStyle,
  );

  if (yAxisLabel != null) {
    paintAxisLabels(
      config,
      canvas,
      axis: CustomAxis.y,
      label: yAxisLabel,
    );
  }
  if (xAxisLabel != null) {
    paintAxisLabels(config, canvas, axis: CustomAxis.x, label: xAxisLabel);
  }
  paintZero(config, canvas);
}
