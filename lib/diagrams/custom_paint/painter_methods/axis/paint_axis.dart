import 'package:economics_app/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/paint_axis_labels.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/paint_axis_lines.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/paint_zero.dart';

import 'package:flutter/material.dart';
import '../../../models/diagram_painter_config.dart';
import '../../i_diagram_canvas.dart';

void paintAxis(
  DiagramPainterConfig config,
  IDiagramCanvas canvas, { // Unified interface
  String yAxisLabel = 'P',
  String xAxisLabel = 'Q',
  double? xMaxValue,
  double? yMaxValue,
  int? xDivisions,
  int? yDivisions,
  bool drawGridlines = false,
  int decimalPlaces = 0,
  GridLineStyle gridLineStyle = GridLineStyle.full,
  double labelPad = kLabelPadding,
}) {
  // 1. Draw the Lines and Grid
  // Ensure paintAxisLines is updated to: void paintAxisLines(config, IDiagramCanvas canvas, ...)
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

  // 2. Draw the Labels (Price/Quantity)
  paintAxisLabels(config, canvas, axis: CustomAxis.y, label: yAxisLabel);

  paintAxisLabels(config, canvas, axis: CustomAxis.x, label: xAxisLabel);

  // 3. Draw the Zero origin
  paintZero(config, canvas);
}
