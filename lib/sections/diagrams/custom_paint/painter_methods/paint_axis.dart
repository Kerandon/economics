import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_axis_lines.dart';
import 'package:economics_app/sections/diagrams/models/diagram_painter_config.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../enums/axis_label_margin.dart';
import '../../enums/indent.dart';
import '../painter_constants.dart';
import 'add_axis_numerical_labels.dart';
import 'paint_text.dart';

void paintAxis(
  DiagramPainterConfig config,
  Canvas canvas, {
  String? yAxisLabel,
      bool yLabelIsHorizontal = true,
  String? xAxisLabel,
  bool addNumericalAxis = false,
  double labelXIndent = kAxisLabelAdjustmentCenter,
  double labelYIndent = kAxisLabelAdjustmentCenter,
  AxisLabelMargin axisLabelMargin = AxisLabelMargin.middle,
  Indent indent = Indent.end,
}) {
  paintAxisLines(config, canvas);

  print('y axis ${axisLabelMargin}');

  if (yAxisLabel != null) {
    paintText(
      config,
      canvas,
      yAxisLabel,
      const Offset(0, 0),
      angle: yLabelIsHorizontal ? 0 : math.pi * 1.5,
      axis: Axis.vertical,
      axisLabelMargin: axisLabelMargin,
      axisIndent: indent,
    );
  }
  if (xAxisLabel != null) {
    paintText(
      config,
      canvas,
      xAxisLabel,
      const Offset(0, 0),
      axis: Axis.horizontal,
      axisLabelMargin: axisLabelMargin,
      axisIndent: indent,
    );
  }
  if (addNumericalAxis == true) {
    addAxisNumericalLabels(config, canvas,
        axis: Axis.horizontal, incrementValue: 50, totalIncrements: 5);
    addAxisNumericalLabels(config, canvas, axis: Axis.vertical);
  }
  paintText(config, canvas, '0', Offset(kAxisIndent - 0.03,(1-kAxisIndent) + 0.03));
}
