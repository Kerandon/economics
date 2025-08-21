import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_demand.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_legend.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_supply.dart';
import 'package:economics_app/diagrams/enums/diagram_bundle_enum.dart';
import 'package:flutter/material.dart';
import '../../enums/diagram_labels.dart';
import '../../enums/label_align.dart';
import '../../enums/shade_type.dart';
import '../../models/base_painter_painter.dart';
import '../painter_methods/paint_axis.dart';
import '../painter_methods/paint_diagram_dash_lines.dart';
import '../painter_methods/paint_diagram_lines.dart';
import '../painter_methods/paint_shading.dart';

class Tariff extends BaseDiagramPainter2 {
  Tariff(super.config, super.diagramBundleEnum);

  @override
  void paint(Canvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);

    if (diagramBundleEnum == DiagramBundleEnum.globalTariffConsumerSurplus) {
      paintConsumerSurplus(canvas, size);
    }
    if (diagramBundleEnum ==
        DiagramBundleEnum.globalTariffConsumerSurplusChange) {
      paintConsumerSurplus(canvas, size);
    }

    if (diagramBundleEnum ==
        DiagramBundleEnum.globalTariffConsumerSurplusChange) {
      paintShading(canvas, size, ShadeType.lost, [
        Offset(0, 0.65),
        Offset(0.65, 0.65),
        Offset(0.80, 0.80),
        Offset(0, 0.80),
      ]);

      paintLegend(canvas, size, [
        LegendEntry.fromShade(ShadeType.consumerSurplus),
        LegendEntry.fromShade(
          ShadeType.lost,
          customLabel: 'Lost Consumer Surplus',
        ),
      ]);
    }
    if (diagramBundleEnum ==
        DiagramBundleEnum.globalTariffProducerSurplusChange) {
      paintShading(canvas, size, ShadeType.gained, [
        Offset(0.0, 0.65),
        Offset(0.35, 0.65),
        Offset(0.20, 0.80),
        Offset(0.0, 0.80),
      ]);
      paintShading(canvas, size, ShadeType.producerSurplus, [
        Offset(0.0, 0.80), // extend left bottom
        Offset(0.20, 0.80), // q1 at pWT
        Offset(0, 1.0), // q1 at supply curve (base)
      ]);
      paintLegend(canvas, size, [
        LegendEntry.fromShade(ShadeType.producerSurplus),
        LegendEntry.fromShade(
          ShadeType.gained,
          customLabel: 'Gained Producer Surplus',
        ),
      ]);
    }
    if (diagramBundleEnum == DiagramBundleEnum.globalTariffGovernmentRevenue) {
      paintGovernmentRevenue(canvas, size);
      paintLegend(canvas, size, [
        LegendEntry.fromShade(ShadeType.governmentRevenue),
      ]);
    }
    if (diagramBundleEnum == DiagramBundleEnum.globalTariffWelfareLoss) {
      paintWelfareLossLeft(canvas, size);

      paintWelfareLossRight(canvas, size);
      paintLegend(canvas, size, [LegendEntry.fromShade(ShadeType.welfareLoss)]);
    }
    if (diagramBundleEnum == DiagramBundleEnum.globalTariffWelfare) {
      paintGovernmentRevenue(canvas, size);
      paintWelfareLossRight(canvas, size);
      paintWelfareLossLeft(canvas, size);
      paintConsumerSurplus(canvas, size);
      paintShading(canvas, size, ShadeType.producerSurplus, [
        Offset(0.0, 0.65), // extend left bottom
        Offset(0.35, 0.65), // q1 at pWT
        Offset(0, 1.0), // q1 at supply curve (base)
      ]);
      paintLegend(canvas, size, [
        LegendEntry.fromShade(ShadeType.consumerSurplus),
        LegendEntry.fromShade(ShadeType.producerSurplus),
        LegendEntry.fromShade(ShadeType.governmentRevenue),
        LegendEntry.fromShade(ShadeType.welfareLoss),
      ]);
    }
    paintAxis(
      c,
      canvas,
      yAxisLabel: DiagramLabel.price.label,
      xAxisLabel: DiagramLabel.quantity.label,
    );
    paintDemand(c, canvas, extend: true, label: DiagramLabel.dD.label);
    paintSupply(c, canvas, extend: true, label: DiagramLabel.sD.label);
    paintDiagramLines(
      c,
      canvas,
      startPos: Offset(0.0, 0.65),
      polylineOffsets: [Offset(0.90, 0.65)],
      label1: DiagramLabel.pWT.label,
      label1Align: LabelAlign.centerLeft,
      label2: DiagramLabel.sWT.label,
      label2Align: LabelAlign.centerRight,
      color: Colors.deepOrange,
    );
    paintDiagramLines(
      c,
      canvas,
      startPos: Offset(0.0, 0.80),
      polylineOffsets: [Offset(0.90, 0.80)],
      label1: DiagramLabel.pW.label,
      label1Align: LabelAlign.centerLeft,
      label2: DiagramLabel.sW.label,
      label2Align: LabelAlign.centerRight,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.80,
      xAxisEndPos: 0.20,
      hideYLine: true,
      xLabel: DiagramLabel.q1.label,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.80,
      xAxisEndPos: 0.80,
      hideYLine: true,
      xLabel: DiagramLabel.q4.label,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.65,
      xAxisEndPos: 0.35,
      hideYLine: true,
      xLabel: DiagramLabel.q2.label,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.65,
      xAxisEndPos: 0.65,
      hideYLine: true,
      xLabel: DiagramLabel.q3.label,
    );
  }

  void paintConsumerSurplus(Canvas canvas, Size size) {
    paintShading(canvas, size, ShadeType.consumerSurplus, [
      Offset(0.0, 0.0), // q1 at pWT
      Offset(0.65, 0.65), // q2 at pWT
      Offset(0.0, 0.65), // approximate top of demand curve (midpoint)
    ]);
  }

  void paintWelfareLossLeft(Canvas canvas, Size size) {
    paintShading(canvas, size, ShadeType.welfareLoss, [
      Offset(0.20, 0.80), // q1 at pW
      Offset(0.35, 0.80), // q3 at pW
      Offset(0.35, 0.65), // q3 at pWT
    ]);
  }

  void paintWelfareLossRight(Canvas canvas, Size size) {
    paintShading(canvas, size, ShadeType.welfareLoss, [
      Offset(0.65, 0.80), // q4 at pW
      Offset(0.80, 0.80), // q2 at pW
      Offset(0.65, 0.65), // q4 at pWT
    ]);
  }

  void paintGovernmentRevenue(Canvas canvas, Size size) {
    paintShading(canvas, size, ShadeType.governmentRevenue, [
      Offset(0.35, 0.80), // q3 at pW
      Offset(0.65, 0.80), // q4 at pW
      Offset(0.65, 0.65), // q4 at pWT
      Offset(0.35, 0.65), // q3 at pWT
    ]);
  }
}
