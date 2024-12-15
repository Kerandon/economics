import 'package:economics_app/sections/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_axis.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_curve.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_diagram_dash_lines.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_shading.dart';
import 'package:economics_app/sections/diagrams/utils/mixins.dart';
import 'package:flutter/material.dart';
import '../../enums/curve_align.dart';
import '../../enums/diagram_type.dart';
import '../../enums/shade_type.dart';
import '../../models/custom_bezier.dart';
import '../painter_methods/paint_custom_bezier.dart';

class MicroMonopolisticCompetition extends CustomPainter with NameMixin {
  final DiagramType type;
  final Color onBackgroundColor;
  final Color highlightedColor;

  MicroMonopolisticCompetition({
    super.repaint,
    this.type = DiagramType.micro_MonopolisticCompetition_LongRun_Default,
    this.onBackgroundColor = Colors.white,
    this.highlightedColor = Colors.green,
  });

  @override
  String get name => type.name;

  @override
  void paint(Canvas canvas, Size size) {
    if (type == DiagramType.micro_MonopolisticCompetition_AbnormalProfits) {
      paintShading(canvas, size, ShadeType.abnormalProfits, [
        const Offset(kAxisIndent, 0.38),
        const Offset(kAxisIndent + 0.285, 0.38),
        const Offset(kAxisIndent + 0.285, 0.46),
        const Offset(kAxisIndent, 0.46),
      ]);
      paintDiagramDashedLines(size, canvas,
          yAxisStartPos: 0.46,
          xAxisEndPos: 0.285,
          yLabel: kAC,
          hideXLine: true);

      /// Average Cost
      paintCustomBezier(size, canvas,
          onBackgroundColor,
          startPos: const Offset(0.27, 0.22),
          points: [
            CustomBezier(
                control: const Offset(0.55, 0.81),
                endPoint: const Offset(0.83, 0.22))
          ],
          label1: kAC,
          label1Align: CurveAlign.centerTop);
    }

    if (type == DiagramType.micro_MonopolisticCompetition_EconomicLosses) {
      paintShading(canvas, size, ShadeType.losses, [
        const Offset(kAxisIndent, 0.29),
        const Offset(kAxisIndent + 0.285, 0.29),
        const Offset(kAxisIndent + 0.285, 0.38),
        const Offset(kAxisIndent, 0.38),
      ]);
      paintDiagramDashedLines(size, canvas,
          yAxisStartPos: 0.29, xAxisEndPos: 0.285, yLabel: kAC);

      /// Average Cost
      paintCustomBezier(size, canvas, onBackgroundColor,
          startPos: const Offset(0.27, 0.10),
          points: [
            CustomBezier(
                control: const Offset(0.55, 0.55),
                endPoint: const Offset(0.83, 0.10))
          ],
          label1: kAC,
          label1Align: CurveAlign.centerTop);
    }

    if (type == DiagramType.micro_MonopolisticCompetition_WelfareLoss ||
        type == DiagramType.micro_MonopolisticCompetition_WelfareAnalysis) {
      paintShading(canvas, size, ShadeType.welfareLoss, [
        const Offset(0.425, 0.38),
        const Offset(0.53, 0.45),
        const Offset(0.425, 0.61)
      ]);
    }
    if (type == DiagramType.micro_MonopolisticCompetition_WelfareAnalysis) {
      paintShading(
        canvas,
        size,
        ShadeType.producerSurplus,
        [
          const Offset(kAxisIndent, 0.38),
          const Offset(0.425, 0.38),
          const Offset(0.425, 0.62),
          CustomBezier(
            control: const Offset(kAxisIndent + 0.11, 0.85),
            endPoint: const Offset(kAxisIndent, 0.64),
          ),
        ],
      );
      paintShading(canvas, size, ShadeType.consumerSurplus, [
        const Offset(kAxisIndent, 0.38),
        const Offset(0.435, 0.38),
        const Offset(kAxisIndent, 0.155),
      ]);
    }

    /// Main Curves
    paintAxis(size, canvas,
        yAxisLabel: kPriceCostsRevenue, xAxisLabel: kQuantity);
    paintCurve(size, canvas, const Offset(0.20, 0.20), const Offset(0.85, 0.70),
        label2: kDAR, label2Align: CurveAlign.centerBottom);
    paintCurve(size, canvas, const Offset(0.18, 0.23), const Offset(0.60, 0.88),
        label2: kMR, label2Align: CurveAlign.centerBottom);
    paintDiagramDashedLines(size, canvas,
        yAxisStartPos: 0.38, xAxisEndPos: 0.285, yLabel: kP, xLabel: kQ1);

    /// Marginal Cost
    paintCustomBezier(size, canvas, onBackgroundColor,
        startPos: const Offset(0.18, 0.70),
        points: [
          CustomBezier(
              control: const Offset(0.35, 0.90),
              endPoint: const Offset(0.70, 0.10))
        ],
        label1: kMC,
        label1Align: CurveAlign.centerTop);

    if (type == DiagramType.micro_MonopolisticCompetition_LongRun_Default ||
        type == DiagramType.micro_MonopolisticCompetition_WelfareLoss ||
        type == DiagramType.micro_MonopolisticCompetition_WelfareAnalysis) {
      /// Average Cost
      paintCustomBezier(size, canvas, onBackgroundColor,
          startPos: const Offset(0.27, 0.15),
          points: [
            CustomBezier(
                control: const Offset(0.55, 0.70),
                endPoint: const Offset(0.83, 0.15))
          ],
          label1: kAC,
          label1Align: CurveAlign.centerTop);
    }

    // paintColorLabel(canvas, size,
    //     pos: const Offset(0.43, 0.61),
    //     text: kA,
    // );
    // paintColorLabel(canvas, size,
    //   pos: const Offset(0.41, 0.36),
    //   text: kB,);
    // paintColorLabel(canvas, size,
    //   pos: const Offset(0.55, 0.41),
    //   text: kC,);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
