import 'package:economics_app/sections/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_arrow.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_axis.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_curve.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_diagram_dash_lines.dart';
import 'package:economics_app/sections/diagrams/utils/mixins.dart';
import 'package:flutter/material.dart';
import '../../enums/curve_align.dart';
import '../../enums/diagram_type.dart';

class GlobalForex extends CustomPainter with NameMixin {
  final DiagramType type;
  final Color onBackgroundColor;
  final Color highlightedColor;

  GlobalForex(
      {super.repaint,
      this.type = DiagramType.global_Forex_Equilibrium_Default,
      this.onBackgroundColor = Colors.white,
      this.highlightedColor = Colors.green});

  @override
  String get name => type.name;

  @override
  void paint(Canvas canvas, Size size) {
    paintDiagramDashedLines(size, canvas,
        yAxisStartPos: 0.455, xAxisEndPos: 0.36, yLabel: kP1, xLabel: kQ1);


    paintAxis(size, canvas, yAxisLabel: kYLabelForex, xAxisLabel: kXLabelForex);
    paintCurve(

        size, canvas, const Offset(0.20, 0.75), const Offset(0.75, 0.20),
        label2: kS, label2Align: CurveAlign.centerRight);
    paintCurve(size, canvas, const Offset(0.80, 0.75), const Offset(0.30, 0.25),
        label1: kD1, label1Align: CurveAlign.centerBottom);
    if (type == DiagramType.global_Forex_DemandIncrease) {
      paintCurve(
        color: highlightedColor,
          size, canvas, const Offset(0.90, 0.70), const Offset(0.40, 0.20),
          label1: kD2, label1Align: CurveAlign.centerBottom);
      paintDiagramDashedLines(size, canvas,
          yAxisStartPos: 0.38, xAxisEndPos: 0.435, yLabel: kP2, xLabel: kQ2);
      paintArrow(size, canvas, const Offset(0.71,0.60));
    }
    if (type == DiagramType.global_Forex_DemandDecrease) {
      paintDiagramDashedLines(size, canvas,
          yAxisStartPos: 0.525, xAxisEndPos: 0.285, yLabel: kP2, xLabel: kQ2);

      paintCurve(
          color: highlightedColor,
          size, canvas, const Offset(0.65, 0.75), const Offset(0.20, 0.30),
          label1: kD2, label1Align: CurveAlign.centerBottom);
      paintArrow(size, canvas, const Offset(0.66,0.60));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
