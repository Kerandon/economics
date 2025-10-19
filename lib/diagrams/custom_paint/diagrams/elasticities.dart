import 'package:economics_app/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/label_align.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/diagram_lines/paint_diagram_lines.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_text_normalized_within_axis.dart';
import 'package:economics_app/diagrams/models/custom_bezier.dart';
import 'package:flutter/material.dart';

import '../../enums/diagram_bundle_enum.dart';
import '../../enums/diagram_labels.dart';
import '../../models/base_painter_painter.dart';
import '../../models/diagram_painter_config.dart';
import '../painter_methods/axis/paint_axis.dart';
import '../painter_methods/paint_arrow_helper.dart';
import '../painter_methods/paint_diagram_dash_lines.dart';
import '../painter_methods/shortcut_methods/paint_demand.dart';
import 'dart:math' as math;

class Elasticities extends BaseDiagramPainter2 {
  Elasticities(super.config, super.diagramBundleEnum);

  @override
  void paint(Canvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);

    final isEngelCurve =
        diagramBundleEnum == DiagramBundleEnum.microDemandEngelCurve;

    paintAxis(
      c,
      canvas,
      yAxisLabel: isEngelCurve
          ? DiagramLabel.income.label
          : DiagramLabel.price.label,
      xAxisLabel: DiagramLabel.quantity.label,
    );

    switch (diagramBundleEnum) {
      case DiagramBundleEnum.microDemandElastic:
        _paintElastic(c, canvas);
        break;
      case DiagramBundleEnum.microDemandInelastic:
        _paintInelastic(c, canvas);
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

      default:
    }
  }

  void _paintElastic(DiagramPainterConfig c, Canvas canvas) {
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.demand,
      elasticityAngle: -0.40, // flatter (elastic)
    );

    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.45,
      xAxisEndPos: 0.36,
      yLabel: DiagramLabel.p1.label,
      xLabel: DiagramLabel.q1.label,
    );

    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.60,
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
      origin: const Offset(-0.1, 0.51),
      angle: math.pi / 2,
    );
  }

  void _paintInelastic(DiagramPainterConfig c, Canvas canvas) {
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.demand,
      elasticityAngle: 0.40, // steeper (inelastic)
    );

    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.45,
      xAxisEndPos: 0.475,
      yLabel: DiagramLabel.p1.label,
      xLabel: DiagramLabel.q1.label,
    );

    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.60,
      xAxisEndPos: 0.54,
      yLabel: DiagramLabel.p2.label,
      xLabel: DiagramLabel.q2.label,
    );

    paintArrowHelper(
      c,
      canvas,
      origin: const Offset(0.50, 1.10),
      angle: math.pi * 2,
    );
    paintArrowHelper(
      c,
      canvas,
      origin: const Offset(-0.1, 0.51),
      angle: math.pi / 2,
    );
  }

  void _paintUnitElastic(DiagramPainterConfig c, Canvas canvas) {
    paintDiagramLines(
      c,
      canvas,
      startPos: Offset(0.10, 0.10),
      bezierPoints: [
        CustomBezier(endPoint: Offset(0.90, 0.90), control: Offset(0.10, 0.90)),
      ],
      label2: DiagramLabel.d.label,
      label2Align: LabelAlign.centerRight,
    );

    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.50,
      xAxisEndPos: 0.17,
      yLabel: DiagramLabel.p1.label,
      xLabel: DiagramLabel.q1.label,
    );

    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.75,
      xAxisEndPos: 0.35,
      yLabel: DiagramLabel.p2.label,
      xLabel: DiagramLabel.q2.label,
    );

    paintArrowHelper(
      c,
      canvas,
      origin: const Offset(0.25, 1.10),
      angle: math.pi * 2,
    );
    paintArrowHelper(
      c,
      canvas,
      origin: const Offset(-0.1, 0.62),
      angle: math.pi / 2,
    );
  }

  _paintDemandPerfectlyElastic(DiagramPainterConfig c, Canvas canvas) {
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.40,
      xAxisEndPos: 0.50,
      yLabel: DiagramLabel.p1.label,
      xLabel: DiagramLabel.q.label,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.60,
      xAxisEndPos: 0.50,
      yLabel: DiagramLabel.p2.label,
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
  }

  _paintDemandPerfectlyInelastic(DiagramPainterConfig c, Canvas canvas) {
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

  _paintDemandEngelCurve(DiagramPainterConfig c, Canvas canvas) {
    final dashedColor = c.colorScheme.onSurfaceVariant.withAlpha(100);
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
    paintTextNormalizedWithinAxis(
      c,
      canvas,
      DiagramLabel.normalGoodLuxury.label,
      Offset(0.32, 0.60),
      fontSize: kLabelFontSize,
      pointerLine: Offset(0.32, 0.68),
    );
    paintTextNormalizedWithinAxis(
      c,
      canvas,
      DiagramLabel.normalGoodNecessity.label,
      Offset(0.83, 0.50),
      fontSize: kLabelFontSize,
      pointerLine: Offset(0.64, 0.50),
    );
    paintTextNormalizedWithinAxis(
      c,
      canvas,
      DiagramLabel.inferiorGood.label,
      Offset(0.40, 0.10),
      fontSize: kLabelFontSize,
      pointerLine: Offset(0.40, 0.225),
    );
  }

  void _paintSupplyElastic(DiagramPainterConfig c, Canvas canvas) {
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.supply,
      elasticityAngle: 0.40, // flatter (elastic)
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
      elasticityAngle: -0.40, // flatter (elastic)
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
}
