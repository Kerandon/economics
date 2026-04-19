import 'dart:math';
import 'package:economics_app/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/paint_axis.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/legend/legend_display.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_diagram_dash_lines.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_line_segment.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_text.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_title.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/shortcut_methods/paint_description.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/shortcut_methods/paint_market_curve.dart';
import 'package:economics_app/diagrams/custom_paint/shade/paint_shading.dart';
import 'package:economics_app/diagrams/custom_paint/shade/shade_type.dart';
import 'package:economics_app/diagrams/enums/diagram_labels.dart';
import 'package:flutter/material.dart';
import '../../../app/configs/constants.dart';
import '../../enums/diagram_enum.dart';
import '../../models/base_painter_painter.dart';
import '../../models/diagram_painter_config.dart';
import '../i_diagram_canvas.dart';

class Externalities extends BaseDiagramPainter {
  Externalities(super.config, super.diagram);

  @override
  void drawDiagram(IDiagramCanvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);

    if (diagram !=
        DiagramEnum.microTradablePollutionPermitsSupplyDemandDecrease) {
      paintAxis(
        c,
        canvas,
        yAxisLabel: DiagramLabel.priceCostsBenefits.label,
        xAxisLabel: DiagramLabel.quantity.label,
      );
    }

    switch (diagram) {
      case DiagramEnum.microNegativeProductionExternality:
      case DiagramEnum.microNegativeProductionExternalityIncludingOveruseOfCPR:
      case DiagramEnum.microCommonPoolResources:
      case DiagramEnum.microNegativeProductionExternalityPigouvianTax:
      case DiagramEnum.microNegativeProductionExternalityRegulations:
        _paintNegativeProduction(c, canvas);

      case DiagramEnum.microCarbonTax:
        _paintCarbonTax(c, canvas);

      case DiagramEnum.microTradablePollutionPermits:
      case DiagramEnum.microTradablePollutionPermitsSupplyDemandDecrease:
        _paintTradablePermits(c, canvas, diagram);

      case DiagramEnum.microNegativeConsumptionExternality:
      case DiagramEnum.microNegativeConsumptionExternalityWelfare:
      case DiagramEnum.microNegativeConsumptionExternalityPigouvianTax:
      case DiagramEnum.microNegativeConsumptionExternalityRegulations:
      case DiagramEnum.microNegativeConsumptionExternalityEducationAndNudges:
        _paintNegativeConsumption(c, canvas);
        break;

      case DiagramEnum.microPositiveProductionExternality:
      case DiagramEnum.microPositiveProductionExternalityWelfare:
      case DiagramEnum.microPositiveProductionExternalitySubsidy:
      case DiagramEnum.microPositiveProductionExternalityGovernmentProvision:
        _paintPositiveProduction(c, canvas);

      case DiagramEnum.microPositiveConsumptionExternality:
      case DiagramEnum.microPositiveConsumptionExternalityWelfare:
      case DiagramEnum.microPositiveConsumptionExternalitySubsidy:
      case DiagramEnum.microPositiveConsumptionExternalityEducationAndNudges:
      case DiagramEnum.microPositiveConsumptionExternalityRegulations:
      case DiagramEnum.microPositiveConsumptionExternalityGovernmentProvision:
        _paintPositiveConsumption(c, canvas);
      default:
        break;
    }
  }

  LegendDisplay get legendDisplay {
    const welfareDiagrams = {
      DiagramEnum.microNegativeProductionExternalityWelfare,
      DiagramEnum.microNegativeConsumptionExternalityWelfare,
      DiagramEnum.microPositiveProductionExternalityWelfare,
      DiagramEnum.microPositiveConsumptionExternalityWelfare,
    };
    return welfareDiagrams.contains(diagram)
        ? LegendDisplay.letters
        : LegendDisplay.shading;
  }

  // --- PRIVATE PAINTING METHODS ---

  void _paintNegativeProduction(DiagramPainterConfig c, IDiagramCanvas canvas) {
    bool isTax =
        diagram == DiagramEnum.microNegativeProductionExternalityPigouvianTax;
    bool isReg =
        diagram == DiagramEnum.microNegativeProductionExternalityRegulations;
    bool hasWelfare =
        diagram ==
        DiagramEnum.microNegativeProductionExternalityIncludingOveruseOfCPR;

    String mscLabel = isTax
        ? DiagramLabel.mPCPlusTaxEqualsMSC.label
        : isReg
        ? DiagramLabel.mPCPlusRegulationsEqualsMSC.label
        : DiagramLabel.msc.label;

    String extLabel = isTax
        ? 'Tax =\nExt. Cost'
        : isReg
        ? 'Regulations'
        : 'External\nCost';

    String desc = isTax
        ? 'Tax increases MPC to align with MSC - removing external cost. Gov revenue: (Pc-Pp) x Qopt.'
        : isReg
        ? 'Gov regulations limiting output shift MPC towards MSC.'
        : 'Free market: MSC > MPC. Qopt < Qm';

    if (isTax) {
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.67,
        xAxisEndPos: 0.43,
        yLabel: DiagramLabel.pP.label,
        hideXLine: true,
      );
    }

    if (hasWelfare) {
      _drawWelfareLoss(
        c,
        canvas,
        [Offset(0.42, 0.42), Offset(0.555, 0.56), Offset(0.555, 0.30)],
        labelOffset: Offset(0.50, 0.18),
        labelAlign: LabelAlign.right,
      );
    }

    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.dEqualsMPBMSB,
      lengthAdjustment: -0.10,
    );
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.sEqualsMPC,
      horizontalShift: 0.05,
      verticalShift: 0.05,
      lengthAdjustment: -0.10,
    );
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.msc,
      horizontalShift: -0.05,
      verticalShift: -0.10,
      lengthAdjustment: -0.10,
      label: mscLabel,
      color: (isTax || isReg) ? kHighLightedColor : c.colorScheme.primary,
    );

    paintText(
      c,
      canvas,
      DiagramLabel.externalCost.label,
      Offset(0.45, 0.20),
      type: DiagramTextType.label,
      pointerLine: Offset(0.70, 0.28),
    );
    _paintShift(
      c,
      canvas,
      Offset(0.70, 0.28),
      pi * 1.5,
      isTax || isReg ? LineEndStyle.arrow : LineEndStyle.arrowBothEnds,
      0.15,
    );

    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.42,
      xAxisEndPos: 0.425,
      yLabel: isTax ? DiagramLabel.pCEqualsPOpt.label : DiagramLabel.pOpt.label,
      xLabel: DiagramLabel.qOpt.label,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.555,
      xAxisEndPos: 0.55,
      yLabel: DiagramLabel.pm.label,
      xLabel: DiagramLabel.qm.label,
    );
  }

  void _paintCarbonTax(DiagramPainterConfig c, IDiagramCanvas canvas) {
    paintTitle(c, canvas, 'Carbon Tax - Two Step Process');
    final adj = -0.15;

    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.dEqualsMPBMSB,
      lengthAdjustment: adj,
    );
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.mscEqualsMpcTax1,
      horizontalShift: -0.12,
      verticalShift: -0.08,
      lengthAdjustment: adj,
      color: kHighLightedColor,
    );
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.mscEqualsMpcTax2,
      lengthAdjustment: adj,
      color: kHighLightedColor,
    );
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.mpc,
      horizontalShift: 0.12,
      verticalShift: 0.08,
      lengthAdjustment: adj,
    );

    final positions = [0.40, 0.50, 0.605];
    final yLabels = [
      DiagramLabel.p1.label,
      DiagramLabel.p2.label,
      DiagramLabel.pm.label,
    ];
    final xLabels = [
      DiagramLabel.q1.label,
      DiagramLabel.q2.label,
      DiagramLabel.qm.label,
    ];

    for (int i = 0; i < 3; i++) {
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: positions[i],
        xAxisEndPos: positions[i],
        yLabel: yLabels[i],
        xLabel: xLabels[i],
      );
    }

    _paintShift(
      c,
      canvas,
      Offset(0.65, 0.36),
      -pi / 2,
      LineEndStyle.arrow,
      0.32,
      label: '1',
      labelAlign: LabelAlign.center,
    );
    _paintShift(
      c,
      canvas,
      Offset(0.75, 0.36),
      -pi / 2,
      LineEndStyle.arrow,
      0.14,
      label: '2',
      labelAlign: LabelAlign.center,
    );
    paintDescription(
      c,
      canvas,
      '1. initial carbon tax, 2. tax reduces as firms substitute to clean energy.',
    );
  }

  void _paintTradablePermits(
    DiagramPainterConfig c,
    IDiagramCanvas canvas,
    DiagramEnum diagram,
  ) {
    paintAxis(
      c,
      canvas,
      yAxisLabel: DiagramLabel.priceOfPermits.label,
      xAxisLabel: DiagramLabel.quantityOfPermits.label,
    );

    if (diagram == DiagramEnum.microTradablePollutionPermits) {
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.40,
        xAxisEndPos: 0.55,
        yLabel: DiagramLabel.pE.label,
        xLabel: DiagramLabel.qE.label,
      );

      paintMarketCurve(
        c,
        canvas,
        type: MarketCurveType.perfectlyInelasticSupply,
        label: DiagramLabel.s.label,
        horizontalShift: 0.05,
      );
      paintMarketCurve(
        c,
        canvas,
        type: MarketCurveType.demand,
        horizontalShift: 0.10,
        verticalShift: -0.05,
        lengthAdjustment: -0.05,
      );
    }
    if (diagram ==
        DiagramEnum.microTradablePollutionPermitsSupplyDemandDecrease) {
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.40,
        xAxisEndPos: 0.55,
        yLabel: DiagramLabel.p1.label,
        xLabel: DiagramLabel.q1.label,
      );
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.35,
        xAxisEndPos: 0.35,
        yLabel: DiagramLabel.p2.label,
        xLabel: DiagramLabel.q2.label,
      );

      paintMarketCurve(
        c,
        canvas,
        type: MarketCurveType.perfectlyInelasticSupply,
        label: DiagramLabel.s1.label,
        horizontalShift: 0.05,
      );
      paintMarketCurve(
        c,
        canvas,
        type: MarketCurveType.perfectlyInelasticSupply,
        label: DiagramLabel.s2.label,
        color: kHighLightedColor,
        horizontalShift: -0.15,
      );
      paintMarketCurve(
        c,
        canvas,
        type: MarketCurveType.d1,
        horizontalShift: 0.10,
        verticalShift: -0.05,
        lengthAdjustment: -0.05,
      );
      paintMarketCurve(
        c,
        canvas,
        type: MarketCurveType.d2,
        color: Colors.red,
        lengthAdjustment: -0.05,
      );

      _paintShift(c, canvas, Offset(0.46, 0.80), pi, LineEndStyle.arrow, 0.11);
      _paintShift(c, canvas, Offset(0.77, 0.69), pi, LineEndStyle.arrow, 0.08);
    }
  }

  void _paintNegativeConsumption(
    DiagramPainterConfig c,
    IDiagramCanvas canvas,
  ) {
    paintTitle(c, canvas, 'Sugary Drinks Market');

    bool isTax =
        diagram == DiagramEnum.microNegativeConsumptionExternalityPigouvianTax;
    bool isReg =
        diagram == DiagramEnum.microNegativeConsumptionExternalityRegulations;
    bool isEdu =
        diagram ==
        DiagramEnum.microNegativeConsumptionExternalityEducationAndNudges;
    bool isStandard =
        diagram == DiagramEnum.microNegativeConsumptionExternality;

    String msbLabel = isReg
        ? DiagramLabel.mPBPlusRegulationsEqualsMSC.label
        : isEdu
        ? DiagramLabel.mPBPlusEducationEqualsMSC.label
        : DiagramLabel.msb.label;

    String desc = isTax
        ? 'Gov budget gains by (Pc-Pp) x Qopt.'
        : isReg
        ? 'Regulations shift MPB towards MSC.'
        : isEdu
        ? 'Education and nudges shift MPB towards MSB.'
        : 'Free market: MSC > MPC. Qopt < Qm';

    if (isTax) {
      paintMarketCurve(
        c,
        canvas,
        type: MarketCurveType.mpcTax,
        lengthAdjustment: -0.20,
        color: Colors.red,
        verticalShift: -0.15,
        horizontalShift: -0.10,
      );
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.33,
        xAxisEndPos: 0.42,
        yLabel: DiagramLabel.pC.label,
      );
      _paintShift(
        c,
        canvas,
        Offset(0.70, 0.19),
        pi * 1.5,
        LineEndStyle.arrow,
        0.18,
        label: 'Tax',
      );
    }

    if (isReg || isEdu) {
      _paintShift(
        c,
        canvas,
        Offset(0.73, 0.75),
        pi,
        LineEndStyle.arrow,
        0.18,
        label: isReg ? 'Regulations' : 'Education',
        labelAlign: LabelAlign.centerBottom,
      );
    }

    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.sEqualsMPCMSC,
      lengthAdjustment: -0.10,
    );
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.dEqualsMPB,
      lengthAdjustment: -0.10,
      horizontalShift: 0.05,
      verticalShift: -0.05,
    );
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.msb,
      horizontalShift: -0.10,
      verticalShift: 0.05,
      lengthAdjustment: -0.10,
      color: kHighLightedColor,
      label: msbLabel,
    );

    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.45,
      xAxisEndPos: 0.55,
      yLabel: DiagramLabel.pm.label,
      xLabel: DiagramLabel.qm.label,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.58,
      xAxisEndPos: 0.42,
      yLabel: isTax ? DiagramLabel.pP.label : DiagramLabel.pOpt.label,
      xLabel: DiagramLabel.qOpt.label,
      hideXLine: isTax,
    );
    if (isStandard) {
      _drawWelfareLoss(
        c,
        canvas,
        [Offset(0.42, 0.58), Offset(0.55, 0.71), Offset(0.55, 0.46)],
        labelOffset: Offset(0.80, 0.55),
        labelAlign: LabelAlign.right,
      );
      _paintShift(
        c,
        canvas,
        Offset(0.70, 0.73),
        pi / 2,
        LineEndStyle.arrowBothEnds,
        0.18,
        label: 'External\nCost',
      );
    }
    paintDescription(c, canvas, desc);
  }

  void _paintPositiveProduction(DiagramPainterConfig c, IDiagramCanvas canvas) {
    paintTitle(c, canvas, 'Vaccination Research & Development');

    bool isSub =
        diagram == DiagramEnum.microPositiveProductionExternalitySubsidy;
    bool isGov =
        diagram ==
        DiagramEnum.microPositiveProductionExternalityGovernmentProvision;
    bool isStandard = diagram == DiagramEnum.microPositiveProductionExternality;

    String mscLabel = isSub
        ? DiagramLabel.mPCMinusSubsidyEqualsMSC.label
        : isGov
        ? DiagramLabel.sPlusProvisionEqualsMSC.label
        : DiagramLabel.msc.label;

    if (isSub) {
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.30,
        xAxisEndPos: 0.50,
        yLabel: DiagramLabel.pP.label,
        xLabel: DiagramLabel.qOpt.label,
      );
    }

    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.dEqualsMPBMSB,
      horizontalShift: -0.05,
    );
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.sEqualsMPC,
      horizontalShift: -0.10,
      verticalShift: -0.10,
      lengthAdjustment: -0.10,
    );
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.msc,
      verticalShift: 0.05,
      lengthAdjustment: -0.10,
      label: mscLabel,
      color: (isSub || isGov) ? kHighLightedColor : c.colorScheme.primary,
    );

    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.55,
      xAxisEndPos: 0.50,
      yLabel: isSub ? DiagramLabel.pC.label : DiagramLabel.pOpt.label,
      xLabel: DiagramLabel.qOpt.label,
      hideXLine: isSub,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.43,
      xAxisEndPos: 0.37,
      yLabel: DiagramLabel.pm.label,
      xLabel: DiagramLabel.qm.label,
    );

    _paintShift(
      c,
      canvas,
      Offset(0.65, 0.27),
      pi / 2,
      (isSub || isGov) ? LineEndStyle.arrow : LineEndStyle.arrowBothEnds,
      0.17,
      label: isSub
          ? 'Subsidy'
          : isGov
          ? 'Provision'
          : 'External\nBenefit',
      labelAlign: LabelAlign.center,
    );

    if (isStandard) {
      _drawWelfareLoss(
        c,
        canvas,
        [Offset(0.37, 0.42), Offset(0.37, 0.69), Offset(0.50, 0.55)],
        labelOffset: Offset(0.70, 0.55),
        labelAlign: LabelAlign.left,
      );
    }
    paintDescription(
      c,
      canvas,
      isSub
          ? 'Price reduces to Pc but producers receive Pc+Subsidy.'
          : isGov
          ? 'Total supply = private supply + gov provision.'
          : 'Free market: MSC < MPC. Qopt > Qm',
    );
  }

  void _paintPositiveConsumption(
    DiagramPainterConfig c,
    IDiagramCanvas canvas,
  ) {
    paintTitle(c, canvas, 'Health Insurance');

    bool isSub =
        diagram == DiagramEnum.microPositiveConsumptionExternalitySubsidy;
    bool isGov =
        diagram ==
        DiagramEnum.microPositiveConsumptionExternalityGovernmentProvision;
    bool isEdu =
        diagram ==
        DiagramEnum.microPositiveConsumptionExternalityEducationAndNudges;
    bool isReg =
        diagram == DiagramEnum.microPositiveConsumptionExternalityRegulations;

    if (isSub || isGov) {
      _paintShift(
        c,
        canvas,
        Offset(0.80, 0.32),
        pi / 2,
        LineEndStyle.arrow,
        0.17,
        label: isSub
            ? DiagramLabel.subsidy.label
            : DiagramLabel.provision.label,
      );
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.70,
        xAxisEndPos: 0.55,
        yLabel: DiagramLabel.pC.label,
        xLabel: DiagramLabel.qOpt.label,
        hideXLine: true,
      );
      paintMarketCurve(
        c,
        canvas,
        type: isSub ? MarketCurveType.mpcSub : MarketCurveType.sPlusProvision,
        verticalShift: 0.10,
        horizontalShift: 0.15,
        lengthAdjustment: -0.20,
        color: kHighLightedColor,
      );
    }

    if (isEdu || isReg) {
      _paintShift(
        c,
        canvas,
        Offset(0.73, 0.75),
        0,
        LineEndStyle.arrow,
        0.16,
        label: isEdu
            ? DiagramLabel.education.label
            : DiagramLabel.regulations.label,
        labelAlign: LabelAlign.centerBottom,
      );
    }

    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.sEqualsMPCMSC,
      lengthAdjustment: -0.10,
    );
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.msb,
      lengthAdjustment: -0.10,
      verticalShift: -0.05,
      horizontalShift: 0.05,
      color: (isEdu || isReg) ? kHighLightedColor : c.colorScheme.primary,
      label: (isEdu || isReg)
          ? DiagramLabel.mPBPlusEducationEqualsMSC.label
          : DiagramLabel.msb.label,
    );
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.dEqualsMPB,
      verticalShift: 0.05,
      horizontalShift: -0.10,
      lengthAdjustment: -0.10,
    );

    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.58,
      xAxisEndPos: 0.425,
      yLabel: DiagramLabel.pm.label,
      xLabel: DiagramLabel.qm.label,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.45,
      xAxisEndPos: 0.55,
      yLabel: isSub || isGov ? DiagramLabel.pP.label : DiagramLabel.pOpt.label,
      xLabel: DiagramLabel.qOpt.label,
      hideXLine: isSub || isGov,
    );
    if (diagram == DiagramEnum.microPositiveConsumptionExternality) {
      _paintShift(
        c,
        canvas,
        Offset(0.70, 0.72),
        pi / 2,
        LineEndStyle.arrowBothEnds,
        0.16,
        label: 'External\nBenefit',
      );
      _drawWelfareLoss(
        c,
        canvas,
        [Offset(0.42, 0.32), Offset(0.42, 0.59), Offset(0.55, 0.45)],
        labelOffset: Offset(0.75, 0.45),
        labelAlign: LabelAlign.left,
      );
    }

    paintDescription(
      c,
      canvas,
      isSub
          ? 'Cost to government budget: (Pp-Pc) x Qopt.'
          : isGov
          ? 'Gov-run scheme adds to private supply.'
          : 'Free market: MSB > MPB. Qopt > Qm',
    );
  }

  // --- REUSABLE HELPERS ---

  void _drawWelfareLoss(
    DiagramPainterConfig c,
    IDiagramCanvas canvas,
    List<Offset> points, {
    required Offset labelOffset,
    LabelAlign? labelAlign,
  }) {
    paintShading(
      c,
      canvas,
      ShadeType.welfareLoss,
      points,
      label: 'Welfare\nLoss',
      labelAlign: labelAlign ?? LabelAlign.center,
      showLabelBackground: true,
    );
  }

  void _paintShift(
    DiagramPainterConfig c,
    IDiagramCanvas canvas,
    Offset origin,
    double angle,
    LineEndStyle endStyle,
    double length, {
    String? label,
    LabelAlign? labelAlign,
  }) {
    paintLineSegment(
      c,
      canvas,
      origin: origin,
      angle: angle,
      endStyle: endStyle,
      length: length,
      label: label,
      labelAlign: labelAlign ?? LabelAlign.center,
    );
  }
}
