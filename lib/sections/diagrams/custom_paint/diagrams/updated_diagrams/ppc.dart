import 'package:economics_app/sections/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_axis.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_custom_bezier.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_dot.dart';
import 'package:economics_app/sections/diagrams/models/custom_bezier.dart';
import 'package:flutter/material.dart';
import '../../../models/base_painter_painter.dart';
import '../../../models/diagram_model.dart';
import '../../../models/diagram_painter_config.dart';

class PPC extends BaseDiagramPainter {
  PPC({
    required DiagramPainterConfig config,
    required DiagramModel model,
  }) : super(config, model);

  @override
  void paint(Canvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);

    paintAxis(
      c,
      canvas,
      xAxisLabel: kConsumerGoods,
      yAxisLabel: kCapitalGoods,
    );
    paintCustomBezier(
      c,
      canvas,
      startPos: Offset(kAxisIndent, 0.20),
      points: [
        CustomBezier(
          control: Offset(0.70, 0.35),
          endPoint: Offset(
            0.80,
            (1 - kAxisIndent),
          ),
        ),
      ],
    );
    paintDot(c, canvas, pos: Offset(0.30, 0.30));
  }
}
