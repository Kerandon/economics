import 'package:economics_app/sections/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_axis.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_curve.dart';
import 'package:economics_app/sections/diagrams/models/diagram_painter_config.dart';
import 'package:flutter/material.dart';
import '../../enums/label_align.dart';
import '../../models/base_painter_painter.dart';
import '../../models/custom_bezier.dart';
import '../../models/diagram_model.dart';
import '../painter_methods/paint_custom_bezier.dart';
import '../painter_methods/paint_diagram_dash_lines.dart';

class PerfectCompetition extends BaseDiagramPainter {
  PerfectCompetition({
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
      yAxisStartPos: 0.50,
      xAxisEndPos: 0.33,
      yLabel: kPe,
      xLabel: kQ,
    );

    paintAxis(
      c,
      canvas,
      yAxisLabel: kPriceCostsRevenue,
      xAxisLabel: kQuantity,
    );

    paintCurve(
        c,
        canvas,
        color: c.colorScheme.primary,
        Offset(kAxisIndent, 0.50),
        Offset(0.80, 0.5),
        label2: kPARMR,
        label2Align: LabelAlign.centerRight);

    /// Marginal Cost
    paintCustomBezier(c, canvas,
        startPos: const Offset(0.25, 0.60),
        points: [
          CustomBezier(
              control: const Offset(0.35, 0.90),
              endPoint: const Offset(0.60, 0.20))
        ],
        label1: kMC,
        label1Align: LabelAlign.centerTop);

    /// Average cost
    paintCustomBezier(c, canvas,
        startPos: const Offset(0.25, 0.30),
        points: [
          CustomBezier(
              control: const Offset(0.45, 0.70),
              endPoint: const Offset(0.75, 0.30))
        ],
        label1: kSRAC,
        label1Align: LabelAlign.centerTop);
  }
}
