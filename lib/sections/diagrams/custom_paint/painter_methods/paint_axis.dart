import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_axis_lines.dart';
import 'package:economics_app/sections/diagrams/models/size_adjuster.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../enums/axis_label_margin.dart';
import '../../enums/indent.dart';
import '../painter_constants.dart';
import 'add_axis_numerical_labels.dart';
import 'paint_text.dart';

void paintAxis(
  Size size,
  Canvas canvas, {
  SizeAdjustor sizeAdjustor = const SizeAdjustor(),
  String? yAxisLabel,
  String? xAxisLabel,
  Color color = Colors.white,
  bool addNumericalAxis = false,
  double labelXIndent = kAxisLabelAdjustmentCenter,
  double labelYIndent = kAxisLabelAdjustmentCenter,
  AxisLabelMargin axisMargin = AxisLabelMargin.close,
  Indent indent = Indent.end,
}) {
  paintAxisLines(size, canvas, sizeAdjustor: sizeAdjustor, color: color);

  if (yAxisLabel != null) {
    paintText(
      size,
      sizeAdjustor: sizeAdjustor,
      canvas,
      yAxisLabel,
      const Offset(0, 0),
      angle: math.pi / -2,
      color: color,
      axis: Axis.vertical,
      axisLabelMargin: axisMargin,
      axisIndent: indent,
    );
  }
  if (xAxisLabel != null) {
    paintText(
      size,
      sizeAdjustor: sizeAdjustor,
      canvas,
      xAxisLabel,
      const Offset(0, 0),
      color: color,
      axis: Axis.horizontal,
      axisLabelMargin: axisMargin,
      axisIndent: indent,
    );
  }
  if (addNumericalAxis == true) {
    addAxisNumericalLabels(canvas, size,
        axis: Axis.horizontal, incrementValue: 50, totalIncrements: 5);
    addAxisNumericalLabels(canvas, size, axis: Axis.vertical);
  }
}
