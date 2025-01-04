// import 'package:flutter/material.dart';
// import '../../enums/curve_align.dart';
// import '../painter_constants.dart';
// import '../painter_methods/paint_axis.dart';
// import '../painter_methods/paint_curve.dart';
// import '../painter_methods/paint_diagram_dash_lines.dart';
//
// class GlobalTariffs extends CustomPainter {
//   final Color color;
//   final Color highlightedColor;
//
//   GlobalTariffs({
//     this.color = Colors.white,
//     this.highlightedColor = Colors.green,
//   });
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     String pWT = kPWT;
//     String pW = kPW;
//     String q1 = kQ1;
//     String q2 = kQ2;
//     String q3 = kQ3;
//     String q4 = kQ4;
//
//     paintAxis(size, canvas, xAxisLabel: kXLabelWine, yAxisLabel: kYLabelWine);
//     paintCurve(
//       size,
//       canvas,
//       const Offset(0.20, 0.80),
//       const Offset(0.85, 0.10),
//       label2: kSDomestic,
//       label2Align: CurveAlign.centerTop,
//       color: color,
//     );
//     paintCurve(
//       size,
//       canvas,
//       const Offset(0.22, 0.10),
//       const Offset(0.80, 0.80),
//       label2: kDDomestic,
//       label2Align: CurveAlign.centerBottom,
//       color: color,
//     );
//
//     paintCurve(
//       size,
//       canvas,
//       const Offset(kAxisIndent, 0.70),
//       const Offset(
//         1 - kAxisIndent,
//         0.70,
//       ),
//       label1: pW,
//       label1Align: CurveAlign.centerLeft,
//       label2: kSupplyWorld,
//       label2Align: CurveAlign.centerRight,
//       color: color,
//     );
//
//     paintCurve(
//       size,
//       canvas,
//       const Offset(kAxisIndent, 0.58),
//       const Offset(
//         1 - kAxisIndent,
//         0.58,
//       ),
//       label1: pWT,
//       label1Align: CurveAlign.centerLeft,
//       label2: 'S + tariff',
//       label2Align: CurveAlign.centerRight,
//       color: highlightedColor,
//       strokeWidth: kCurveWidth,
//     );
//
//     /// Vertical lines
//     paintDiagramDashedLines(size, canvas,
//         yAxisStartPos: 0.70, xAxisEndPos: 0.155, hideYLine: true, xLabel: q1);
//     paintDiagramDashedLines(size, canvas,
//         yAxisStartPos: 0.59, xAxisEndPos: 0.26, hideYLine: true, xLabel: q2);
//     paintDiagramDashedLines(size, canvas,
//         yAxisStartPos: 0.59, xAxisEndPos: 0.48, hideYLine: true, xLabel: q3);
//     paintDiagramDashedLines(size, canvas,
//         yAxisStartPos: 0.70, xAxisEndPos: 0.58, hideYLine: true, xLabel: q4);
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return false;
//   }
// }
