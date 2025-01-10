import 'package:economics_app/sections/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_axis.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_curve.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_diagram_dash_lines.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_text_box.dart';
import 'package:flutter/material.dart';
import '../../../../../app/configs/constants.dart';
import '../../../enums/label_align.dart';
import '../../../models/base_painter_painter.dart';
import '../../../models/diagram_model.dart';
import '../../../models/diagram_painter_config.dart';

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
      xAxisEndPos: 0.36,
      yLabel: kPm,
      xLabel: kQm,
    );

    /// Dashed Lines Optimum
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.40,
      xAxisEndPos: 0.25,
      yLabel: kPOpt,
      xLabel: kQOpt,
    );

    paintAxis(
      c,
      canvas,
      yAxisLabel: kP,
      xAxisLabel: kQ,
    );

    /// Demand
    paintCurve(
      c,
      canvas,
      Offset(0.20, 0.20),
      Offset(0.80, 0.80),
      label2: kDMPBMSB,
      label2Align: LabelAlign.centerRight,
    );

    /// Supply
    paintCurve(
      c,
      canvas,
      Offset(0.20, 0.80),
      Offset(0.80, 0.20),
      label2: kMPC,
      label2Align: LabelAlign.centerRight,
    );

    /// MSC
    paintCurve(
      c,
      canvas,
      Offset(0.20, 0.60),
      Offset(0.72, 0.10),
      label2: kMSC,
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

    /// Explanation
    paintTextBox(c, canvas,
        scale: kTextBoxScale,
        text: 'External cost caused by\noverfishing',
        position: Offset(0.80, 0.45));
    paintCurve(
      c,
      color: c.colorScheme.onSurface,
      canvas,
      strokeWidth: kSkinnyCurveWidth,
      Offset(0.75, 0.40),
      Offset(0.70, 0.28),
    );
  }
}
