import 'package:flutter/material.dart';
import '../../models/diagram_painter_config.dart';
import '../i_diagram_canvas.dart';
import 'shade_type.dart';
import '../../models/custom_bezier.dart';
import '../painter_constants.dart';

void paintShading(
  DiagramPainterConfig config,
  IDiagramCanvas canvas,
  ShadeType shade,
  List<dynamic> pointsAndBeziers, {
  bool striped = true,
  double stripeSpacing = 12.0, // Tighter for professional look
  double strokeWidth = 0.8, // Thinner lines for print
  int alpha = 40, // Much lower alpha for print compatibility
  bool invertStripes = false,
}) {
  if (pointsAndBeziers.isEmpty) return;

  final double width = config.painterSize.width;
  final double height = config.painterSize.height;

  // Coordinate math
  final double normalizeW = 1 - (kAxisIndent * 2);
  final double normalizeH =
      1 - (kAxisIndent * (kTopAxisIndent + kBottomAxisIndent));
  final double indentX = width * kAxisIndent;
  final double indentY = height * (kAxisIndent * kTopAxisIndent);

  Offset toCanvasCoords(Offset pos) {
    return Offset(
      pos.dx * (width * normalizeW) + indentX,
      pos.dy * (height * normalizeH) + indentY,
    );
  }

  // 1. Build the Polyline
  final List<Offset> polyline = [];
  for (final item in pointsAndBeziers) {
    if (item is Offset) {
      polyline.add(toCanvasCoords(item));
    } else if (item is CustomBezier) {
      final startPoint = polyline.isNotEmpty
          ? polyline.last
          : toCanvasCoords(Offset.zero);
      final control = toCanvasCoords(item.control);
      final endPoint = toCanvasCoords(item.endPoint);
      for (double t = 0.1; t <= 1.0; t += 0.1) {
        polyline.add(
          Offset(
            (1 - t) * (1 - t) * startPoint.dx +
                2 * (1 - t) * t * control.dx +
                t * t * endPoint.dx,
            (1 - t) * (1 - t) * startPoint.dy +
                2 * (1 - t) * t * control.dy +
                t * t * endPoint.dy,
          ),
        );
      }
    }
  }

  final color = shade.setShadeColor();

  // 2. Draw a very light solid background first
  // alpha ~/ 3 ensures it's just a hint of color on paper
  canvas.drawPath(polyline, color.withAlpha(alpha ~/ 3), fill: true);

  // 3. Draw the Stripes (The important part for PDF)
  if (striped) {
    canvas.save();
    canvas.clipPath(polyline); // Keeps lines inside the triangle/box

    final double maxDim = width + height;
    // Use a slightly darker alpha for the actual lines so they "pop"
    final stripeColor = color.withAlpha(alpha + 20);
    final double spacing = stripeSpacing * config.averageRatio;

    for (double i = -maxDim; i < maxDim; i += spacing) {
      Offset p1 = invertStripes ? Offset(0, i + width) : Offset(0, i);
      Offset p2 = invertStripes ? Offset(width, i) : Offset(width, i + width);
      canvas.drawLine(p1, p2, stripeColor, strokeWidth * config.averageRatio);
    }

    canvas.restore();
  }
}
