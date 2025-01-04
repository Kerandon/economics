// import 'package:flutter/material.dart';
// import '../painter_constants.dart';
// import '../painter_methods/paint_axis.dart';
// import '../painter_methods/paint_diagram_dash_lines.dart';
//
// class MacroPPC extends CustomPainter {
//   final Color color;
//
//   MacroPPC({this.color = Colors.white});
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final width = size.width;
//     final height = size.height;
//
//     final path = Path();
//
//     /// PPC Paint Curve
//     final paint = Paint()
//       ..color = color
//       ..strokeWidth = kCurveWidth
//       ..style = PaintingStyle.stroke;
//
//     paintDiagramDashedLines(size, canvas,
//         yAxisStartPos: 0.40, xAxisEndPos: 0.38);
//     paintDiagramDashedLines(size, canvas,
//         yAxisStartPos: 0.70, xAxisEndPos: 0.62);
//
//     paintAxis(size, canvas,
//         xAxisLabel: 'Consumer goods',
//         yAxisLabel: 'Capital goods',
//         addNumericalAxis: true);
//
//     path
//       ..moveTo(width * kAxisIndent, height * 0.30)
//       ..quadraticBezierTo(width * 0.70, height * 0.30, width * 0.80,
//           height * (1 - kAxisIndent));
//
//     canvas.drawPath(path, paint);
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return false;
//   }
// }
