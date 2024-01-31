import 'dart:math';
import 'package:flutter/material.dart';

void addAxis() {}

void addXAxis(String text, Size size, Canvas canvas) {
  final textPainter = addText(text, size, canvas);
  textPainter.paint(
      canvas, Offset(size.width / 4, size.height - (size.height * 0.08)));
}

void addYAxis(String text, Size size, Canvas canvas) {
  final textPainter = addText(text, size, canvas);
  canvas.save();
  final offset = Offset(0 - size.width * 0.05, size.height / 2);

  /// Rotate text
  final pivot = textPainter.size.center(offset);
  canvas.translate(pivot.dx, pivot.dy);
  canvas.rotate(pi / -2);
  canvas.translate(-pivot.dx, -pivot.dy);
  textPainter.paint(canvas, offset);
  canvas.restore();
}

TextPainter addText(String text, Size size, Canvas canvas) {
  final textStyle = TextStyle(
    color: Colors.black,
    fontSize: size.width * 0.06,
  );
  final textSpan = TextSpan(
    text: text,
    style: textStyle,
  );
  final textPainter = TextPainter(
    text: textSpan,
    textDirection: TextDirection.ltr,
  );
  textPainter.layout(
    minWidth: 0,
    maxWidth: size.width,
  );
  return textPainter;
}
