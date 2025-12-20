import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/label_align.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/diagram_lines/paint_diagram_lines.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/legend/legend_display.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/legend/legend_entry.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/legend/paint_legend.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_dot.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_line_segment.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_text_2.dart';
import 'package:economics_app/diagrams/custom_paint/shade/paint_shading.dart';
import 'package:economics_app/diagrams/custom_paint/shade/shade_type.dart';
import 'package:economics_app/diagrams/models/custom_bezier.dart';
import 'package:flutter/material.dart';
import '../../enums/diagram_enum.dart';
import '../../enums/diagram_labels.dart';
import '../../models/base_painter_painter.dart';
import '../../models/diagram_painter_config.dart';
import '../painter_methods/axis/paint_axis.dart';
import '../painter_methods/paint_diagram_dash_lines.dart';
import '../painter_methods/shortcut_methods/paint_market_curve.dart';
import 'dart:math' as math;

const marketCurveLengthAdjustment = -0.10;

class Elasticities extends BaseDiagramPainter2 {
  Elasticities(super.config, super.bundle);

  @override
  void paint(Canvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);

    String yLabel = DiagramLabel.price.label;

    if (bundle == DiagramEnum.microDemandEngelCurve) {
      yLabel = DiagramLabel.income.label;
    } else if (bundle == DiagramEnum.microDemandElasticityRevenueChange) {
      yLabel = DiagramLabel.revenue.label;
    }

    paintAxis(
      c,
      canvas,
      yAxisLabel: yLabel,
      xAxisLabel: DiagramLabel.quantity.label,
    );

    switch (bundle) {
      case DiagramEnum.microDemandElastic ||
          DiagramEnum.microDemandElasticRevenue:
        _paintElasticDemand(c, canvas, size);
        break;
      case DiagramEnum.microDemandInelastic ||
          DiagramEnum.microDemandInelasticRevenue:
        _paintInelasticDemand(c, canvas, size);
        break;
      case DiagramEnum.microDemandUnitElastic:
        _paintUnitElastic(c, canvas);
        break;
      case DiagramEnum.microDemandPerfectlyElastic:
        _paintDemandPerfectlyElastic(c, canvas);
        break;
      case DiagramEnum.microDemandPerfectlyInelastic:
        _paintDemandPerfectlyInelastic(c, canvas);
        break;
      case DiagramEnum.microDemandEngelCurve:
        _paintDemandEngelCurve(c, canvas);
        break;
      case DiagramEnum.microDemandElasticityChange:
        _paintMicroDemandElasticityChange(c, canvas);
        break;
      case DiagramEnum.microDemandElasticityRevenueChange:
        _paintMicroDemandRevenueChange(c, canvas);
      case DiagramEnum.microSupplyElastic:
        _paintSupplyElastic(c, canvas);
        break;
      case DiagramEnum.microSupplyInelastic:
        _paintSupplyInelastic(c, canvas);
        break;
      case DiagramEnum.microSupplyUnitElastic:
        _paintSupplyUnitElastic(c, canvas);
        break;
      case DiagramEnum.microSupplyPerfectlyElastic:
        _paintSupplyPerfectlyElastic(c, canvas);
        break;
      case DiagramEnum.microSupplyPerfectlyInelastic:
        _paintSupplyPerfectlyInelastic(c, canvas);
        break;
      case DiagramEnum.microSupplyPrimaryCommodities:
        _paintMicroSupplyPrimaryCommodities(c, canvas, size);

      default:
    }
  }

  void _paintInelasticDemand(DiagramPainterConfig c, Canvas canvas, Size size) {
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
      yLabel: DiagramLabel.p1.label,
      xLabel: DiagramLabel.q1.label,
      showDotAtIntersection: true,
    );

    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.60,
      xAxisEndPos: 0.74,
      yLabel: DiagramLabel.p2.label,
      xLabel: DiagramLabel.q2.label,
      showDotAtIntersection: true,
    );

    paintLineSegment(
      c,
      canvas,
      origin: const Offset(0.54, 1.10),
      angle: math.pi * 2,
      length: 0.30,
    );
    paintLineSegment(
      c,
      canvas,
      origin: const Offset(-0.1, 0.51),
      angle: math.pi / 2,
    );
    if (bundle == DiagramEnum.microDemandInelasticRevenue) {
      paintShading(canvas, size, ShadeType.lostRevenue, [
        Offset(0.00, 0.45),
        Offset(0.36, 0.45),
        Offset(0.36, 0.60),
        Offset(0.00, 0.60),
      ]);
      paintShading(canvas, size, ShadeType.gainedRevenue, [
        Offset(0.36, 0.60),
        Offset(0.74, 0.60),
        Offset(0.74, 1.0),
        Offset(0.36, 1.0),
      ]);
      paintShading(canvas, size, ShadeType.revenueUnchanged, [
        Offset(0.0, 0.60),
        Offset(0.36, 0.60),
        Offset(0.36, 1.00),
        Offset(0.0, 1.0),
      ]);

      paintLegend(canvas, size, [
        LegendEntry.fromShade(ShadeType.lostRevenue, customLabel: ' A Loss'),
        LegendEntry.fromShade(
          ShadeType.revenueUnchanged,
          customLabel: ' B Unchanged',
        ),
        LegendEntry.fromShade(ShadeType.gainedRevenue, customLabel: ' C Gain'),
      ]);
      paintText2(c, canvas, DiagramLabel.b.label, Offset(0.15, 0.80));
      paintText2(c, canvas, DiagramLabel.a.label, Offset(0.15, 0.52));
      paintText2(c, canvas, DiagramLabel.c.label, Offset(0.55, 0.80));
    }
  }

  void _paintElasticDemand(DiagramPainterConfig c, Canvas canvas, Size size) {
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.demand,
      angle: 0.40,
      lengthAdjustment: marketCurveLengthAdjustment, // steeper (inelastic)
    );

    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.45,
      xAxisEndPos: 0.475,
      yLabel: DiagramLabel.p1.label,
      xLabel: DiagramLabel.q1.label,
      showDotAtIntersection: true,
    );

    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.60,
      xAxisEndPos: 0.54,
      yLabel: DiagramLabel.p2.label,
      xLabel: DiagramLabel.q2.label,
      showDotAtIntersection: true,
    );

    paintLineSegment(
      c,
      canvas,
      origin: const Offset(0.50, 1.10),
      angle: 0,
      length: 0.050,
    );
    paintLineSegment(
      c,
      canvas,
      origin: const Offset(-0.1, 0.52),
      angle: math.pi / 2,
    );
    if (bundle == DiagramEnum.microDemandElasticRevenue) {
      paintShading(canvas, size, ShadeType.lostRevenue, [
        Offset(0.00, 0.45),
        Offset(0.475, 0.45),
        Offset(0.475, 0.60),
        Offset(0.00, 0.60),
      ]);
      paintShading(canvas, size, ShadeType.gainedRevenue, [
        Offset(0.475, 0.60),
        Offset(0.54, 0.60),
        Offset(0.54, 1.0),
        Offset(0.475, 1.0),
      ]);
      paintShading(canvas, size, ShadeType.revenueUnchanged, [
        Offset(0.0, 0.60),
        Offset(0.475, 0.60),
        Offset(0.475, 1.00),
        Offset(0.0, 1.0),
      ]);

      paintLegend(canvas, size, [
        LegendEntry.fromShade(ShadeType.lostRevenue, customLabel: ' A Loss'),
        LegendEntry.fromShade(
          ShadeType.revenueUnchanged,
          customLabel: ' B Unchanged',
        ),
        LegendEntry.fromShade(ShadeType.gainedRevenue, customLabel: ' C Gain'),
      ]);
      paintText2(c, canvas, DiagramLabel.b.label, Offset(0.25, 0.80));
      paintText2(c, canvas, DiagramLabel.a.label, Offset(0.25, 0.52));
      paintText2(c, canvas, DiagramLabel.c.label, Offset(0.51, 0.80));
    }
  }

  void _paintUnitElastic(DiagramPainterConfig c, Canvas canvas) {
    paintDiagramLines(
      c,
      canvas,
      startPos: Offset(0.10, 0.10),
      bezierPoints: [
        CustomBezier(endPoint: Offset(0.90, 0.90), control: Offset(0.09, 0.90)),
      ],
      label2: DiagramLabel.d.label,
      label2Align: LabelAlign.centerRight,
    );

    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.50,
      xAxisEndPos: 0.16,
      yLabel: DiagramLabel.p1.label,
      xLabel: DiagramLabel.q1.label,
      showDotAtIntersection: true,
    );

    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.75,
      xAxisEndPos: 0.35,
      yLabel: DiagramLabel.p2.label,
      xLabel: DiagramLabel.q2.label,
      showDotAtIntersection: true,
    );

    paintLineSegment(
      c,
      canvas,
      origin: const Offset(0.25, 1.10),
      angle: math.pi * 2,
      length: 0.15,
    );
    paintLineSegment(
      c,
      canvas,
      origin: const Offset(-0.1, 0.62),
      angle: math.pi / 2,
      length: 0.15,
    );
  }

  void _paintDemandPerfectlyElastic(DiagramPainterConfig c, Canvas canvas) {
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.50,
      xAxisEndPos: 0.0,
      yLabel: DiagramLabel.p.label,
    );
    paintDiagramLines(
      c,
      canvas,
      startPos: Offset(0.0, 0.50),
      polylineOffsets: [Offset(0.90, 0.50)],
      label2: DiagramLabel.d.label,
      label2Align: LabelAlign.centerRight,
    );
  }

  void _paintDemandPerfectlyInelastic(DiagramPainterConfig c, Canvas canvas) {
    paintDiagramLines(
      c,
      canvas,
      startPos: Offset(0.50, 1.0),
      polylineOffsets: [Offset(0.50, 0.10)],
      label2: DiagramLabel.d.label,
      label2Align: LabelAlign.centerTop,
    );
    paintLineSegment(
      c,
      canvas,
      origin: const Offset(-0.1, 0.51),
      angle: -math.pi / 2,
      length: 0.15,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.40,
      xAxisEndPos: 0.50,
      yLabel: DiagramLabel.p2.label,
      xLabel: DiagramLabel.q.label,
      showDotAtIntersection: true,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.60,
      xAxisEndPos: 0.50,
      yLabel: DiagramLabel.p1.label,
      hideXLine: true,
      showDotAtIntersection: true,
    );
  }

  void _paintMicroDemandRevenueChange(DiagramPainterConfig c, Canvas canvas) {
    paintDiagramLines(
      c,
      canvas,
      startPos: Offset(0, 1),
      bezierPoints: [
        CustomBezier(control: Offset(0.50, -0.70), endPoint: Offset(1, 1)),
      ],
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.36,
      xAxisEndPos: 0.25,
      hideYLine: true,
      xLabel: DiagramLabel.q1.label,
      showDotAtIntersection: true,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.15,
      xAxisEndPos: 0.50,
      yLabel: DiagramLabel.rMax.label,
      xLabel: DiagramLabel.qStar.label,
      showDotAtIntersection: true,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.36,
      xAxisEndPos: 0.75,
      hideYLine: true,
      xLabel: DiagramLabel.q2.label,
      showDotAtIntersection: true,
    );

    paintText2(c, canvas, DiagramLabel.pedBigger1.label, Offset(0.20, 0.25));
    paintText2(c, canvas, DiagramLabel.pedEqual1.label, Offset(0.50, 0.08));
    paintText2(c, canvas, DiagramLabel.pedSmaller1.label, Offset(0.80, 0.25));
  }

  void _paintMicroDemandElasticityChange(
    DiagramPainterConfig c,
    Canvas canvas,
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
      yLabel: DiagramLabel.p1.label,
      xLabel: DiagramLabel.q1.label,
      showDotAtIntersection: true,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.50,
      xAxisEndPos: 0.50,
      yLabel: DiagramLabel.pStar.label,
      xLabel: DiagramLabel.qStar.label,
      showDotAtIntersection: true,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.75,
      xAxisEndPos: 0.75,
      yLabel: DiagramLabel.p2.label,
      xLabel: DiagramLabel.q2.label,
      showDotAtIntersection: true,
    );
    paintLineSegment(
      c,
      canvas,
      origin: Offset(0.35, 0.25),
      angle: math.pi * -0.75,
      length: 0.40,
    );
    paintLineSegment(
      c,
      canvas,
      origin: Offset(0.75, 0.65),
      angle: math.pi * 0.25,
      length: 0.40,
    );
    paintText2(
      c,
      canvas,
      DiagramLabel.pedBigger1.label,
      Offset(0.30, 0.15),
      horizontalPivot: LabelPivot.left,
    );
    paintText2(
      c,
      canvas,
      DiagramLabel.pedSmaller1.label,
      Offset(0.80, 0.65),
      horizontalPivot: LabelPivot.left,
    );
    paintText2(
      c,
      canvas,
      DiagramLabel.pedSmaller1.label,
      Offset(0.60, 0.40),
      horizontalPivot: LabelPivot.left,
      pointerLine: Offset(0.50, 0.50),
    );
  }

  void _paintDemandEngelCurve(DiagramPainterConfig c, Canvas canvas) {
    final dashedColor = c.colorScheme.onSurface.withAlpha(120);
    paintDiagramLines(
      c,
      canvas,
      startPos: Offset(0.15, 0.80),
      polylineOffsets: [Offset(0.50, 0.70)],
    );
    paintDiagramLines(
      c,
      canvas,
      startPos: Offset(0.0, 0.845),
      polylineOffsets: [Offset(0.15, 0.80)],
      curveStyle: CurveStyle.dashed,
      color: dashedColor,
    );
    paintDiagramLines(
      c,
      canvas,
      startPos: Offset(0.50, 0.70),
      polylineOffsets: [Offset(0.70, 0.40)],
    );
    paintDiagramLines(
      c,
      canvas,
      startPos: Offset(0.50, 0.70),
      polylineOffsets: [Offset(0.29, 1.0)],
      curveStyle: CurveStyle.dashed,
      color: dashedColor,
    );

    paintDiagramLines(
      c,
      canvas,
      startPos: Offset(0.70, 0.40),
      polylineOffsets: [Offset(0.30, 0.25)],
    );
    paintDiagramLines(
      c,
      canvas,
      startPos: Offset(0.30, 0.25),
      polylineOffsets: [Offset(0, 0.14)],
      curveStyle: CurveStyle.dashed,
      color: dashedColor,
    );
    paintText2(
      c,
      canvas,
      DiagramLabel.normalGoodLuxury.label,
      Offset(0.25, 0.65),
      pointerLine: Offset(0.25, 0.77),
    );
    paintText2(
      c,
      canvas,
      DiagramLabel.normalGoodNecessity.label,
      Offset(0.75, 0.70),
      pointerLine: Offset(0.57, 0.60),
    );
    paintText2(
      c,
      canvas,
      DiagramLabel.inferiorGood.label,
      Offset(0.50, 0.20),
      pointerLine: Offset(0.50, 0.32),
    );
    paintDot(c, canvas, pos: Offset(0.29, 1.0));
    paintDot(c, canvas, pos: Offset(0.0, 0.840));
    paintDot(c, canvas, pos: Offset(0.0, 0.14));
  }

  void _paintSupplyElastic(DiagramPainterConfig c, Canvas canvas) {
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
      yLabel: DiagramLabel.p1.label,
      xLabel: DiagramLabel.q1.label,
      showDotAtIntersection: true,
    );

    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.405,
      xAxisEndPos: 0.74,
      yLabel: DiagramLabel.p2.label,
      xLabel: DiagramLabel.q2.label,
      showDotAtIntersection: true,
    );

    paintLineSegment(
      c,
      canvas,
      origin: const Offset(0.54, 1.10),
      angle: math.pi * 2,
      length: 0.35,
    );
    paintLineSegment(
      c,
      canvas,
      origin: const Offset(-0.1, 0.48),
      angle: -math.pi / 2,
    );
  }

  void _paintSupplyInelastic(DiagramPainterConfig c, Canvas canvas) {
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
      yLabel: DiagramLabel.p1.label,
      xLabel: DiagramLabel.q1.label,
      showDotAtIntersection: true,
    );

    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.35,
      xAxisEndPos: 0.56,
      yLabel: DiagramLabel.p2.label,
      xLabel: DiagramLabel.q2.label,
      showDotAtIntersection: true,
    );

    paintLineSegment(
      c,
      canvas,
      origin: const Offset(0.52, 1.10),
      angle: math.pi * 2,
      length: 0.06,
    );
    paintLineSegment(
      c,
      canvas,
      origin: const Offset(-0.1, 0.46),
      angle: -math.pi / 2,
      length: 0.18,
    );
  }

  void _paintSupplyUnitElastic(DiagramPainterConfig c, Canvas canvas) {
    paintDiagramLines(
      c,
      canvas,
      startPos: Offset(0, 1.0),
      polylineOffsets: [Offset(0.80, 0.20)],
      label2: DiagramLabel.s2.label,
      label2Align: LabelAlign.centerRight,
    );
    paintDiagramLines(
      c,
      canvas,
      startPos: Offset(0, 1.0),
      polylineOffsets: [Offset(0.35, 0.10)],
      label2: DiagramLabel.s1.label,
      label2Align: LabelAlign.centerRight,
    );

    paintDiagramLines(
      c,
      canvas,
      startPos: Offset(0, 1.0),
      polylineOffsets: [Offset(0.90, 0.65)],
      label2: DiagramLabel.s3.label,
      label2Align: LabelAlign.centerRight,
    );
    paintDot(c, canvas, pos: Offset(0.005, 0.995));
  }

  void _paintSupplyPerfectlyElastic(DiagramPainterConfig c, Canvas canvas) {
    paintDiagramLines(
      c,
      canvas,
      startPos: const Offset(0.0, 0.50),
      polylineOffsets: [const Offset(0.90, 0.50)],
      label2: DiagramLabel.s.label,
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

  void _paintSupplyPerfectlyInelastic(DiagramPainterConfig c, Canvas canvas) {
    paintDiagramLines(
      c,
      canvas,
      startPos: const Offset(0.50, 0.10),
      polylineOffsets: [const Offset(0.50, 1.00)],
      label1: DiagramLabel.s.label,
      label1Align: LabelAlign.centerTop,
    );
    paintLineSegment(
      c,
      canvas,
      origin: const Offset(-0.1, 0.51),
      angle: -math.pi / 2,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.60,
      xAxisEndPos: 0.50,
      yLabel: DiagramLabel.p1.label,
      xLabel: DiagramLabel.q.label,
      showDotAtIntersection: true,
    );

    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.40,
      xAxisEndPos: 0.50,
      yLabel: DiagramLabel.p2.label,
      hideXLine: true,
      showDotAtIntersection: true,
    );
  }

  void _paintMicroSupplyPrimaryCommodities(
    DiagramPainterConfig c,
    Canvas canvas,
    Size size,
  ) {
    paintShading(canvas, size, ShadeType.gainedRevenue, [
      Offset(0.00, 0.35),
      Offset(0.45, 0.35),
      Offset(0.45, 0.65),
      Offset(0.0, 0.65),
    ]);
    paintShading(canvas, size, ShadeType.revenueUnchanged, [
      Offset(0.00, 0.65),
      Offset(0.45, 0.65),
      Offset(0.45, 1.0),
      Offset(0.0, 1.0),
    ]);
    paintShading(canvas, size, ShadeType.lostRevenue, [
      Offset(0.45, 0.65),
      Offset(0.55, 0.65),
      Offset(0.55, 1.0),
      Offset(0.45, 1.0),
    ]);

    ///      paintShading(canvas, size, ShadeType.lostRevenue, [
    //         Offset(0.00, 0.45),
    //         Offset(0.475, 0.45),
    //         Offset(0.475, 0.60),
    //         Offset(0.00, 0.60),
    //       ]);
    //       paintShading(canvas, size, ShadeType.gainedRevenue, [
    //         Offset(0.475, 0.60),
    //         Offset(0.54, 0.60),
    //         Offset(0.54, 1.0),
    //         Offset(0.475, 1.0),
    //       ]);
    //       paintShading(canvas, size, ShadeType.revenueUnchanged, [
    //         Offset(0.0, 0.60),
    //         Offset(0.475, 0.60),
    //         Offset(0.475, 1.00),
    //         Offset(0.0, 1.0),
    //       ]);
    //

    //       paintText2(c, canvas, DiagramLabel.b.label, Offset(0.25, 0.80));
    //       paintText2(c, canvas, DiagramLabel.a.label, Offset(0.25, 0.52));
    //       paintText2(c, canvas, DiagramLabel.c.label, Offset(0.51, 0.80));
    //
    //     }

    paintLineSegment(
      c,
      canvas,
      origin: Offset(0.58, 0.30),
      angle: math.pi,
      length: 0.12,
    );
    paintLineSegment(
      length: 0.22,
      c,
      canvas,
      origin: Offset(-0.08, 0.505),
      angle: math.pi * 1.5,
    );
    paintLineSegment(
      c,
      canvas,
      origin: Offset(0.52, 1.09),
      angle: math.pi * 1,
      length: 0.05,
    );
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.demand,
      angle: math.pi * 0.15,
      lengthAdjustment: -0.10,
    );
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.supply,
      angle: math.pi * -0.15,
      horizontalShift: -0.10,
      label: DiagramLabel.s2.label,
      lengthAdjustment: -0.10,
    );
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.supply,
      angle: math.pi * -0.15,
      horizontalShift: 0.10,
      label: DiagramLabel.s1.label,
      lengthAdjustment: -0.10,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.35,
      xAxisEndPos: 0.45,
      yLabel: DiagramLabel.p2.label,
      xLabel: DiagramLabel.q2.label,
      showDotAtIntersection: true,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.65,
      xAxisEndPos: 0.55,
      yLabel: DiagramLabel.p1.label,
      xLabel: DiagramLabel.q1.label,
      showDotAtIntersection: true,
    );

    paintLegend(canvas, size, [
      LegendEntry.fromShade(ShadeType.gainedRevenue, customLabel: ' A Gain'),
      LegendEntry.fromShade(
        ShadeType.revenueUnchanged,
        customLabel: 'B Unchanged',
      ),
      LegendEntry.fromShade(ShadeType.lostRevenue, customLabel: 'C Loss'),
    ]);
    paintText2(c, canvas, DiagramLabel.a.label, Offset(0.20, 0.50));
    paintText2(c, canvas, DiagramLabel.b.label, Offset(0.20, 0.80));

    paintText2(c, canvas, DiagramLabel.c.label, Offset(0.51, 0.93));
  }
}
