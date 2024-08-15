import 'package:economics_app/sections/diagrams/utils/mixins.dart';
import 'package:flutter/material.dart';
import '../../enums/curve_align.dart';
import '../../enums/diagram_type.dart';
import '../painter_constants.dart';
import '../painter_methods/paint_axis.dart';
import '../painter_methods/paint_curve.dart';
import '../painter_methods/paint_diagram_dash_lines.dart';
import '../painter_methods/paint_text.dart';

class GlobalProductionSubsidies extends CustomPainter with NameMixin {
  @override
  String get name => type.name;

  final DiagramType type;
  final Color color;
  final Color highlightedColor;

  GlobalProductionSubsidies({
    this.type = DiagramType.global_ProductionSubsidies_Standard_Default,
    this.color = Colors.white,
    this.highlightedColor = Colors.green,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;

    /// Show welfare loss
    // paintShading(canvas, size, ShadeType.welfareLoss, const Offset(0.24, 0.70),
    //     const Offset(0.41, 0.54), const Offset(0.41, 0.70));

    String pWS = 'Pw+s';
    String pW = 'Pw';
    String q1 = 'Q1';
    String q2 = 'Q2';
    String q3 = 'Q3';

    if (type == DiagramType.global_ProductionSubsidies_Calculation) {
      pWS = '\$12';
      pW = '\$8';
      q1 = '500';
      q2 = '600';
      q3 = '800';
    }

    paintAxis(
      size,
      canvas,
      xAxisLabel: kXLabelRice,
      yAxisLabel: kYLabelRice,
    );
    paintCurve(
      size,
      canvas,
      const Offset(0.18, 0.75),
      const Offset(0.80, 0.18),
      label2: kSDomestic,
      label2Align: CurveAlign.centerTop,
      color: color,
    );
    paintCurve(
      size,
      canvas,
      const Offset(0.22, 0.18),
      const Offset(0.80, 0.75),
      label2: '         $kDDomestic',
      label2Align: CurveAlign.centerBottom,
      color: color,
    );
    paintCurve(
      size,
      canvas,
      const Offset(kAxisIndent, 0.70),
      const Offset(1 - kAxisIndent, 0.70),
      label1: pW,
      label1Align: CurveAlign.centerLeft,
      color: Colors.red,
    );

    /// Highlighted curve
    paintCurve(
      size,
      canvas,
      const Offset(0.35, 0.75),
      const Offset(0.86, 0.27),
      label2: 'S subsidy',
      label2Align: CurveAlign.centerRight,
      color: highlightedColor,
      strokeWidth: kCurveWidth,
    );

    /// Paint Arrows

    paintText(size, canvas, 'subsidy', Offset(width * 0.70, height * 0.35));

    /// Vertical lines
    paintDiagramDashedLines(
      size,
      canvas,
      yAxisStartPos: 0.535,
      xAxisEndPos: 0.43,
      hideXLine: true,
      yLabel: pWS,
    );
    paintDiagramDashedLines(
      size,
      canvas,
      yAxisStartPos: 0.70,
      xAxisEndPos: 0.095,
      hideYLine: true,
      xLabel: q1,
    );
    paintDiagramDashedLines(
      size,
      canvas,
      yAxisStartPos: 0.535,
      xAxisEndPos: 0.27,
      hideYLine: true,
      xLabel: q2,
    );
    paintDiagramDashedLines(
      size,
      canvas,
      yAxisStartPos: 0.70,
      xAxisEndPos: 0.61,
      hideYLine: true,
      xLabel: q3,
    );

    /// Label letters
    if (type == DiagramType.global_ProductionSubsidies_Standard_Default) {
      paintText(size, canvas, 'a', Offset(width * 0.20, height * 0.62),
          fontSize: kLabelLetterFontSize);
      paintText(size, canvas, 'b', Offset(width * 0.35, height * 0.65),
          fontSize: kLabelLetterFontSize);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
