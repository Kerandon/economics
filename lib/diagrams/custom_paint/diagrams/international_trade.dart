import 'package:economics_app/diagrams/enums/diagram_bundle_enum.dart';
import 'package:flutter/material.dart';
import '../../enums/diagram_labels.dart';
import '../painter_methods/axis/label_align.dart';
import '../../models/base_painter_painter.dart';
import '../painter_methods/axis/paint_axis.dart';
import '../painter_methods/paint_diagram_dash_lines.dart';
import '../painter_methods/diagram_lines/paint_diagram_lines.dart';
import '../painter_methods/paint_title.dart';
import '../painter_methods/shortcut_methods/paint_demand.dart';
import '../painter_methods/shortcut_methods/paint_supply.dart';

class InternationalTrade extends BaseDiagramPainter2 {
  InternationalTrade(super.config, super.diagramBundleEnum);

  @override
  void paint(Canvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);

    paintAxis(
      c,
      canvas,
      yAxisLabel: DiagramLabel.price.label,
      xAxisLabel: DiagramLabel.q.label,
    );
    if (diagramBundleEnum == DiagramBundleEnum.globalWorldPriceStandAlone) {
      paintTitle(c, canvas, 'World Market');
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.50,
        xAxisEndPos: 1,
        yLabel: DiagramLabel.pW.label,
        hideXLine: true,
      );
      paintDemand(c, canvas, label: DiagramLabel.dW.label);
      paintSupply(c, canvas, label: DiagramLabel.sW.label);
    }
    if (diagramBundleEnum == DiagramBundleEnum.globalWorldPrice) {
      paintTitle(c, canvas, 'World Market');
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.50,
        xAxisEndPos: 1.2,
        yLabel: DiagramLabel.pW.label,
        hideXLine: true,
      );
      paintDemand(c, canvas, label: DiagramLabel.dW.label);
      paintSupply(c, canvas, label: DiagramLabel.sW.label);
    }
    if (diagramBundleEnum == DiagramBundleEnum.globalNetImporter) {
      paintTitle(c, canvas, 'Domestic Market - Importer');
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.38,
        xAxisEndPos: 0.525,
        yLabel: DiagramLabel.pD.label,
        xLabel: DiagramLabel.qD.label,
      );
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.50,
        xAxisEndPos: 0.33,
        xLabel: DiagramLabel.q1.label,
        hideYLine: true,
      );
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.50,
        xAxisEndPos: 0.715,
        xLabel: DiagramLabel.q2.label,
        hideYLine: true,
      );
      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0.10, 0.10),
        polylineOffsets: [Offset(0.95, 0.65)],
        label2: DiagramLabel.dD.label,
        label2Align: LabelAlign.centerRight,
      );
      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0.10, 0.65),
        polylineOffsets: [Offset(0.95, 0.10)],
        label2: DiagramLabel.sD.label,
        label2Align: LabelAlign.centerRight,
      );
      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0, 0.50),
        polylineOffsets: [Offset(1.0, 0.50)],
        label1: DiagramLabel.pW.label,
        label1Align: LabelAlign.centerLeft,
        label2: DiagramLabel.sW.label,
        label2Align: LabelAlign.centerRight,
      );
    }
    if (diagramBundleEnum == DiagramBundleEnum.globalNetExporter) {
      paintTitle(c, canvas, 'Domestic Market - Exporter');
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.625,
        xAxisEndPos: 0.50,
        yLabel: DiagramLabel.pD.label,
        xLabel: DiagramLabel.qD.label,
      );
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.50,
        xAxisEndPos: 0.31,
        xLabel: DiagramLabel.q1.label,
        hideYLine: true,
      );
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.50,
        xAxisEndPos: 0.69,
        xLabel: DiagramLabel.q2.label,
        hideYLine: true,
      );
      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0.10, 0.35),
        polylineOffsets: [Offset(0.90, 0.90)],
        label2: DiagramLabel.dD.label,
        label2Align: LabelAlign.centerRight,
      );
      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0.10, 0.90),
        polylineOffsets: [Offset(0.90, 0.35)],
        label2: DiagramLabel.sD.label,
        label2Align: LabelAlign.centerRight,
      );
      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0, 0.50),
        polylineOffsets: [Offset(1.0, 0.50)],
        label1: DiagramLabel.pW.label,
        label1Align: LabelAlign.centerLeft,
        label2: DiagramLabel.sW.label,
        label2Align: LabelAlign.centerRight,
      );
    }
  }
}
