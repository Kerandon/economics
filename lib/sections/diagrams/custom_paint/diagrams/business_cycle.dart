import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_custom_bezier.dart';
import 'package:economics_app/sections/diagrams/models/custom_bezier.dart';
import 'package:flutter/material.dart';
import '../../enums/label_align.dart';
import '../../models/base_painter_painter.dart';
import '../../models/diagram_model.dart';
import '../../models/diagram_painter_config.dart';
import '../painter_constants.dart';
import '../painter_methods/paint_axis.dart';
import '../painter_methods/paint_curve.dart';

class BusinessCycle extends BaseDiagramPainter {
  BusinessCycle({
    required DiagramPainterConfig config,
    required DiagramModel model,
  }) : super(config, model);

  @override
  void paint(Canvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);

    paintAxis(c, canvas, yAxisLabel: kRealGDP, xAxisLabel: kTimeYears);

    paintCurve(
      c,
      canvas,
      const Offset(kAxisIndent, 0.62),
      const Offset(0.80, 0.40),
      makeDashed: true,
      label2: kPotentialOutput,
      label2Align: LabelAlign.centerRight,
    );

    /// Biz cycle curve
    paintCustomBezier(
      c,
      canvas,
      startPos: Offset(kAxisIndent, 0.650),
      points: [
        CustomBezier(
          control: Offset(kAxisIndent + 0.01, 0.70),
          endPoint: Offset(kAxisIndent + 0.08, 0.55),
        ),
        CustomBezier(
          control: Offset(kAxisIndent + 0.12, 0.48),
          endPoint: Offset(kAxisIndent + 0.25, 0.55),
        ),
        CustomBezier(
          control: Offset(kAxisIndent + 0.33, 0.60),
          endPoint: Offset(kAxisIndent + 0.36, 0.49),
        ),
        CustomBezier(
          control: Offset(kAxisIndent + 0.39, 0.35),
          endPoint: Offset(kAxisIndent + 0.51, 0.45),
        ),
        CustomBezier(
          control: Offset(kAxisIndent + 0.62, 0.52),
          endPoint: Offset(kAxisIndent + 0.64, 0.39),
        ),
      ],
    );
  }
}
