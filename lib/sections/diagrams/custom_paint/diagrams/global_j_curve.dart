import 'dart:math' as math;
import 'package:economics_app/sections/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_curve.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_text.dart';
import 'package:economics_app/sections/diagrams/utils/mixins.dart';
import 'package:flutter/material.dart';
import '../../enums/curve_align.dart';
import '../../enums/diagram_type.dart';

class GlobalJCurve extends CustomPainter with NameMixin {
  @override
  String get name => type.name;

  final DiagramType type;
  final Color onBackgroundColor;
  final Color highlightedColor;

  GlobalJCurve(
      {super.repaint,
      this.type = DiagramType.global_JCurve_CorrectingTradeDeficit_Default,
      this.onBackgroundColor = Colors.white,
      this.highlightedColor = Colors.green});

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;

    paintCurve(size, canvas, const Offset(kAxisIndent, kAxisIndent),
        const Offset(kAxisIndent, 1 - kAxisIndent),
        drawArrowAtStart: true, drawArrowAtEnd: true);
    paintCurve(size, canvas, const Offset(kAxisIndent, 0.50),
        const Offset(1 - kAxisIndent, 0.50),
        drawArrowAtEnd: true,
        label2: 'Time',
        label2Align: CurveAlign.centerRight);
    paintText(
        size, canvas, '(X=M)', const Offset(kAxisLabelAdjustmentCenter, 0.50),
        angle: math.pi * -0.50);

    final paint = Paint()
      ..color = highlightedColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = kCurveWidth;

    final path = Path()..moveTo(kAxisIndent * width, 0.50 * height);

    if (type == DiagramType.global_JCurve_CorrectingTradeSurplus) {
      // Inverted curve
      path
        ..lineTo(width * 0.20, 0.50 * height)
        ..quadraticBezierTo(
            width * 0.40, 0.10 * height, width * 0.70, 0.80 * height);
    } else {
      // Default curve
      path
        ..lineTo(width * 0.20, 0.50 * height)
        ..quadraticBezierTo(
            width * 0.40, 0.90 * height, width * 0.70, 0.20 * height);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
