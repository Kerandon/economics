// i_diagram_canvas.dart
import 'dart:ui';
import 'package:flutter/material.dart' show Color, Offset, Rect, TextAlign;
import 'dart:ui';

abstract class IDiagramCanvas {
  // Drawing primitives
  void drawLine(Offset p1, Offset p2, Color color, double width);
  void drawDashedLine(Offset p1, Offset p2, Color color, double width);
  void drawPath(List<Offset> points, Color color, {bool fill = true});
  void drawRect(Rect rect, Color color, {bool fill = false});
  void drawDot(Offset center, Color color, {double radius, bool fill = true});
  void clipPath(List<Offset> points);

  // Text
  void drawText(
    String text,
    Offset position, // This should be the Top-Left corner of the text
    double fontSize,
    Color color,
  );

  // Transformations & Context
  void save();
  void restore();
  void translate(double dx, double dy);
  void rotate(double radians);
}
