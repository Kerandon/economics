import 'package:flutter/material.dart';
import '../../enums/diagram_labels.dart';
import '../../enums/diagram_subtype.dart';
import '../../enums/label_align.dart';
import '../../models/base_painter_painter.dart';
import '../../models/diagram_model.dart';
import '../../models/diagram_painter_config.dart';
import '../painter_methods/paint_axis.dart';
import '../painter_methods/paint_diagram_custom_lines.dart';
import '../painter_methods/paint_diagram_dash_lines.dart';
import '../painter_methods/paint_text_normalized_within_axis.dart';
import '../painter_methods/paint_title.dart';

class InternationalTrade extends BaseDiagramPainter {
  InternationalTrade({
    required DiagramPainterConfig config,
    required DiagramModel model,
  }) : super(config, model);

  @override
  void paint(Canvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);

    paintAxis(c, canvas, yAxisLabel:  DiagramLabel.price.label, xAxisLabel: DiagramLabel.q.label);

    if (model.subtype == DiagramSubtype.worldPrice) {
      paintTitle(c, canvas, 'World Market');
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.50,
        xAxisEndPos: 1.2,
        yLabel: DiagramLabel.pW.label,
        hideXLine: true,
      );
      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(0.10, 0.10),
        polylineOffsets: [Offset(0.90, 0.90),],
        label2: DiagramLabel.dD.label,
        label2Align: LabelAlign.centerRight,
      );
      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(0.10, 0.90),
        polylineOffsets: [Offset(0.90, 0.10),],
        label2: DiagramLabel.sD.label,
        label2Align: LabelAlign.centerRight,
      );
    }

    if (model.subtype == DiagramSubtype.importer) {
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
      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(0.10, 0.10),
        polylineOffsets: [ Offset(0.95, 0.65),],
        label2: DiagramLabel.dD.label,
        label2Align: LabelAlign.centerRight,
      );
      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(0.10, 0.65),
        polylineOffsets: [Offset(0.95, 0.10),],
        label2: DiagramLabel.sD.label,
        label2Align: LabelAlign.centerRight,
      );
      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(0, 0.50),
        polylineOffsets: [Offset(1.0, 0.50),],
        label1: DiagramLabel.pW.label,
        label1Align: LabelAlign.centerLeft,
        label2: DiagramLabel.sW.label,
        label2Align: LabelAlign.centerRight,
      );
      paintCustomDiagramLines(c, canvas,
          startPos: Offset(0.30, 1.1),
          polylineOffsets: [
            Offset(0.30, 1.15),
            Offset(0.30, 1.15),
            Offset(0.70, 1.15),
            Offset(0.70, 1.10)
          ],
          arrowOnStart: true,
          arrowOnEnd: true,
          color: Colors.orange);
      paintTextNormalizedWithinAxis(c, canvas, 'Q2 - Q1 is imported', Offset(0.50, 1.20));
    }
    if (model.subtype == DiagramSubtype.exporter) {
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
      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(0.10, 0.35),
        polylineOffsets: [ Offset(0.90, 0.90),],
        label2: DiagramLabel.dD.label,
        label2Align: LabelAlign.centerRight,
      );
      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(0.10, 0.90),
        polylineOffsets: [Offset(0.90, 0.35),],
        label2: DiagramLabel.sD.label,
        label2Align: LabelAlign.centerRight,
      );
      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(0, 0.50),
        polylineOffsets: [Offset(1.0, 0.50),],
        label1: DiagramLabel.pW.label,
        label1Align: LabelAlign.centerLeft,
        label2: DiagramLabel.sW.label,
        label2Align: LabelAlign.centerRight,
      );
      paintCustomDiagramLines(c, canvas,
          startPos: Offset(0.30, 1.1),
          polylineOffsets: [
            Offset(0.30, 1.15),
            Offset(0.30, 1.15),
            Offset(0.70, 1.15),
            Offset(0.70, 1.10)
          ],
          arrowOnStart: true,
          arrowOnEnd: true,
          color: Colors.orange);
      paintTextNormalizedWithinAxis(c, canvas, 'Q2 - Q1 is Exported', Offset(0.50, 1.20));
    }
  }
}
