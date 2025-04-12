import 'package:economics_app/sections/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_axis.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_curve.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_diagram_dash_lines.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_shading.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_text_box.dart';
import 'package:economics_app/sections/diagrams/enums/axis_label_margin.dart';
import 'package:economics_app/sections/diagrams/enums/shade_type.dart';
import 'package:flutter/material.dart';

import '../../enums/label_align.dart';
import '../../models/base_painter_painter.dart';
import '../../models/diagram_model.dart';
import '../../models/diagram_painter_config.dart';

class NegativeProductionExternalities extends BaseDiagramPainter {
  NegativeProductionExternalities({
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
      yLabel: MicroLabel.pm.label,
      xLabel: MicroLabel.qm.label,
    );

    /// Dashed Lines Optimum
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.40,
      xAxisEndPos: 0.25,
      yLabel: MicroLabel.pOpt.label,
      xLabel: MicroLabel.qOpt.label,
    );

    paintShading(
      canvas,
      size,
      ShadeType.welfareLoss,
      [
        Offset(0.50, 0.50),
        Offset(0.40, 0.40),
        Offset(0.50, 0.31),
      ],
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

    /// MSC
    paintCurve(
      c,
      canvas,
      Offset(0.20, 0.60),
      Offset(0.72, 0.10),
      label2: MicroLabel.msc.label,
      label2Align: LabelAlign.centerRight,
    );

    /// Externality curve
    paintCurve(
      c,
      color: c.colorScheme.onSurface,
      canvas,
      (Offset(0.68, 0.28)),
      Offset(0.68, 0.18),
      drawArrowAtEnd: true,
      drawArrowAtStart: true,
    );

    paintTextBox(
      canvas: canvas,
      config: c,
      text: 'Welfare loss',
      position: Offset(0.40, 0.25),
      linePoint: Offset(0.45, 0.40),
      addLineDot: true,
    );
    paintTextBox(
      canvas: canvas,
      config: c,
      text: 'External cost',
      position: Offset(0.80, 0.35),
      linePoint: Offset(0.70, 0.25),
      addLineDot: true,
    );
  }
}
