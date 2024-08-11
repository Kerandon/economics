import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_text.dart';
import 'package:economics_app/sections/diagrams/utils/mixins.dart';
import 'package:flutter/material.dart';
import '../../enums/diagram_type.dart';
import '../../enums/text_box_shape.dart';
import '../../models/models.dart';
import '../painter_methods/paint_custom_bezier.dart';
import '../painter_methods/paint_text_box.dart';
import 'dart:math' as math;

class MacroCircularFlowOfIncome extends CustomPainter with NameMixin {
  @override
  String get name => type.name;
  final Color color;
  final Color primaryColor;
  final DiagramType type;

  MacroCircularFlowOfIncome({
    super.repaint,
    this.type = DiagramType.macro_CircularFlowOfIncome_Default,
    this.color = Colors.white,
    this.primaryColor = Colors.transparent,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (type == DiagramType.macro_CircularFlowOfIncome_Default) {
      paintTextBox(
        canvas,
        size,
        text: 'Households',
        position: const Offset(0.15, 0.30),
        shape: TextBoxShape.oval,
        fillColor: primaryColor,
        lineColor: color,
      );

      paintTextBox(
        canvas,
        size,
        text: 'Firms',
        position: const Offset(0.85, 0.30),
        shape: TextBoxShape.oval,
        fillColor: primaryColor,
        lineColor: color,
      );

      paintCustomBezier(
        size,
        canvas,
        startPos: const Offset(0.15, 0.20),
        points: [
          CustomBezier(
            control: const Offset(0.50, 0.05),
            endPoint: const Offset(0.85, 0.20),
          ),
        ],
        drawArrowOnStart: true,
        arrowOnStartAngle: math.pi * 1.2,
      );

      paintCustomBezier(
        size,
        canvas,
        startPos: const Offset(0.15, 0.40),
        points: [
          CustomBezier(
            control: const Offset(0.50, 0.55),
            endPoint: const Offset(0.85, 0.40),
          ),
        ],
        drawArrowOnEnd: true,
        arrowOnEndAngle: math.pi * 0.20,
      );

      /// Injections & Leakages

      paintTextBox(
        canvas,
        size,
        text: 'Financial',
        position: const Offset(0.50, 0.65),
        lineColor: color,
        fillColor: primaryColor,
      );
      paintTextBox(
        canvas,
        size,
        text: 'Government',
        position: const Offset(0.50, 0.75),
        lineColor: color,
        fillColor: primaryColor,
      );
      paintTextBox(
        canvas,
        size,
        text: 'Foreign',
        position: const Offset(0.50, 0.85),
        lineColor: color,
        fillColor: primaryColor,
      );
    }

    /// Leakages



    paintCustomBezier(
      size,
      canvas,
      startPos: const Offset(0.10, 0.55),
      points: [
        CustomBezier(
          control: const Offset(0.10, 0.85),
          endPoint: const Offset(0.35, 0.85),
        ),
      ],
      drawArrowOnEnd: true,
      arrowOnEndAngle: math.pi / 2,
    );
    paintCustomBezier(
      size,
      canvas,
      startPos: const Offset(0.30, 0.55),
      points: [
        CustomBezier(
          control: const Offset(0.30, 0.65),
          endPoint: const Offset(0.35, 0.65),
        ),
      ],
      drawArrowOnEnd: true,
      arrowOnEndAngle: math.pi / 2,
    );
    paintCustomBezier(
      size,
      canvas,
      startPos: const Offset(0.20, 0.55),
      points: [
        CustomBezier(
          control: const Offset(0.20, 0.75),
          endPoint: const Offset(0.35, 0.75),
        ),
      ],
      drawArrowOnEnd: true,
      arrowOnEndAngle: math.pi / 2,
    );

    /// Injections

    paintCustomBezier(
      size,
      canvas,
      startPos: const Offset(0.90, 0.55),
      points: [
        CustomBezier(
          control: const Offset(0.90, 0.85),
          endPoint: const Offset(0.65, 0.85),
        ),
      ],
      drawArrowOnStart: true,
    );

    paintText(size, canvas, 'Imports', Offset(0.10, 1.20));

    paintCustomBezier(
      size,
      canvas,
      startPos: const Offset(0.80, 0.55),
      points: [
        CustomBezier(
          control: const Offset(0.80, 0.75),
          endPoint: const Offset(0.65, 0.75),
        ),
      ],
      drawArrowOnStart: true,
    );
    paintCustomBezier(
      size,
      canvas,
      startPos: const Offset(0.70, 0.55),
      points: [
        CustomBezier(
          control: const Offset(0.70, 0.65),
          endPoint: const Offset(0.65, 0.65),
        ),
      ],
      drawArrowOnStart: true,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
