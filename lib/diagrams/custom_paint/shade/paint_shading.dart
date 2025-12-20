import 'package:flutter/material.dart';
import 'shade_type.dart';
import '../../models/custom_bezier.dart';
import '../painter_constants.dart';

void paintShading(
  Canvas canvas,
  Size size,
  ShadeType shade,
  List<dynamic> pointsAndBeziers, {
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
    final x = dx * width * normalize + ((kAxisIndent * 1.5) * width);
    final y = dy * height * normalize + (kAxisIndent * (height / 2));
    return Offset(x, y);
  }

  final path = Path();
  bool pathStarted = false;

  // 1. Build the Path
  for (final item in pointsAndBeziers) {
    if (item is Offset) {
      final point = toCanvasCoords(item.dx, item.dy);
      if (!pathStarted) {
        path.moveTo(point.dx, point.dy);
        pathStarted = true;
      } else {
        path.lineTo(point.dx, point.dy);
      }
    } else if (item is CustomBezier) {
      final control = toCanvasCoords(item.control.dx, item.control.dy);
      final endPoint = toCanvasCoords(item.endPoint.dx, item.endPoint.dy);

      if (!pathStarted) {
        // If the list starts with a bezier, we move to the end point
        // or a default start point to avoid starting at (0,0)
        path.moveTo(endPoint.dx, endPoint.dy);
        pathStarted = true;
      } else {
        path.quadraticBezierTo(
          control.dx,
          control.dy,
          endPoint.dx,
          endPoint.dy,
        );
      }
    }
  }

  // Explicitly close the path to the FIRST point moved to.
  if (pathStarted) {
    path.close();
  }

  // 2. Define Paints
  final fillPaint = Paint()
    ..style = PaintingStyle.fill
    ..color = shade.setShadeColor();

  final stripePaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = strokeWidth
    ..color = shade.setShadeColor().withAlpha(alpha)
    ..strokeCap = StrokeCap.round;

  // 3. Draw to Canvas
  if (striped) {
    canvas.save();
    canvas.clipPath(path);

    // Using a hypotenuse-based range ensures stripes cover the
    // entire clipped area even when rotated/inverted.
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
