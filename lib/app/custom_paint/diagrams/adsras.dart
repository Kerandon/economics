import 'package:economics_app/app/custom_paint/painter_constants.dart';
import 'package:economics_app/app/custom_paint/painter_methods/paint_diagram_dash_lines.dart';
import 'package:flutter/material.dart';
import '../painter_methods/paint_axis.dart';
import '../painter_methods/paint_curve.dart';

class ClassicalADAS extends CustomPainter {
  final Color axisColor;
  final Color primaryColor;

  ClassicalADAS(
      {this.axisColor = Colors.white, this.primaryColor = Colors.green});

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;

    paintDiagramDashedLines(size, canvas,
        yAxisStartPos: 0.45, xAxisEndPos: 0.385, xLabel: 'Ye', yLabel: 'Pe');

    paintAxis(size, canvas, 'Price Level', 'Real GDP', color: axisColor);

    /// AD
    paintCurve(
        size,
        canvas,
        Offset(width * kCurveRight, height * kCurveHeightTop),
        Offset(width * kCurveLeft, height * kCurveHeightBottom),
        color: primaryColor,
        label: 'AD');

    /// SRAS
    paintCurve(
        size,
        canvas,
        Offset(width * kCurveRight, height * kCurveHeightBottom),
        Offset(width * kCurveLeft, height * kCurveHeightTop),
        color: primaryColor,
        label: 'SRAS',
        adjustLabelY: -kCurveLabelAdjustment);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
