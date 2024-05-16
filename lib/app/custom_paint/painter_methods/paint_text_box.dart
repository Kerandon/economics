import 'package:economics_app/app/custom_paint/paint_enums/text_box_shape.dart';
import 'package:economics_app/app/custom_paint/painter_methods/paint_text.dart';
import 'package:flutter/material.dart';

import '../custom_rotate.dart';
import '../painter_constants.dart';

void paintTextBox(
  Canvas canvas,
  Size size, {
  required String text,
  required Offset position,
  TextBoxShape shape = TextBoxShape.rectangle,
  double topHeight = 3,
  Color lineColor = Colors.white,
  Color fontColor = Colors.white,
  scale = 0.60,
  double angle = 0,
  double fontSizeAdjustment = 2.2,
}) {
  final width = size.width;
  final height = size.height;
  final halfWidth = width * 0.50;
  final verticalAdjustment = topHeight;
  final fontAdjustment = fontSizeAdjustment;

  final paint = Paint()
    ..strokeWidth = kTextBoxLineWidth
    ..style = PaintingStyle.stroke
    ..color = lineColor;

  Path path;

  switch (shape) {
    case TextBoxShape.rectangle:
      path = Path()
        ..addRect(Rect.fromCenter(
            center: Offset(width / 2, height / 2),
            width: width,
            height: height / 2 - (halfWidth / verticalAdjustment)));

    case TextBoxShape.diamond:
      path = Path()
        ..addPolygon([
          Offset(halfWidth, halfWidth / verticalAdjustment),
          Offset(0, halfWidth),
          Offset(width * 0.50, height - (halfWidth / verticalAdjustment)),
          Offset(width, height * 0.50)
        ], true);
  }

  final centerWidthAdjustment = (width * scale) / 2;
  final centerHeightAdjustment = (height * scale) / 2;

  paintText(size, canvas, text, position,
      color: fontColor, fontSize: (scale * kDefaultFontSize) * fontAdjustment);

  /// Change position, scale, rotation
  canvas.save();
  canvas.translate(position.dx - centerWidthAdjustment,
      position.dy - centerHeightAdjustment);
  canvas.scale(scale);
  customRotate(canvas, width * 0.50, height * 0.50, angle);
  canvas.drawPath(path, paint);
  canvas.restore();
}
