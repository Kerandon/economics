import 'package:economics_app/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/grid_lines/draw_dashed_line_for_grid.dart';
import 'package:flutter/material.dart';

import 'i_diagram_canvas.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'i_diagram_canvas.dart';
// Import your constants...

import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class FlutterDiagramCanvas implements IDiagramCanvas {
  final Canvas canvas;

  FlutterDiagramCanvas(this.canvas);

  @override
  void drawLine(Offset p1, Offset p2, Color color, double width) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = width
      ..style = PaintingStyle.stroke;
    canvas.drawLine(p1, p2, paint);
  }

  @override
  void drawDashedLine(Offset p1, Offset p2, Color color, double width) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = width
      ..style = PaintingStyle.stroke;

    const double dashWidth = 4.0;
    const double dashSpace = 4.0;
    double currentDist = 0.0;
    final double totalDist = (p2 - p1).distance;

    if (totalDist == 0) return;

    final double dx = (p2.dx - p1.dx) / totalDist;
    final double dy = (p2.dy - p1.dy) / totalDist;

    while (currentDist < totalDist) {
      final double endDraw = (currentDist + dashWidth).clamp(0.0, totalDist);

      canvas.drawLine(
        Offset(p1.dx + dx * currentDist, p1.dy + dy * currentDist),
        Offset(p1.dx + dx * endDraw, p1.dy + dy * endDraw),
        paint,
      );
      currentDist += dashWidth + dashSpace;
    }
    // NOTICE: No canvas.restore() here!
  }

  @override
  void drawPath(List<Offset> points, Color color, {bool fill = true}) {
    if (points.isEmpty) return;
    final path = Path()..moveTo(points.first.dx, points.first.dy);
    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }
    if (fill) path.close();

    final paint = Paint()
      ..color = color
      ..style = fill ? PaintingStyle.fill : PaintingStyle.stroke
      ..strokeWidth = fill ? 0 : 1.5;

    canvas.drawPath(path, paint);
  }

  @override
  void drawRect(Rect rect, Color color, {bool fill = false}) {
    final paint = Paint()
      ..color = color
      ..style = fill ? PaintingStyle.fill : PaintingStyle.stroke
      ..strokeWidth = fill ? 0 : 1.5;
    canvas.drawRect(rect, paint);
  }

  @override
  void drawRRect(Rect rect, Radius radius, Color color, {bool fill = true}) {
    final paint = Paint()
      ..color = color
      ..style = fill ? PaintingStyle.fill : PaintingStyle.stroke
      ..strokeWidth = fill ? 0 : 1.5;
    canvas.drawRRect(RRect.fromRectAndRadius(rect, radius), paint);
  }

  @override
  void drawDot(Offset center, Color color, {double? radius, bool fill = true}) {
    final paint = Paint()
      ..color = color
      ..style = fill ? PaintingStyle.fill : PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawCircle(center, radius ?? 4.0, paint);
  }

  @override
  void drawText(String text, Offset position, double fontSize, Color color) {
    final textSpan = TextSpan(
      text: text,
      style: TextStyle(color: color, fontSize: fontSize),
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, position);
    // NOTICE: No canvas.restore() here!
  }

  @override
  void paintTextPainter(TextPainter painter, Offset offset) {
    painter.paint(canvas, offset);
  }

  // --- Stack Management ---
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
    final path = Path()..moveTo(points.first.dx, points.first.dy);
    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }
    path.close();
    canvas.clipPath(path);
  }
}
