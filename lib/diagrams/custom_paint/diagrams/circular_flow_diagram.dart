import 'package:economics_app/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/diagram_lines/paint_diagram_lines.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_text.dart';
import 'package:economics_app/diagrams/enums/diagram_enum.dart';
import 'package:economics_app/diagrams/enums/diagram_labels.dart';
import 'package:economics_app/diagrams/models/custom_bezier.dart';
import 'package:flutter/material.dart';

import '../../models/base_painter_painter.dart';
import '../../models/diagram_painter_config.dart';
import '../i_diagram_canvas.dart';

class CircularFlowDiagram extends BaseDiagramPainter {
  CircularFlowDiagram(super.config, super.diagram);

  @override
  void drawDiagram(IDiagramCanvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);
    final moneyFlowColor = Colors.green;
    final factorsFlowColor = Colors.blueAccent;
    switch (diagram) {
      case DiagramEnum.macroCircularFlowClosed:
        _paintCircularClosed(c, canvas, moneyFlowColor, factorsFlowColor, 1);
      case DiagramEnum.macroCircularFlowOpen:
        _paintCircularOpen(c, canvas, moneyFlowColor, factorsFlowColor, 1);
      default:
    }
  }
}

void _paintCircularClosed(
  DiagramPainterConfig c,
  IDiagramCanvas canvas,
  Color moneyFlowColor,
  Color factorsFlowColor,
  int flowCount,
) {
  paintDiagramLines(
    c,
    canvas,
    startPos: Offset(0.08, 0.50),
    bezierPoints: [
      CustomBezier(control: Offset(0.50, 0.0), endPoint: Offset(0.92, 0.50)),
    ],
    arrowOnEndAngle: 0.25,
    normalizeToDiagramArea: false,
    flowArrow: DiagramFlowArrow.forward,
    flowArrowCount: flowCount,
    color: moneyFlowColor,
    middleLabel: DiagramLabel.landLaborCapitalEntrepreneurship.label,
    middleLabelAlign: LabelAlign.centerTop,
  );
  paintDiagramLines(
    c,
    canvas,
    startPos: Offset(0.10, 0.50),
    bezierPoints: [
      CustomBezier(control: Offset(0.50, 0.3), endPoint: Offset(0.90, 0.50)),
    ],
    arrowOnEndAngle: 0.25,
    normalizeToDiagramArea: false,
    flowArrow: DiagramFlowArrow.backward,
    flowArrowCount: flowCount,
    color: factorsFlowColor,
    middleLabel: DiagramLabel.rentWagesInterestProfitY.label,
    middleLabelAlign: LabelAlign.centerTop,
  );
  paintDiagramLines(
    c,
    canvas,
    startPos: Offset(0.08, 0.50),
    bezierPoints: [
      CustomBezier(control: Offset(0.50, 1.0), endPoint: Offset(0.92, 0.50)),
    ],
    arrowOnEndAngle: 0.25,
    normalizeToDiagramArea: false,
    flowArrow: DiagramFlowArrow.backward,
    flowArrowCount: flowCount,
    color: moneyFlowColor,
    middleLabel: DiagramLabel.goodsAndServicesO.label,
    middleLabelAlign: LabelAlign.centerBottom,
  );
  paintDiagramLines(
    c,
    canvas,
    startPos: Offset(0.10, 0.50),
    bezierPoints: [
      CustomBezier(control: Offset(0.50, 0.70), endPoint: Offset(0.90, 0.50)),
    ],
    arrowOnEndAngle: 0.25,
    normalizeToDiagramArea: false,
    flowArrow: DiagramFlowArrow.forward,
    flowArrowCount: flowCount,
    color: factorsFlowColor,
    middleLabel: DiagramLabel.householdSpendingE.label,
    middleLabelAlign: LabelAlign.centerBottom,
  );
  paintText(
    c,
    canvas,
    DiagramLabel.factorMarkets.label,
    Offset(0.50, 0.31),
    ignoreIndent: true,
  );
  paintText(
    c,
    canvas,
    DiagramLabel.productMarkets.label,
    Offset(0.50, 0.69),
    ignoreIndent: true,
  );
  paintText(
    c,
    canvas,
    DiagramLabel.households.label,
    Offset(0.10, 0.50),
    ignoreIndent: true,
    shape: DiagramShape.circle,
  );

  paintText(
    c,
    canvas,
    DiagramLabel.firms.label,
    Offset(0.90, 0.50),
    ignoreIndent: true,
    shape: DiagramShape.circle,
  );
}

void _paintCircularOpen(
  DiagramPainterConfig c,
  IDiagramCanvas canvas,
  Color productsColor,
  Color moneyColor,
  int flowCount,
) {
  // --- 1. CONFIG ---
  final leakagesColor = Colors.red;
  final injectionsColor = Colors.blueAccent;

  // --- COORDINATE TUNING ---
  final double householdsX = 0.05;
  final double firmsX = 0.95;

  final double mainFlowY = 0.30;

  // --- VERTICAL COMPRESSION ---
  // Moved sectors UP (Closer to the main loop)
  // Previous: 0.72, 0.84, 0.96
  final double publicSectorY = 0.60;
  final double financialSectorY = 0.70;
  final double foreignSectorY = 0.80;

  // Box Logic
  final double centerX = 0.50;
  final double boxPad = 0.12;

  final double sectorLeftX = centerX - boxPad;
  final double sectorRightX = centerX + boxPad;

  final double textGapY = 0.015;

  // --- 2. MAIN CIRCULAR FLOW (Households <-> Firms) ---

  final double bezierStart = householdsX - 0.02;
  final double bezierEnd = firmsX + 0.02;

  // TOP ARCS
  paintDiagramLines(
    c,
    canvas,
    startPos: Offset(bezierStart, mainFlowY),
    bezierPoints: [
      CustomBezier(
        control: Offset(0.50, 0.00),
        endPoint: Offset(bezierEnd, mainFlowY),
      ),
    ],
    arrowOnEnd: true,
    arrowOnEndAngle: 0.2,
    normalizeToDiagramArea: false,
    flowArrow: DiagramFlowArrow.forward,
    flowArrowCount: flowCount,
    color: productsColor,
    middleLabel: DiagramLabel.factorsOfProduction.label,
    middleLabelAlign: LabelAlign.centerTop,
  );

  paintDiagramLines(
    c,
    canvas,
    startPos: Offset(bezierStart, mainFlowY),
    bezierPoints: [
      CustomBezier(
        control: Offset(0.50, 0.15),
        endPoint: Offset(bezierEnd, mainFlowY),
      ),
    ],
    arrowOnEnd: true,
    arrowOnEndAngle: 0.2,
    normalizeToDiagramArea: false,
    flowArrow: DiagramFlowArrow.backward,
    flowArrowCount: flowCount,
    color: moneyColor,
    middleLabel: DiagramLabel.factorPayments.label,
    middleLabelAlign: LabelAlign.centerTop,
  );

  // BOTTOM ARCS
  paintDiagramLines(
    c,
    canvas,
    startPos: Offset(bezierStart, mainFlowY),
    bezierPoints: [
      CustomBezier(
        control: Offset(0.50, 0.45),
        endPoint: Offset(bezierEnd, mainFlowY),
      ),
    ],
    arrowOnEnd: true,
    arrowOnEndAngle: 0.2,
    normalizeToDiagramArea: false,
    flowArrow: DiagramFlowArrow.forward,
    flowArrowCount: flowCount,
    color: moneyColor,
    middleLabel: DiagramLabel.householdSpending.label,
    middleLabelAlign: LabelAlign.centerBottom,
  );

  paintDiagramLines(
    c,
    canvas,
    startPos: Offset(bezierStart, mainFlowY),
    bezierPoints: [
      CustomBezier(
        control: Offset(0.50, 0.60),
        endPoint: Offset(bezierEnd, mainFlowY),
      ),
    ],
    arrowOnEnd: true,
    arrowOnEndAngle: 0.2,
    normalizeToDiagramArea: false,
    flowArrow: DiagramFlowArrow.backward,
    flowArrowCount: flowCount,
    color: productsColor,
    middleLabel: DiagramLabel.goodsAndServices.label,
    middleLabelAlign: LabelAlign.centerBottom,
  );

  // --- 3. SECTOR BOXES ---
  paintText(
    c,
    canvas,
    DiagramLabel.publicSector.label,
    Offset(centerX, publicSectorY),
    shape: DiagramShape.square,
    ignoreIndent: true,
  );
  paintText(
    c,
    canvas,
    DiagramLabel.financialSector.label,
    Offset(centerX, financialSectorY),
    shape: DiagramShape.square,
    ignoreIndent: true,
  );
  paintText(
    c,
    canvas,
    DiagramLabel.foreignSector.label,
    Offset(centerX, foreignSectorY),
    shape: DiagramShape.square,
    ignoreIndent: true,
  );

  // --- 4. LEAKAGES (RED) ---

  void drawLeakage(String text, double yPos, double startXOffset) {
    paintDiagramLines(
      c,
      canvas,
      startPos: Offset(householdsX + startXOffset, mainFlowY + 0.10),
      polylineOffsets: [
        Offset(householdsX + startXOffset, yPos),
        Offset(sectorLeftX, yPos),
      ],
      color: leakagesColor,
      arrowOnEnd: true,
      normalizeToDiagramArea: false,
    );

    final double midX = ((householdsX + startXOffset) + sectorLeftX) / 2;

    paintText(
      c,
      canvas,
      text,
      Offset(midX, yPos - textGapY),
      ignoreIndent: true,
      verticalPivot: LabelPivot.bottom,
      horizontalPivot: LabelPivot.center,
      style: TextStyle(color: leakagesColor),
    );
  }

  // Increased Offsets for "More Outside Padding"
  // (0.06 -> 0.09) and (0.03 -> 0.05)
  drawLeakage(DiagramLabel.taxesT.label, publicSectorY, 0.09);
  drawLeakage(DiagramLabel.savingsS.label, financialSectorY, 0.05);
  drawLeakage(DiagramLabel.importsM.label, foreignSectorY, 0.01);

  // --- 5. INJECTIONS (BLUE) ---

  void drawInjection(String text, double yPos, double endXOffset) {
    paintDiagramLines(
      c,
      canvas,
      startPos: Offset(sectorRightX, yPos),
      polylineOffsets: [
        Offset(firmsX + endXOffset, yPos),
        Offset(firmsX + endXOffset, mainFlowY + 0.10),
      ],
      color: injectionsColor,
      arrowOnEnd: true,
      normalizeToDiagramArea: false,
    );

    final double midX = (sectorRightX + (firmsX + endXOffset)) / 2;

    paintText(
      c,
      canvas,
      text,
      Offset(midX, yPos - textGapY),
      ignoreIndent: true,
      verticalPivot: LabelPivot.bottom,
      horizontalPivot: LabelPivot.center,
      style: TextStyle(color: injectionsColor),
    );
  }

  // Increased offsets negatively to push lines outwards
  drawInjection(DiagramLabel.governmentSpendingG.label, publicSectorY, -0.09);
  drawInjection(DiagramLabel.investmentI.label, financialSectorY, -0.05);
  drawInjection(DiagramLabel.exportsX.label, foreignSectorY, -0.01);

  // --- 6. MAIN LABELS ---
  paintText(
    c,
    canvas,
    DiagramLabel.households.label,
    Offset(householdsX, mainFlowY),
    ignoreIndent: true,
    shape: DiagramShape.circle,
  );

  paintText(
    c,
    canvas,
    DiagramLabel.firms.label,
    Offset(firmsX, mainFlowY),
    ignoreIndent: true,
    shape: DiagramShape.circle,
  );
}
