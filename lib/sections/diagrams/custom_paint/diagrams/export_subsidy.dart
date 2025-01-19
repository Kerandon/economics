import 'package:economics_app/sections/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_axis.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_curve.dart';
import 'package:economics_app/sections/diagrams/enums/label_align.dart';
import 'package:economics_app/sections/diagrams/models/diagram_painter_config.dart';
import 'package:flutter/material.dart';
import '../../models/base_painter_painter.dart';
import '../../models/diagram_model.dart';

class ExportSubsidy extends BaseDiagramPainter {
  ExportSubsidy({
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
      Offset(0.70, 0.25),
      label2: kSd,
      label2Align: LabelAlign.centerRight,
    );

    /// Supply + export sub
    paintCurve(
      c,
      canvas,
      Offset(0.29, 0.75),
      Offset(0.75, 0.28),
      label2: kDomesticSupplySubsidy,
      label2Align: LabelAlign.centerRight,
    );

    /// World Line
    paintCurve(c, canvas, Offset(kAxisIndent, 0.40), Offset(0.75, 0.41),
        label2: kWorldPrice, label2Align: LabelAlign.centerRight);

    /// World Line + export subsidy
    paintCurve(c, canvas, Offset(kAxisIndent, 0.32), Offset(0.75, 0.32),
        label2: kWorldPriceSubsidy, label2Align: LabelAlign.centerRight);
  }
}
