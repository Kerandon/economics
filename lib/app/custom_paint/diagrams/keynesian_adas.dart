import 'package:economics_app/app/custom_paint/painter_methods/paint_axis.dart';
import 'package:economics_app/app/custom_paint/painter_methods/paint_curve.dart';
import 'package:economics_app/app/custom_paint/painter_methods/paint_diagram_dash_lines.dart';
import 'package:flutter/material.dart';

import '../painter_methods/paint_keyensian_curve.dart';

class KeynesianADAS extends CustomPainter {
  final Color axisColor;
  final Color primaryColor;

  KeynesianADAS(
      {this.axisColor = Colors.white, this.primaryColor = Colors.green});

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;

    paintDiagramDashedLines(size, canvas,
        yAxisStartPos: 0.65, xAxisEndPos: 0.55, xLabel: 'Ye', yLabel: 'PL');
    paintAxis(size, canvas, 'Price Level', 'Real GDP', color: axisColor);

    paintKeynesianCurve(size, canvas,
        totalWidth: 0.80, label: 'AS', color: primaryColor);

    paintCurve(size, canvas, Offset(width * 0.30, height * 0.30),
        Offset(width * 0.80, height * 0.750),
        color: primaryColor, label: 'AD');
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}