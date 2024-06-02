import 'package:economics_app/app/custom_paint/paint_enums/shade_type.dart';
import 'package:economics_app/app/custom_paint/painter_methods/paint_diagram_dash_lines.dart';
import 'package:economics_app/app/custom_paint/painter_methods/paint_shading.dart';
import 'package:flutter/material.dart';
import '../../../models/position.dart';
import '../../paint_enums/custom_align.dart';
import '../../paint_enums/world_trade_types.dart';
import '../../painter_constants.dart';
import '../../painter_methods/paint_arrow.dart';
import '../../painter_methods/paint_axis.dart';
import '../../painter_methods/paint_curve.dart';
import '../../painter_methods/paint_text.dart';

class WorldTradeQuotas extends CustomPainter {
  final WorldTradeType type;
  final Color color;
  final Color highlightedColor;

  WorldTradeQuotas(
    this.type, {
    this.color = Colors.white,
    this.highlightedColor = Colors.green,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;

    /// Welfare Loss
    paintShading(canvas, size, ShadeType.welfareLoss, Pos(0.23, 0.70),
        Pos(0.40, 0.51), Pos(0.40, 0.70));
    paintShading(canvas, size, ShadeType.welfareLoss, Pos(0.565, 0.70),
        Pos(0.565, 0.52), Pos(0.72, 0.70));

    String pWQ = 'Pq';
    String pW = 'Pw';
    String q1 = 'Q1';
    String q2 = 'Q2';
    String q3 = 'Q3';
    String q4 = 'Q4';

    if (type == WorldTradeType.quotaCalculation) {
      pWQ = '\$110';
      pW = '\$60';
      q1 = '150';
      q2 = '450';
      q3 = '750';
      q4 = '1000';
    }

    paintAxis(size, canvas, yAxisLabel: kYLabelWine, xAxisLabel: kXLabelWine);
    paintCurve(
      size,
      canvas,
      Offset(width * 0.18, height * 0.75),
      Offset(width * 0.75, height * 0.15),
      label2: kSDomestic,
      label2Align: CustomAlign.centerTop,
      color: color,
    );
    paintCurve(
      size,
      canvas,
      Offset(width * 0.2, height * 0.10),
      Offset(width * 0.80, height * 0.80),
      label2: kDDomestic,
      label2Align: CustomAlign.centerBottom,
      color: color,
    );

    /// Arrows
    paintText(
      size,
      canvas,
      'quota',
      Offset(width * 0.66, height * 0.32),
    );
    paintArrow(size, canvas, Offset(width * 0.59, height * 0.30),
        oppositeArrowHead: true);
    paintText(
      size,
      canvas,
      'quota',
      Offset(width * 0.48, height * 0.93),
    );
    paintArrow(size, canvas, Offset(width * 0.43, height * 0.85),
        oppositeArrowHead: true);

    /// World Supply Curve
    paintCurve(
      size,
      canvas,
      Offset(width * kAxisIndent, height * 0.70),
      Offset(
        width - (width * kAxisIndent),
        height * 0.70,
      ),
      label1: pW,
      label1Align: CustomAlign.centerLeft,
      label2: kSupplyWorld,
      label2Align: CustomAlign.centerRight,
      color: color,
    );

    /// Quota curve

    paintCurve(size, canvas, Offset(width * 0.40, height * 0.70),
        Offset(width * 0.86, height * 0.20),
        label1Align: CustomAlign.centerLeft,
        label2: 'S domestic + quota',
        label2Align: CustomAlign.centerTop,
        color: highlightedColor,
        strokeWidth: kHighlightedStrokeWidth);
    paintCurve(size, canvas, Offset(width * kAxisIndent, height * 0.70),
        Offset(width * 0.405, height * 0.70),
        color: highlightedColor, strokeWidth: kHighlightedStrokeWidth);

    /// dash-lines
    const q3Height = 0.52;
    paintDiagramDashedLines(size, canvas,
        yAxisStartPos: q3Height, xAxisEndPos: 0.425, xLabel: q3, yLabel: pWQ);
    paintDiagramDashedLines(
      size,
      canvas,
      yAxisStartPos: 0.52,
      xAxisEndPos: 0.09,
      hideYLine: true,
      xLabel: q1,
    );
    paintDiagramDashedLines(size, canvas,
        yAxisStartPos: 0.52, xAxisEndPos: 0.26, hideYLine: true, xLabel: q2);
    paintDiagramDashedLines(size, canvas,
        yAxisStartPos: 0.70, xAxisEndPos: 0.57, hideYLine: true, xLabel: q4);

    /// Label letters
    if (type == WorldTradeType.quotaLabels) {
      paintText(size, canvas, 'a', Offset(width * 0.18, height * 0.60),
          fontSize: kLabelLetterFontSize);
      paintText(size, canvas, 'b', Offset(width * 0.28, height * 0.58),
          fontSize: kLabelLetterFontSize);
      paintText(size, canvas, 'c', Offset(width * 0.35, height * 0.65),
          fontSize: kLabelLetterFontSize);
      paintText(size, canvas, 'd', Offset(width * 0.46, height * 0.58),
          fontSize: kLabelLetterFontSize);
      paintText(size, canvas, 'e', Offset(width * 0.52, height * 0.65),
          fontSize: kLabelLetterFontSize);
      paintText(size, canvas, 'f', Offset(width * 0.62, height * 0.65),
          fontSize: kLabelLetterFontSize);
      paintText(size, canvas, 'g', Offset(width * 0.18, height * 0.78),
          fontSize: kLabelLetterFontSize);
      paintText(size, canvas, 'h', Offset(width * 0.31, height * 0.78),
          fontSize: kLabelLetterFontSize);
      paintText(size, canvas, 'i', Offset(width * 0.48, height * 0.78),
          fontSize: kLabelLetterFontSize);
      paintText(size, canvas, 'j', Offset(width * 0.63, height * 0.78),
          fontSize: kLabelLetterFontSize);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
