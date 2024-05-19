import 'dart:math' as math;

import 'package:economics_app/app/custom_paint/paint_enums/ppc_types.dart';
import 'package:economics_app/app/custom_paint/painter_constants.dart';
import 'package:economics_app/app/custom_paint/painter_methods/paint_arrow.dart';
import 'package:economics_app/app/custom_paint/painter_methods/paint_axis.dart';
import 'package:economics_app/app/custom_paint/painter_methods/paint_diagram_dash_lines.dart';
import 'package:economics_app/app/custom_paint/painter_methods/paint_text.dart';
import 'package:flutter/material.dart';

import '../painter_methods/paint_dot.dart';

class PPC extends CustomPainter {
  final Color color;
  final PPCType type;

  PPC({this.type = PPCType.standard, this.color = Colors.white});

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;
    // final paint2 = Paint()
    //   ..color = Colors.green
    //   ..style = PaintingStyle.fill;
    // canvas.drawCircle(Offset(100,100), 100, paint2);
    final path = Path();

    /// PPC Paint Curve
    final paint = Paint()
      ..color = color
      ..strokeWidth = kCurveWidth
      ..style = PaintingStyle.stroke;

    if (type == PPCType.standard) {
      paintDiagramDashedLines(size, canvas,
          yAxisStartPos: 0.40, xAxisEndPos: 0.38);
      paintDiagramDashedLines(size, canvas,
          yAxisStartPos: 0.70, xAxisEndPos: 0.62);

      paintAxis(size, canvas, 'Consumer goods', 'Capital goods',
          addNumericalAxis: true);

      path
        ..moveTo(width * kAxisIndent, height * 0.30)
        ..quadraticBezierTo(width * 0.70, height * 0.30, width * 0.80,
            height * (1 - kAxisIndent));
    }
    if (type == PPCType.growth) {
      path
        ..moveTo(width * kAxisIndent, height * 0.30)
        ..quadraticBezierTo(width * 0.70, height * 0.30, width * 0.80,
            height * (1 - kAxisIndent));
      paintAxis(size, canvas, 'Consumer goods', 'Capital goods');
      paintArrow(size, canvas, Offset(width * 0.40, height * 0.60),
          angle: math.pi / -6, arrowStickExtension: 1);
      paintText(size, canvas, 'A', Offset(width * 0.30, height * 0.72));
      paintText(size, canvas, 'B', Offset(width * 0.50, height * 0.60));
      paintDot(canvas, size, pos: Offset(width / 2, height / 2));
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
