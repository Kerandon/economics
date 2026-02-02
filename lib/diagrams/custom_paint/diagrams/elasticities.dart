import 'dart:math';

import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_line_segment_MAKEREDUNDANT.dart';
import 'package:flutter/material.dart';

import '../../enums/diagram_enum.dart';
import '../../enums/diagram_labels.dart';
import '../../models/base_painter_painter.dart';
import '../../models/custom_bezier.dart';
import '../../models/diagram_painter_config.dart';
import '../i_diagram_canvas.dart';
import '../painter_constants.dart';
import '../painter_methods/axis/paint_axis.dart';
import '../painter_methods/diagram_lines/paint_diagram_lines.dart';
import '../painter_methods/paint_diagram_dash_lines.dart';
import '../painter_methods/paint_dot.dart';
import '../painter_methods/paint_text.dart' show paintText;
import '../painter_methods/shortcut_methods/paint_market_curve.dart';
import '../shade/paint_shading.dart';
import '../shade/shade_type.dart';

const double marketCurveLengthAdjustment = -0.10;

class Elasticities extends BaseDiagramPainter {
  Elasticities(super.config, super.diagram);

  @override
  void drawDiagram(IDiagramCanvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);

    String yLabel = DiagramLabel.p.label;
    if (diagram == DiagramEnum.microDemandEngelCurve) {
      yLabel = DiagramLabel.y.label;
    } else if (diagram == DiagramEnum.microDemandElasticityRevenueChange) {
      yLabel = DiagramLabel.revenue.label;
    }

    paintAxis(c, canvas, yAxisLabel: yLabel, xAxisLabel: DiagramLabel.q.label);

    switch (diagram) {
      case DiagramEnum.microDemandElastic:
      case DiagramEnum.microDemandElasticRevenue:
        _paintElasticDemand(c, canvas, size);
      case DiagramEnum.microDemandInelastic:
      case DiagramEnum.microDemandInelasticRevenue:
        _paintInelasticDemand(c, canvas, size);
      case DiagramEnum.microDemandUnitElastic:
        _paintUnitElastic(c, canvas);
      case DiagramEnum.microDemandPerfectlyElastic:
        _paintDemandPerfectlyElastic(c, canvas);
      case DiagramEnum.microDemandPerfectlyInelastic:
        _paintDemandPerfectlyInelastic(c, canvas);
      case DiagramEnum.microDemandEngelCurve:
        _paintDemandEngelCurve(c, canvas);
      case DiagramEnum.microDemandElasticityChange:
        _paintMicroDemandElasticityChange(c, canvas);
      case DiagramEnum.microDemandElasticityRevenueChange:
        _paintMicroDemandRevenueChange(c, canvas);
      case DiagramEnum.microSupplyElastic:
        _paintSupplyElastic(c, canvas);
      case DiagramEnum.microSupplyInelastic:
        _paintSupplyInelastic(c, canvas);
      case DiagramEnum.microSupplyUnitElastic:
        _paintSupplyUnitElastic(c, canvas);
      case DiagramEnum.microSupplyPerfectlyElastic:
        _paintSupplyPerfectlyElastic(c, canvas);
      case DiagramEnum.microSupplyPerfectlyInelastic:
        _paintSupplyPerfectlyInelastic(c, canvas);
      case DiagramEnum.microSupplyPrimaryCommodities:
        _paintMicroSupplyPrimaryCommodities(c, canvas, size);
      default:
    }
  }

  // --- DEMAND METHODS ---

  void _paintInelasticDemand(
    DiagramPainterConfig c,
    IDiagramCanvas canvas,
    Size size,
  ) {
    paintMarketCurve(
      c,
      canvas,

      type: MarketCurveType.demand,
      angle: -0.40,
      lengthAdjustment: marketCurveLengthAdjustment,
    );
    paintDiagramDashedLines(
      c,
      canvas,

      yAxisStartPos: 0.45,
      xAxisEndPos: 0.36,
      yLabel: 'P1',
      xLabel: 'Q1',
      showDotAtIntersection: true,
    );
    paintDiagramDashedLines(
      c,
      canvas,

      yAxisStartPos: 0.60,
      xAxisEndPos: 0.74,
      yLabel: 'P2',
      xLabel: 'Q2',
      showDotAtIntersection: true,
    );

    if (diagram == DiagramEnum.microDemandInelasticRevenue) {
      _paintRevenueShading(c, canvas, q1: 0.36, q2: 0.74, p1: 0.45, p2: 0.60);
    }
  }

  void _paintElasticDemand(
    DiagramPainterConfig c,
    IDiagramCanvas canvas,
    Size size,
  ) {
    paintMarketCurve(
      c,
      canvas,

      type: MarketCurveType.demand,
      angle: 0.40,
      lengthAdjustment: marketCurveLengthAdjustment,
    );
    paintDiagramDashedLines(
      c,
      canvas,

      yAxisStartPos: 0.45,
      xAxisEndPos: 0.475,
      yLabel: 'P1',
      xLabel: 'Q1',
      showDotAtIntersection: true,
    );
    paintDiagramDashedLines(
      c,
      canvas,

      yAxisStartPos: 0.60,
      xAxisEndPos: 0.54,
      yLabel: 'P2',
      xLabel: 'Q2',
      showDotAtIntersection: true,
    );

    if (diagram == DiagramEnum.microDemandElasticRevenue) {
      _paintRevenueShading(c, canvas, q1: 0.475, q2: 0.54, p1: 0.45, p2: 0.60);
    }
  }

  void _paintUnitElastic(DiagramPainterConfig c, IDiagramCanvas canvas) {
    paintDiagramLines(
      c,
      canvas,

      startPos: const Offset(0.10, 0.10),
      bezierPoints: [
        CustomBezier(
          endPoint: const Offset(0.90, 0.90),
          control: const Offset(0.09, 0.90),
        ),
      ],
      label2: 'D',
      label2Align: LabelAlign.centerRight,
    );
    paintDiagramDashedLines(
      c,
      canvas,

      yAxisStartPos: 0.50,
      xAxisEndPos: 0.16,
      yLabel: 'P1',
      xLabel: 'Q1',
      showDotAtIntersection: true,
    );
    paintDiagramDashedLines(
      c,
      canvas,

      yAxisStartPos: 0.75,
      xAxisEndPos: 0.35,
      yLabel: 'P2',
      xLabel: 'Q2',
      showDotAtIntersection: true,
    );
  }

  void _paintDemandPerfectlyElastic(
    DiagramPainterConfig c,
    IDiagramCanvas canvas,
  ) {
    paintDiagramLines(
      c,
      canvas,

      startPos: const Offset(0.0, 0.50),
      polylineOffsets: [const Offset(0.90, 0.50)],
      label2: 'D',
      label2Align: LabelAlign.centerRight,
    );
    paintDiagramDashedLines(
      c,
      canvas,

      yAxisStartPos: 0.50,
      xAxisEndPos: 0.0,
      yLabel: 'P',
    );
  }

  void _paintDemandPerfectlyInelastic(
    DiagramPainterConfig c,
    IDiagramCanvas canvas,
  ) {
    paintDiagramLines(
      c,
      canvas,

      startPos: const Offset(0.50, 1.0),
      polylineOffsets: [const Offset(0.50, 0.10)],
      label2: 'D',
      label2Align: LabelAlign.centerTop,
    );
    paintDiagramDashedLines(
      c,
      canvas,

      yAxisStartPos: 0.60,
      xAxisEndPos: 0.50,
      yLabel: 'P1',
      xLabel: 'Q',
      showDotAtIntersection: true,
    );
    paintDiagramDashedLines(
      c,
      canvas,

      yAxisStartPos: 0.40,
      xAxisEndPos: 0.50,
      yLabel: 'P2',
      hideXLine: true,
      showDotAtIntersection: true,
    );
  }

  void _paintMicroDemandRevenueChange(
    DiagramPainterConfig c,
    IDiagramCanvas canvas,
  ) {
    paintDiagramLines(
      c,
      canvas,

      startPos: const Offset(0, 1),
      bezierPoints: [
        CustomBezier(
          control: const Offset(0.50, -0.70),
          endPoint: const Offset(1, 1),
        ),
      ],
    );
    paintDiagramDashedLines(
      c,
      canvas,

      yAxisStartPos: 0.15,
      xAxisEndPos: 0.50,
      yLabel: 'R Max',
      xLabel: 'Q*',
      showDotAtIntersection: true,
    );
    paintText(c, canvas, 'PED > 1', const Offset(0.20, 0.25));
    paintText(c, canvas, 'PED = 1', const Offset(0.50, 0.08));
    paintText(c, canvas, 'PED < 1', const Offset(0.80, 0.25));
  }

  void _paintMicroDemandElasticityChange(
    DiagramPainterConfig c,
    IDiagramCanvas canvas,
  ) {
    paintMarketCurve(
      c,
      canvas,

      type: MarketCurveType.demand,
      lengthAdjustment: 0.15,
    );
    paintDiagramDashedLines(
      c,
      canvas,

      yAxisStartPos: 0.25,
      xAxisEndPos: 0.25,
      yLabel: 'P1',
      xLabel: 'Q1',
      showDotAtIntersection: true,
    );
    paintDiagramDashedLines(
      c,
      canvas,

      yAxisStartPos: 0.50,
      xAxisEndPos: 0.50,
      yLabel: 'P*',
      xLabel: 'Q*',
      showDotAtIntersection: true,
    );
    paintDiagramDashedLines(
      c,
      canvas,

      yAxisStartPos: 0.75,
      xAxisEndPos: 0.75,
      yLabel: 'P2',
      xLabel: 'Q2',
      showDotAtIntersection: true,
    );
    paintText(c, canvas, 'PED > 1', const Offset(0.30, 0.15));
    paintText(
      c,
      canvas,
      'PED = 1',
      const Offset(0.60, 0.40),

      pointerLine: const Offset(0.50, 0.50),
    );
    paintText(c, canvas, 'PED < 1', const Offset(0.80, 0.65));
  }

  void _paintDemandEngelCurve(DiagramPainterConfig c, IDiagramCanvas canvas) {
    final dashedColor = Colors.grey;
    // Luxuries
    paintDiagramLines(
      c,
      canvas,

      startPos: const Offset(0.10, 0.80),
      polylineOffsets: [const Offset(0.60, 0.65)],
    );
    paintText(
      c,
      canvas,
      DiagramLabel.normalGoodLuxury.label,
      const Offset(0.25, 0.60),
      pointerLine: const Offset(0.25, 0.76),
    );

    // Necessities
    paintDiagramLines(
      c,
      canvas,

      startPos: const Offset(0.60, 0.90),
      polylineOffsets: [const Offset(0.80, 0.30)],
    );
    paintText(
      c,
      canvas,
      DiagramLabel.normalGoodNecessity.label,
      const Offset(0.90, 0.70),
      pointerLine: const Offset(0.66, 0.70),
    );
    // Inferior
    paintDiagramLines(
      c,
      canvas,

      startPos: const Offset(0.10, 0.20),
      polylineOffsets: [const Offset(0.60, 0.50)],
    );

    paintText(
      c,
      canvas,
      DiagramLabel.inferiorGood.label,
      const Offset(0.25, 0.15),
      pointerLine: const Offset(0.25, 0.29),
    );
  }

  // --- SUPPLY METHODS ---

  void _paintSupplyElastic(DiagramPainterConfig c, IDiagramCanvas canvas) {
    paintMarketCurve(
      c,
      canvas,

      type: MarketCurveType.supply,
      angle: 0.40,
      lengthAdjustment: marketCurveLengthAdjustment,
    );
    paintDiagramDashedLines(
      c,
      canvas,

      yAxisStartPos: 0.56,
      xAxisEndPos: 0.36,
      yLabel: 'P1',
      xLabel: 'Q1',
      showDotAtIntersection: true,
    );
    paintDiagramDashedLines(
      c,
      canvas,

      yAxisStartPos: 0.405,
      xAxisEndPos: 0.74,
      yLabel: 'P2',
      xLabel: 'Q2',
      showDotAtIntersection: true,
    );
  }

  void _paintSupplyInelastic(DiagramPainterConfig c, IDiagramCanvas canvas) {
    paintMarketCurve(
      c,
      canvas,

      type: MarketCurveType.supply,
      angle: -0.40,
      lengthAdjustment: marketCurveLengthAdjustment,
    );
    paintDiagramDashedLines(
      c,
      canvas,

      yAxisStartPos: 0.55,
      xAxisEndPos: 0.48,
      yLabel: 'P1',
      xLabel: 'Q1',
      showDotAtIntersection: true,
    );
    paintDiagramDashedLines(
      c,
      canvas,

      yAxisStartPos: 0.35,
      xAxisEndPos: 0.56,
      yLabel: 'P2',
      xLabel: 'Q2',
      showDotAtIntersection: true,
    );
  }

  void _paintSupplyUnitElastic(DiagramPainterConfig c, IDiagramCanvas canvas) {
    final supplyCurves = [
      const Offset(0.35, 0.10),
      const Offset(0.80, 0.20),
      const Offset(0.90, 0.65),
    ];
    for (int i = 0; i < supplyCurves.length; i++) {
      paintDiagramLines(
        c,
        canvas,

        startPos: const Offset(0, 1.0),
        polylineOffsets: [supplyCurves[i]],
        label2: 'S${i + 1}',
        label2Align: LabelAlign.centerRight,
      );
    }
    paintDot(c, canvas, const Offset(0.005, 0.995));
  }

  void _paintSupplyPerfectlyElastic(
    DiagramPainterConfig c,
    IDiagramCanvas canvas,
  ) {
    paintDiagramLines(
      c,
      canvas,

      startPos: const Offset(0.0, 0.50),
      polylineOffsets: [const Offset(0.90, 0.50)],
      label2: 'S',
      label2Align: LabelAlign.centerRight,
    );
    paintDiagramDashedLines(
      c,
      canvas,

      yAxisStartPos: 0.50,
      xAxisEndPos: 0.0,
      yLabel: 'P',
    );
  }

  void _paintSupplyPerfectlyInelastic(
    DiagramPainterConfig c,
    IDiagramCanvas canvas,
  ) {
    paintDiagramLines(
      c,
      canvas,

      startPos: const Offset(0.50, 1.0),
      polylineOffsets: [const Offset(0.50, 0.10)],
      label1: 'S',
      label1Align: LabelAlign.centerTop,
    );
    paintDiagramDashedLines(
      c,
      canvas,

      yAxisStartPos: 0.60,
      xAxisEndPos: 0.50,
      yLabel: 'P1',
      xLabel: 'Q',
      showDotAtIntersection: true,
    );
    paintDiagramDashedLines(
      c,
      canvas,

      yAxisStartPos: 0.40,
      xAxisEndPos: 0.50,
      yLabel: 'P2',
      hideXLine: true,
      showDotAtIntersection: true,
    );
  }

  void _paintMicroSupplyPrimaryCommodities(
    DiagramPainterConfig c,
    IDiagramCanvas canvas,
    Size size, {
    IDiagramCanvas? iCanvas,
  }) {
    paintLineSegment(c, canvas, origin: Offset(0.61, 0.20), angle: pi);
    paintText(
      c,
      canvas,
      DiagramLabel.gainedRevenue.label,
      Offset(0.20, 0.20),
      pointerLine: Offset(0.20, 0.50),
    );
    paintText(
      c,
      canvas,
      DiagramLabel.lostRevenue.label,
      Offset(0.80, 0.80),
      pointerLine: Offset(0.52, 0.80),
    );
    _paintRevenueShading(c, canvas, q1: 0.45, q2: 0.55, p1: 0.35, p2: 0.65);
    paintMarketCurve(
      c,
      canvas,

      type: MarketCurveType.demand,
      angle: pi * 0.15,
      lengthAdjustment: -0.10,
    );
    paintMarketCurve(
      c,
      canvas,

      type: MarketCurveType.supply,
      horizontalShift: -0.10,
      label: 'S2',
      angle: pi * -0.15,
      lengthAdjustment: -0.10,
    );
    paintMarketCurve(
      c,
      canvas,

      type: MarketCurveType.supply,
      horizontalShift: 0.10,
      label: 'S1',
      angle: pi * -0.15,
      lengthAdjustment: -0.10,
    );
    paintDiagramDashedLines(
      c,
      canvas,

      yAxisStartPos: 0.35,
      xAxisEndPos: 0.45,
      yLabel: 'P2',
      xLabel: 'Q2',
      showDotAtIntersection: true,
    );
    paintDiagramDashedLines(
      c,
      canvas,

      yAxisStartPos: 0.65,
      xAxisEndPos: 0.55,
      yLabel: 'P1',
      xLabel: 'Q1',
      showDotAtIntersection: true,
    );
  }

  // --- REVENUE UTILITY ---

  void _paintRevenueShading(
    DiagramPainterConfig c,
    IDiagramCanvas canvas, {
    required double q1,
    required double q2,
    required double p1,
    required double p2,
  }) {
    paintShading(c, canvas, ShadeType.gainedRevenue, [
      Offset(0, p1),
      Offset(q1, p1),
      Offset(q1, p2),
      Offset(0, p2),
    ]);
    paintShading(c, canvas, ShadeType.lostRevenue, [
      Offset(q1, p2),
      Offset(q2, p2),
      Offset(q2, 1.0),
      Offset(q1, 1.0),
    ]);
  }
}
