import 'package:economics_app/app/custom_paint/painter_methods/paint_axis.dart';
import 'package:flutter/material.dart';

import '../painter_methods/paint_curve.dart';

class AD extends CustomPainter {
  final Color axisColor;
  final Color primaryColor;

  AD({this.axisColor = Colors.white, this.primaryColor = Colors.green});

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;
    paintAxis(size, canvas, 'Price Level', 'Real GDP', color: axisColor);
    paintCurve(size, canvas, Offset(width * 0.25, height * 0.20),
        Offset(width * 0.80, height * 0.70),
        color: primaryColor, label1: 'AD');
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
