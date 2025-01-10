import 'package:economics_app/sections/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_axis.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_curve.dart';
import 'package:economics_app/sections/diagrams/models/diagram_painter_config.dart';
import 'package:flutter/material.dart';
import '../../../enums/label_align.dart';
import '../../../models/base_painter_painter.dart';
import '../../../models/custom_bezier.dart';
import '../../../models/diagram_model.dart';
import '../../painter_methods/paint_custom_bezier.dart';
import '../../painter_methods/paint_diagram_dash_lines.dart';

class Monopoly extends BaseDiagramPainter {
  Monopoly({
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
      yAxisStartPos: 0.38,
      xAxisEndPos: 0.27,
      yLabel: kPe,
      xLabel: kQ,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.49,
      xAxisEndPos: 0.27,
      hideXLine: true,
      yLabel: 'Costs',
      xLabel: kQ,
    );

    paintAxis(
      c,
      canvas,
      yAxisLabel: kPriceCostsRevenue,
      xAxisLabel: kQuantity,
    );

    /// Demand curve
    paintCurve(c, canvas, Offset(0.20, 0.20), Offset(0.80, 0.70),
        label2: kDAR, label2Align: LabelAlign.centerBottom);

    /// MR curve
    paintCurve(c, canvas, Offset(0.20, 0.25), Offset(0.60, 0.90),
        label2: kMR, label2Align: LabelAlign.centerBottom);

    /// Marginal Cost
    paintCustomBezier(
      c,
      canvas,
      startPos: const Offset(0.25, 0.60),
      points: [
        CustomBezier(
          control: const Offset(0.35, 0.90),
          endPoint: const Offset(0.60, 0.20),
        ),
      ],
      label1: kMC,
      label1Align: LabelAlign.centerTop,
    );

    /// Average cost
    paintCustomBezier(
      c,
      canvas,
      startPos: const Offset(0.20, 0.30),
      points: [
        CustomBezier(
            control: const Offset(0.45, 0.70),
            endPoint: const Offset(0.80, 0.30))
      ],
      label1: kAC,
      label1Align: LabelAlign.centerTop,
    );
  }
}
