import 'package:economics_app/app/custom_paint/painter_methods/paint_arrow.dart';
import 'package:economics_app/app/custom_paint/painter_methods/paint_axis.dart';
import 'package:flutter/material.dart';
import '../painter_methods/paint_curve.dart';

class ADIncrease extends CustomPainter {
  final Color axisColor;
  final Color primaryColor;

  ADIncrease({this.axisColor = Colors.white, this.primaryColor = Colors.green});

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;

    /// AD1
    paintAxis(size, canvas, 'Price Level', 'Real GDP', color: axisColor);
    paintCurve(
      size,
      canvas,
      Offset(width * 0.20, height * 0.30),
      Offset(width * 0.50, height * 0.70),
      color: primaryColor,
      label: 'AD1',
    );

    /// AD2
    paintAxis(size, canvas, 'Price Level', 'Real GDP', color: axisColor);
    paintCurve(
      size,
      canvas,
      Offset(width * 0.45, height * 0.30),
      Offset(width * 0.75, height * 0.70),
      color: primaryColor,
      label: 'AD2',
    );
    paintArrow(size, canvas, Offset(width * 0.47, height * 0.50));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
