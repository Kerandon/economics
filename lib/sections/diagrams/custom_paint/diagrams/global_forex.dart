import 'package:economics_app/sections/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_axis.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_curve.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_diagram_dash_lines.dart';
import 'package:economics_app/sections/diagrams/diagram_enums/custom_align.dart';
import 'package:economics_app/sections/diagrams/utils/mixins.dart';
import 'package:flutter/material.dart';

import '../../diagram_enums/diagram_type.dart';

class GlobalForex extends CustomPainter with NameMixin {
  final DiagramType type;
  final Color onBackgroundColor;
  final Color highlightedColor;

  GlobalForex(
      {super.repaint,
      this.type = DiagramType.global_Forex_Default,
      this.onBackgroundColor = Colors.white,
      this.highlightedColor = Colors.green});

  @override
  String get name => type.name;

  @override
  void paint(Canvas canvas, Size size) {
    paintDiagramDashedLines(size, canvas,
        yAxisStartPos: 0.475, xAxisEndPos: 0.34, yLabel: kPe, xLabel: kQe);

    paintAxis(size, canvas, yAxisLabel: kYLabelForex, xAxisLabel: kXLabelForex);
    paintCurve(size, canvas, const Offset(0.20, 0.75), const Offset(0.75, 0.20),
        label2: kForexSupplyDollar, label2Align: CustomAlign.centerTop);
    paintCurve(size, canvas, const Offset(0.75, 0.75), const Offset(0.20, 0.20),
        label1: kForexDemandDollar, label1Align: CustomAlign.centerBottom);
    if (type == DiagramType.global_Forex_DemandDecrease) {
      paintCurve(
          size, canvas, const Offset(0.85, 0.75), const Offset(0.20, 0.20),
          label1: kForexDemandDollar, label1Align: CustomAlign.centerBottom);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
