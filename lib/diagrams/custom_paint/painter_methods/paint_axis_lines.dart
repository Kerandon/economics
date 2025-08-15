import 'dart:math';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_arrow_head.dart';
import 'package:flutter/material.dart';
import '../../models/diagram_painter_config.dart';
import '../painter_constants.dart';

void paintAxisLines(
  DiagramPainterConfig config,
  Canvas canvas, {
  Color color = Colors.white,
  double strokeWidth = kAxisWidth,
}) {
  final double width = config.painterSize.width;
  final double height = config.painterSize.height;

  final axisPaint = Paint()
    ..color = config.colorScheme.onSurface
    ..strokeWidth = kCurveWidth * config.averageRatio;

  final startYOffset = Offset(width * kAxisIndent, height * kAxisIndent / 2);
  final endYOffset = Offset(width * kAxisIndent, height * (1 - kAxisIndent));
  final startXOffset = Offset(width * kAxisIndent, height * (1 - kAxisIndent));
  final endXOffset = Offset(
    width * (1 - kAxisIndent / 2),
    height * (1 - kAxisIndent),
  );
  canvas
    ..drawLine(startYOffset, endYOffset, axisPaint)
    ..drawLine(startXOffset, endXOffset, axisPaint);

  /// Arrow-head

  final path = Path();
  final paint = Paint()..color = Colors.white;

  /// Y Axis Arrow
  paintArrowHead(config, canvas, positionOfArrow: startYOffset);

  /// X Axis Arrow
  paintArrowHead(
    config,
    canvas,
    positionOfArrow: endXOffset,
    rotationAngle: pi / 2,
  );

  canvas.save();
  canvas.drawPath(path, paint);
  canvas.restore();
}
