import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_axis.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_curve.dart';
import 'package:economics_app/sections/diagrams/models/diagram_model.dart';
import 'package:economics_app/sections/diagrams/utils/mixins.dart';
import 'package:flutter/material.dart';

class CircularFlowOfIncome extends CustomPainter with DiagramIdentifierMixin {
  @override
  DiagramModel get model => diagramModel;

  final Size appSize;
  final DiagramModel diagramModel;
  final Color surfaceColor;
  final Color onSurfaceColor;
  final Color primaryColor;

  CircularFlowOfIncome({
    required this.appSize,
    required this.diagramModel,
    required this.surfaceColor,
    required this.onSurfaceColor,
    required this.primaryColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    paintAxis(size, canvas);
    paintCurve(size, canvas, Offset(100, 200), Offset(0, 0));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
