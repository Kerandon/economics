
import 'package:flutter/material.dart';

void paintText(Size size, Canvas canvas, String text, Offset position,
    {Color color = Colors.white, double fontSize = 15, double angle = 0,
    alignToLeft = false}) {
  final textStyle = TextStyle(
    color: Colors.white,
    fontSize: fontSize,
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
  final xAlign = alignToLeft == true ? - textPainter.width : (- textPainter.width / 2);
  final yAlign = (- textPainter.height / 2);
  final offset = Offset(xAlign + position.dx, yAlign + position.dy);



  canvas.save();
  final pivot = textPainter.size.center(offset);
  canvas.translate(pivot.dx, pivot.dy);
  canvas.rotate(angle);
  canvas.translate(-pivot.dx, -pivot.dy);
  textPainter.paint(canvas, offset);
  canvas.restore();

}

