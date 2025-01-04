import 'package:economics_app/sections/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_axis.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_curve.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_diagram_dash_lines.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_shading.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_text_box.dart';
import 'package:economics_app/sections/diagrams/enums/curve_align.dart';
import 'package:economics_app/sections/diagrams/enums/shade_type.dart';
import 'package:flutter/material.dart';
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
      xAxisEndPos: 0.41,
      yLabel: kMicroLabelPm,
      xLabel: kMicroLabelQm,
    );

    /// Dashed Lines Optimum
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.40,
      xAxisEndPos: 0.29,
      yLabel: kMicroLabelPOpt,
      xLabel: kMicroLabelQOpt,
    );

    paintAxis(
      c,
      canvas,
      yAxisLabel: kMicroLabelPriceOfFish,
      xAxisLabel: kMicroLabelQuantityOfFish,
    );

    /// Welfare-loss
    paintShading(canvas, size, ShadeType.welfareLoss, [
      Offset(0.55, 0.30),
      Offset(0.55, 0.50),
      Offset(0.43, 0.40),
    ]);

    /// Explanation
    paintTextBox(c, canvas,
        scale: 0.15, text: 'Welfare-loss', position: Offset(0.42, 0.25));
    paintCurve(
      c,
      canvas,
      color: config.colorScheme.onSurface,
      strokeWidth: kSkinnyCurveWidth,
      Offset(0.45, 0.28),
      Offset(0.50, 0.40),
    );

    /// Demand
    paintCurve(
      c,
      canvas,
      Offset(0.20, 0.20),
      Offset(0.90, 0.80),
      label2: kMicroLabelDMPBMSB,
      label2Align: CurveAlign.centerRight,
    );

    /// Supply
    paintCurve(
      c,
      canvas,
      Offset(0.20, 0.80),
      Offset(0.90, 0.20),
      label2: kMicroLabelSMPC,
      label2Align: CurveAlign.centerRight,
    );

    /// MSC
    paintCurve(
      c,
      canvas,
      Offset(0.20, 0.60),
      Offset(0.78, 0.10),
      label2: kMicroLabelSMSC,
      label2Align: CurveAlign.centerRight,
    );

    /// Externality curve
    paintCurve(
      c,
      canvas,
      (Offset(0.68, 0.35)),
      Offset(0.68, 0.22),
      color: config.colorScheme.onSurface,
      drawArrowAtEnd: true,
      drawArrowAtStart: true,
    );

    /// Explanation
    paintTextBox(c, canvas,
        scale: 0.15,
        text:
            'Externality caused by\noverfishing and \ndepletion of fish-stocks',
        position: Offset(0.90, 0.45));
    paintCurve(
      c,
      canvas,
      color: config.colorScheme.onSurface,
      strokeWidth: kSkinnyCurveWidth,
      Offset(0.85, 0.40),
      Offset(0.70, 0.28),
    );
  }
}
