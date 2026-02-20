// i_diagram_canvas.dart
import 'dart:ui';
import 'package:flutter/material.dart'
    show Color, Offset, Rect, TextAlign, TextPainter;
import 'dart:ui';

abstract class IDiagramCanvas {
  // ... existing drawing primitives ...
  void drawLine(Offset p1, Offset p2, Color color, double width);
  void drawDashedLine(Offset p1, Offset p2, Color color, double width);
  void drawPath(List<Offset> points, Color color, {bool fill = true});
  void drawRect(
    Rect rect,
    Color color, {
    bool fill = false,
    double strokeWidth = 1.0,
  }); // 👈 Add it here
  void drawRRect(Rect rect, Radius radius, Color color, {bool fill = true});
  void drawDot(Offset center, Color color, {double radius, bool fill = true});
  void clipPath(List<Offset> points);

  // Existing simple text method
  void drawText(String text, Offset position, double fontSize, Color color);

  // --- NEW METHOD ---
  // Allows passing a pre-configured TextPainter (with wrapping/layout already calculated)
  void paintTextPainter(TextPainter painter, Offset offset);

  // Transformations
  void save();
  void restore();
  void translate(double dx, double dy);
  void rotate(double radians);
}
