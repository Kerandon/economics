import 'package:economics_app/sections/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_axis.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_curve.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_keyensian_curve.dart';
import 'package:economics_app/sections/diagrams/models/diagram_painter_config.dart';
import 'package:flutter/material.dart';
import '../../../enums/label_align.dart';
import '../../../models/base_painter_painter.dart';
import '../../../models/diagram_model.dart';
import '../../painter_methods/paint_diagram_dash_lines.dart';

class KeynesianADAS extends BaseDiagramPainter {
  KeynesianADAS({
    required DiagramPainterConfig config,
    required DiagramModel model,
  }) : super(config, model);

  @override
  void paint(Canvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);

    /// Dashed Lines
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.69,
      xAxisEndPos: 0.57,
      xLabel: kYe,
      hideYLine: true,
    );

    paintAxis(
      c,
      canvas,
      yAxisLabel: kPriceLevel,
      xAxisLabel: kRealGDP,
    );

    /// AD
    paintCurve(
      c,
      canvas,
      Offset(0.40, 0.30),
      Offset(0.77, 0.75),
      label2: kAD,
      label2Align: LabelAlign.centerRight,
    );

    paintKeynesianCurve(config: c, canvas: canvas);
  }
}
