import 'package:economics_app/sections/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_axis.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_curve.dart';
import 'package:economics_app/sections/diagrams/enums/diagram_subtype.dart';
import 'package:economics_app/sections/diagrams/enums/label_align.dart';
import 'package:economics_app/sections/diagrams/models/diagram_painter_config.dart';
import 'package:flutter/material.dart';
import '../../models/base_painter_painter.dart';
import '../../models/diagram_model.dart';
import '../painter_methods/paint_diagram_custom_lines.dart';

class InternationalTrade extends BaseDiagramPainter {
  InternationalTrade({
    required DiagramPainterConfig config,
    required DiagramModel model,
  }) : super(config, model);

  @override
  void paint(Canvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);

    paintAxis(c, canvas, yAxisLabel: kPrice, xAxisLabel: kQ);

    if(model.subtype == DiagramSubtype.worldPrice){
      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(0.10, 0.10),
        straightEndPos: Offset(0.90, 0.90),
        label2: DiagramLabel.dD.label,
        label2Align: LabelAlign.centerRight,
      );
      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(0.10, 0.90),
        straightEndPos: Offset(0.90, 0.10),
        label2: DiagramLabel.sD.label,
        label2Align: LabelAlign.centerRight,
      );
    }

    if (model.subtype == DiagramSubtype.importer) {

    }
    if (model.subtype == DiagramSubtype.exporter) {

    }
  }
}
