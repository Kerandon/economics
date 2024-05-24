import 'dart:math' as math;

import 'package:economics_app/app/custom_paint/paint_enums/custom_align.dart';
import 'package:economics_app/app/custom_paint/paint_enums/world_trade_types.dart';
import 'package:economics_app/app/custom_paint/painter_constants.dart';
import 'package:economics_app/app/custom_paint/painter_methods/paint_arrow.dart';
import 'package:economics_app/app/custom_paint/painter_methods/paint_axis.dart';
import 'package:economics_app/app/custom_paint/painter_methods/paint_curve.dart';
import 'package:economics_app/app/custom_paint/painter_methods/paint_diagram_dash_lines.dart';
import 'package:economics_app/app/custom_paint/painter_methods/paint_text.dart';
import 'package:flutter/material.dart';

class WorldTradeSubsidies extends CustomPainter {
  final WorldTradeType type;
  final Color color;
  final Color highlightedColor;

  WorldTradeSubsidies(
    this.type, {
    this.color = Colors.white,
    this.highlightedColor = Colors.green,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;

    String pWT = 'Pwt';
    String pW = 'Pw';
    String q1 = 'Q1';
    String q2 = 'Q2';
    String q3 = 'Q3';
    String q4 = 'Q4';

    if (type == WorldTradeType.subsidiesProductionCalculation) {
      pWT = '\$12';
      pW = '\$8';
      q1 = '500';
      q2 = '600';
      q3 = '800';
      q4 = '900';
    }

    paintAxis(size, canvas, 'Price of rice (\$)',
        'Quantity supplied of rice (\'000 kg)');
    paintCurve(
      size,
      canvas,
      Offset(width * 0.18, height * 0.75),
      Offset(width * 0.80, height * 0.18),
      label2: 'S domestic',
      label2Align: CustomAlign.centerTop,
      color: color,
    );
    paintCurve(
      size,
      canvas,
      Offset(width * 0.22, height * 0.18),
      Offset(width * 0.80, height * 0.75),
      label2: '         D domestic',
      label2Align: CustomAlign.centerBottom,
      color: color,
    );
    paintCurve(
      size,
      canvas,
      Offset(width * kAxisIndent, height * 0.70),
      Offset(width - (width * kAxisIndent), height * 0.70),
      label1: 'Pw',
      label1Align: CustomAlign.centerLeft,
      color: Colors.red,
      label2: 'S world',
      label2Align: CustomAlign.centerRight,
    );

    /// Highlighted curve
    paintCurve(
      size,
      canvas,
      Offset(width * 0.35, height * 0.75),
      Offset(width * 0.80, height * 0.33),
      label1: pWT,
      label1Align: CustomAlign.centerLeft,
      label2: 'S subsidy',
      label2Align: CustomAlign.centerRight,
      color: highlightedColor,
      strokeWidth: kHighlightedStrokeWidth,
    );

    /// Paint Arrows

    paintArrow(size, canvas, Offset(width * 0.60, height * 0.34),
        angle: math.pi / 2, oppositeArrowHead: true);
    paintText(size, canvas, 'subsidy', Offset(width * 0.70, height * 0.35));

    /// Vertical lines
    paintDiagramDashedLines(size, canvas,
        yAxisStartPos: 0.535, xAxisEndPos: 0.43, hideXLine: true,
    yLabel: 'Ps'
    );
    paintDiagramDashedLines(size, canvas,
        yAxisStartPos: 0.535, xAxisEndPos: 0.095,
        hideYLine: true,
      xLabel: 'Q1'
    );
    paintDiagramDashedLines(size, canvas,
        yAxisStartPos: 0.535, xAxisEndPos: 0.27,
        hideYLine: true,
        xLabel: 'Q2'
    );
    paintDiagramDashedLines(size, canvas,
        yAxisStartPos: 0.70, xAxisEndPos: 0.61,
        hideYLine: true,
        xLabel: 'Q3'
    );

    /// Label letters
    if (type == WorldTradeType.subsidiesProductionStandard) {
      // paintText(size, canvas, 'a', Offset(width * 0.25, height * 0.40),
      //     fontSize: kLabelLetterFontSize);
      // paintText(size, canvas, 'b', Offset(width * 0.52, height * 0.53),
      //     fontSize: kLabelLetterFontSize);
      // paintText(size, canvas, 'c', Offset(width * 0.25, height * 0.64),
      //     fontSize: kLabelLetterFontSize);
      // paintText(size, canvas, 'd', Offset(width * 0.38, height * 0.66),
      //     fontSize: kLabelLetterFontSize);
      // paintText(size, canvas, 'e', Offset(width * 0.52, height * 0.64),
      //     fontSize: kLabelLetterFontSize);
      // paintText(size, canvas, 'f', Offset(width * 0.65, height * 0.66),
      //     fontSize: kLabelLetterFontSize);
      // paintText(size, canvas, 'g', Offset(width * 0.20, height * 0.74),
      //     fontSize: kLabelLetterFontSize);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
