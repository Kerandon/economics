import 'package:economics_app/sections/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_axis.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_custom_bezier.dart';
import 'package:economics_app/sections/diagrams/models/custom_bezier.dart';
import 'package:economics_app/sections/diagrams/models/diagram_painter_config.dart';
import 'package:flutter/material.dart';
import '../../../models/base_painter_painter.dart';
import '../../../models/diagram_model.dart';

class PhillipsCurve extends BaseDiagramPainter {
  PhillipsCurve({
    required DiagramPainterConfig config,
    required DiagramModel model,
  }) : super(config, model);

  @override
  void paint(Canvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);

    paintAxis(
      c,
      canvas,
      yAxisLabel: kInflationRate,
      xAxisLabel: kUnemploymentRate,
    );
    paintCustomBezier(c, canvas, startPos: Offset(0.25, 0.30), points: [
      CustomBezier(control: Offset(0.30, 0.70), endPoint: Offset(0.80, 0.75))
    ]);
  }
}
