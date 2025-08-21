import 'dart:math';
import 'dart:ui';

import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_title.dart';
import '../../enums/diagram_bundle_enum.dart';
import '../../enums/diagram_labels.dart';
import '../../enums/diagram_subtype.dart';
import '../../enums/label_align.dart';
import '../../models/base_painter_painter.dart';
import '../../models/diagram_model.dart';
import '../../models/diagram_painter_config.dart';
import '../painter_methods/paint_axis.dart';
import '../painter_methods/paint_diagram_dash_lines.dart';
import '../painter_methods/paint_diagram_lines.dart';

class Supply extends BaseDiagramPainter {
  Supply({required DiagramPainterConfig config, required DiagramModel model})
    : super(config, model);

  @override
  void paint(Canvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);

    var supplyLabel = DiagramLabel.supply.label;

    if (model.diagramBundleEnum == DiagramBundleEnum.microSupplyPriceChanges) {
      paintTitle(c, canvas, 'Title');
    }

    if (model.subtype == DiagramSubtype.priceChange) {
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.30,
        xAxisEndPos: 0.30,
      );
    }

    if (model.subtype == DiagramSubtype.determinants) {
      supplyLabel = DiagramLabel.s1.label;
    }

    paintAxis(
      c,
      canvas,
      yAxisLabel: DiagramLabel.p.label,
      xAxisLabel: DiagramLabel.q.label,
    );

    paintDiagramLines(
      c,
      canvas,
      startPos: Offset(0.20, 0.80),
      polylineOffsets: [Offset(0.80, 0.20)],
      label2: supplyLabel,
      label2Align: LabelAlign.centerRight,
    );

    if (model.subtype == DiagramSubtype.determinants) {
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.50,
        xAxisEndPos: 0.30,
        hideYLine: true,
        xLabel: DiagramLabel.q2.label,
      );
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.50,
        xAxisEndPos: 0.50,
        hideYLine: true,
        xLabel: DiagramLabel.q1.label,
      );
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.50,
        xAxisEndPos: 0.700,
        yLabel: DiagramLabel.p.label,
        xLabel: DiagramLabel.q3.label,
      );
      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0.20, 0.80),
        polylineOffsets: [Offset(0.80, 0.20)],
        label2: supplyLabel,
        label2Align: LabelAlign.centerRight,
      );
      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0.10, 0.70),
        polylineOffsets: [Offset(0.70, 0.10)],
        label2: DiagramLabel.s2.label,
        label2Align: LabelAlign.centerRight,
      );
      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0.30, 0.90),
        polylineOffsets: [Offset(0.90, 0.30)],
        label2: DiagramLabel.s3.label,
        label2Align: LabelAlign.centerRight,
      );
      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0.66, 0.40),
        polylineOffsets: [Offset(0.74, 0.40)],
        arrowOnEnd: true,
        arrowOnEndAngle: pi * 0.5,
      );
      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0.46, 0.40),
        polylineOffsets: [Offset(0.54, 0.40)],
        arrowOnStart: true,
        arrowOnStartAngle: pi * 1.5,
      );
    }
  }
}

class Supply2 extends BaseDiagramPainter2 {
  Supply2(super.config, super.diagramBundleEnum);

  @override
  void paint(Canvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);

    if (diagramBundleEnum == DiagramBundleEnum.microSupplyPriceChanges) {
      paintAxis(c, canvas, xAxisLabel: 'Price Changes');
    }
    if (diagramBundleEnum == DiagramBundleEnum.microSupplyDeterminants) {
      paintAxis(c, canvas, xAxisLabel: 'Price Determinants');
    }
  }
}
