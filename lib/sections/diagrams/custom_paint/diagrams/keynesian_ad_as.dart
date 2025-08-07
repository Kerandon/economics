import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_axis.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_curve.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_keyensian_curve.dart';
import 'package:economics_app/sections/diagrams/enums/diagram_labels.dart';
import 'package:economics_app/sections/diagrams/enums/diagram_subtype.dart';
import 'package:economics_app/sections/diagrams/models/diagram_painter_config.dart';
import 'package:flutter/material.dart';
import '../../enums/label_align.dart';
import '../../models/base_painter_painter.dart';
import '../../models/diagram_model.dart';
import '../painter_methods/paint_diagram_dash_lines.dart';

class KeynesianADAS extends BaseDiagramPainter {
  KeynesianADAS({
    required DiagramPainterConfig config,
    required DiagramModel model,
  }) : super(config, model);

  @override
  void paint(Canvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);

    if(model.subtype == DiagramSubtype.fullEmploymentKeynesian){
      /// Dashed Lines
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.82,
        xAxisEndPos: 0.77,
        xLabel: DiagramLabel.yE.label,
      );

    }

    paintAxis(
      c,
      canvas,
      yAxisLabel: DiagramLabel.priceLevel.label,
      xAxisLabel: DiagramLabel.realGDP.label,
    );

    /// AD
    paintCurve(
      c,
      canvas,
      Offset(0.45, 0.30),
      Offset(0.80, 0.75),
      label2: DiagramLabel.aD.label,
      label2Align: LabelAlign.centerRight,
    );

    paintKeynesianCurve(config: c, canvas: canvas);
  }
}
