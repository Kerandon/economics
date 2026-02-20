import 'dart:math';

import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_line_segment.dart';
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

const double marketCurveLengthAdjustment = -0.20;

class Elasticities extends BaseDiagramPainter {
  Elasticities(super.config, super.diagram);

  @override
  void drawDiagram(IDiagramCanvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);

    // 1. Determine Axis Labels via Lookup
    final axisLabels = _getAxisLabels();
    paintAxis(
      c,
      canvas,
      yAxisLabel: axisLabels['y']!,
      xAxisLabel: axisLabels['x']!,
    );

    // 2. Delegate to Specific Painters
    _triggerSpecificPainter(c, canvas);
  }

  Map<String, String> _getAxisLabels() {
    String y = DiagramLabel.p.label;
    String x = DiagramLabel.q.label;

    switch (diagram) {
      case DiagramEnum.microDemandEngelCurve:
        y = DiagramLabel.y.label;
        break;
      case DiagramEnum.microDemandElasticityRevenueChange:
        y = DiagramLabel.revenue$.label;
        x = DiagramLabel.quantity.label;
        break;
      case DiagramEnum.microDemandElasticityChange:
        y = DiagramLabel.price$.label;
        x = DiagramLabel.quantity.label;
        break;
      default:
        break;
    }
    return {'x': x, 'y': y};
  }

  void _triggerSpecificPainter(DiagramPainterConfig c, IDiagramCanvas canvas) {
    switch (diagram) {
      // Demand
      case DiagramEnum.microDemandElastic:
      case DiagramEnum.microDemandElasticRevenue:
        _paintElasticDemand(c, canvas);
      case DiagramEnum.microDemandInelastic:
      case DiagramEnum.microDemandInelasticRevenue:
        _paintInelasticDemand(c, canvas);
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

      // Supply
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
        _paintMicroSupplyPrimaryCommodities(c, canvas);
      default:
        break;
    }
  }

  // --- DEMAND METHODS ---

  void _paintInelasticDemand(DiagramPainterConfig c, IDiagramCanvas canvas) {
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.demand,
      angle: -0.40,
      lengthAdjustment: marketCurveLengthAdjustment,
    );
    _paintStandardDashedLines(
      c,
      canvas,
      p1: 0.45,
      q1: 0.36,
      p2: 0.60,
      q2: 0.74,
    );

    if (diagram == DiagramEnum.microDemandInelasticRevenue) {
      _paintRevenueShading(c, canvas, q1: 0.36, q2: 0.74, p1: 0.45, p2: 0.60);
    }
  }

  void _paintElasticDemand(DiagramPainterConfig c, IDiagramCanvas canvas) {
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.demand,
      angle: 0.40,
      lengthAdjustment: marketCurveLengthAdjustment,
    );
    _paintStandardDashedLines(
      c,
      canvas,
      p1: 0.45,
      q1: 0.475,
      p2: 0.60,
      q2: 0.54,
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
      label2: DiagramLabel.d.label,
      label2Align: LabelAlign.centerRight,
    );
    _paintStandardDashedLines(
      c,
      canvas,
      p1: 0.50,
      q1: 0.16,
      p2: 0.75,
      q2: 0.35,
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
      label2: DiagramLabel.d.label.toUpperCase(),
      label2Align: LabelAlign.centerRight,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.50,
      xAxisEndPos: 0.0,
      yLabel: DiagramLabel.p.label,
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
      label2: DiagramLabel.d.label.toUpperCase(),
      label2Align: LabelAlign.centerTop,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.60,
      xAxisEndPos: 0.50,
      yLabel: DiagramLabel.p1.label,
      xLabel: DiagramLabel.q.label,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.40,
      xAxisEndPos: 0.50,
      yLabel: DiagramLabel.p2.label,
      hideXLine: true,
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
      label2: DiagramLabel.tR.label,
      label2Align: LabelAlign.centerRight,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.15,
      xAxisEndPos: 0.50,
      xLabel: '50',
      yLabel: '100',
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.35,
      xAxisEndPos: 0.745,
      additionalXLabels: ['25'],
      additionalXPositions: [0.255],
      xLabel: '75',
      yLabel: '75',
    );

    // Labels using DiagramLabel constants
    paintText(
      c,
      canvas,
      DiagramLabel.pedGreaterThanOne.label,
      const Offset(0.20, 0.275),
    );
    paintText(
      c,
      canvas,
      DiagramLabel.pedEqualToOne.label,
      const Offset(0.50, 0.10),
    );
    paintText(
      c,
      canvas,
      DiagramLabel.pedLessThanOne.label,
      const Offset(0.80, 0.275),
    );
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
      yLabel: '3',
      xLabel: '25',
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.50,
      xAxisEndPos: 0.50,
      yLabel: '2',
      xLabel: '50',
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.75,
      xAxisEndPos: 0.75,
      yLabel: '1',
      xLabel: '75',
    );

    paintText(
      c,
      canvas,
      DiagramLabel.pedGreaterThanOne.label,
      const Offset(0.35, 0.225),
    );
    paintText(
      c,
      canvas,
      DiagramLabel.pedEqualToOne.label,
      const Offset(0.60, 0.50),
    );
    paintText(
      c,
      canvas,
      DiagramLabel.pedLessThanOne.label,
      const Offset(0.85, 0.75),
    );
  }

  void _paintDemandEngelCurve(DiagramPainterConfig c, IDiagramCanvas canvas) {
    _paintEngelLine(
      c,
      canvas,
      start: const Offset(0.10, 0.80),
      end: const Offset(0.60, 0.65),
      label: DiagramLabel.normalGoodLuxury.label,
      textPos: const Offset(0.25, 0.60),
      pointer: const Offset(0.25, 0.76),
    );
    _paintEngelLine(
      c,
      canvas,
      start: const Offset(0.60, 0.90),
      end: const Offset(0.80, 0.30),
      label: DiagramLabel.normalGoodNecessity.label,
      textPos: const Offset(0.90, 0.70),
      pointer: const Offset(0.66, 0.70),
    );
    _paintEngelLine(
      c,
      canvas,
      start: const Offset(0.10, 0.20),
      end: const Offset(0.60, 0.50),
      label: DiagramLabel.inferiorGood.label,
      textPos: const Offset(0.25, 0.15),
      pointer: const Offset(0.25, 0.29),
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
    _paintStandardDashedLines(
      c,
      canvas,
      p1: 0.56,
      q1: 0.36,
      p2: 0.405,
      q2: 0.74,
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
    _paintStandardDashedLines(
      c,
      canvas,
      p1: 0.55,
      q1: 0.48,
      p2: 0.35,
      q2: 0.56,
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
      label2: DiagramLabel.s.label.toUpperCase(),
      label2Align: LabelAlign.centerRight,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.50,
      xAxisEndPos: 0.0,
      yLabel: DiagramLabel.p.label,
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
      label1: DiagramLabel.s.label.toUpperCase(),
      label1Align: LabelAlign.centerTop,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.60,
      xAxisEndPos: 0.50,
      yLabel: DiagramLabel.p1.label,
      xLabel: DiagramLabel.q.label,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.40,
      xAxisEndPos: 0.50,
      yLabel: DiagramLabel.p2.label,
      hideXLine: true,
    );
  }

  void _paintMicroSupplyPrimaryCommodities(
    DiagramPainterConfig c,
    IDiagramCanvas canvas,
  ) {
    paintLineSegment(c, canvas, origin: const Offset(0.61, 0.20), angle: pi);
    paintText(
      c,
      canvas,
      DiagramLabel.gainedRevenue.label,
      const Offset(0.20, 0.25),
      pointerLine: const Offset(0.20, 0.40),
    );
    paintText(
      c,
      canvas,
      DiagramLabel.lostRevenue.label,
      const Offset(0.70, 0.80),
      pointerLine: const Offset(0.53, 0.80),
    );
    _paintRevenueShading(c, canvas, q1: 0.45, q2: 0.55, p1: 0.35, p2: 0.65);
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.demand,
      angle: pi * 0.15,
      lengthAdjustment: marketCurveLengthAdjustment,
    );
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.supply,
      horizontalShift: -0.10,
      label: DiagramLabel.s2.label,
      angle: pi * -0.15,
      lengthAdjustment: marketCurveLengthAdjustment,
    );
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.supply,
      horizontalShift: 0.10,
      label: DiagramLabel.s1.label,
      angle: pi * -0.15,
      lengthAdjustment: marketCurveLengthAdjustment,
    );
    _paintStandardDashedLines(
      c,
      canvas,
      p1: 0.65,
      q1: 0.55,
      p2: 0.35,
      q2: 0.45,
    );
  }

  // --- REUSABLE UTILITIES ---

  void _paintStandardDashedLines(
    DiagramPainterConfig c,
    IDiagramCanvas canvas, {
    required double p1,
    required double q1,
    required double p2,
    required double q2,
  }) {
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: p1,
      xAxisEndPos: q1,
      yLabel: DiagramLabel.p1.label,
      xLabel: DiagramLabel.q1.label,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: p2,
      xAxisEndPos: q2,
      yLabel: DiagramLabel.p2.label,
      xLabel: DiagramLabel.q2.label,
    );
  }

  void _paintEngelLine(
    DiagramPainterConfig c,
    IDiagramCanvas canvas, {
    required Offset start,
    required Offset end,
    required String label,
    required Offset textPos,
    required Offset pointer,
  }) {
    paintDiagramLines(c, canvas, startPos: start, polylineOffsets: [end]);
    paintText(c, canvas, label, textPos, pointerLine: pointer);
  }

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
