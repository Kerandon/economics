import 'package:economics_app/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/grid_lines/draw_dashed_line_for_grid.dart';
import 'package:flutter/material.dart';

import 'i_diagram_canvas.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'i_diagram_canvas.dart';
// Import your constants...

class FlutterDiagramCanvas implements IDiagramCanvas {
  final Canvas canvas;
  final double scale;

  FlutterDiagramCanvas(this.canvas, {this.scale = 1.0});

  @override
  void drawLine(Offset p1, Offset p2, Color color, double width) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = width * scale
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    canvas.drawLine(p1, p2, paint);
  }

  @override
  void drawDashedLine(Offset p1, Offset p2, Color color, double width) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = width * scale
      ..style = PaintingStyle.stroke;
    drawDashedLineForGrid(canvas, p1, p2, paint);
  }

  @override
  void drawRect(Rect rect, Color color, {bool fill = false}) {
    final paint = Paint()
      ..color = color
      ..style = fill ? PaintingStyle.fill : PaintingStyle.stroke;
    // If not filling, you might want a stroke width here, e.g. ..strokeWidth = 1.0
    canvas.drawRect(rect, paint);
  }

  // --- NEW IMPLEMENTATION ---
  @override
  void drawRRect(Rect rect, Radius radius, Color color, {bool fill = true}) {
    final paint = Paint()
      ..color = color
      ..style = fill ? PaintingStyle.fill : PaintingStyle.stroke;

    // Create the Rounded Rectangle from the Rect and Radius
    final rrect = RRect.fromRectAndRadius(rect, radius);

    canvas.drawRRect(rrect, paint);
  }
  // --------------------------

  @override
  void drawDot(
    Offset center,
    Color color, {
    double radius = 4.0,
    bool fill = true,
  }) {
    final paint = Paint()
      ..color = color
      ..style = fill ? PaintingStyle.fill : PaintingStyle.stroke
      ..strokeWidth = 2.0;
    canvas.drawCircle(center, radius * scale, paint);
  }

  @override
  void drawPath(List<Offset> points, Color color, {bool fill = false}) {
    if (points.isEmpty) return;
    final paint = Paint()
      ..color = color
      ..style = fill ? PaintingStyle.fill : PaintingStyle.stroke
      ..strokeWidth = (fill ? 1.0 : kCurveWidth) * scale
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path()..moveTo(points.first.dx, points.first.dy);
    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }

    if (fill) {
      path.close();
      canvas.drawPath(path, paint);
    } else {
      canvas.drawPath(path, paint);
    }
  }

  @override
  void drawText(String text, Offset position, double fontSize, Color color) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(color: color, fontSize: fontSize * scale),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    textPainter.paint(canvas, position);
  }

  @override
  void save() => canvas.save();
  @override
  void restore() => canvas.restore();
  @override
  void translate(double dx, double dy) => canvas.translate(dx, dy);
  @override
  void rotate(double radians) => canvas.rotate(radians);

  @override
  void clipPath(List<Offset> points) {
    if (points.isEmpty) return;
    final path = Path()..addPolygon(points, true);
    canvas.clipPath(path);
  }
}
