import 'package:economics_app/sections/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_axis.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_curve.dart';
import 'package:economics_app/sections/diagrams/enums/label_align.dart';
import 'package:economics_app/sections/diagrams/models/diagram_painter_config.dart';
import 'package:flutter/material.dart';
import '../../../models/base_painter_painter.dart';
import '../../../models/diagram_model.dart';

class ProductionSubsidy extends BaseDiagramPainter {
  ProductionSubsidy({
    required DiagramPainterConfig config,
    required DiagramModel model,
  }) : super(config, model);

  @override
  void paint(Canvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);

    paintAxis(c, canvas, yAxisLabel: kPrice, xAxisLabel: kQ);

    /// Demand
    paintCurve(
      c,
      canvas,
      Offset(0.20, 0.25),
      Offset(0.75, 0.75),
      label2: kDd,
      label2Align: LabelAlign.centerRight,
    );

    /// Supply
    paintCurve(
      c,
      canvas,
      Offset(0.20, 0.75),
      Offset(0.75, 0.25),
      label2: kSd,
      label2Align: LabelAlign.centerRight,
    );

    /// Supply
    paintCurve(
      c,
      canvas,
      Offset(0.30, 0.75),
      Offset(0.75, 0.34),
      label2: kDomesticSupplySubsidy,
      label2Align: LabelAlign.centerRight,
    );

    /// World Line
    paintCurve(c, canvas, Offset(kAxisIndent, 0.65), Offset(0.75, 0.65),
        label2: kWorldSupply, label2Align: LabelAlign.centerRight);
  }
}
