import 'dart:math';
import 'package:economics_app/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/label_align.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/paint_axis.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/diagram_lines/paint_diagram_lines.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/legend/legend_display.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_diagram_dash_lines.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_legend_table.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_line_segment.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_text_2.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/shortcut_methods/paint_market_curve.dart';
import 'package:economics_app/diagrams/custom_paint/shade/paint_shading.dart';
import 'package:economics_app/diagrams/custom_paint/shade/shade_type.dart';
import 'package:economics_app/diagrams/enums/diagram_labels.dart';
import 'package:flutter/material.dart';
import '../../enums/diagram_bundle_enum.dart';
import '../../models/base_painter_painter.dart';
import '../../models/diagram_painter_config.dart';

class Externalities extends BaseDiagramPainter2 {
  Externalities(super.config, super.bundle);

  @override
  void paint(Canvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);

    paintAxis(
      c,
      canvas,
      yAxisLabel: DiagramLabel.price.label,
      xAxisLabel: DiagramLabel.quantity.label,
    );
    switch (bundle) {
      case DiagramEnum.microNegativeProductionExternality ||
          DiagramEnum.microNegativeProductionExternalityWelfare ||
          DiagramEnum.microCommonPoolResources ||
          DiagramEnum.microNegativeProductionExternalityPigouvianTax ||
          DiagramEnum.microNegativeProductionExternalityRegulations:
        _paintNegativeProduction(c, canvas, size, bundle);
      case DiagramEnum.microCarbonTax:
        _paintCarbonTax(c, canvas, size);
      case DiagramEnum.microTradablePollutionPermits:
        _paintTradablePermits(c, canvas, size);
      case DiagramEnum.microNegativeConsumptionExternality ||
          DiagramEnum.microNegativeConsumptionExternalityWelfare ||
          DiagramEnum.microNegativeConsumptionExternalityPigouvianTax ||
          DiagramEnum.microNegativeConsumptionExternalityPublicAwareness:
        _paintNegativeConsumption(c, canvas, size, bundle);
      case DiagramEnum.microPositiveProductionExternality ||
          DiagramEnum.microPositiveProductionExternalityWelfare ||
          DiagramEnum.microPositiveProductionExternalitySubsidy ||
          DiagramEnum.microPositiveProductionExternalityDirectProvision:
        _paintPositiveProduction(c, canvas, size, bundle);
      case DiagramEnum.microPositiveConsumptionExternality ||
          DiagramEnum.microPositiveConsumptionExternalityWelfare ||
          DiagramEnum.microPositiveConsumptionExternalitySubsidy ||
          DiagramEnum.microPositiveConsumptionExternalityAdvertising ||
          DiagramEnum.microPositiveConsumptionExternalityDirectProvision:
        _paintPositiveConsumption(c, canvas, size, bundle);
      default:
    }
  }

  @override
  // TODO: implement legendDisplay
  LegendDisplay get legendDisplay => throw UnimplementedError();
}

void _paintNegativeProduction(
  DiagramPainterConfig c,
  Canvas canvas,
  Size size,
  DiagramEnum bundle,
) {
  String yLabel = DiagramLabel.pOpt.label;
  String supplyLabel = DiagramLabel.msc.label;
  String arrowLabel = DiagramLabel.externalCost.label;
  LineEndStyle lineEndStyle = LineEndStyle.arrowBothEnds;
  if (bundle == DiagramEnum.microNegativeProductionExternalityPigouvianTax ||
      bundle == DiagramEnum.microNegativeProductionExternalityRegulations) {
    lineEndStyle = LineEndStyle.arrow;

    paintLineSegment(c, canvas, origin: Offset(0.38, 1.09), angle: -pi);
    if (bundle == DiagramEnum.microNegativeProductionExternalityPigouvianTax) {
      paintText2(
        c,
        canvas,
        DiagramLabel.governmentTaxRevenue.label,
        Offset(0.25, 0.22),
        pointerLine: Offset(0.20, 0.50),
      );
      // paintShading(canvas, size, ShadeType.consumerSurplus, [Offset(0,0.20),Offset(0.30,0.47),Offset(0,0.47)]);
      paintShading(canvas, size, ShadeType.governmentRevenue, [
        Offset(0, 0.47),
        Offset(0.31, 0.47),
        Offset(0.31, 0.675),
        Offset(0.0, 0.675),
      ], striped: true);
      yLabel = DiagramLabel.pPEqualsPOpt.label;
      supplyLabel = DiagramLabel.mscEqualsMPCPlusTax.label;
      arrowLabel = DiagramLabel.pigouvianTaxEqualsExternalCost.label;

      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.675,
        xAxisEndPos: 0.31,
        yLabel: DiagramLabel.pc.label,
        hideXLine: true,
      );
    }
    if (bundle == DiagramEnum.microNegativeProductionExternalityRegulations) {
      supplyLabel = DiagramLabel.msc.label;
      arrowLabel = DiagramLabel.governmentRegulations.label;
    }
  }
  if (bundle == DiagramEnum.microCommonPoolResources) {
    arrowLabel = DiagramLabel.externalCostOfOverFishing.label;
  }
  paintLineSegment(
    c,
    canvas,
    origin: Offset(0.65, 0.315),
    angle: -pi / 2,
    length: 0.13,
    endStyle: lineEndStyle,
  );
  paintText2(
    c,
    canvas,
    arrowLabel,
    Offset(0.80, 0.50),
    pointerLine: Offset(0.65, 0.32),
  );
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.47,
    xAxisEndPos: 0.31,
    yLabel: yLabel,
    xLabel: DiagramLabel.qOpt.label,
  );
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.575,
    xAxisEndPos: 0.43,
    yLabel: DiagramLabel.pm.label,
    xLabel: DiagramLabel.qm.label,
  );

  paintDiagramLines(
    c,
    canvas,
    startPos: Offset(0, 0.20),
    polylineOffsets: [Offset(0.80, 0.90)],
    label2: DiagramLabel.dEqualsMPBMSB.label,
    label2Align: LabelAlign.centerRight,
  );

  paintDiagramLines(
    c,
    canvas,
    startPos: Offset(0, 0.90),
    polylineOffsets: [Offset(0.80, 0.30)],
    label2: DiagramLabel.mpc.label,
    label2Align: LabelAlign.centerRight,
  );
  paintDiagramLines(
    c,
    canvas,
    startPos: Offset(0, 0.68),
    polylineOffsets: [Offset(0.80, 0.11)],
    label2: supplyLabel,
    label2Align: LabelAlign.centerRight,
  );

  if (bundle == DiagramEnum.microNegativeProductionExternalityWelfare ||
      bundle == DiagramEnum.microNegativeProductionExternality ||
      bundle == DiagramEnum.microCommonPoolResources) {
    /// Welfare Loss
    paintShading(canvas, size, ShadeType.welfareLoss, [
      Offset(0.31, 0.465),
      Offset(0.435, 0.375),
      Offset(0.435, 0.58),
    ]);
    paintText2(
      c,
      canvas,
      DiagramLabel.welfareLoss.label,
      Offset(0.38, 0.20),
      pointerLine: Offset(0.38, 0.45),
    );
  }
  if (bundle == DiagramEnum.microNegativeProductionExternalityWelfare) {
    paintText2(c, canvas, DiagramLabel.a.label, Offset(0.10, 0.40));
    paintText2(c, canvas, DiagramLabel.b.label, Offset(0.10, 0.53));
    paintText2(c, canvas, DiagramLabel.c.label, Offset(0.28, 0.53));
    paintText2(c, canvas, DiagramLabel.d.label, Offset(0.34, 0.54));
    paintText2(c, canvas, DiagramLabel.e.label, Offset(0.38, 0.48));
    paintText2(c, canvas, DiagramLabel.f.label, Offset(0.05, 0.615));
    paintText2(c, canvas, DiagramLabel.g.label, Offset(0.10, 0.70));
    paintText2(c, canvas, DiagramLabel.h.label, Offset(0.34, 0.61));

    paintLegendTable(
      canvas,
      c,
      headers: [
        '',
        DiagramLabel.freeMarket.label,
        DiagramLabel.sociallyOptimumOutput.label,
      ],
      data: [
        [DiagramLabel.consumerSurplus.label, '+(A,B,C,D)', '+A'],
        [DiagramLabel.producerSurplus.label, '+(F,G,H)', '+(B,F)'],
        [DiagramLabel.externalCost.label, '-(C,D,G,H,E)', '-'],
        [DiagramLabel.socialWelfare.label, '+(A,B,F)-E', '+(A,B,F)'],
      ],
    );
  }
}

void _paintCarbonTax(DiagramPainterConfig c, Canvas canvas, Size size) {
  paintLineSegment(
    c,
    canvas,
    origin: Offset(0.55, 0.40),
    angle: -pi / 2,
    length: 0.25,
  );
  paintLineSegment(
    c,
    canvas,
    origin: Offset(0.65, 0.40),
    angle: -pi / 2,
    length: 0.10,
  );
  paintText2(
    c,
    canvas,
    'Reduced Carbon Tax\n'
    'Due To Lower External\nCost of Emissions',
    Offset(0.88, 0.55),
    pointerLine: Offset(0.65, 0.38),
  );
  paintText2(
    c,
    canvas,
    'Initial\nCarbon Tax',
    Offset(0.35, 0.20),
    pointerLine: Offset(0.55, 0.40),
  );

  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.44,
    xAxisEndPos: 0.275,
    yLabel: DiagramLabel.pc1.label,
    xLabel: '   Q\nopt1 ',
  );
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.52,
    xAxisEndPos: 0.37,
    yLabel: DiagramLabel.pc2.label,
    xLabel: '  Q\nopt2',
  );
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.605,
    xAxisEndPos: 0.465,
    yLabel: DiagramLabel.pm.label,
    xLabel: DiagramLabel.qm.label,
  );

  paintDiagramLines(
    c,
    canvas,
    startPos: Offset(0, 0.20),
    polylineOffsets: [Offset(0.80, 0.90)],
    label2: DiagramLabel.dEqualsMPBMSB.label,
    label2Align: LabelAlign.centerRight,
  );

  paintDiagramLines(
    c,
    canvas,
    startPos: Offset(0, 0.95),
    polylineOffsets: [Offset(0.80, 0.35)],
    label2: DiagramLabel.mpc.label,
    label2Align: LabelAlign.centerRight,
  );
  paintDiagramLines(
    c,
    canvas,
    startPos: Offset(0, 0.80),
    polylineOffsets: [Offset(0.80, 0.20)],
    label2: 'MSC2 after adopting\ncleaner energy sources',
    label2Align: LabelAlign.centerRight,
  );
  paintDiagramLines(
    c,
    canvas,
    startPos: Offset(0, 0.65),
    polylineOffsets: [Offset(0.80, 0.05)],
    label2: 'MSC1 with\ncarbon-intensive\nenergy sources',
    label2Align: LabelAlign.centerRight,
  );
}

void _paintTradablePermits(DiagramPainterConfig c, Canvas canvas, Size size) {
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.50,
    xAxisEndPos: 0.50,
    yLabel: DiagramLabel.p.label,
    xLabel: DiagramLabel.q.label,
  );
  paintDiagramLines(
    c,
    canvas,
    startPos: Offset(0.50, 1.0),
    polylineOffsets: [Offset(0.50, 0.15)],
    label2: DiagramLabel.supplyOfPermits.label,
    label2Align: LabelAlign.centerTop,
  );
  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.demand,
    label: DiagramLabel.demandForPermits.label,
  );
}

void _paintNegativeConsumption(
  DiagramPainterConfig c,
  Canvas canvas,
  Size size,
  DiagramEnum bundle,
) {
  if (bundle == DiagramEnum.microNegativeConsumptionExternality ||
      bundle == DiagramEnum.microNegativeConsumptionExternalityWelfare) {
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.61,
      xAxisEndPos: 0.325,
      yLabel: DiagramLabel.pOpt.label,
      xLabel: DiagramLabel.qOpt.label,
    );
    paintText2(
      c,
      canvas,
      DiagramLabel.welfareLoss.label,
      Offset(0.43, 0.35),
      pointerLine: Offset(0.43, 0.58),
    );

    paintShading(canvas, size, ShadeType.welfareLoss, [
      Offset(0.32, 0.61),
      Offset(0.465, 0.50),
      Offset(0.465, 0.71),
    ]);
    paintLineSegment(
      c,
      canvas,
      origin: Offset(0.65, 0.725),
      angle: -pi / 2,
      length: 0.15,
      endStyle: LineEndStyle.arrowBothEnds,
    );
    paintText2(
      c,
      canvas,
      DiagramLabel.externalCost.label,
      Offset(0.80, 0.60),
      pointerLine: Offset(0.65, 0.72),
    );
  }

  if (bundle != DiagramEnum.microNegativeConsumptionExternality &&
      bundle != DiagramEnum.microNegativeConsumptionExternalityWelfare) {
    paintLineSegment(c, canvas, origin: Offset(0.41, 1.09), angle: -pi);
  }

  if (bundle == DiagramEnum.microNegativeConsumptionExternalityPigouvianTax) {
    paintLineSegment(
      c,
      canvas,
      origin: Offset(0.60, 0.31),
      angle: -pi / 2,
      length: 0.14,
    );
    paintText2(
      c,
      canvas,
      DiagramLabel.pigouvianTaxEqualsExternalCost.label,
      Offset(0.78, 0.45),
      pointerLine: Offset(0.60, 0.30),
    );
    paintShading(canvas, size, ShadeType.governmentRevenue, [
      Offset(0, 0.405),
      Offset(0.325, 0.405),
      Offset(0.325, 0.615),
      Offset(0.0, 0.615),
    ], striped: true);
    paintText2(
      c,
      canvas,
      DiagramLabel.governmentTaxRevenue.label,
      Offset(0.28, 0.22),
      pointerLine: Offset(0.20, 0.45),
    );

    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.615,
      xAxisEndPos: 0.325,
      yLabel: DiagramLabel.pp.label,
      xLabel: DiagramLabel.qOpt.label,
      hideXLine: true,
    );
    paintDiagramLines(
      c,
      canvas,
      startPos: Offset(0, 0.63),
      polylineOffsets: [Offset(0.75, 0.10)],
      label2: 'MPC+Tax',
      label2Align: LabelAlign.centerRight,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.405,
      xAxisEndPos: 0.325,
      yLabel: DiagramLabel.pc.label,
    );
  }
  if (bundle == DiagramEnum.microNegativeConsumptionExternalityWelfare) {
    paintText2(c, canvas, DiagramLabel.a.label, Offset(0.15, 0.40));
    paintText2(c, canvas, DiagramLabel.b.label, Offset(0.03, 0.46));
    paintText2(c, canvas, DiagramLabel.c.label, Offset(0.15, 0.56));
    paintText2(c, canvas, DiagramLabel.d.label, Offset(0.32, 0.55));
    paintText2(c, canvas, DiagramLabel.e.label, Offset(0.10, 0.70));
    paintText2(c, canvas, DiagramLabel.f.label, Offset(0.40, 0.61));
    paintLegendTable(
      canvas,
      c,
      headers: [
        '',
        DiagramLabel.freeMarket.label,
        DiagramLabel.sociallyOptimumOutput.label,
      ],
      data: [
        [DiagramLabel.consumerSurplus.label, '+(A,B)', '+(B,C)'],
        [DiagramLabel.producerSurplus.label, '+(C,D,E)', '+E'],
        [DiagramLabel.externalCost.label, '-(A,D,F)', '-'],
        [DiagramLabel.socialWelfare.label, '+(B,C,E)-F', '+(B,C,E)'],
      ],
    );
  }
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.50,
    xAxisEndPos: 0.465,
    yLabel: DiagramLabel.pm.label,
    xLabel: DiagramLabel.qm.label,
  );

  paintDiagramLines(
    c,
    canvas,
    startPos: Offset(0, 0.20),
    polylineOffsets: [Offset(0.85, 0.75)],
    label2: DiagramLabel.dEqualsMPB.label,
    label2Align: LabelAlign.centerRight,
  );
  paintDiagramLines(
    c,
    canvas,
    startPos: Offset(0, 0.40),
    polylineOffsets: [Offset(0.75, 0.90)],
    label2: DiagramLabel.msb.label,
    label2Align: LabelAlign.centerRight,
  );
  paintDiagramLines(
    c,
    canvas,
    startPos: Offset(0, 0.85),
    polylineOffsets: [Offset(0.80, 0.25)],
    label2: DiagramLabel.sEqualsMPCMSC.label,
    label2Align: LabelAlign.centerRight,
  );
  if (bundle ==
          DiagramEnum.microNegativeConsumptionExternalityPublicAwareness ||
      bundle ==
          DiagramEnum
              .microNegativeConsumptionExternalityGovernmentRegulations) {
    String costLabel =
        'Rules & Regulations to\n'
        'Reduce Consumption\n'
        '= External Cost';
    if (bundle ==
        DiagramEnum.microNegativeConsumptionExternalityPublicAwareness) {
      costLabel = 'Public Awareness\nCampaign On Social\nCosts of Consumption';
    }
    paintLineSegment(c, canvas, origin: Offset(-0.125, 0.55), angle: pi / 2);
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.61,
      xAxisEndPos: 0.325,
      yLabel: DiagramLabel.pOpt.label,
      xLabel: DiagramLabel.qOpt.label,
    );
    paintText2(
      c,
      canvas,
      costLabel,
      Offset(0.80, 0.50),
      pointerLine: Offset(0.65, 0.70),
    );
    if (bundle ==
        DiagramEnum.microNegativeConsumptionExternalityPublicAwareness) {
      paintLineSegment(
        c,
        canvas,
        origin: Offset(0.65, 0.715),
        length: 0.15,
        angle: pi / 2,
      );
    }
  }
}

void _paintPositiveProduction(
  DiagramPainterConfig c,
  Canvas canvas,
  Size size,
  DiagramEnum bundle,
) {
  String mSCLabel = DiagramLabel.msc.label;
  if (bundle == DiagramEnum.microPositiveProductionExternalityWelfare ||
      bundle == DiagramEnum.microPositiveProductionExternality) {
    paintLineSegment(
      c,
      canvas,
      origin: Offset(0.65, 0.335),
      angle: pi / 2,
      length: 0.16,
      endStyle: LineEndStyle.arrow,
    );
    paintShading(canvas, size, ShadeType.welfareLoss, [
      Offset(0.40, 0.42),
      Offset(0.40, 0.635),
      Offset(0.54, 0.53),
    ]);
    paintText2(
      c,
      canvas,
      DiagramLabel.welfareLoss.label,
      Offset(0.46, 0.20),
      pointerLine: Offset(0.46, 0.50),
    );

    if (bundle == DiagramEnum.microPositiveProductionExternalityWelfare) {
      paintLegendTable(
        canvas,
        c,
        headers: [
          '',
          DiagramLabel.freeMarket.label,
          DiagramLabel.sociallyOptimumOutput.label,
        ],
        data: [
          [DiagramLabel.consumerSurplus.label, '+A', '+(A,B,C,D)'],
          [DiagramLabel.producerSurplus.label, '+(B,E)', '+(B,E)'],
          [DiagramLabel.externalBenefits.label, '+(F,C)', '-'],
          [
            DiagramLabel.socialWelfare.label,
            '+(A,B,E,F,C)',
            '+(A,B,C,D,E,F,G)',
          ],
          [DiagramLabel.welfareLoss.label, '-(D,G)', '-'],
        ],
      );

      paintText2(c, canvas, DiagramLabel.a.label, Offset(0.15, 0.32));
      paintText2(c, canvas, DiagramLabel.b.label, Offset(0.15, 0.47));
      paintText2(c, canvas, DiagramLabel.c.label, Offset(0.37, 0.49));
      paintText2(c, canvas, DiagramLabel.d.label, Offset(0.43, 0.49));
      paintText2(c, canvas, DiagramLabel.e.label, Offset(0.08, 0.60));
      paintText2(c, canvas, DiagramLabel.f.label, Offset(0.26, 0.65));
      paintText2(c, canvas, DiagramLabel.g.label, Offset(0.43, 0.56));
    }
  }

  String arrowLabel = DiagramLabel.externalBenefits.label;
  if (bundle == DiagramEnum.microPositiveProductionExternalitySubsidy ||
      bundle == DiagramEnum.microPositiveProductionExternalityDirectProvision) {
    paintLineSegment(
      c,
      canvas,
      origin: Offset(-0.14, 0.47),
      angle: pi / 2,
      length: 0.09,
      endStyle: LineEndStyle.arrow,
    );
    paintLineSegment(
      c,
      canvas,
      origin: Offset(0.46, 1.10),
      angle: -pi / 0.50,
      length: 0.09,
      endStyle: LineEndStyle.arrow,
    );

    paintLineSegment(
      c,
      canvas,
      origin: Offset(0.65, 0.32),
      angle: pi / 2,
      length: 0.18,
      endStyle: LineEndStyle.arrow,
    );

    if (bundle == DiagramEnum.microPositiveProductionExternalitySubsidy) {
      mSCLabel = DiagramLabel.mscEqualsMPCPlusSubsidy.label;
      arrowLabel = DiagramLabel.subsidyEqualExternalBenefits.label;
    }
    if (bundle ==
        DiagramEnum.microPositiveProductionExternalityDirectProvision) {
      mSCLabel = DiagramLabel.mscEqualsMPCPlusGovernmentProvision.label;
      arrowLabel = DiagramLabel.governmentDirectProvision.label;
    }
  }
  paintText2(
    c,
    canvas,
    arrowLabel,
    Offset(0.90, 0.45),
    pointerLine: Offset(0.65, 0.33),
  );

  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.63,
    xAxisEndPos: 0.40,
    xLabel: DiagramLabel.qm.label,
    hideXLine: true,
    hideYLine: true,
  );
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.42,
    xAxisEndPos: 0.40,
    hideXLine: true,
    yLabel: DiagramLabel.pm.label,
  );
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.42,
    xAxisEndPos: 0.40,
    hideYLine: true,
  );
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.53,
    xAxisEndPos: 0.535,
    yLabel: DiagramLabel.pOpt.label,
    xLabel: DiagramLabel.qOpt.label,
  );
  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.demand,
    label: DiagramLabel.dEqualsMPBMSB.label,
    horizontalShift: -0.06,
    verticalShift: -kExtendBy5,
    lengthAdjustment: 0,
    angle: -0.10,
  );
  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.supply,
    label: DiagramLabel.sEqualsMPC.label,
    angle: 0.12,
    horizontalShift: -0.10,
    verticalShift: -0.080,
    lengthAdjustment: -kExtendBy10,
  );
  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.supply,
    label: mSCLabel,
    angle: 0.12,
    horizontalShift: -0.05,
    verticalShift: kExtendBy10,
  );
}

void _paintPositiveConsumption(
  DiagramPainterConfig c,
  Canvas canvas,
  Size size,
  DiagramEnum bundle,
) {
  if (bundle == DiagramEnum.microPositiveConsumptionExternality ||
      bundle == DiagramEnum.microPositiveConsumptionExternalityWelfare) {
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.39,
      xAxisEndPos: 0.285,
      hideYLine: true,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.59,
      xAxisEndPos: 0.285,
      yLabel: DiagramLabel.pm.label,
      xLabel: DiagramLabel.qm.label,
      hideXLine: true,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.495,
      xAxisEndPos: 0.45,
      yLabel: DiagramLabel.pOpt.label,
      xLabel: DiagramLabel.qOpt.label,
    );
    paintLineSegment(
      c,
      canvas,
      origin: Offset(0.68, 0.745),
      angle: -pi / 2,
      length: 0.155,
      endStyle: LineEndStyle.arrowBothEnds,
    );
    paintText2(
      c,
      canvas,
      DiagramLabel.externalBenefits.label,
      Offset(0.75, 0.55),
      pointerLine: Offset(0.68, 0.75),
    );

    paintShading(canvas, size, ShadeType.welfareLoss, [
      Offset(0.285, 0.39),
      Offset(0.285, 0.585),
      Offset(0.455, 0.50),
    ]);
    paintText2(
      c,
      canvas,
      DiagramLabel.welfareLoss.label,
      Offset(0.40, 0.32),
      pointerLine: Offset(0.35, 0.48),
    );
    if (bundle == DiagramEnum.microPositiveConsumptionExternalityWelfare) {
      paintText2(c, canvas, DiagramLabel.a.label, Offset(0.10, 0.35));
      paintText2(c, canvas, DiagramLabel.b.label, Offset(0.04, 0.46));
      paintText2(c, canvas, DiagramLabel.c.label, Offset(0.33, 0.45));
      paintText2(c, canvas, DiagramLabel.d.label, Offset(0.10, 0.55));
      paintText2(c, canvas, DiagramLabel.e.label, Offset(0.26, 0.53));
      paintText2(c, canvas, DiagramLabel.f.label, Offset(0.33, 0.53));
      paintText2(c, canvas, DiagramLabel.g.label, Offset(0.10, 0.65));

      paintLegendTable(
        canvas,
        c,
        headers: [
          '',
          DiagramLabel.freeMarket.label,
          DiagramLabel.sociallyOptimumOutput.label,
        ],
        data: [
          [DiagramLabel.consumerSurplus.label, '+(B,D)', '+(A,B,C)'],
          [DiagramLabel.producerSurplus.label, '+(G)', '+(D,E,F,G)'],
          [DiagramLabel.externalBenefits.label, '+(A,E)', '-'],
          [
            DiagramLabel.socialWelfare.label,
            '+(A,B,D,E,G)',
            '+(A,B,C,D,E,F,G)',
          ],
          [DiagramLabel.welfareLoss.label, '-(C,F)', '-'],
        ],
      );
    }
  }

  paintDiagramLines(
    c,
    canvas,
    startPos: Offset(0, 0.20),
    polylineOffsets: [Offset(0.85, 0.75)],
    label2: DiagramLabel.msb.label,
    label2Align: LabelAlign.centerRight,
  );
  paintDiagramLines(
    c,
    canvas,
    startPos: Offset(0, 0.40),
    polylineOffsets: [Offset(0.75, 0.90)],
    label2: DiagramLabel.dEqualsMPB.label,
    label2Align: LabelAlign.centerRight,
  );
  paintDiagramLines(
    c,
    canvas,
    startPos: Offset(0, 0.75),
    polylineOffsets: [Offset(0.80, 0.30)],
    label2: DiagramLabel.sEqualsMPCMSC.label,
    label2Align: LabelAlign.centerRight,
  );
  if (bundle == DiagramEnum.microPositiveConsumptionExternalitySubsidy ||
      bundle ==
          DiagramEnum.microPositiveConsumptionExternalityDirectProvision ||
      bundle == DiagramEnum.microPositiveConsumptionExternalityAdvertising) {
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.59,
      xAxisEndPos: 0.285,
      yLabel: DiagramLabel.pm.label,
      xLabel: DiagramLabel.qm.label,
      showDotAtIntersection: true,
    );
  }
  if (bundle == DiagramEnum.microPositiveConsumptionExternalitySubsidy) {
    paintLineSegment(c, canvas, origin: Offset(0.365, 1.08), length: 0.16);

    paintText2(
      c,
      canvas,
      DiagramLabel.subsidyEqualExternalBenefits.label,
      Offset(0.50, 0.30),
      pointerLine: Offset(0.70, 0.45),
    );
    paintLineSegment(
      c,
      canvas,
      origin: Offset(0.70, 0.445),
      length: 0.16,
      angle: pi / 2,
    );
    paintDiagramLines(
      c,
      canvas,
      startPos: Offset(0, 0.95),
      polylineOffsets: [Offset(0.80, 0.50)],
      label2: DiagramLabel.mPCPlusSubsidy.label,
      label2Align: LabelAlign.centerRight,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.70,
      xAxisEndPos: 0.45,
      yLabel: DiagramLabel.pc.label,
      hideXLine: true,
      showDotAtIntersection: true,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.495,
      xAxisEndPos: 0.455,
      yLabel: DiagramLabel.pp.label,
      xLabel: DiagramLabel.qOpt.label,
    );
  }
  if (bundle == DiagramEnum.microPositiveConsumptionExternalityAdvertising) {
    paintLineSegment(c, canvas, origin: Offset(0.60, 0.70), length: 0.18);
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.495,
      xAxisEndPos: 0.455,
      showDotAtIntersection: true,
      yLabel: DiagramLabel.pOpt.label,
      xLabel: DiagramLabel.qOpt.label,
    );
  }

  if (bundle ==
      DiagramEnum.microPositiveConsumptionExternalityDirectProvision) {
    paintDiagramLines(
      c,
      canvas,
      startPos: Offset(0, 0.95),
      polylineOffsets: [Offset(0.80, 0.50)],
      label2: DiagramLabel.mPCPlusSubsidy.label,
      label2Align: LabelAlign.centerRight,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.49,
      xAxisEndPos: 0.46,
      yLabel: DiagramLabel.pp.label,
      xLabel: DiagramLabel.qOpt.label,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.70,
      xAxisEndPos: 0.46,
      hideXLine: true,
      yLabel: DiagramLabel.pc.label,
      showDotAtIntersection: true,
    );
  }
}
