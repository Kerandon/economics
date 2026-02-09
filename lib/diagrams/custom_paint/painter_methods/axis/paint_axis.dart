import 'dart:math';

import 'package:economics_app/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/paint_axis_labels.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/paint_axis_lines.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/paint_j_curve_axis.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/paint_zero.dart';

import 'package:flutter/material.dart';
import '../../../models/diagram_painter_config.dart';
import '../../i_diagram_canvas.dart';
import '../paint_arrow_head.dart';
import '../paint_text.dart';
import 'axis_enum.dart';

void paintAxis(
  DiagramPainterConfig config,
  IDiagramCanvas canvas, {
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
  AxisStyle axisStyle = AxisStyle.arrows,
}) {
  // 1. J-Curve Special Handling
  // We exit early because J-Curve has unique geometry (centered X-axis)
  // and specific text labels that don't fit the standard painters.
  if (axisStyle == AxisStyle.jCurve) {
    paintJCurveAxes(config, canvas, xAxisLabel, yAxisLabel);
    return;
  }

  // 2. Standard Axis Logic
  final effectiveGridStyle = drawGridlines ? gridLineStyle : GridLineStyle.none;

  paintAxisLines(
    config,
    canvas,
    yMaxValue: yMaxValue,
    yDivisions: yDivisions,
    xMaxValue: xMaxValue,
    xDivisions: xDivisions,
    decimalPlaces: decimalPlaces,
    gridLineStyle: effectiveGridStyle,
    axisStyle: axisStyle,
  );

  paintAxisLabels(config, canvas, axis: CustomAxis.y, label: yAxisLabel);
  paintAxisLabels(config, canvas, axis: CustomAxis.x, label: xAxisLabel);

  if (axisStyle == AxisStyle.arrows) {
    paintZero(config, canvas);
  }
}
