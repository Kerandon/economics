import 'dart:math';
import 'package:economics_app/diagrams/custom_paint/painter_constants.dart';

import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/paint_axis.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/diagram_lines/paint_diagram_lines.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_diagram_dash_lines.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_line_segment_MAKEREDUNDANT.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_text.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/shortcut_methods/paint_market_curve.dart';
import 'package:economics_app/diagrams/custom_paint/shade/paint_shading.dart';
import 'package:economics_app/diagrams/custom_paint/shade/shade_type.dart';
import 'package:economics_app/diagrams/enums/diagram_enum.dart';
import 'package:economics_app/diagrams/enums/diagram_labels.dart';
import 'package:flutter/material.dart';

import '../../models/base_painter_painter.dart';
import '../../models/diagram_painter_config.dart';
import '../i_diagram_canvas.dart';

class CompetitiveMarket extends BaseDiagramPainter {
  CompetitiveMarket(super.config, super.diagram);

  @override
  void drawDiagram(
    IDiagramCanvas canvas,
    Size size, {
    IDiagramCanvas? iCanvas,
  }) {
    final c = config.copyWith(painterSize: size);

    // 1. Initial Axis logic
    if (diagram != DiagramEnum.microMarginalBenefit) {
      paintAxis(c, canvas);
    }

    // 2. Base Equilibrium (Shared across several diagrams)
    if (diagram == DiagramEnum.microShortage ||
        diagram == DiagramEnum.microSurplus ||
        diagram == DiagramEnum.microMarketEquilibrium) {
      if (diagram == DiagramEnum.microShortage) {
        paintLineSegment(
          c,
          canvas,
          origin: Offset(0.5, 1.12),
          length: 0.40,
          endStyle: LineEndStyle.arrowRightAngles,
          label: DiagramLabel.shortage.label,
          labelAlign: LabelAlign.centerBottom,
        );
      }
      if (diagram == DiagramEnum.microSurplus) {
        paintLineSegment(
          c,
          canvas,
          origin: Offset(0.5, 1.12),
          length: 0.40,
          endStyle: LineEndStyle.arrowRightAngles,
          label: DiagramLabel.surplus.label,
          labelAlign: LabelAlign.centerBottom,
        );
      }
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
      paintDiagramDashedLines(
        c,
        canvas,

        yAxisStartPos: 0.50,
        xAxisEndPos: 0.50,
        yLabel: DiagramLabel.pE.label,
        xLabel: DiagramLabel.qE.label,
        showDotAtIntersection: true,
      );
    }

    // 3. Diagram Specific Logic
    switch (diagram) {
      case DiagramEnum.microShortage || DiagramEnum.microSurplus:
        _paintShortageOrSurplus(c, canvas, size, diagram);
      case DiagramEnum.microDemandIncreasePriceMechanism ||
          DiagramEnum.microDemandDecreasePriceMechanism ||
          DiagramEnum.microPriceRationing:
        _paintIncreaseOrDecreaseInDemand(c, canvas, size, diagram);
      case DiagramEnum.microMarginalBenefit ||
          DiagramEnum.microMarginalCostSteps:
        _paintMarginalBenefitAndMarginalCostSteps(c, canvas, size, diagram);
      case DiagramEnum.microConsumerSurplus ||
          DiagramEnum.microProducerSurplus ||
          DiagramEnum.microAllocativeEfficiency:
        _paintConsumerProducerSurplusAllocativeEfficiency(
          c,
          canvas,
          size,
          diagram,
        );
      default:
    }
  }
}

void _paintShortageOrSurplus(
  DiagramPainterConfig c,
  IDiagramCanvas canvas,
  Size size,
  DiagramEnum bundle,
) {
  bool isShortage = bundle == DiagramEnum.microShortage;

  double yPos = isShortage ? 0.70 : 0.30;

  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: yPos,
    xAxisEndPos: 0.70,
    yLabel: DiagramLabel.pm.label,
    xLabel: isShortage ? DiagramLabel.qD.label : DiagramLabel.qS.label,
    showDotAtIntersection: true,
  );
  paintDiagramDashedLines(
    c,
    canvas,

    yAxisStartPos: yPos,
    xAxisEndPos: 0.30,
    xLabel: isShortage ? DiagramLabel.qS.label : DiagramLabel.qD.label,
    showDotAtIntersection: true,
  );
}

void _paintIncreaseOrDecreaseInDemand(
  DiagramPainterConfig c,
  IDiagramCanvas canvas,
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

  // D2
  paintMarketCurve(
    c,
    canvas,

    type: MarketCurveType.demand,
    horizontalShift: 0.15,
    lengthAdjustment: -0.15,
    label: increaseInDemand ? DiagramLabel.d2.label : DiagramLabel.d1.label,
  );

  // D1
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
    paintDiagramLines(
      c,
      canvas,
      startPos: Offset(0.45, 0.58),
      polylineOffsets: [Offset(0.70, 0.58)],
      color: Colors.red,
    );
    paintLineSegment(
      c,
      canvas,
      origin: Offset(0.575, 1.12),
      length: 0.30,
      endStyle: LineEndStyle.arrowRightAngles,
      label: DiagramLabel.shortage.label,
      labelAlign: LabelAlign.centerBottom,
    );
    // Tracing points for Increase
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

    paintLineSegment(
      c,
      canvas,

      origin: const Offset(0.69, 0.48),
      angle: -pi / 1.33,
    ); // Extension arrow

    if (increaseInDemand) {
      paintLineSegment(
        c,
        canvas,

        origin: const Offset(0.45, 0.50),
        angle: -pi / 4,
      ); // Contraction arrow
    }
  }

  if (bundle == DiagramEnum.microDemandDecreasePriceMechanism) {
    paintDiagramLines(
      c,
      canvas,
      startPos: Offset(0.30, 0.425),
      polylineOffsets: [Offset(0.56, 0.425)],
      color: Colors.red,
    );
    paintLineSegment(
      c,
      canvas,
      origin: Offset(0.42, 1.12),
      length: 0.30,
      endStyle: LineEndStyle.arrowRightAngles,
      label: DiagramLabel.surplus.label,
      labelAlign: LabelAlign.centerBottom,
    );
    paintLineSegment(
      c,
      canvas,

      origin: const Offset(0.31, 0.50),
      angle: pi * 0.25,
    ); //
    paintLineSegment(
      c,
      canvas,

      origin: const Offset(0.54, 0.51),
      angle: pi * 0.75,
    ); //
    // Tracing points for Decrease
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
  }
}

void _paintMarginalBenefitAndMarginalCostSteps(
  DiagramPainterConfig c,
  IDiagramCanvas canvas,
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

  bool isBenefit = bundle == DiagramEnum.microMarginalBenefit;

  // Optimization: Loop for grid numbers to reduce code wall
  for (int i = 0; i < 10; i++) {
    double val = isBenefit ? (90.0 - i * 10) : (i * 10.0);
    double pos = 0.05 + i * 0.10;
    paintText(
      c,
      canvas,
      val.toInt().toString(),
      Offset(pos, isBenefit ? pos : (1.0 - pos)),
    );
  }

  // Step paths
  List<Offset> steps = [];
  if (isBenefit) {
    for (double i = 0; i <= 0.9; i += 0.1) {
      steps.add(Offset(i, i + 0.1));
      steps.add(Offset(i + 0.1, i + 0.1));
    }
  } else {
    for (double i = 0.0; i <= 0.9; i += 0.1) {
      steps.add(Offset(i, 1.0 - i));
      steps.add(Offset(i + 0.1, 1.0 - i));
    }
  }

  paintDiagramLines(
    c,
    canvas,

    color: isBenefit ? c.colorScheme.primary : Colors.deepOrange,
    startPos: isBenefit ? const Offset(0, 0.10) : const Offset(0, 1.0),
    polylineOffsets: steps,
  );

  paintText(
    c,
    canvas,
    isBenefit
        ? 'The Law Of Diminishing\nMarginal Utility\nleads to falling MB'
        : 'The Law Of Diminishing\nMarginal Returns\nleads to rising MC',
    Offset(isBenefit ? 0.72 : 0.36, 0.20),
  );
}

void _paintConsumerProducerSurplusAllocativeEfficiency(
  DiagramPainterConfig c,
  IDiagramCanvas canvas,

  Size size,
  DiagramEnum bundle,
) {
  // Demand (MB)
  paintDiagramLines(
    c,
    canvas,
    startPos: const Offset(0.0, 0.10),
    polylineOffsets: [const Offset(0.90, 0.90)],
    label2: DiagramLabel.dEqualsMB.label,
    label2Align: LabelAlign.centerRight,
  );

  // Supply (MC)
  paintDiagramLines(
    c,
    canvas,

    startPos: const Offset(0.0, 0.90),
    polylineOffsets: [const Offset(0.90, 0.10)],
    label2: DiagramLabel.sEqualsMC.label,
    label2Align: LabelAlign.centerRight,
  );

  if (bundle == DiagramEnum.microConsumerSurplus ||
      bundle == DiagramEnum.microAllocativeEfficiency) {
    paintShading(c, canvas, ShadeType.consumerSurplus, [
      const Offset(0, 0.10),
      const Offset(0.45, 0.50),
      const Offset(0, 0.50),
    ]);
    paintText(
      c,
      canvas,
      DiagramLabel.consumerSurplus.label,
      const Offset(0.30, 0.15),
      pointerLine: const Offset(0.20, 0.40),
    );
  }

  if (bundle == DiagramEnum.microProducerSurplus ||
      bundle == DiagramEnum.microAllocativeEfficiency) {
    paintShading(c, canvas, ShadeType.producerSurplus, [
      const Offset(0, 0.50),
      const Offset(0.45, 0.50),
      const Offset(0, 0.90),
    ]);
    paintText(
      c,
      canvas,
      DiagramLabel.producerSurplus.label,
      const Offset(0.25, 0.90),
      pointerLine: const Offset(0.20, 0.60),
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
