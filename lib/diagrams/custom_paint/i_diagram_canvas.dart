// i_diagram_canvas.dart
import 'dart:ui';
import 'package:flutter/material.dart' show Color, Offset, Rect, TextAlign;
import 'dart:ui';

abstract class IDiagramCanvas {
  // Drawing primitives
  void drawLine(Offset p1, Offset p2, Color color, double width);
  void drawDashedLine(Offset p1, Offset p2, Color color, double width);

  // Draws a polygon from a list of points (Used for Diamond)
  void drawPath(List<Offset> points, Color color, {bool fill = true});

  // Standard Rectangle (Used for Square)
  void drawRect(Rect rect, Color color, {bool fill = false});

  // NEW: Rounded Rectangle (Used for Circle/Capsule)
  void drawRRect(Rect rect, Radius radius, Color color, {bool fill = true});

  void drawDot(Offset center, Color color, {double radius, bool fill = true});
  void clipPath(List<Offset> points);

  // Text
  void drawText(
    String text,
    Offset position, // Top-Left corner of the text
    double fontSize,
    Color color,
  );

  // Transformations & Context
  void save();
  void restore();
  void translate(double dx, double dy);
  void rotate(double radians);
}
