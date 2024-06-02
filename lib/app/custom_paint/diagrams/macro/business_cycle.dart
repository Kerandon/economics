import 'package:economics_app/app/custom_paint/paint_enums/custom_align.dart';
import 'package:economics_app/app/custom_paint/painter_constants.dart';
import 'package:economics_app/app/custom_paint/painter_methods/paint_axis.dart';
import 'package:economics_app/app/custom_paint/painter_methods/paint_dashed_line.dart';
import 'package:flutter/material.dart';
import '../../painter_methods/path_label_line.dart';

class BusinessCycle extends CustomPainter {
  final Color axisColor;
  final Color primaryColor;

  BusinessCycle(
      {this.axisColor = Colors.white, this.primaryColor = Colors.green});

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;

    /// Axis

    paintAxis(size, canvas, xAxisLabel: kXLabelADAS, yAxisLabel: kYLabelADAS);

    /// Trend line
    paintDashedLine(
      strokeWidth: 2,
      canvas: canvas,
      p1: Offset(width * 0.16, height * 0.60),
      p2: Offset(width * 0.98, height * 0.40),
    );

    final paint = Paint()
      ..color = primaryColor
      ..strokeWidth = kCurveWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    /// Curved path
    final path = Path();
    path
      ..moveTo(width * 0.18, height * 0.65)
      ..quadraticBezierTo(
          width * 0.20, height * 0.45, width * 0.30, height * 0.55)
      ..quadraticBezierTo(
          width * 0.40, height * 0.65, width * 0.45, height * 0.50)
      ..quadraticBezierTo(
          width * 0.50, height * 0.30, width * 0.62, height * 0.50)
      ..quadraticBezierTo(
          width * 0.70, height * 0.65, width * 0.72, height * 0.45)
      ..quadraticBezierTo(
          width * 0.75, height * 0.30, width * 0.85, height * 0.45)
      ..quadraticBezierTo(
          width * 0.90, height * 0.50, width * 0.92, height * 0.36);

    canvas.save();
    canvas.drawPath(path, paint);
    canvas.restore();

    /// Labels
    paintLabelLine(canvas, size, 'Peak', Offset(width * 0.24, height * 0.52),
        Offset(width * 0.24, height * 0.40),
        textAlign: CustomAlign.centerTop,
        lineColor: Colors.blue,
        fontColor: Colors.blue);

    paintLabelLine(canvas, size, 'Trough', Offset(width * 0.38, height * 0.59),
        Offset(width * 0.38, height * 0.70),
        textAlign: CustomAlign.centerBottom,
        lineColor: Colors.blue,
        fontColor: Colors.blue);

    paintLabelLine(
        canvas,
        size,
        'Expansion',
        Offset(width * 0.45, height * 0.50),
        Offset(width * 0.45, height * 0.30),
        textAlign: CustomAlign.centerTop,
        lineColor: Colors.blue,
        fontColor: Colors.blue);

    paintLabelLine(
        canvas,
        size,
        'Contraction',
        Offset(width * 0.62, height * 0.50),
        Offset(width * 0.62, height * 0.70),
        textAlign: CustomAlign.centerBottom,
        lineColor: Colors.blue,
        fontColor: Colors.blue);

    paintLabelLine(
        canvas,
        size,
        'Long-term growth\n  (potential GDP)',
        Offset(width * 0.88, height * 0.42),
        Offset(width * 0.80, height * 0.20),
        textAlign: CustomAlign.centerTop,
        lineColor: Colors.blue,
        fontColor: Colors.blue);

    paintLabelLine(
        canvas,
        size,
        'Actual growth\n    (real GDP)',
        Offset(width * 0.88, height * 0.46),
        Offset(width * 0.86, height * 0.60),
        textAlign: CustomAlign.centerBottom,
        lineColor: Colors.blue,
        fontColor: Colors.blue);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
