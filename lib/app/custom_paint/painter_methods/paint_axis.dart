import 'package:economics_app/app/custom_paint/painter_constants.dart';
import 'package:economics_app/app/custom_paint/painter_methods/paint_axis_lines.dart';
import 'package:economics_app/app/custom_paint/painter_methods/paint_text.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

void paintAxis(
  Size size,
  Canvas canvas,
  String? verticalLabel,
  String? horizontalLabel, {
  Color color = Colors.white,
  bool addNumericalAxis = false,
}) {
  final width = size.width;
  final height = size.height;
  paintAxisLines(size, canvas, color: color);

  if(verticalLabel != null) {
    paintText(size, canvas, verticalLabel, Offset(width * 0.05, height * 0.30),
        angle: math.pi / -2, color: color);
  }
  if(horizontalLabel != null) {
    paintText(
        size, canvas, horizontalLabel, Offset(width * 0.80, height * 0.94),
        color: color);
  }
  if (addNumericalAxis == true) {
    _addAxisNumericalLabels(canvas, size,
        axis: Axis.horizontal, incrementValue: 50, totalIncrements: 5);
    _addAxisNumericalLabels(canvas, size, axis: Axis.vertical);
  }
}

void _addAxisNumericalLabels(Canvas canvas, Size size,
    {required Axis axis,
    int initialValue = 0,
    int incrementValue = 1,
    totalIncrements = 10}) {
  final width = size.width;
  final height = size.height;

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
      size,
      canvas,
      initialValue.toString(),
      Offset(xPos + xPosAdjustment, yPos + yPosAdjustment),
    );
    canvas.drawPath(path, paintDash);
    initialValue += incrementValue;
  }
}
