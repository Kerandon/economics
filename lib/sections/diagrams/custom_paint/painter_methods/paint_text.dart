import 'package:flutter/material.dart';
import '../../diagram_enums/custom_align.dart';
import '../painter_constants.dart';

void paintText(Size size, Canvas canvas, String text, Offset position,
    {Color color = Colors.white,
    double fontSize = kFontSize,
    double angle = 0,
    CustomAlign align = CustomAlign.center}) {
  final textStyle = TextStyle(
    color: color,
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

  double xAlign = 0;
  double yAlign = 0;
  const adjustment = 6.0;
  switch (align) {
    case CustomAlign.center:
      xAlign = -textPainter.width / 2;
      yAlign = -textPainter.height / 2;
      break;
    case CustomAlign.centerLeft:
      xAlign = -textPainter.width - adjustment;
      yAlign = -textPainter.height / 2;
      break;
    case CustomAlign.centerRight:
      xAlign = adjustment;
      yAlign = -textPainter.height / 2;
    case CustomAlign.centerTop:
      xAlign = -textPainter.width / 2;
      yAlign = -textPainter.height - adjustment;
    case CustomAlign.centerBottom:
      xAlign = -textPainter.width / 2;
      yAlign = textPainter.height - adjustment;
  }

  final offset = Offset((position.dx * size.width) + xAlign,
      (position.dy * size.height) + yAlign);

  canvas.save();
  final pivot = textPainter.size.center(offset);
  canvas.translate(pivot.dx, pivot.dy);
  canvas.rotate(angle);
  canvas.translate(-pivot.dx, -pivot.dy);
  textPainter.paint(canvas, offset);
  canvas.restore();
}
