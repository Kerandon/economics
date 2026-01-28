import 'package:economics_app/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/grid_lines/draw_dashed_line_for_grid.dart';
import 'package:flutter/material.dart';

import 'i_diagram_canvas.dart';

class FlutterDiagramCanvas implements IDiagramCanvas {
  final Canvas canvas;
  FlutterDiagramCanvas(this.canvas);

  @override
  void drawLine(Offset p1, Offset p2, Color color, double width) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = width
      ..strokeCap = StrokeCap
          .round // Added for smoother line joins
      ..style = PaintingStyle.stroke;
    canvas.drawLine(p1, p2, paint);
  }

  @override
  void drawRect(Rect rect, Color color, {bool fill = false}) {
    final paint = Paint()
      ..color = color
      ..style = fill ? PaintingStyle.fill : PaintingStyle.stroke;
    canvas.drawRect(rect, paint);
  }

  @override
  void drawDashedLine(Offset p1, Offset p2, Color color, double width) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = width
      ..style = PaintingStyle.stroke;

    drawDashedLineForGrid(canvas, p1, p2, paint);
  }

  @override
  void drawText(
    String text,
    Offset position,
    double fontSize,
    Color color, {
    TextAlign align = TextAlign.left,
  }) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(color: color, fontSize: fontSize),
      ),
      textDirection: TextDirection.ltr,
      textAlign: align,
    );

    textPainter.layout();

    double x = position.dx;
    double y = position.dy - (textPainter.height / 2);

    if (align == TextAlign.right) {
      x = position.dx - textPainter.width;
    } else if (align == TextAlign.center) {
      x = position.dx - (textPainter.width / 2);
    }

    textPainter.paint(canvas, Offset(x, y));
  }

  @override
  void drawPath(List<Offset> points, Color color, {bool fill = false}) {
    if (points.isEmpty) return;

    final paint = Paint()
      ..color = color
      ..style = fill ? PaintingStyle.fill : PaintingStyle.stroke
      ..strokeWidth =
          kCurveWidth // Standardized with your constants
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path();
    path.moveTo(points.first.dx, points.first.dy);

    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }

    if (fill) {
      path.close();
    }

    canvas.drawPath(path, paint);
  }

  @override
  void drawDot(
    Offset center,
    Color color, {
    double radius = kDotRadius,
    bool fill = true,
  }) {
    final paint = Paint()
      ..color = color
      ..style = fill ? PaintingStyle.fill : PaintingStyle.stroke
      ..strokeWidth = 2.0; // Stroke width if not filled

    canvas.drawCircle(center, radius, paint);
  }
}
