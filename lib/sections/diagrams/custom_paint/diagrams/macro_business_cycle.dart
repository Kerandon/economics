// import 'package:flutter/material.dart';
// import '../../enums/curve_align.dart';
// import '../painter_constants.dart';
// import '../painter_methods/paint_axis.dart';
// import '../painter_methods/paint_dashed_line.dart';
// import '../painter_methods/path_label_line.dart';
//
// class MacroBusinessCycle extends CustomPainter {
//   final Color axisColor;
//   final Color primaryColor;
//
//   MacroBusinessCycle(
//       {this.axisColor = Colors.white, this.primaryColor = Colors.green});
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final width = size.width;
//     final height = size.height;
//
//     /// Axis
//     paintAxis(size, canvas, xAxisLabel: kXLabelADAS, yAxisLabel: kYLabelADAS);
//
//     /// Trend line
//     paintDashedLine(
//       size: size,
//       strokeWidth: 2,
//       canvas: canvas,
//       p1: const Offset(0.16, 0.60),
//       p2: const Offset(0.98, 0.40),
//     );
//
//     final paint = Paint()
//       ..color = primaryColor
//       ..strokeWidth = kCurveWidth
//       ..style = PaintingStyle.stroke
//       ..strokeCap = StrokeCap.round;
//
//     /// Curved path
//     final path = Path();
//     path
//       ..moveTo(width * 0.18, height * 0.65)
//       ..quadraticBezierTo(
//           width * 0.20, height * 0.45, width * 0.30, height * 0.55)
//       ..quadraticBezierTo(
//           width * 0.40, height * 0.65, width * 0.45, height * 0.50)
//       ..quadraticBezierTo(
//           width * 0.50, height * 0.30, width * 0.62, height * 0.50)
//       ..quadraticBezierTo(
//           width * 0.70, height * 0.65, width * 0.72, height * 0.45)
//       ..quadraticBezierTo(
//           width * 0.75, height * 0.30, width * 0.85, height * 0.45)
//       ..quadraticBezierTo(
//           width * 0.90, height * 0.50, width * 0.92, height * 0.36);
//
//     canvas.save();
//     canvas.drawPath(path, paint);
//     canvas.restore();
//
//     /// Labels
//     paintLabelLine(
//       canvas,
//       size,
//       'Peak',
//       const Offset(0.24, 0.52),
//       const Offset(0.24, 0.40),
//       textAlign: CurveAlign.centerTop,
//     );
//
//     paintLabelLine(
//       canvas,
//       size,
//       'Trough',
//       const Offset(0.38, 0.59),
//       const Offset(0.38, 0.70),
//       textAlign: CurveAlign.centerBottom,
//     );
//
//     paintLabelLine(
//       canvas,
//       size,
//       'Expansion',
//       const Offset(0.45, 0.50),
//       const Offset(0.45, 0.30),
//       textAlign: CurveAlign.centerTop,
//     );
//
//     paintLabelLine(
//       canvas,
//       size,
//       'Contraction',
//       const Offset(0.62, 0.50),
//       const Offset(0.62, 0.70),
//       textAlign: CurveAlign.centerBottom,
//     );
//
//     paintLabelLine(canvas, size, 'Long-term growth\n  (potential GDP)',
//         const Offset(0.88, 0.42), const Offset(0.80, 0.20),
//         textAlign: CurveAlign.centerTop);
//
//     paintLabelLine(
//       canvas,
//       size,
//       'Actual growth\n    (real GDP)',
//       const Offset(0.88, 0.46),
//       const Offset(0.86, 0.60),
//       textAlign: CurveAlign.centerBottom,
//     );
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return false;
//   }
// }
