import 'dart:math';
import 'package:flutter/material.dart';
import '../../enums/diagram_labels.dart';
import '../../models/base_painter_painter.dart';
import '../../models/custom_bezier.dart' show CustomBezier;
import '../../models/diagram_model.dart';
import '../../models/diagram_painter_config.dart';
import '../painter_constants.dart';
import '../painter_methods/paint_custom_bezier.dart';
import '../painter_methods/paint_text_box.dart';

class PovertyTrap extends BaseDiagramPainter {
  PovertyTrap({
    required DiagramPainterConfig config,
    required DiagramModel model,
  }) : super(config, model);

  @override
  void paint(Canvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);

    paintTextBox(
      canvas: canvas,
      config: c,
      text: DiagramLabel.lowIncome.label,
      position: Offset(kAxisIndent, 0.50),
      showBoxBorder: true,
    );
    paintTextBox(
      canvas: canvas,
      config: c,
      text: DiagramLabel.lowSavings.label,
      position: Offset(0.50, 0.20),
      showBoxBorder: true,
    );
    paintTextBox(
      canvas: canvas,
      config: c,
      text: DiagramLabel.lowInvestment.label,
      position: Offset((1 - kAxisIndent), 0.50),
      showBoxBorder: true,
    );
    paintTextBox(
      canvas: canvas,
      config: c,
      text: DiagramLabel.lowProductivity.label,
      position: Offset(0.50, 0.80),
      showBoxBorder: true,
    );
    paintCustomBezier(
      c,
      canvas,
      startPos: Offset(0.15, 0.40),
      points: [
        CustomBezier(control: Offset(0.15, 0.20), endPoint: Offset(0.28, 0.20)),
      ],
      drawArrowOnEnd: true,
      arrowOnEndAngle: pi * 0.50,
    );
    paintCustomBezier(
      c,
      canvas,
      startPos: Offset(0.70, 0.20),
      points: [
        CustomBezier(control: Offset(0.85, 0.22), endPoint: Offset(0.85, 0.40)),
      ],
      drawArrowOnEnd: true,
      arrowOnEndAngle: pi,
    );
    paintCustomBezier(
      c,
      canvas,
      startPos: Offset(0.85, 0.58),
      points: [
        CustomBezier(control: Offset(0.85, 0.80), endPoint: Offset(0.75, 0.80)),
      ],
      drawArrowOnEnd: true,
      arrowOnEndAngle: pi * 1.5,
    );
    paintCustomBezier(
      c,
      canvas,
      startPos: Offset(0.25, 0.80),
      points: [
        CustomBezier(control: Offset(0.15, 0.80), endPoint: Offset(0.15, 0.60)),
      ],
      drawArrowOnEnd: true,
      arrowOnEndAngle: 0,
    );
  }
}
