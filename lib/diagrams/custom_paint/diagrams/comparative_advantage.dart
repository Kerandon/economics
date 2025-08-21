import 'package:flutter/material.dart';
import '../../enums/diagram_labels.dart';
import '../../enums/diagram_subtype.dart';
import '../../models/base_painter_painter.dart';
import '../../models/diagram_model.dart';
import '../../models/diagram_painter_config.dart';
import '../painter_methods/paint_axis.dart';
import '../painter_methods/paint_diagram_lines.dart';

class ComparativeAdvantage extends BaseDiagramPainter {
  ComparativeAdvantage({
    required DiagramPainterConfig config,
    required DiagramModel model,
  }) : super(config, model);

  @override
  void paint(Canvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);

    paintAxis(
      c,
      canvas,
      yAxisLabel: DiagramLabel.goodA.label,
      yLabelIsVertical: false,
      xAxisLabel: DiagramLabel.goodB.label,
    );

    if (model.subtype == DiagramSubtype.absoluteAdvantage) {
      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0, 0.20),
        polylineOffsets: [Offset(0.60, 1.0)],
      );
    }
    if (model.subtype == DiagramSubtype.comparativeAdvantage) {}
    if (model.subtype == DiagramSubtype.noGainsFromTrade) {}
  }
}
