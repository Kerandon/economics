import 'package:economics_app/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/label_align.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/diagram_lines/paint_diagram_lines.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/legend/legend_entry.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/legend/paint_legend.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_legend_table.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_line_segment.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_text_2.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_title.dart';
import 'package:economics_app/diagrams/custom_paint/shade/paint_shading.dart';
import 'package:economics_app/diagrams/custom_paint/shade/shade_type.dart';
import 'package:economics_app/diagrams/models/custom_bezier.dart';
import 'package:flutter/material.dart';
import '../../enums/diagram_bundle_enum.dart';
import '../../enums/diagram_labels.dart';
import '../../models/base_painter_painter.dart';
import '../../models/diagram_painter_config.dart';
import '../painter_methods/axis/paint_axis.dart';
import '../painter_methods/paint_arrow_helper.dart';
import '../painter_methods/paint_diagram_dash_lines.dart';
import '../painter_methods/shortcut_methods/paint_market_curve.dart';
import 'dart:math' as math;

class Elasticities extends BaseDiagramPainter2 {
  Elasticities(super.config, super.bundle);

  @override
  void paint(Canvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);

    String yLabel = DiagramLabel.price.label;

    if (bundle == DiagramBundleEnum.microDemandEngelCurve) {
      yLabel = DiagramLabel.income.label;
    } else if (bundle ==
        DiagramBundleEnum.microDemandElasticityRevenueChange) {
      yLabel = DiagramLabel.revenue.label;
    }

    paintAxis(
      c,
      canvas,
      yAxisLabel: yLabel,
      xAxisLabel: DiagramLabel.quantity.label,
    );

    switch (bundle) {
      case DiagramBundleEnum.microDemandElastic ||
          DiagramBundleEnum.microDemandElasticRevenue:
        _paintElastic(c, canvas, size);
        break;
      case DiagramBundleEnum.microDemandInelastic ||
          DiagramBundleEnum.microDemandInelasticRevenue:
        _paintInelastic(c, canvas, size);
        break;
      case DiagramBundleEnum.microDemandUnitElastic:
        _paintUnitElastic(c, canvas);
        break;
      case DiagramBundleEnum.microDemandPerfectlyElastic:
        _paintDemandPerfectlyElastic(c, canvas);
        break;
      case DiagramBundleEnum.microDemandPerfectlyInelastic:
        _paintDemandPerfectlyInelastic(c, canvas);
        break;
      case DiagramBundleEnum.microDemandEngelCurve:
        _paintDemandEngelCurve(c, canvas);
        break;
      case DiagramBundleEnum.microDemandElasticityChange:
        _paintMicroDemandElasticityChange(c, canvas);
        break;
      case DiagramBundleEnum.microDemandElasticityRevenueChange:
        _paintMicroDemandRevenueChange(c, canvas);
      case DiagramBundleEnum.microSupplyElastic:
        _paintSupplyElastic(c, canvas);
        break;
      case DiagramBundleEnum.microSupplyInelastic:
        _paintSupplyInelastic(c, canvas);
        break;
      case DiagramBundleEnum.microSupplyUnitElastic:
        _paintSupplyUnitElastic(c, canvas);
        break;
      case DiagramBundleEnum.microSupplyPerfectlyElastic:
        _paintSupplyPerfectlyElastic(c, canvas);
        break;
      case DiagramBundleEnum.microSupplyPerfectlyInelastic:
        _paintSupplyPerfectlyInelastic(c, canvas);
        break;
      case DiagramBundleEnum.microSupplyPrimaryCommodities:
        _paintMicroSupplyPrimaryCommodities(c, canvas, size);

      default:
    }
  }

  void _paintElastic(DiagramPainterConfig c, Canvas canvas, Size size) {
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.demand,
      angle: -0.40, // flatter (elastic)
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
    if (bundle == DiagramBundleEnum.microDemandElasticRevenue) {
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

      paintLegend(canvas, size, [
        LegendEntry.fromShade(ShadeType.lostRevenue, customLabel: ' A Loss'),
        LegendEntry.fromShade(ShadeType.revenueUnchanged, customLabel: ' B Unchanged'),
        LegendEntry.fromShade(ShadeType.gainedRevenue, customLabel: ' C Gain'),
      ]);
      paintText2(c, canvas, DiagramLabel.b.label, Offset(0.15, 0.80));
      paintText2(c, canvas, DiagramLabel.a.label, Offset(0.15, 0.52));
      paintText2(c, canvas, DiagramLabel.c.label, Offset(0.55, 0.80));
    }
  }

  void _paintInelastic(DiagramPainterConfig c, Canvas canvas, Size size) {
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.demand,
      angle: 0.40, // steeper (inelastic)
    );

    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.45,
      xAxisEndPos: 0.475,
      yLabel: DiagramLabel.p2.label,
      xLabel: DiagramLabel.q2.label,
      showDotAtIntersection: true,
    );

    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.60,
      xAxisEndPos: 0.54,
      yLabel: DiagramLabel.p1.label,
      xLabel: DiagramLabel.q1.label,
      showDotAtIntersection: true,
    );

    paintLineSegment(
      c,
      canvas,
      origin: const Offset(0.52, 1.10),
      angle: math.pi,
      length: 0.050
    );
    paintLineSegment(
      c,
      canvas,
      origin: const Offset(-0.1, 0.53),
      angle: -math.pi / 2,
    );
    if (bundle == DiagramBundleEnum.microDemandInelasticRevenue) {
      paintShading(canvas, size, ShadeType.gainedRevenue, [
        Offset(0.00, 0.45),
        Offset(0.48, 0.45),
        Offset(0.48, 0.60),
        Offset(0.00, 0.60),
      ]);
      paintShading(canvas, size, ShadeType.loss, [
        Offset(0.48, 0.60),
        Offset(0.54, 0.60),
        Offset(0.54, 1.0),
        Offset(0.48, 1.0),
      ]);
      paintText2(c, canvas, DiagramLabel.a.label, Offset(0.25, 0.80));
      paintText2(c, canvas, DiagramLabel.b.label, Offset(0.25, 0.52));
      paintText2(c, canvas, DiagramLabel.c.label, Offset(0.51, 0.80));

      paintLegend(canvas, size, [
        LegendEntry(
          label:
              '${DiagramLabel.a.label} ${DiagramLabel.revenueUnchanged.label}',
          color: Colors.grey,
        ),
        LegendEntry(
          label: '${DiagramLabel.b.label} Revenue Gain',
          color: Colors.green,
        ),
        LegendEntry(
          label: '${DiagramLabel.c.label} Revenue Loss',
          color: Colors.red,
        ),
      ]);
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
      length:
        0.15
    );
    paintLineSegment(
      c,
      canvas,
      origin: const Offset(-0.1, 0.62),
      angle: math.pi / 2,
        length:
        0.15
    );
  }

  void _paintDemandPerfectlyElastic(DiagramPainterConfig c, Canvas canvas) {
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.40,
      xAxisEndPos: 0.50,
      yLabel: DiagramLabel.p2.label,
      xLabel: DiagramLabel.q.label,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.60,
      xAxisEndPos: 0.50,
      yLabel: DiagramLabel.p1.label,
      hideXLine: true,
    );
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
        length:
        0.15
    );
  }

  void _paintDemandPerfectlyInelastic(DiagramPainterConfig c, Canvas canvas) {
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
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.36,
      xAxisEndPos: 0.75,
      hideYLine: true,
      xLabel: DiagramLabel.q3.label,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.16,
      xAxisEndPos: 0.50,
      hideYLine: true,
      xLabel: DiagramLabel.q2.label,
    );
    paintText2(
      c,
      canvas,
      DiagramLabel.pedSmaller1.label,
      Offset(0.20, 0.25),
      fontSize: kFontSmall,
    );
    paintText2(
      c,
      canvas,
      DiagramLabel.pedEqual1.label,
      Offset(0.50, 0.08),
      fontSize: kFontSmall,
    );
    paintText2(
      c,
      canvas,
      DiagramLabel.pedBigger1.label,
      Offset(0.80, 0.25),
      fontSize: kFontSmall,
    );
  }
  void _paintMicroDemandElasticityChange(
    DiagramPainterConfig c,
    Canvas canvas,
  ) {
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.demand,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.25,
      xAxisEndPos: 0.25,
      yLabel: DiagramLabel.p1.label,
      xLabel: DiagramLabel.q1.label,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.50,
      xAxisEndPos: 0.50,
      yLabel: DiagramLabel.p2.label,
      xLabel: DiagramLabel.q2.label,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.75,
      xAxisEndPos: 0.75,
      yLabel: DiagramLabel.p3.label,
      xLabel: DiagramLabel.q3.label,
    );
    paintArrowHelper(
      c,
      canvas,
      origin: Offset(0.35, 0.25),
      angle: math.pi * 0.25,
      arrowBothEnds: true,
      length: 0.30,
    );
    paintArrowHelper(
      c,
      canvas,
      origin: Offset(0.75, 0.65),
      angle: math.pi * 0.25,
      arrowBothEnds: true,
      length: 0.30,
    );
    paintText2(
      c,
      canvas,
      DiagramLabel.elasticDemand.label,
      Offset(0.40, 0.20),
      horizontalPivot: LabelPivot.left,
      fontSize: kFontSmall,
    );
    paintText2(
      c,
      canvas,
      DiagramLabel.inelasticDemand.label,
      Offset(0.80, 0.65),
      horizontalPivot: LabelPivot.left,
      fontSize: kFontSmall,
    );
    paintText2(
      c,
      canvas,
      DiagramLabel.unitElasticDemand.label,
      Offset(0.65, 0.40),
      horizontalPivot: LabelPivot.left,
      fontSize: kFontSmall,
      pointerLine: Offset(0.50, 0.50),
    );
  }

  void _paintDemandEngelCurve(DiagramPainterConfig c, Canvas canvas) {
    final dashedColor = c.colorScheme.onSurfaceVariant.withAlpha(155);
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
      polylineOffsets: [Offset(0.26, 1.0)],
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
      Offset(0.20, 0.65),
      fontSize: kFontSmall,
      pointerLine: Offset(0.20, 0.78),
    );
    paintText2(
      c,
      canvas,
      DiagramLabel.normalGoodNecessity.label,
      Offset(0.75, 0.70),
      fontSize: kFontSmall,
      pointerLine: Offset(0.57, 0.60),
    );
    paintText2(
      c,
      canvas,
      DiagramLabel.inferiorGood.label,
      Offset(0.50, 0.20),
      fontSize: kFontSmall,
      pointerLine: Offset(0.50, 0.32),
    );
  }

  void _paintSupplyElastic(DiagramPainterConfig c, Canvas canvas) {
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.supply,
      angle: 0.40, // flatter (elastic)
    );

    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.55,
      xAxisEndPos: 0.36,
      yLabel: DiagramLabel.p1.label,
      xLabel: DiagramLabel.q1.label,
    );

    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.40,
      xAxisEndPos: 0.74,
      yLabel: DiagramLabel.p2.label,
      xLabel: DiagramLabel.q2.label,
    );

    paintArrowHelper(
      c,
      canvas,
      origin: const Offset(0.54, 1.10),
      angle: math.pi * 2,
    );
    paintArrowHelper(
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
      angle: -0.40, // flatter (elastic)
    );

    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.55,
      xAxisEndPos: 0.48,
      yLabel: DiagramLabel.p1.label,
      xLabel: DiagramLabel.q1.label,
    );

    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.35,
      xAxisEndPos: 0.56,
      yLabel: DiagramLabel.p2.label,
      xLabel: DiagramLabel.q2.label,
    );

    paintArrowHelper(
      c,
      canvas,
      origin: const Offset(0.52, 1.10),
      angle: math.pi * 2,
    );
    paintArrowHelper(
      c,
      canvas,
      origin: const Offset(-0.1, 0.46),
      angle: -math.pi / 2,
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
    paintDiagramLines(
      c,
      canvas,
      startPos: const Offset(0.50, 0.10),
      polylineOffsets: [const Offset(0.50, 1.00)],
      label1: DiagramLabel.s.label,
      label1Align: LabelAlign.centerTop,
    );
    paintArrowHelper(
      c,
      canvas,
      origin: const Offset(-0.1, 0.51),
      angle: -math.pi / 2,
    );
  }

  void _paintMicroSupplyPrimaryCommodities(
    DiagramPainterConfig c,
    Canvas canvas,
    Size size,
  ) {
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.demand,
      angle: math.pi * 0.15,
    );
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.supply,
      angle: math.pi * -0.15,
      horizontalShift: -0.10,
      label: DiagramLabel.s2.label,
    );
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.supply,
      angle: math.pi * -0.15,
      horizontalShift: 0.10,
      label: DiagramLabel.s1.label,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.35,
      xAxisEndPos: 0.45,
      yLabel: DiagramLabel.p2.label,
      xLabel: DiagramLabel.q2.label,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.65,
      xAxisEndPos: 0.55,
      yLabel: DiagramLabel.p1.label,
      xLabel: DiagramLabel.q1.label,
    );
    paintArrowHelper(c, canvas, origin: Offset(0.58, 0.30), angle: math.pi);
    paintArrowHelper(
      c,
      canvas,
      origin: Offset(-0.06, 0.50),
      angle: math.pi * 1.5,
    );
    paintArrowHelper(c, canvas, origin: Offset(0.52, 1.11), angle: math.pi * 1);
    paintText2(c, canvas, DiagramLabel.a.label, Offset(0.20, 0.80));
    paintText2(c, canvas, DiagramLabel.b.label, Offset(0.20, 0.50));
    paintText2(c, canvas, DiagramLabel.c.label, Offset(0.51, 0.93));
paintLegendTable(canvas, config,
    normalizedTopLeft: Offset(kAxisIndent * 2,(1-kAxisIndent * 1.5)),
    headers: ['P1,Q1','P2,Q2'], data: [['A,C', 'A,B']]);
    paintShading(canvas, size, ShadeType.gainedRevenue, [
      Offset(0.00, 0.35),
      Offset(0.45, 0.35),
      Offset(0.45, 0.65),
      Offset(0.0, 0.65),

    ],);
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
  }
}
