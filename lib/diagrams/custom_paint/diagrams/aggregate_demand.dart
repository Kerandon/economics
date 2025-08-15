import 'dart:math';
import 'dart:ui';

import '../../enums/diagram_labels.dart';
import '../../enums/diagram_subtype.dart';
import '../../enums/label_align.dart';
import '../../models/base_painter_painter.dart';
import '../../models/diagram_model.dart';
import '../../models/diagram_painter_config.dart';
import '../painter_methods/paint_axis.dart';
import '../painter_methods/paint_diagram_custom_lines.dart';

class AggregateDemand extends BaseDiagramPainter {
  AggregateDemand({
    required DiagramPainterConfig config,
    required DiagramModel model,
  }) : super(config, model);

  @override
  void paint(Canvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);

    paintAxis(
      c,
      canvas,
      yAxisLabel: DiagramLabel.priceLevel.label,
      xAxisLabel: DiagramLabel.realGDP.label,
    );

    var aDLabel = DiagramLabel.aggregateDemand.label;
    if (model.subtype == DiagramSubtype.determinants) {
      aDLabel = DiagramLabel.aD1.label;
    }
    paintCustomDiagramLines(
      c,
      canvas,
      startPos: Offset(0.25, 0.20),
      polylineOffsets: [Offset(0.75, 0.80)],
      label2: aDLabel,
      label2Align: LabelAlign.centerRight,
    );
    if (model.subtype == DiagramSubtype.determinants) {
      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(0.50, 0.20),
        polylineOffsets: [Offset(1.0, 0.80)],
        label2: DiagramLabel.aD2.label,
        label2Align: LabelAlign.centerRight,
      );
      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(0.05, 0.25),
        polylineOffsets: [Offset(0.50, 0.80)],
        label2: DiagramLabel.aD3.label,
        label2Align: LabelAlign.centerRight,
      );
      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(0.57, 0.50),
        polylineOffsets: [Offset(0.65, 0.50)],
        arrowOnEnd: true,
        arrowOnEndAngle: pi / 2,
      );
      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(0.43, 0.50),
        polylineOffsets: [Offset(0.35, 0.50)],
        arrowOnEnd: true,
        arrowOnEndAngle: pi / -2,
      );
    }
  }
}
