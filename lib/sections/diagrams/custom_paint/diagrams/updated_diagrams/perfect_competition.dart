import 'package:economics_app/sections/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_axis.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_curve.dart';
import 'package:economics_app/sections/diagrams/models/diagram_painter_config.dart';
import 'package:flutter/material.dart';
import '../../../enums/label_align.dart';
import '../../../models/base_painter_painter.dart';
import '../../../models/diagram_model.dart';

class PerfectCompetition extends BaseDiagramPainter {
  PerfectCompetition({
    required DiagramPainterConfig config,
    required DiagramModel model,
  }) : super(config, model);

  @override
  void paint(Canvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);
    paintAxis(
      c,
      canvas,
      yAxisLabel: kPriceCostsRevenue,
      xAxisLabel: kQuantity,
    );

    paintCurve(c, canvas, Offset(kAxisIndent, 0.50), Offset(0.80, 0.5),
    label2: kPARMR, label2Align: LabelAlign.centerRight

    );
  }
}
