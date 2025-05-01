import 'package:economics_app/sections/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_axis.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_curve.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_diagram_dash_lines.dart';
import 'package:economics_app/sections/diagrams/enums/axis_label_margin.dart';
import 'package:flutter/material.dart';
import '../../enums/label_align.dart';
import '../../models/base_painter_painter.dart';
import '../../models/diagram_model.dart';
import '../../models/diagram_painter_config.dart';

class SupplyDemand extends BaseDiagramPainter {
  SupplyDemand({
    required DiagramPainterConfig config,
    required DiagramModel model,
  }) : super(config, model);

  @override
  void paint(Canvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);

    /// Dashed Lines market
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.50,
      xAxisEndPos: 0.35,
      yLabel: MicroLabel.pe.label,
      xLabel: MicroLabel.qe.label,
    );

    paintAxis(
      c,
      canvas,
      yAxisLabel: MicroLabel.p.label,
      xAxisLabel: MicroLabel.q.label,
      axisLabelMargin: AxisLabelMargin.close,
    );

    /// Demand
    paintCurve(
      c,
      canvas,
      Offset(0.20, 0.20),
      Offset(0.80, 0.80),
      label2: MicroLabel.dEqualsMPBMSB.label,
      label2Align: LabelAlign.centerRight,
    );

    /// Supply
    paintCurve(
      c,
      canvas,
      Offset(0.20, 0.80),
      Offset(0.80, 0.20),
      label2: MicroLabel.mpc.label,
      label2Align: LabelAlign.centerRight,
    );
  }
}
