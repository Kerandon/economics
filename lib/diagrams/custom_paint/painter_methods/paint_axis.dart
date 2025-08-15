import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_axis_lines.dart';
import 'package:flutter/material.dart';
import '../../models/diagram_painter_config.dart';
import '../painter_constants.dart';
import 'add_axis_numerical_labels.dart';
import 'paint_text.dart';

void paintAxis(
  DiagramPainterConfig config,
  Canvas canvas, {
  String? yAxisLabel,
  bool yLabelIsVertical = false,
  String? xAxisLabel,
  bool addNumericalAxis = false,
  double labelXIndent = kAxisLabelAdjustmentCenter,
  double labelYIndent = kAxisLabelAdjustmentCenter,
}) {
  paintAxisLines(config, canvas);

  if (yAxisLabel != null) {
    paintText(
      config,
      canvas,
      yAxisLabel,
      const Offset(0, 0),
      axis: Axis.vertical,
      yLabelIsVertical: yLabelIsVertical,
    );
  }
  if (xAxisLabel != null) {
    paintText(
      config,
      canvas,
      xAxisLabel,
      const Offset(0, 0),
      axis: Axis.horizontal,
    );
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
