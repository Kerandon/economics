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

  final widthAndHeight = config.painterSize.width;
  final indent = widthAndHeight * kAxisIndent;

  final axisPaint = Paint()
    ..color = config.colorScheme.onSurface
    ..strokeWidth = kCurveWidth * config.averageRatio;

  final indentXLeft = indent * 1.5;
  final indentYTop = indent * 0.50;
  final indentYBottom = widthAndHeight - (indent * 1.5);
  final indentXRight = widthAndHeight * (1 - (kAxisIndent * 0.50));

  final startYOffset = Offset(indentXLeft, indentYTop);
  final endYOffset = Offset(indentXLeft, indentYBottom);
  final startXOffset = Offset(indentXLeft, indentYBottom);
  final endXOffset = Offset(indentXRight, indentYBottom);

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
