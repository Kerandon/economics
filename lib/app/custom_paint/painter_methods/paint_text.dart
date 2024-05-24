import 'package:flutter/material.dart';
import '../paint_enums/custom_align.dart';
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
  const adjustment = 10.0;
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
      yAlign = textPainter.height;
  }

  final offset = Offset(position.dx + xAlign, position.dy + yAlign);

  canvas.save();
  final pivot = textPainter.size.center(offset);
  canvas.translate(pivot.dx, pivot.dy);
  canvas.rotate(angle);
  canvas.translate(-pivot.dx, -pivot.dy);
  textPainter.paint(canvas, offset);
  canvas.restore();
}
