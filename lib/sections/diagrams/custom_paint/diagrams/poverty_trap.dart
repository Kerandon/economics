import 'dart:math';

import 'package:economics_app/sections/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_custom_bezier.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_text_box.dart';
import 'package:economics_app/sections/diagrams/models/custom_bezier.dart';
import 'package:economics_app/sections/diagrams/models/diagram_painter_config.dart';
import 'package:flutter/material.dart';

import '../../models/base_painter_painter.dart';
import '../../models/diagram_model.dart';

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
      text: kLowIncome,
      position: Offset(kAxisIndent, 0.50),
    );
    paintTextBox(
      canvas: canvas,
      config: c,
      text: kLowSavings,
      position: Offset(0.50, 0.20),
    );
    paintTextBox(
      canvas: canvas,
      config: c,
      text: kLowInvestment,
      position: Offset((1 - kAxisIndent), 0.50),
    );
    paintTextBox(
      canvas: canvas,
      config: c,
      text: kLowProductivity,
      position: Offset(0.50, 0.80),
    );
    paintCustomBezier(c, canvas,
        startPos: Offset(0.15, 0.43),
        points: [
          CustomBezier(
            control: Offset(0.15, 0.22),
            endPoint: Offset(0.35, 0.20),
          ),
        ],
        drawArrowOnEnd: true,
        arrowOnEndAngle: pi * 0.50);
    paintCustomBezier(
      c,
      canvas,
      startPos: Offset(0.62, 0.20),
      points: [
        CustomBezier(
          control: Offset(0.85, 0.22),
          endPoint: Offset(0.85, 0.42),
        ),
      ],
      drawArrowOnEnd: true,
      arrowOnEndAngle: pi,
    );
    paintCustomBezier(
      c,
      canvas,
      startPos: Offset(0.85, 0.58),
      points: [
        CustomBezier(
          control: Offset(0.85, 0.80),
          endPoint: Offset(0.68, 0.80),
        ),
      ],
      drawArrowOnEnd: true,
      arrowOnEndAngle: pi * 1.5,
    );
    paintCustomBezier(
      c,
      canvas,
      startPos: Offset(0.35, 0.80),
      points: [
        CustomBezier(
          control: Offset(0.15, 0.80),
          endPoint: Offset(0.15, 0.58),
        ),
      ],
      drawArrowOnEnd: true,
      arrowOnEndAngle: 0,
    );
  }
}
