import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_text.dart';
import 'package:economics_app/sections/diagrams/diagram_enums/text_box_shape.dart';
import 'package:flutter/material.dart';
import '../custom_rotate.dart';
import '../painter_constants.dart';

void paintTextBox(
  Canvas canvas,
  Size size, {
  required String text,
  required Offset position,
  TextBoxShape shape = TextBoxShape.rectangle,
  double topHeight = 2,
  Color color = Colors.white,
  Color fontColor = Colors.white,
  scale = 0.25,
  double angle = 0,
  double fontSizeAdjustment = 2.2,
  Color? fillColor,
  Color? lineColor,
}) {
  final width = size.width;
  final height = size.height;
  final halfWidth = width * 0.50;
  final verticalAdjustment = halfWidth / topHeight;
  final fontAdjustment = fontSizeAdjustment;

  final fillPaint = Paint()
    ..style = PaintingStyle.fill
    ..color = fillColor ?? Colors.transparent;

  final linePaint = Paint()
    ..strokeWidth = kTextBoxLineWidth
    ..style = PaintingStyle.stroke
    ..color = lineColor ?? color;

  Path path;

  switch (shape) {
    case TextBoxShape.rectangle:
      path = Path()
        ..addRect(Rect.fromCenter(
            center: const Offset(0, 0), width: width, height: height / 3));
      break;
    case TextBoxShape.diamond:
      path = Path()
        ..addPolygon([
          Offset(0, -verticalAdjustment),
          Offset(-halfWidth, 0),
          Offset(0, verticalAdjustment),
          Offset(halfWidth, 0),
        ], true);
      break;
  }

  /// Change position, scale, rotation
  canvas.save();
  canvas.translate(position.dx * width, position.dy * height);
  canvas.scale(scale);
  customRotate(canvas, width * 0.50, height * 0.50, angle);

  if (fillColor != null) {
    canvas.drawPath(path, fillPaint);
  }
  if (lineColor != null) {
    canvas.drawPath(path, linePaint);
  }

  canvas.restore();

  paintText(size, canvas, text, position,
      color: fontColor, fontSize: (scale * kDefaultFontSize) * fontAdjustment);
}
