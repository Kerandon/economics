import 'package:economics_app/sections/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_axis.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_curve.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_diagram_dash_lines.dart';
import 'package:flutter/material.dart';
import '../../enums/curve_align.dart';
import '../../models/custom_bezier.dart';
import '../painter_methods/paint_custom_bezier.dart';

class MicroMonopolisticCompetition extends CustomPainter {
  final Color onBackgroundColor;
  final Color highlightedColor;

  MicroMonopolisticCompetition({
    super.repaint,
    this.onBackgroundColor = Colors.white,
    this.highlightedColor = Colors.green,
  });

  @override
  void paint(Canvas canvas, Size size) {
    /// Main Curves
    paintAxis(size, canvas,
        yAxisLabel: kPriceCostsRevenue, xAxisLabel: kQuantity);
    paintCurve(size, canvas, const Offset(0.20, 0.20), const Offset(0.85, 0.70),
        label2: kDAR, label2Align: CurveAlign.centerBottom);
    paintCurve(size, canvas, const Offset(0.18, 0.23), const Offset(0.60, 0.88),
        label2: kMR, label2Align: CurveAlign.centerBottom);
    paintDiagramDashedLines(size, canvas,
        yAxisStartPos: 0.38, xAxisEndPos: 0.285, yLabel: kP, xLabel: kQ1);

    /// Marginal Cost
    paintCustomBezier(size, canvas, onBackgroundColor,
        startPos: const Offset(0.18, 0.70),
        points: [
          CustomBezier(
              control: const Offset(0.35, 0.90),
              endPoint: const Offset(0.70, 0.10))
        ],
        label1: kMC,
        label1Align: CurveAlign.centerTop);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
