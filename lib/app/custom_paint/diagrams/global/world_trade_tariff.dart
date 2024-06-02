import 'dart:math' as math;

import 'package:economics_app/app/custom_paint/paint_enums/custom_align.dart';
import 'package:economics_app/app/custom_paint/paint_enums/world_trade_types.dart';
import 'package:economics_app/app/custom_paint/painter_constants.dart';
import 'package:economics_app/app/custom_paint/painter_methods/paint_arrow.dart';
import 'package:economics_app/app/custom_paint/painter_methods/paint_axis.dart';
import 'package:economics_app/app/custom_paint/painter_methods/paint_curve.dart';
import 'package:economics_app/app/custom_paint/painter_methods/paint_text.dart';
import 'package:flutter/material.dart';

import '../../painter_methods/paint_diagram_dash_lines.dart';

class WorldTradeTariff extends CustomPainter {
  final WorldTradeType type;
  final Color color;
  final Color highlightedColor;

  WorldTradeTariff(
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

    if (type == WorldTradeType.tariffCalculation) {
      pWT = '\$12';
      pW = '\$8';
      q1 = '500';
      q2 = '600';
      q3 = '1200';
      q4 = '1300';
    }

    paintAxis(size, canvas, xAxisLabel: kXLabelWine, yAxisLabel: kYLabelWine);
    paintCurve(
      size,
      canvas,
      Offset(width * 0.20, height * 0.80),
      Offset(width * 0.85, height * 0.10),
      label2: kSDomestic,
      label2Align: CustomAlign.centerTop,
      color: color,
    );
    paintCurve(
      size,
      canvas,
      Offset(width * 0.22, height * 0.10),
      Offset(width * 0.80, height * 0.80),
      label2: kDDomestic,
      label2Align: CustomAlign.centerBottom,
      color: color,
    );
    if (type == WorldTradeType.tariffStandard) {
      paintCurve(size, canvas, Offset(width * kAxisIndent, height * 0.46),
          Offset(width * 0.52, height * 0.46),
          label1: 'Pd', label1Align: CustomAlign.centerLeft, makeDashed: true);

      paintArrow(size, canvas, Offset(width * 0.18, height * 0.60),
          angle: math.pi / -2);
      paintArrow(size, canvas, Offset(width * 0.72, height * 0.60),
          angle: math.pi / -2);
    }
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

    paintCurve(
      size,
      canvas,
      Offset(width * kAxisIndent, height * 0.58),
      Offset(
        width - (width * kAxisIndent),
        height * 0.58,
      ),
      label1: pWT,
      label1Align: CustomAlign.centerLeft,
      label2: 'S + tariff',
      label2Align: CustomAlign.centerRight,
      color: highlightedColor,
      strokeWidth: kHighlightedStrokeWidth,
    );

    /// Vertical lines
    paintDiagramDashedLines(size, canvas,
        yAxisStartPos: 0.70, xAxisEndPos: 0.155, hideYLine: true, xLabel: q1);
    paintDiagramDashedLines(size, canvas,
        yAxisStartPos: 0.59, xAxisEndPos: 0.26, hideYLine: true, xLabel: q2);
    paintDiagramDashedLines(size, canvas,
        yAxisStartPos: 0.59, xAxisEndPos: 0.48, hideYLine: true, xLabel: q3);
    paintDiagramDashedLines(size, canvas,
        yAxisStartPos: 0.70, xAxisEndPos: 0.58, hideYLine: true, xLabel: q4);

    /// Label letters
    if (type == WorldTradeType.tariffLabels) {
      paintText(size, canvas, 'a', Offset(width * 0.25, height * 0.40),
          fontSize: kLabelLetterFontSize);
      paintText(size, canvas, 'b', Offset(width * 0.52, height * 0.53),
          fontSize: kLabelLetterFontSize);
      paintText(size, canvas, 'c', Offset(width * 0.25, height * 0.64),
          fontSize: kLabelLetterFontSize);
      paintText(size, canvas, 'd', Offset(width * 0.37, height * 0.66),
          fontSize: kLabelLetterFontSize);
      paintText(size, canvas, 'e', Offset(width * 0.52, height * 0.64),
          fontSize: kLabelLetterFontSize);
      paintText(size, canvas, 'f', Offset(width * 0.64, height * 0.66),
          fontSize: kLabelLetterFontSize);
      paintText(size, canvas, 'g', Offset(width * 0.20, height * 0.74),
          fontSize: kLabelLetterFontSize);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
