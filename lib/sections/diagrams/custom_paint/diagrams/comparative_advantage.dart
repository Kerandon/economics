import 'package:economics_app/sections/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_axis.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_diagram_custom_lines.dart';
import 'package:economics_app/sections/diagrams/enums/diagram_subtype.dart';
import 'package:economics_app/sections/diagrams/models/diagram_painter_config.dart';
import 'package:flutter/material.dart';
import '../../models/base_painter_painter.dart';
import '../../models/diagram_model.dart';

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
      paintCustomDiagramLines(c, canvas,
          startPos: Offset(0, 0.20),
          polylineOffsets: [Offset(0.60, 1.0),],);
    }
    if (model.subtype == DiagramSubtype.comparativeAdvantage) {}
    if (model.subtype == DiagramSubtype.noGainsFromTrade) {}
  }
}
