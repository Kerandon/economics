
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_text.dart';
import 'package:flutter/material.dart';

import '../../models/diagram_painter_config.dart';
import '../painter_constants.dart';

void addAxisNumericalLabels(DiagramPainterConfig config, Canvas canvas,
    {required Axis axis,
    int initialValue = 0,
    int incrementValue = 1,
    totalIncrements = 10}) {
  final width = config.appSize.width;
  final height = config.appSize.height;

  const labelAdjustment = 18.0;
  double length = 0;
  switch (axis) {
    case Axis.horizontal:
      length = width;
    case Axis.vertical:
      length = height;
  }

  final axisPointsDistance = (length - (kAxisIndent * 2 * length));
  final yDeciles = axisPointsDistance / totalIncrements;

  for (int i = 0; i < totalIncrements + 1; i++) {
    double xPos = 0;
    double yPos = 0;
    double xPosAdjustment = 0;
    double yPosAdjustment = 0;
    if (axis == Axis.vertical) {
      xPos = (width * kAxisIndent);
      yPos = height - (height * kAxisIndent) - (yDeciles * i);
      xPosAdjustment = -labelAdjustment;
      yPosAdjustment = 0;
    }
    if (axis == Axis.horizontal) {
      xPos = (width * kAxisIndent) + (yDeciles * i);
      yPos = height - (height * kAxisIndent);
      xPosAdjustment = 0;
      yPosAdjustment = labelAdjustment;
    }

    final paintDash = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final path = Path()
      ..moveTo(xPos, yPos)
      ..lineTo(xPos + xPosAdjustment / 3, yPos + yPosAdjustment / 3);

    paintText(
      config,
      canvas,
      initialValue.toString(),
      Offset(xPos + xPosAdjustment, yPos + yPosAdjustment),
    );
    canvas.drawPath(path, paintDash);
    initialValue += incrementValue;
  }
}
