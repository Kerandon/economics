// i_diagram_canvas.dart
import 'dart:ui';
import 'package:flutter/material.dart' show Color, Offset, Rect, TextAlign;

abstract class IDiagramCanvas {
  void drawLine(Offset p1, Offset p2, Color color, double width);
  void drawDashedLine(Offset p1, Offset p2, Color color, double width);
  void drawText(
    String text,
    Offset position,
    double fontSize,
    Color color, {
    TextAlign align,
  });
  void drawPath(List<Offset> points, Color color, {bool fill = true});
  void drawRect(Rect rect, Color color, {bool fill = false});
  void drawDot(
    Offset center,
    Color color, {
    double radius = 5.0,
    bool fill = true,
  });
}
