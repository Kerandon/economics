import 'package:flutter/material.dart';
import '../i_diagram_canvas.dart';
import 'shade_type.dart';
import '../../models/custom_bezier.dart';
import '../painter_constants.dart';


void paintShading(
  Canvas? canvas,
  Size size,
  ShadeType shade,
  List<dynamic> pointsAndBeziers, {
  IDiagramCanvas? iCanvas,
  bool striped = true,
  double stripeSpacing = 20.0,
  double strokeWidth = 16,
  int alpha = 100,
  bool invertStripes = false,
}) {
  if (pointsAndBeziers.isEmpty) return;

  final double width = size.width;
  final double height = size.height;
  final double normalize = 1 - (kAxisIndent * 2);

  // Helper to transform normalized coordinates to canvas space
  Offset toCanvasCoords(double dx, double dy) {
    final x = dx * width * normalize + (kAxisIndent * width);
    final y = dy * height * normalize + (kAxisIndent * (height * kTopAxisIndent));
    return Offset(x, y);
  }

  final path = Path();
  final List<Offset> polyline = [];
  bool pathStarted = false;
  Offset? firstPoint;

  // 1. Build both the Flutter Path and the flattened Polyline
  for (final item in pointsAndBeziers) {
    if (item is Offset) {
      final point = toCanvasCoords(item.dx, item.dy);
      polyline.add(point);
      if (!pathStarted) {
        path.moveTo(point.dx, point.dy);
        firstPoint = point;
        pathStarted = true;
      } else {
        path.lineTo(point.dx, point.dy);
      }
    } else if (item is CustomBezier) {
      final startPoint = polyline.isNotEmpty
          ? polyline.last
          : toCanvasCoords(0, 0);
      final control = toCanvasCoords(item.control.dx, item.control.dy);
      final endPoint = toCanvasCoords(item.endPoint.dx, item.endPoint.dy);

      // Add curve to Flutter Path
      path.quadraticBezierTo(control.dx, control.dy, endPoint.dx, endPoint.dy);

      // Flatten curve for iCanvas (Bridge)
      for (double t = 0.1; t <= 1.0; t += 0.1) {
        final x =
            (1 - t) * (1 - t) * startPoint.dx +
            2 * (1 - t) * t * control.dx +
            t * t * endPoint.dx;
        final y =
            (1 - t) * (1 - t) * startPoint.dy +
            2 * (1 - t) * t * control.dy +
            t * t * endPoint.dy;
        polyline.add(Offset(x, y));
      }
    }
  }

  // Ensure the polyline closes back to the start for the bridge fill
  if (pathStarted && firstPoint != null) {
    path.close();
    polyline.add(firstPoint);
  }

  final color = shade.setShadeColor();

  // --- 2. Bridge Drawing (PDF Export) ---
  if (iCanvas != null) {
    iCanvas.drawPath(polyline, color.withAlpha(alpha), fill: true);
    // Continue if canvas is not null so we see it on screen too
    if (canvas == null) return;
  }

  // --- 3. Flutter Screen Drawing ---
  if (canvas != null) {
    final fillPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = color.withAlpha(alpha);

    final stripePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = color.withAlpha(alpha)
      ..strokeCap = StrokeCap.round;

    if (striped) {
      canvas.save();
      canvas.clipPath(path);

      final double maxDim = size.width + size.height;

      if (invertStripes) {
        for (double i = -maxDim; i < maxDim; i += stripeSpacing) {
          canvas.drawLine(
            Offset(0, i + size.width),
            Offset(size.width, i),
            stripePaint,
          );
        }
      } else {
        for (double i = -maxDim; i < maxDim; i += stripeSpacing) {
          canvas.drawLine(
            Offset(0, i),
            Offset(size.width, i + size.width),
            stripePaint,
          );
        }
      }
      canvas.restore();
    } else {
      canvas.drawPath(path, fillPaint);
    }
  }
}
