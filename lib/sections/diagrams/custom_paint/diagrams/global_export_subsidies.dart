import 'package:economics_app/sections/diagrams/enums/curve_align.dart';
import 'package:flutter/material.dart';
import '../../enums/diagram_type.dart';
import '../../utils/mixins.dart';
import '../painter_constants.dart';
import '../painter_methods/paint_axis.dart';
import '../painter_methods/paint_curve.dart';
import '../painter_methods/paint_diagram_dash_lines.dart';

class GlobalExportSubsidies extends CustomPainter with NameMixin {
  @override
  String get name => type.name;

  final Color color;
  final Color highlightedColor;
  final DiagramType type;

  GlobalExportSubsidies(
      {this.color = Colors.white,
      this.highlightedColor = Colors.green,
      this.type = DiagramType.global_ExportSubsidies_Standard_Default});

  @override
  void paint(Canvas canvas, Size size) {
    paintAxis(size, canvas, xAxisLabel: kXLabelWine, yAxisLabel: kYLabelWine);

    String q1 = kQ1;
    String q2 = kQ2;
    String q3 = kQ3;
    String q4 = kQ4;

    /// Shading

    // paintShading(canvas, size, ShadeType.welfareLoss, const Offset(0.295, 0.28),
    //     const Offset(0.295, 0.35), const Offset(0.38, 0.35));
    // paintShading(canvas, size, ShadeType.welfareLoss, const Offset(0.69, 0.27),
    //     const Offset(0.60, 0.35), const Offset(0.69, 0.35));

    /// Domestic supply & demand
    paintCurve(size, canvas, const Offset(0.20, 0.20), const Offset(0.80, 0.70),
        label2: kDDomestic, label2Align: CurveAlign.centerBottom);
    paintCurve(size, canvas, const Offset(0.18, 0.70), const Offset(0.78, 0.20),
        label2: kSDomestic, label2Align: CurveAlign.centerTop);

    /// Supply + sub curve

    paintCurve(size, canvas, const Offset(0.28, 0.70), const Offset(0.80, 0.25),
        label2: 'S + sub',
        label2Align: CurveAlign.centerRight,
        color: highlightedColor);

    /// World Curves
    paintCurve(size, canvas, const Offset(kAxisIndent, 0.35),
        const Offset(1 - kAxisIndent, 0.35),
        label1: kPW, label1Align: CurveAlign.centerLeft);
    paintCurve(size, canvas, const Offset(kAxisIndent, 0.28),
        const Offset(1 - kAxisIndent, 0.28),
        label1: kPWSub, label1Align: CurveAlign.centerLeft);

    /// Dashed lines

    paintDiagramDashedLines(
      size,
      canvas,
      yAxisStartPos: 0.28,
      xAxisEndPos: 0.155,
      hideYLine: true,
      xLabel: q1,
    );
    paintDiagramDashedLines(
      size,
      canvas,
      yAxisStartPos: 0.35,
      xAxisEndPos: 0.235,
      hideYLine: true,
      xLabel: q2,
    );
    paintDiagramDashedLines(
      size,
      canvas,
      yAxisStartPos: 0.35,
      xAxisEndPos: 0.46,
      hideYLine: true,
      xLabel: q3,
    );
    paintDiagramDashedLines(
      size,
      canvas,
      yAxisStartPos: 0.28,
      xAxisEndPos: 0.55,
      hideYLine: true,
      xLabel: q4,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
