import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_text.dart';
import 'package:economics_app/sections/diagrams/enums/text_box_shape.dart';
import 'package:flutter/material.dart';
import '../../enums/label_align.dart';
import '../../models/diagram_painter_config.dart';
import '../custom_rotate.dart';
import '../painter_constants.dart';

void paintTextBox(
  DiagramPainterConfig config,
  Canvas canvas, {
  required String text,
  required Offset position,
  TextBoxShape shape = TextBoxShape.rectangle,
  scale = 0.20,
  double angle = 0,
  double fontSizeAdjustment = 6.0,
  Color? fillColor,
  Color? lineColor,
}) {
  final width = config.painterSize.width;
  final height = config.painterSize.height;
  final halfWidth = width * 0.50;
  final verticalAdjustment = halfWidth / 2;
  final fontAdjustment = fontSizeAdjustment;

  final fillPaint = Paint()
    ..style = PaintingStyle.fill
    ..color = fillColor ?? Colors.transparent;

  final linePaint = Paint()
    ..strokeWidth = (kCurveWidth * 4) * config.averageRatio
    ..style = PaintingStyle.stroke
    ..color = lineColor ?? config.colorScheme.onSurface;

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
    case TextBoxShape.oval:
      path = Path()
        ..addOval(Rect.fromCenter(
            center: const Offset(0, 0), width: width, height: width / 2));
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
  paintText(config, canvas, text, Offset(position.dx, position.dy),
      fontSize: (scale * kDefaultFontSize) * fontAdjustment,
      curveAlign: LabelAlign.center);
}
