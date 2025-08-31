import 'dart:math';
import 'package:flutter/material.dart';
import '../../enums/diagram_labels.dart';
import '../../enums/diagram_subtype.dart';
import '../../models/base_painter_painter.dart';
import '../../models/diagram_model.dart';
import '../../models/diagram_painter_config.dart';
import '../painter_constants.dart';

import '../painter_methods/diagram_lines/paint_diagram_lines.dart';
import '../painter_methods/paint_text.dart';
import '../painter_methods/paint_text_box.dart';
import '../painter_methods/paint_title.dart';

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
      paintTitle(c, canvas, 'Closed Model');
      final topIndent = 0.20;
      final bottomIndent = 0.80;
      final gap = 0.05;

      /// Arrows - Purple
      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0.50, topIndent),
        polylineOffsets: [Offset(0.10, topIndent), Offset(0.10, 0.40)],
        color: color2,
        normalizeToDiagramArea: false,
        arrowOnEnd: true,
        arrowOnEndAngle: pi,
      );
      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0.10, 0.50),
        polylineOffsets: [
          Offset(0.10, bottomIndent),
          Offset(0.50, bottomIndent),
        ],
        normalizeToDiagramArea: false,
        color: color2,
      );

      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0.50, bottomIndent),
        polylineOffsets: [Offset(0.90, bottomIndent), Offset(0.90, 0.60)],
        color: color2,
        normalizeToDiagramArea: false,
        arrowOnEnd: true,
        arrowOnEndAngle: pi / 0.50,
      );

      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0.90, 0.50),
        polylineOffsets: [Offset(0.90, topIndent), Offset(0.50, topIndent)],
        color: color2,
        normalizeToDiagramArea: false,
        arrowOnEnd: true,
        arrowOnEndAngle: pi / -2,
      );

      /// Arrows - Orange
      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0.05, 0.60),
        polylineOffsets: [
          Offset(0.05, bottomIndent + gap),
          Offset(0.50, bottomIndent + gap),
        ],
        normalizeToDiagramArea: false,
        arrowOnStart: true,
        color: color1,
      );

      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0.95, 0.40),
        polylineOffsets: [
          Offset(0.95, topIndent - gap),
          Offset(0.50, topIndent - gap),
        ],
        color: color1,
        normalizeToDiagramArea: false,
        arrowOnStart: true,
        arrowOnStartAngle: pi,
      );

      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0.50, bottomIndent + gap),
        polylineOffsets: [Offset(0.95, bottomIndent + gap), Offset(0.95, 0.50)],
        color: color1,
        normalizeToDiagramArea: false,
      );
      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0.50, topIndent - gap),
        polylineOffsets: [Offset(0.05, topIndent - gap), Offset(0.05, 0.50)],
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
        position: Offset(0.50, 0.18),
        showBoxBorder: true,
        dottedBorder: true,
      );

      /// Product Markets
      paintTextBox(
        canvas: canvas,
        config: c,
        lineColor: c.colorScheme.primary,
        text: DiagramLabel.productMarkets.label,
        position: Offset(0.50, 0.82),
        showBoxBorder: true,
        dottedBorder: true,
      );

      /// Labels
      paintText(
        c,
        canvas,
        DiagramLabel.landLaborCapitalEnterprise.label,
        Offset(0.50, 0.10),
        style: TextStyle(color: color1, fontWeight: FontWeight.bold),
      );
      paintText(
        c,
        canvas,
        DiagramLabel.rentWagesInterestProfit.label,
        Offset(0.50, 0.26),
        style: TextStyle(color: color2, fontWeight: FontWeight.bold),
      );
      paintText(
        c,
        canvas,
        DiagramLabel.householdSpendingFirmRevenue.label,
        Offset(0.50, 0.74),
        style: TextStyle(color: color2, fontWeight: FontWeight.bold),
      );
      paintText(
        c,
        canvas,
        DiagramLabel.goodsAndServices.label,
        Offset(0.50, 0.90),
        style: TextStyle(color: color1, fontWeight: FontWeight.bold),
      );
    }
    if (model.subtype == DiagramSubtype.openModel) {
      paintTitle(c, canvas, 'Open Model');

      const Color injectionColor = Colors.green;
      const Color leakageColor = Colors.red;
      const Color closedLoopColor = Colors.blueGrey;

      final leftIndent = 0.02;
      final rightIndent = 0.94;

      /// Factor Payments (Closed Loop)
      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0.28, 0.20),
        polylineOffsets: [Offset(0.90, 0.20)],
        arrowOnStart: true,
        arrowOnStartAngle: pi / -2,
        normalizeToDiagramArea: false,
        color: closedLoopColor,
      );

      /// Household Spending (Closed Loop)
      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0.80, 0.24),
        polylineOffsets: [Offset(0.10, 0.24)],
        arrowOnStart: true,
        arrowOnStartAngle: pi / 2,
        normalizeToDiagramArea: false,
        color: closedLoopColor,
      );

      /// Factors of Production (Closed Loop)
      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0.10, 0.22),
        polylineOffsets: [
          Offset(0.10, 0.12),
          Offset(0.90, 0.12),
          Offset(0.90, 0.14),
        ],
        arrowOnEnd: true,
        arrowOnEndAngle: pi,
        normalizeToDiagramArea: false,
        color: closedLoopColor,
      );

      /// Goods and Services (Closed Loop)
      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0.10, 0.30),
        polylineOffsets: [
          Offset(0.10, 0.32),
          Offset(0.90, 0.32),
          Offset(0.90, 0.22),
        ],
        arrowOnStart: true,
        normalizeToDiagramArea: false,
        color: closedLoopColor,
      );

      /// Leakages
      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(leftIndent, 0.22),
        polylineOffsets: [Offset(leftIndent, 0.82)],
        normalizeToDiagramArea: false,
        color: leakageColor,
      );

      for (final y in [0.52, 0.67, 0.82]) {
        paintDiagramLines(
          c,
          canvas,
          startPos: Offset(leftIndent, y),
          polylineOffsets: [Offset(0.25, y)],
          arrowOnEnd: true,
          arrowOnEndAngle: pi * 0.5,
          normalizeToDiagramArea: false,
          color: leakageColor,
        );
      }

      /// Injections
      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(rightIndent, 0.32),
        polylineOffsets: [Offset(rightIndent, 0.82)],
        arrowOnStart: true,
        normalizeToDiagramArea: false,
        color: injectionColor,
      );

      for (final y in [0.52, 0.67, 0.82]) {
        paintDiagramLines(
          c,
          canvas,
          startPos: Offset(0.50, y),
          polylineOffsets: [Offset(rightIndent, y)],
          normalizeToDiagramArea: false,
          color: injectionColor,
        );
      }

      /// Text Boxes
      paintTextBox(
        canvas: canvas,
        config: c,
        lineColor: color1,
        text: DiagramLabel.households.label,
        position: Offset(0.10, 0.22),
        showBoxBorder: true,
        boxBorderWidth: kCurveWidth,
      );

      paintTextBox(
        canvas: canvas,
        config: c,
        lineColor: color1,
        text: DiagramLabel.firms.label,
        position: Offset(0.90, 0.22),
        showBoxBorder: true,
        boxBorderWidth: kCurveWidth,
      );

      paintTextBox(
        canvas: canvas,
        config: c,
        lineColor: color1,
        text: DiagramLabel.government.label,
        position: Offset(0.50, 0.52),
        showBoxBorder: true,
        boxBorderWidth: kCurveWidth,
      );

      paintTextBox(
        canvas: canvas,
        config: c,
        lineColor: color1,
        text: DiagramLabel.financialSector.label,
        position: Offset(0.50, 0.67),
        showBoxBorder: true,
        boxBorderWidth: kCurveWidth,
      );

      paintTextBox(
        canvas: canvas,
        config: c,
        lineColor: color1,
        text: DiagramLabel.foreignSector.label,
        position: Offset(0.50, 0.82),
        showBoxBorder: true,
        boxBorderWidth: kCurveWidth,
      );

      /// Text Labels
      paintText(
        c,
        canvas,
        DiagramLabel.factorsOfProduction.label,
        Offset(0.50, 0.08),
      );
      paintText(
        c,
        canvas,
        DiagramLabel.factorPayments.label,
        Offset(0.50, 0.16),
      );
      paintText(
        c,
        canvas,
        DiagramLabel.householdSpending.label,
        Offset(0.50, 0.27),
      );
      paintText(
        c,
        canvas,
        DiagramLabel.goodsAndServices.label,
        Offset(0.50, 0.36),
      );

      paintText(
        c,
        canvas,
        DiagramLabel.leakages.label,
        Offset(-0.02, 0.52),
        angle: -pi / 2,
      );
      paintText(
        c,
        canvas,
        DiagramLabel.injections.label,
        Offset(0.98, 0.52),
        angle: -pi / 2,
      );

      paintText(c, canvas, DiagramLabel.taxes.label, Offset(0.15, 0.48));
      paintText(c, canvas, DiagramLabel.savings.label, Offset(0.15, 0.63));
      paintText(c, canvas, DiagramLabel.imports.label, Offset(0.15, 0.78));

      paintText(
        c,
        canvas,
        DiagramLabel.governmentSpending.label,
        Offset(0.80, 0.48),
      );
      paintText(c, canvas, DiagramLabel.investment.label, Offset(0.80, 0.63));
      paintText(c, canvas, DiagramLabel.exports.label, Offset(0.80, 0.78));
    }
  }
}
