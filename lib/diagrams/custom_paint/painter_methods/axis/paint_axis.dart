import 'package:economics_app/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/paint_axis_labels.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/paint_axis_lines.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/paint_zero.dart';

import 'package:flutter/material.dart';
import '../../../models/diagram_painter_config.dart';
import '../../i_diagram_canvas.dart';

void paintAxis(
  DiagramPainterConfig config,
  Canvas? canvas, {
  IDiagramCanvas? iCanvas,
  String yAxisLabel = 'Price',
  String xAxisLabel = 'Quantity',
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
  paintAxisLines(
    config,
    canvas,
    iCanvas: iCanvas,
    yMaxValue: yMaxValue,
    yDivisions: yDivisions,
    xMaxValue: xMaxValue,
    xDivisions: xDivisions,
    decimalPlaces: decimalPlaces,
    gridLineStyle: gridLineStyle,
  );

  // 2. Draw the Labels (Price/Quantity) and the Zero origin
  // Uncommenting these ensures they show up on the PDF bridge
  paintAxisLabels(
    config,
    canvas,
    iCanvas: iCanvas,
    axis: CustomAxis.y,
    label: yAxisLabel,
    labelPadding: labelPad,
  );
  paintAxisLabels(
    config,
    canvas,
    iCanvas: iCanvas,
    axis: CustomAxis.x,
    label: xAxisLabel,
  );
  paintZero(config, canvas, iCanvas: iCanvas);
}
