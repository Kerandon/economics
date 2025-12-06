import 'dart:math';
import 'package:economics_app/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/grid_lines/grid_line_style.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/label_align.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/paint_axis.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/diagram_lines/paint_diagram_lines.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_diagram_dash_lines.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_line_segment.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_text_2.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/shortcut_methods/paint_market_curve.dart';
import 'package:economics_app/diagrams/custom_paint/shade/paint_shading.dart';
import 'package:economics_app/diagrams/custom_paint/shade/shade_type.dart';
import 'package:economics_app/diagrams/enums/diagram_bundle_enum.dart';
import 'package:economics_app/diagrams/enums/diagram_labels.dart';
import 'package:flutter/material.dart';

import '../../models/base_painter_painter.dart';
import '../../models/diagram_painter_config.dart';

class CompetitiveMarket extends BaseDiagramPainter2 {
  CompetitiveMarket(super.config, super.bundle);

  @override
  void paint(Canvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);
    if (bundle != DiagramEnum.microMarginalBenefit) {
      paintAxis(c, canvas);
    }

    if (bundle == DiagramEnum.microShortage ||
        bundle == DiagramEnum.microSurplus ||
        bundle == DiagramEnum.microMarketEquilibrium) {
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.50,
        xAxisEndPos: 0.50,
        yLabel: DiagramLabel.pE.label,
        xLabel: DiagramLabel.qE.label,
      );
      paintMarketCurve(
        c,
        canvas,
        type: MarketCurveType.demand,
        lengthAdjustment: 0.20,
      );
      paintMarketCurve(
        c,
        canvas,
        type: MarketCurveType.supply,
        lengthAdjustment: 0.20,
      );
    }

    switch (bundle) {
      case DiagramEnum.microShortage || DiagramEnum.microSurplus:
        _paintShortageOrSurplus(c, canvas, size, bundle);
      case DiagramEnum.microDemandIncreasePriceMechanism ||
          DiagramEnum.microDemandDecreasePriceMechanism ||
          DiagramEnum.microPriceRationing:
        _paintIncreaseOrDecreaseInDemand(c, canvas, size, bundle);
      case DiagramEnum.microMarginalBenefit ||
          DiagramEnum.microMarginalCostSteps:
        _paintMarginalBenefitAndMarginalCostSteps(c, canvas, size, bundle);
      case DiagramEnum.microConsumerSurplus ||
          DiagramEnum.microProducerSurplus ||
          DiagramEnum.microAllocativeEfficiency:
        _paintConsumerProducerSurplusAllocativeEfficiency(
          c,
          canvas,
          size,
          bundle,
        );

      default:
    }
  }
}

void _paintShortageOrSurplus(
  DiagramPainterConfig c,
  Canvas canvas,
  Size size,
  DiagramEnum bundle,
) {
  if (bundle == DiagramEnum.microShortage) {
    paintLineSegment(
      c,
      canvas,
      origin: Offset(0.50, 1.1),
      endStyle: LineEndStyle.arrowRightAngles,
      length: 0.40,
      label: DiagramLabel.shortageQdMinusQs.label,
      labelAlign: LabelAlign.centerBottom,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.70,
      xAxisEndPos: 0.70,
      yLabel: DiagramLabel.pm.label,
      xLabel: DiagramLabel.qD.label,
      showDotAtIntersection: true,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.70,
      xAxisEndPos: 0.30,
      xLabel: DiagramLabel.qS.label,
      showDotAtIntersection: true,
    );
  }
  if (bundle == DiagramEnum.microSurplus) {
    paintLineSegment(
      c,
      canvas,
      origin: Offset(0.50, 1.1),
      endStyle: LineEndStyle.arrowRightAngles,
      length: 0.40,
      label: DiagramLabel.surplusQsMinusQd.label,
      labelAlign: LabelAlign.centerBottom,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.30,
      xAxisEndPos: 0.30,
      yLabel: DiagramLabel.pm.label,
      xLabel: DiagramLabel.qD.label,
      showDotAtIntersection: true,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.30,
      xAxisEndPos: 0.70,
      xLabel: DiagramLabel.qS.label,
      showDotAtIntersection: true,
    );
  }
}

void _paintIncreaseOrDecreaseInDemand(
  DiagramPainterConfig c,
  Canvas canvas,
  Size size,
  DiagramEnum bundle,
) {
  final increaseInDemand =
      bundle == DiagramEnum.microDemandIncreasePriceMechanism;

  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.supply,
    lengthAdjustment: -0.15,
  );
  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.demand,
    horizontalShift: 0.15,
    lengthAdjustment: -0.15,
    label: increaseInDemand ? DiagramLabel.d2.label : DiagramLabel.d1.label,
  );
  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.demand,
    horizontalShift: -0.15,
    lengthAdjustment: -0.15,
    label: increaseInDemand ? DiagramLabel.d1.label : DiagramLabel.d2.label,
  );
  if (bundle == DiagramEnum.microDemandIncreasePriceMechanism ||
      bundle == DiagramEnum.microPriceRationing) {
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.575,
      xAxisEndPos: 0.425,
      hideYLine: true,
      xLabel: DiagramLabel.q1.label,
      showDotAtIntersection: true,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.575,
      xAxisEndPos: 0.725,
      yLabel: DiagramLabel.p1.label,
      xLabel: DiagramLabel.q3.label,
      showDotAtIntersection: true,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.425,
      xAxisEndPos: 0.575,
      yLabel: DiagramLabel.p2.label,
      xLabel: DiagramLabel.q2.label,
      showDotAtIntersection: true,
    );
    paintLineSegment(c, canvas, origin: Offset(0.69, 0.50), angle: -pi / 1.33);
    paintLineSegment(c, canvas, origin: Offset(-0.10, 0.50), angle: -pi / 2);
    if (increaseInDemand) {
      paintText2(
        c,
        canvas,
        'Price signals (↑)\nQd contracts, Qs Extends',
        Offset(0.90, 0.40),
      );

      paintLineSegment(c, canvas, origin: Offset(0.46, 0.50), angle: -pi / 4);

      paintLineSegment(c, canvas, origin: Offset(0.50, 1.08));

      if (increaseInDemand) {
        paintDiagramLines(
          c,
          canvas,
          startPos: Offset(0.435, 0.575),
          polylineOffsets: [Offset(0.715, 0.575)],
          color: Colors.red,
        );
      }
    }
    if (bundle == DiagramEnum.microPriceRationing) {
      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0.58, 0.43),
        polylineOffsets: [Offset(0.72, 0.57)],
        color: Colors.red,
      );
      paintText2(
        c,
        canvas,
        'Price\nRationing',
        Offset(0.85, 0.50),
        pointerLine: Offset(0.69, 0.50),
      );
    }
    paintLineSegment(
      c,
      canvas,
      origin: Offset(0.575, 1.12),
      label: 'Shortage at P1',
      labelAlign: LabelAlign.centerBottom,
      length: 0.30,
      endStyle: LineEndStyle.arrowRightAngles,
    );
  }
  if (bundle == DiagramEnum.microDemandDecreasePriceMechanism) {
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.575,
      xAxisEndPos: 0.425,
      yLabel: DiagramLabel.p2.label,
      xLabel: DiagramLabel.q2.label,
      showDotAtIntersection: true,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.425,
      xAxisEndPos: 0.575,
      yLabel: DiagramLabel.p1.label,
      xLabel: DiagramLabel.q3.label,

      showDotAtIntersection: true,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.425,
      xAxisEndPos: 0.275,
      hideYLine: true,
      xLabel: DiagramLabel.q1.label,
      showDotAtIntersection: true,
    );
    paintLineSegment(
      c,
      canvas,
      origin: Offset(0.425, 1.12),
      label: 'Surplus at P1',
      labelAlign: LabelAlign.centerBottom,
      length: 0.30,
      endStyle: LineEndStyle.arrowRightAngles,
    );
    paintLineSegment(c, canvas, origin: Offset(0.515, 0.52), angle: pi / 1.33);
    paintLineSegment(c, canvas, origin: Offset(0.325, 0.515), angle: pi / 4);
    paintText2(
      c,
      canvas,
      'Price signals (↓)\nQd extends, Qs contracts',
      Offset(0.90, 0.40),
    );
    paintLineSegment(c, canvas, origin: Offset(0.51, 1.08), angle: -pi);
    paintDiagramLines(
      c,
      canvas,
      startPos: Offset(0.285, 0.425),
      polylineOffsets: [Offset(0.565, 0.425)],
      color: Colors.red,
    );
    paintLineSegment(c, canvas, origin: Offset(-0.10, 0.49), angle: pi / 2);
  }
}

void _paintMarginalBenefitAndMarginalCostSteps(
  DiagramPainterConfig c,
  Canvas canvas,
  Size size,
  DiagramEnum bundle,
) {
  paintAxis(
    c,
    canvas,
    drawGridlines: true,
    gridLineStyle: GridLineStyle.indents,
    yMaxValue: 100,
    xMaxValue: 10,
    xDivisions: 10,
    yDivisions: 10,
  );
  if (bundle == DiagramEnum.microMarginalBenefit) {
    paintText2(c, canvas, '90', Offset(0.05, 0.05));
    paintText2(c, canvas, '80', Offset(0.15, 0.15));
    paintText2(c, canvas, '70', Offset(0.25, 0.25));
    paintText2(c, canvas, '60', Offset(0.35, 0.35));
    paintText2(c, canvas, '50', Offset(0.45, 0.45));
    paintText2(c, canvas, '40', Offset(0.55, 0.55));
    paintText2(c, canvas, '30', Offset(0.65, 0.65));
    paintText2(c, canvas, '20', Offset(0.75, 0.75));
    paintText2(c, canvas, '10', Offset(0.85, 0.85));
    paintText2(c, canvas, '0', Offset(0.95, 0.95));

    paintDiagramLines(
      c,
      canvas,
      startPos: Offset(0, 0.10),
      polylineOffsets: [
        Offset(0.10, 0.10),
        Offset(0.10, 0.20),
        Offset(0.20, 0.20),
        Offset(0.20, 0.30),
        Offset(0.30, 0.30),
        Offset(0.30, 0.40),
        Offset(0.40, 0.40),
        Offset(0.40, 0.50),
        Offset(0.50, 0.50),
        Offset(0.50, 0.60),
        Offset(0.60, 0.60),
        Offset(0.60, 0.70),
        Offset(0.70, 0.70),
        Offset(0.70, 0.80),
        Offset(0.80, 0.80),
        Offset(0.80, 0.90),
        Offset(0.90, 0.90),
        Offset(0.90, 1.0),
        Offset(1.0, 1.0),
      ],
    );
    paintLineSegment(
      c,
      canvas,
      origin: Offset(0.56, 0.42),
      angle: pi / 4,
      length: 1.1,
    );
    paintText2(
      c,
      canvas,
      'The Law Of Diminishing\nMarginal Utility\nleads to falling MB',
      Offset(0.72, 0.20),
    );
  }
  if (bundle == DiagramEnum.microMarginalCostSteps) {
    paintText2(c, canvas, '0', Offset(0.05, 0.95));
    paintText2(c, canvas, '10', Offset(0.15, 0.85));
    paintText2(c, canvas, '20', Offset(0.25, 0.75));
    paintText2(c, canvas, '30', Offset(0.35, 0.65));
    paintText2(c, canvas, '40', Offset(0.45, 0.55));
    paintText2(c, canvas, '50', Offset(0.55, 0.45));
    paintText2(c, canvas, '60', Offset(0.65, 0.35));
    paintText2(c, canvas, '70', Offset(0.75, 0.25));
    paintText2(c, canvas, '80', Offset(0.85, 0.15));
    paintText2(c, canvas, '90', Offset(0.95, 0.05));
    paintDiagramLines(
      color: Colors.deepOrange,
      c,
      canvas,
      startPos: Offset(0.0, 1.0),
      polylineOffsets: [
        Offset(0.10, 1.0), // horizontal flat
        Offset(0.10, 0.90), // down
        Offset(0.20, 0.90), // horizontal
        Offset(0.20, 0.80), // down
        Offset(0.30, 0.80),
        Offset(0.30, 0.70),
        Offset(0.40, 0.70),
        Offset(0.40, 0.60),
        Offset(0.50, 0.60),
        Offset(0.50, 0.50),
        Offset(0.60, 0.50),
        Offset(0.60, 0.40),
        Offset(0.70, 0.40),
        Offset(0.70, 0.30),
        Offset(0.80, 0.30),
        Offset(0.80, 0.20),
        Offset(0.90, 0.20),
        Offset(0.90, 0.10),
        Offset(1.0, 0.10), // reach right edge
      ],
    );

    paintLineSegment(
      c,
      canvas,
      origin: Offset(0.42, 0.46),
      angle: pi * -0.25,
      length: 1.1,
    );
    paintText2(
      c,
      canvas,
      'The Law Of Diminishing\nMarginal Returns\nleads to rising MC',
      Offset(0.36, 0.20),
    );
  }
}

void _paintConsumerProducerSurplusAllocativeEfficiency(
  DiagramPainterConfig c,
  Canvas canvas,
  Size size,
  DiagramEnum bundle,
) {
  paintDiagramLines(
    c,
    canvas,
    startPos: Offset(0.0, 0.10),
    polylineOffsets: [Offset(0.90, 0.90)],
    label2: DiagramLabel.dEqualsMB.label,
    label2Align: LabelAlign.centerRight,
  );
  paintDiagramLines(
    c,
    canvas,
    startPos: Offset(0.0, 0.90),
    polylineOffsets: [Offset(0.90, 0.10)],
    label2: DiagramLabel.sEqualsMC.label,
    label2Align: LabelAlign.centerRight,
  );
  if (bundle == DiagramEnum.microConsumerSurplus ||
      bundle == DiagramEnum.microAllocativeEfficiency) {
    paintShading(canvas, size, ShadeType.consumerSurplus, [
      Offset(0, 0.10),
      Offset(0.45, 0.50),
      Offset(0, 0.50),
    ]);
    paintText2(
      c,
      canvas,
      DiagramLabel.consumerSurplus.label,
      Offset(0.30, 0.15),
      pointerLine: Offset(0.20, 0.40),
    );
  }
  if (bundle == DiagramEnum.microProducerSurplus ||
      bundle == DiagramEnum.microAllocativeEfficiency) {
    paintShading(canvas, size, ShadeType.producerSurplus, [
      Offset(0, 0.50),
      Offset(0.45, 0.50),
      Offset(0, 0.90),
    ]);
    paintText2(
      c,
      canvas,
      DiagramLabel.producerSurplus.label,
      Offset(0.25, 0.90),
      pointerLine: Offset(0.20, 0.60),
    );
  }
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.50,
    xAxisEndPos: 0.45,
    yLabel: DiagramLabel.pE.label,
    xLabel: DiagramLabel.qE.label,
  );
}
