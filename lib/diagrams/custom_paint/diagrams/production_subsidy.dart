import 'package:economics_app/diagrams/custom_paint/painter_methods/legend/paint_legend.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_text.dart';
import 'package:economics_app/diagrams/enums/diagram_bundle_enum.dart';
import 'package:flutter/material.dart';
import '../../enums/diagram_labels.dart';
import '../painter_methods/axis/label_align.dart';
import '../painter_methods/legend/legend_display.dart';
import '../painter_methods/legend/legend_entry.dart';
import '../shade/shade_type.dart';
import '../../models/base_painter_painter.dart';
import '../painter_methods/axis/paint_axis.dart';
import '../painter_methods/paint_diagram_dash_lines.dart';
import '../painter_methods/diagram_lines/paint_diagram_lines.dart';
import '../shade/paint_shading.dart';

class ProductionSubsidy extends BaseDiagramPainter2 {
  ProductionSubsidy(
    super.config,
    super.bundle, {
    super.legendDisplay,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);

    if (legendDisplay == LegendDisplay.shading) {
      paintText(c, canvas, 'FUCK ITS SHADING', Offset(0.50, 0.50));
    }
    if (legendDisplay == LegendDisplay.letters) {
      paintText(c, canvas, 'FUCK ITS LETTERS', Offset(0.50, 0.50));
    }
    paintAxis(
      c,
      canvas,
      yAxisLabel: DiagramLabel.price.label,
      xAxisLabel: DiagramLabel.quantity.label,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.80,
      xAxisEndPos: 0.20,
      xLabel: DiagramLabel.q1.label,
      hideYLine: true,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.60,
      yLabel: DiagramLabel.pSub.label,
      xAxisEndPos: 0.40,
      xLabel: DiagramLabel.q2.label,
    );

    paintDiagramLines(
      c,
      canvas,
      startPos: Offset(0.10, 0.10),
      polylineOffsets: [Offset(0.90, 0.90)],
      label2: DiagramLabel.dD.label,
      label2Align: LabelAlign.centerRight,
    );
    paintDiagramLines(
      c,
      canvas,
      startPos: Offset(0.10, 0.90),
      polylineOffsets: [Offset(0.90, 0.10)],
      label2: DiagramLabel.sD.label,
      label2Align: LabelAlign.centerRight,
    );
    paintDiagramLines(
      c,
      canvas,
      startPos: Offset(0.30, 0.90),
      polylineOffsets: [Offset(0.90, 0.30)],
      label2: DiagramLabel.sDSub.label,
      label2Align: LabelAlign.centerRight,
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
    if (bundle == DiagramBundleEnum.globalProductionSubsidyWelfare) {
      _paintWelfareLoss(canvas, size);
      _paintConsumerSurplus(canvas, size);
      _paintProducerSurplus(canvas, size);
      paintLegend(canvas, size, [
        LegendEntry.fromShade(ShadeType.consumerSurplus),
        LegendEntry.fromShade(ShadeType.producerSurplus),
        LegendEntry.fromShade(ShadeType.welfareLoss),
      ]);
    }
    if (bundle ==
        DiagramBundleEnum.globalProductionSubsidyConsumerSurplus) {
      _paintConsumerSurplus(canvas, size);
      paintLegend(canvas, size, [
        LegendEntry.fromShade(ShadeType.consumerSurplus),
      ]);
    }
    if (bundle ==
        DiagramBundleEnum.globalProductionSubsidyProducerSurplusChange) {
      _originalProducerSurplus(canvas, size);
      paintShading(canvas, size, ShadeType.gainedProducerSurplus, [
        Offset(0.0, 0.80),
        Offset(0.20, 0.80),
        Offset(0.40, 0.60),
        Offset(0.0, 0.60),
      ]);
      paintLegend(canvas, size, [
        LegendEntry.fromShade(ShadeType.originalProducerSurplus),
        LegendEntry.fromShade(ShadeType.gainedProducerSurplus),
      ]);
    }
  }

  void _originalProducerSurplus(Canvas canvas, Size size) {
    paintShading(canvas, size, ShadeType.producerSurplus, [
      Offset(0.0, 1.0),
      Offset(0.20, 0.80),
      Offset(0.0, 0.80),
    ]);
  }

  void _paintProducerSurplus(Canvas canvas, Size size) {
    paintShading(canvas, size, ShadeType.producerSurplus, [
      Offset(0.0, 1.0),
      Offset(0.40, 0.60),
      Offset(0.0, 0.60),
    ]);
  }

  void _paintConsumerSurplus(Canvas canvas, Size size) {
    paintShading(canvas, size, ShadeType.consumerSurplus, invertStripes: true, [
      Offset(0.0, 0.0),
      Offset(0.0, 0.80),
      Offset(0.80, 0.80),
    ]);
  }

  void _paintWelfareLoss(Canvas canvas, Size size) {
    paintShading(canvas, size, ShadeType.welfareLoss, [
      Offset(0.20, 0.80),
      Offset(0.40, 0.80),
      Offset(0.40, 0.60),
    ]);
  }
}
