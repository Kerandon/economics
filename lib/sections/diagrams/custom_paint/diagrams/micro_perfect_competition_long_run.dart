import 'package:economics_app/sections/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_axis.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_curve.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_custom_bezier.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_dot.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_shading.dart';
import 'package:economics_app/sections/diagrams/enums/axis_label_margin.dart';
import 'package:economics_app/sections/diagrams/enums/curve_align.dart';
import 'package:economics_app/sections/diagrams/enums/shade_type.dart';
import 'package:economics_app/sections/diagrams/models.dart';
import 'package:economics_app/sections/diagrams/utils/mixins.dart';
import 'package:flutter/material.dart';
import '../../enums/diagram_type.dart';

class MicroPerfectCompetition extends CustomPainter with NameMixin {
  final DiagramType type;
  final Color onBackgroundColor;
  final Color highlightedColor;

  MicroPerfectCompetition({
    required this.type,
    this.onBackgroundColor = Colors.white,
    this.highlightedColor = Colors.green,
  });

  @override
  String get name => type.name;

  @override
  void paint(Canvas canvas, Size size) {
    paintAxis(
      size,
      canvas,
      yAxisLabel: kPriceCostsRevenue,
      xAxisLabel: kQuantity,
    );

    /// D = MR = P
    paintCurve(
      size,
      canvas,
      const Offset(kAxisIndent, 0.50),
      const Offset(0.80, 0.50),
      label2: kDPARMR,
      label2Align: CurveAlign.centerRight,
    );

    /// MC
    paintCustomBezier(
      size,
      canvas,
      startPos: Offset(0.20, 0.60),
      points: [
        CustomBezier(control: Offset(0.35, 0.90), endPoint: Offset(0.65, 0.20))
      ],
      label1: kMC,
      label1Align: CurveAlign.centerTop,
    );
    if (type == DiagramType.micro_PerfectCompetition_LongRun_Default) {
      /// AC
      paintCustomBezier(
        size,
        canvas,
        startPos: Offset(0.18, 0.30),
        points: [
          CustomBezier(
              control: Offset(0.50, 0.70), endPoint: Offset(0.82, 0.30))
        ],
        label1: kAC,
        label1Align: CurveAlign.centerTop,
      );
    }  if (type == DiagramType.micro_PerfectCompetition_AbnormalProfits) {
      /// AC
      paintCustomBezier(
        size,
        canvas,
        startPos: Offset(0.18, 0.40),
        points: [
          CustomBezier(
              control: Offset(0.40, 0.80), endPoint: Offset(0.72, 0.40))
        ],
        label1: kAC,
        label1Align: CurveAlign.centerTop,
      );
      paintShading(canvas, size, ShadeType.abnormalProfits, [
        Offset(kAxisIndent,0.50),Offset(0.50,0.50),
        Offset(0.50,0.59),
        Offset(kAxisIndent,0.59)
      ]);
      paintDot(canvas, size, pos: Offset(0.50, 0.59), color: highlightedColor);

    }


    if (type == DiagramType.micro_PerfectCompetition_EconomicLosses) {
      /// AC
      paintCustomBezier(
        size,
        canvas,
        startPos: Offset(0.20, 0.20),
        points: [
          CustomBezier(
              control: Offset(0.55, 0.60), endPoint: Offset(0.90, 0.20))
        ],
        label1: kAC,
        label1Align: CurveAlign.centerTop,
      );
      paintShading(canvas, size, ShadeType.losses, [
        Offset(kAxisIndent,0.50),Offset(0.50,0.50),
        Offset(0.50,0.395),
        Offset(kAxisIndent,0.395)
      ]);
      paintDot(canvas, size, pos: Offset(0.50, 0.395), color: highlightedColor);

    }

    paintDot(canvas, size, pos: Offset(0.50, 0.50), color: highlightedColor);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
