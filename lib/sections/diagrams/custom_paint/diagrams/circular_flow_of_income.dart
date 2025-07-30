import 'dart:math';

import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_custom_bezier.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_diagram_custom_lines.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_text.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_text_box.dart';
import 'package:economics_app/sections/diagrams/enums/diagram_subtype.dart';
import 'package:economics_app/sections/diagrams/models/custom_bezier.dart';
import 'package:flutter/material.dart';
import '../../models/base_painter_painter.dart';
import '../../models/diagram_model.dart';
import '../../models/diagram_painter_config.dart';
import '../painter_constants.dart';

class CircularFlowOfIncome extends BaseDiagramPainter {
  CircularFlowOfIncome({
    required DiagramPainterConfig config,
    required DiagramModel model,
  }) : super(config, model);

  @override
  void paint(Canvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);

    // Define color variables
    const color1 = Colors.red;
    const color2 = Colors.indigo;

    if (model.subtype == DiagramSubtype.closedModel) {
      /// Arrows - Purple
      paintCustomDiagramLines(c, canvas,
          startPos: Offset(0.50, 0.13),
          polylineOffsets: [Offset(0.10, 0.13), Offset(0.10, 0.40)],
          color: color2,
          normalizeToDiagramArea: false,
          arrowOnEnd: true,
          arrowOnEndAngle: pi);
      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(0.10, 0.50),
        polylineOffsets: [Offset(0.10, 0.88), Offset(0.50, 0.88)],
        normalizeToDiagramArea: false,
        color: color2,
      );

      paintCustomDiagramLines(c, canvas,
          startPos: Offset(0.50, 0.88),
          polylineOffsets: [Offset(0.90, 0.88), Offset(0.90, 0.60)],
          color: color2,
          normalizeToDiagramArea: false,
          arrowOnEnd: true,
          arrowOnEndAngle: pi / 0.50);

      paintCustomDiagramLines(c, canvas,
          startPos: Offset(0.90, 0.50),
          polylineOffsets: [Offset(0.90, 0.13), Offset(0.50, 0.13)],
          color: color2,
          normalizeToDiagramArea: false,
          arrowOnEnd: true,
          arrowOnEndAngle: pi / -2);

      /// Arrows - Orange
      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(0.05, 0.60),
        polylineOffsets: [Offset(0.05, 0.93), Offset(0.50, 0.93)],
        normalizeToDiagramArea: false,
        arrowOnStart: true,
        color: color1,
      );

      paintCustomDiagramLines(c, canvas,
          startPos: Offset(0.95, 0.40),
          polylineOffsets: [Offset(0.95, 0.08), Offset(0.50, 0.08)],
          color: color1,
          normalizeToDiagramArea: false,
          arrowOnStart: true,
          arrowOnStartAngle: pi);

      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(0.50, 0.93),
        polylineOffsets: [Offset(0.95, 0.93), Offset(0.95, 0.50)],
        color: color1,
        normalizeToDiagramArea: false,
      );
      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(0.50, 0.08),
        polylineOffsets: [Offset(0.05, 0.08), Offset(0.05, 0.50)],
        color: color1,
        normalizeToDiagramArea: false,
      );

      /// Boxes

      /// Households
      paintTextBox(
        canvas: canvas,
        config: c,
        lineColor: color1,
        text: DiagramLabel.households.label,
        position: Offset(0.10, 0.50),
        showBoxBorder: true,
        boxBorderWidth: kCurveWidth,
      );

      /// Firms
      paintTextBox(
        canvas: canvas,
        config: c,
        lineColor: color1,
        text: DiagramLabel.firms.label,
        position: Offset(0.90, 0.50),
        showBoxBorder: true,
        boxBorderWidth: kCurveWidth,
      );

      /// Factor Markets
      paintTextBox(
        canvas: canvas,
        config: c,
        lineColor: c.colorScheme.primary,
        text: DiagramLabel.factorMarkets.label,
        position: Offset(0.50, 0.10),
        showBoxBorder: true,
        dottedBorder: true,
      );

      /// Product Markets
      paintTextBox(
        canvas: canvas,
        config: c,
        lineColor: c.colorScheme.primary,
        text: DiagramLabel.productMarkets.label,
        position: Offset(0.50, 0.90),
        showBoxBorder: true,
        dottedBorder: true,
      );

      /// Labels
      paintText(
        c,
        canvas,
        DiagramLabel.landLaborCapitalEnterprise.label,
        Offset(0.50, 0),
        style: TextStyle(color: color1, fontWeight: FontWeight.bold),
      );
      paintText(
        c,
        canvas,
        DiagramLabel.rentWagesInterestProfit.label,
        Offset(0.50, 0.20),
        style: TextStyle(color: color2, fontWeight: FontWeight.bold),
      );
      paintText(
        c,
        canvas,
        DiagramLabel.goodsAndServices.label,
        Offset(0.50, 0.98),
        style: TextStyle(color: color1, fontWeight: FontWeight.bold),
      );
      paintText(
        c,
        canvas,
        DiagramLabel.householdSpendingFirmRevenue.label,
        Offset(0.50, 0.80),
        style: TextStyle(color: color2, fontWeight: FontWeight.bold),
      );
    }
    if (model.subtype == DiagramSubtype.openModel) {
      /// Factors of Production
      paintCustomDiagramLines(c, canvas,
          startPos: Offset(0.10, 0.08),
          polylineOffsets: [
            Offset(0.76, 0.08),
          ],
          arrowOnEnd: true,
          arrowOnEndAngle: pi / 2,
          normalizeToDiagramArea: false);

      /// Factor Payments
      paintCustomDiagramLines(c, canvas,
          startPos: Offset(0.90, 0.12),
          polylineOffsets: [
            Offset(0.28, 0.12),
          ],
          arrowOnEnd: true,
          arrowOnEndAngle: pi / -2,
          normalizeToDiagramArea: false);

      /// Goods & Services
      paintCustomDiagramLines(c, canvas,
          startPos: Offset(0.10, 0.02),
          polylineOffsets: [
            Offset(0.10, 0.00),
            Offset(0.90, 0.00),
            Offset(0.90, 0.10),
          ],
          arrowOnStart: true,
          arrowOnStartAngle: pi,
          normalizeToDiagramArea: false);
      paintCustomDiagramLines(c, canvas,
          startPos: Offset(0.10, 0.10),
          polylineOffsets: [
            Offset(0.10, 0.20),
            Offset(0.90, 0.20),
            Offset(0.90, 0.18),
          ],
          arrowOnEnd: true,
          normalizeToDiagramArea: false);

      /// Leakages
      final leftIndent = 0.02;
      paintCustomDiagramLines(c, canvas,
          startPos: Offset(leftIndent, 0.10),
          polylineOffsets: [Offset(leftIndent, 0.70)],
          normalizeToDiagramArea: false);
      paintCustomDiagramLines(c, canvas,
          startPos: Offset(leftIndent, 0.40),
          polylineOffsets: [Offset(0.25, 0.40)],
          arrowOnEnd: true,
          arrowOnEndAngle: pi * 0.50,
          normalizeToDiagramArea: false);
      paintCustomDiagramLines(c, canvas,
          startPos: Offset(leftIndent, 0.55),
          polylineOffsets: [Offset(0.25, 0.55)],
          arrowOnEnd: true,
          arrowOnEndAngle: pi * 0.50,
          normalizeToDiagramArea: false);
      paintCustomDiagramLines(c, canvas,
          startPos: Offset(leftIndent, 0.70),
          polylineOffsets: [Offset(0.25, 0.70)],
          arrowOnEnd: true,
          arrowOnEndAngle: pi * 0.50,
          normalizeToDiagramArea: false);

      /// Injections
      final rightIndent = 0.94;
      paintCustomDiagramLines(c, canvas,
          startPos: Offset(rightIndent, 0.20),
          polylineOffsets: [Offset(rightIndent, 0.70)],
          arrowOnStart: true,
          normalizeToDiagramArea: false);

      paintCustomDiagramLines(c, canvas,
          startPos: Offset(0.50, 0.40),
          polylineOffsets: [
            Offset(rightIndent, 0.40),
          ],
          normalizeToDiagramArea: false);
      paintCustomDiagramLines(c, canvas,
          startPos: Offset(0.50, 0.55),
          polylineOffsets: [
            Offset(rightIndent, 0.55),
          ],
          normalizeToDiagramArea: false);
      paintCustomDiagramLines(c, canvas,
          startPos: Offset(0.50, 0.70),
          polylineOffsets: [
            Offset(rightIndent, 0.70),
          ],
          normalizeToDiagramArea: false);

      /// Households
      paintTextBox(
        canvas: canvas,
        config: c,
        lineColor: color1,
        text: DiagramLabel.households.label,
        position: Offset(0.10, 0.10),
        showBoxBorder: true,
        boxBorderWidth: kCurveWidth,
      );

      /// Firms
      paintTextBox(
        canvas: canvas,
        config: c,
        lineColor: color1,
        text: DiagramLabel.firms.label,
        position: Offset(0.90, 0.10),
        showBoxBorder: true,
        boxBorderWidth: kCurveWidth,
      );

      paintTextBox(
        canvas: canvas,
        config: c,
        lineColor: color1,
        text: DiagramLabel.government.label,
        position: Offset(0.50, 0.40),
        showBoxBorder: true,
        boxBorderWidth: kCurveWidth,
      );
      paintTextBox(
        canvas: canvas,
        config: c,
        lineColor: color1,
        text: DiagramLabel.financialSector.label,
        position: Offset(0.50, 0.55),
        showBoxBorder: true,
        boxBorderWidth: kCurveWidth,
      );
      paintTextBox(
        canvas: canvas,
        config: c,
        lineColor: color1,
        text: DiagramLabel.foreignSector.label,
        position: Offset(0.50, 0.70),
        showBoxBorder: true,
        boxBorderWidth: kCurveWidth,
      );

      paintText(
          c, canvas,
          DiagramLabel.rentWagesInterestProfit.label,
          Offset(0.50,-0.04),);
    }
  }
}
