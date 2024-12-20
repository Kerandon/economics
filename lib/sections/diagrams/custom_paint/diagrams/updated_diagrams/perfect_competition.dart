import 'package:economics_app/sections/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_axis.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_curve.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_custom_bezier.dart';
import 'package:economics_app/sections/diagrams/enums/curve_align.dart';
import 'package:economics_app/sections/diagrams/models/diagram_model.dart';
import 'package:economics_app/sections/diagrams/utils/get_size_adjustor.dart';
import 'package:economics_app/sections/diagrams/utils/mixins.dart';
import 'package:flutter/material.dart';
import '../../../models/custom_bezier.dart';

class PerfectCompetition extends CustomPainter with DiagramIdentifierMixin {
  @override
  DiagramModel get model => diagramModel;

  final Size appSize;
  final DiagramModel diagramModel;
  final Color surfaceColor;
  final Color onSurfaceColor;
  final Color primaryColor;

  PerfectCompetition({
    required this.appSize,
    required this.diagramModel,
    required this.surfaceColor,
    required this.onSurfaceColor,
    required this.primaryColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final sizeAdjustor = getSizeAdjustor(size: size, sizeApp: appSize);
    paintAxis(
        size,
        sizeAdjustor: sizeAdjustor,
        canvas,
        yAxisLabel: kPriceCostsRevenue,
        xAxisLabel: kQuantity,
        color: onSurfaceColor);

    /// D = MR = P
    paintCurve(
      size,
      sizeAdjustor: sizeAdjustor,
      canvas,
      const Offset(kAxisIndent, 0.50),
      const Offset(0.80, 0.50),
      label2: kDPARMR,
      label2Align: CurveAlign.centerRight,
      color: onSurfaceColor,
    );

    /// MC
    paintCustomBezier(
      size,
      sizeAdjustor: sizeAdjustor,
      canvas,
      onSurfaceColor,
      startPos: const Offset(0.20, 0.60),
      points: [
        CustomBezier(
            control: const Offset(0.35, 0.90),
            endPoint: const Offset(0.65, 0.20))
      ],
      label1: kMC,
      label1Align: CurveAlign.centerTop,
    );

    /// AC
    paintCustomBezier(
      size,
      sizeAdjustor: sizeAdjustor,
      canvas,
      onSurfaceColor,
      startPos: const Offset(0.18, 0.30),
      points: [
        CustomBezier(
            control: const Offset(0.50, 0.70),
            endPoint: const Offset(0.82, 0.30))
      ],
      label1: kAC,
      label1Align: CurveAlign.centerTop,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
