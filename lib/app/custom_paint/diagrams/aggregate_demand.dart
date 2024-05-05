

import 'package:economics_app/app/custom_paint/painter_methods/paint_axis.dart';
import 'package:flutter/material.dart';

import '../painter_methods/paint_curve.dart';
import '../painter_methods/paint_text.dart';

class AggregateDemand extends CustomPainter {
  final Color axisColor;
  final Color primaryColor;

  AggregateDemand({this.axisColor = Colors.white, this.primaryColor = Colors.green});

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;
    paintAxis(size, canvas, 'Price Level', 'Real GDP', color: axisColor);
    paintCurve(size, canvas, Offset(width * 0.20, height * 0.20),
        Offset(width * 0.80, height * 0.80), color: primaryColor);
    paintText(
        size, canvas, 'Aggregate Demand', Offset(width * 0.60, height * 0.82), color: axisColor);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
