// import 'package:flutter/material.dart';
// import '../../enums/curve_align.dart';
// import '../painter_constants.dart';
// import '../painter_methods/paint_axis.dart';
// import '../painter_methods/paint_curve.dart';
// import '../painter_methods/paint_diagram_dash_lines.dart';
// import '../painter_methods/paint_text.dart';
//
// class GlobalQuotas extends CustomPainter {
//   final Color color;
//   final Color highlightedColor;
//
//   GlobalQuotas({
//     this.color = Colors.white,
//     this.highlightedColor = Colors.green,
//   });
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     /// Welfare Loss
//
//     String pWQ = 'Pq';
//     String pW = 'Pw';
//     String q1 = 'Q1';
//     String q2 = 'Q2';
//     String q3 = 'Q3';
//     String q4 = 'Q4';
//
//     paintAxis(size, canvas, yAxisLabel: kYLabelWine, xAxisLabel: kXLabelWine);
//     paintCurve(
//       size,
//       canvas,
//       const Offset(0.18, 0.75),
//       const Offset(0.75, 0.15),
//       label2: kSDomestic,
//       label2Align: CurveAlign.centerTop,
//       color: color,
//     );
//     paintCurve(
//       size,
//       canvas,
//       const Offset(0.2, 0.10),
//       const Offset(0.80, 0.80),
//       label2: kDDomestic,
//       label2Align: CurveAlign.centerBottom,
//       color: color,
//     );
//
//     /// Arrows
//     paintText(
//       size,
//       canvas,
//       'quota',
//       const Offset(0.66, 0.32),
//     );
//
//     paintText(
//       size,
//       canvas,
//       'quota',
//       const Offset(0.48, 0.93),
//     );
//
//     /// World Supply Curve
//     paintCurve(
//       size,
//       canvas,
//       const Offset(kAxisIndent, 0.70),
//       const Offset(
//         1 - (1 * kAxisIndent),
//         0.70,
//       ),
//       label1: pW,
//       label1Align: CurveAlign.centerLeft,
//       label2: kSupplyWorld,
//       label2Align: CurveAlign.centerRight,
//       color: color,
//     );
//
//     /// Quota curve
//
//     paintCurve(size, canvas, const Offset(0.40, 0.70), const Offset(0.86, 0.20),
//         label1Align: CurveAlign.centerLeft,
//         label2: 'S domestic + quota',
//         label2Align: CurveAlign.centerTop,
//         color: highlightedColor,
//         strokeWidth: kCurveWidth);
//     paintCurve(size, canvas, const Offset(kAxisIndent, 0.70),
//         const Offset(0.405, 0.70),
//         color: highlightedColor, strokeWidth: kCurveWidth);
//
//     /// dash-lines
//     const q3Height = 0.52;
//     paintDiagramDashedLines(size, canvas,
//         yAxisStartPos: q3Height, xAxisEndPos: 0.425, xLabel: q3, yLabel: pWQ);
//     paintDiagramDashedLines(
//       size,
//       canvas,
//       yAxisStartPos: 0.52,
//       xAxisEndPos: 0.09,
//       hideYLine: true,
//       xLabel: q1,
//     );
//     paintDiagramDashedLines(size, canvas,
//         yAxisStartPos: 0.52, xAxisEndPos: 0.26, hideYLine: true, xLabel: q2);
//     paintDiagramDashedLines(size, canvas,
//         yAxisStartPos: 0.70, xAxisEndPos: 0.57, hideYLine: true, xLabel: q4);
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return false;
//   }
// }
