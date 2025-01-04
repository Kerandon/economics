// import 'package:economics_app/sections/diagrams/custom_paint/painter_constants.dart';
// import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_axis.dart';
// import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_curve.dart';
// import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_diagram_dash_lines.dart';
// import 'package:flutter/material.dart';
// import '../../enums/curve_align.dart';
//
// class GlobalForex extends CustomPainter {
//   final Color onBackgroundColor;
//   final Color highlightedColor;
//
//   GlobalForex(
//       {super.repaint,
//       this.onBackgroundColor = Colors.white,
//       this.highlightedColor = Colors.green});
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     paintDiagramDashedLines(size, canvas,
//         yAxisStartPos: 0.455, xAxisEndPos: 0.36, yLabel: kP1, xLabel: kQ1);
//
//     paintAxis(size, canvas, yAxisLabel: kYLabelForex, xAxisLabel: kXLabelForex);
//     paintCurve(size, canvas, const Offset(0.20, 0.75), const Offset(0.75, 0.20),
//         label2: kS, label2Align: CurveAlign.centerRight);
//     paintCurve(size, canvas, const Offset(0.80, 0.75), const Offset(0.30, 0.25),
//         label1: kD1, label1Align: CurveAlign.centerBottom);
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return false;
//   }
// }
