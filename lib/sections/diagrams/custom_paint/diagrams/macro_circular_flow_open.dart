import 'dart:math' as math;
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_curve.dart';
import 'package:economics_app/sections/diagrams/diagram_enums/text_box_shape.dart';
import 'package:economics_app/sections/diagrams/utils/mixins.dart';
import 'package:flutter/material.dart';
import '../../diagram_enums/diagram_type.dart';
import '../painter_methods/paint_right_angle_curves.dart';
import '../painter_methods/paint_text.dart';
import '../painter_methods/paint_text_box.dart';

class MacroCircularFlowOfIncomeOpen extends CustomPainter with NameMixin {
  final Color color;
  final Color primaryColor;

  MacroCircularFlowOfIncomeOpen({
    super.repaint,
    this.type = DiagramType.macroCircularFlowOfIncomeDefault,
    this.color = Colors.white,
    this.primaryColor = Colors.green,
  });

  @override
  String get name => type.name;

  final DiagramType type;

  @override
  void paint(Canvas canvas, Size size) {
    if (type == DiagramType.macroCircularFlowOfIncomeDefault) {
      paintTextBox(
        canvas,
        size,
        text: 'Households',
        position: const Offset(0.15, 0.30),
        shape: TextBoxShape.diamond,
        color: Colors.white,
        fillColor: primaryColor,
        lineColor: color,
      );

      paintTextBox(
        canvas,
        size,
        text: 'Firms',
        position: const Offset(0.85, 0.30),
        shape: TextBoxShape.diamond,
        fillColor: primaryColor,
        lineColor: color,
      );

      /// Top curve

      paintRightAngleArrowCurves(
        canvas,
        size,
        xPosR: 0.15,
        xPosL: 0.85,
        yPos: 0.20,
        showRightArrow: true,
        curveHeight: 0.05,
        color: color,
      );

      /// Bottom curves

      paintRightAngleArrowCurves(
        canvas,
        size,
        xPosR: 0.15,
        xPosL: 0.85,
        yPos: 0.60,
        showRightArrow: true,
        angle: math.pi,
        curveHeight: 0.05,
        color: color,
      );

      paintText(size, canvas, 'Factor Incomes (rent, wages, interest, profit)',
          const Offset(0.50, 0.10));
      paintText(
          size, canvas, 'Household expenditure', const Offset(0.50, 0.40));

      /// Injections & Leakages

      paintTextBox(
        canvas,
        size,
        text: 'Financial sector',
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
        text: 'Foreign sector',
        position: const Offset(0.50, 0.85),
        lineColor: color,
        fillColor: primaryColor,
      );

      paintRightAngleArrowCurves(canvas, size,
          xPosR: 0.60,
          xPosL: 0.85,
          yPos: 0.45,
          flipVertically: true,
          curveHeight: 0.30,
          removeFirstAngle: true,
          removeSecondAngle: true);

      paintRightAngleArrowCurves(canvas, size,
          xPosR: 0.65,
          xPosL: 0.85,
          yPos: 0.45,
          showLeftArrow: true,
          flipVertically: true,
          flipHorizontally: true,
          curveHeight: 0.30,
          removeSecondAngle: true);

      paintCurve(
        size,
        canvas,
        const Offset(0.35, 0.65),
        const Offset(0.15, 0.65),
        strokeWidth: 1,
      );

      paintCurve(
        size,
        canvas,
        const Offset(0.35, 0.75),
        const Offset(0.15, 0.75),
        strokeWidth: 1,
      );
      paintRightAngleArrowCurves(canvas, size,
          xPosR: 0,
          xPosL: 0.750,
          yPos: 0.35,
          showLeftArrow: true,
          curveHeight: 0.20,
          removeFirstAngle: true,
          removeSecondAngle: true,
          angle: math.pi / 2);

      paintRightAngleArrowCurves(canvas, size,
          xPosR: 0,
          xPosL: 0.65,
          yPos: 0.35,
          showLeftArrow: true,
          curveHeight: 0.20,
          removeFirstAngle: true,
          removeSecondAngle: true,
          angle: math.pi / 2);

      paintRightAngleArrowCurves(canvas, size,
          xPosR: 0,
          xPosL: 0.85,
          yPos: 0.35,
          showLeftArrow: true,
          curveHeight: 0.20,
          removeFirstAngle: true,
          removeSecondAngle: true,
          angle: math.pi / 2);

      /// Injections and withdrawals labels

      paintText(size, canvas, 'Injections', const Offset(0.12, 0.70),
          angle: math.pi / -2);
      paintText(size, canvas, 'Leakages', const Offset(0.88, 0.70),
          angle: math.pi / 2);

      paintText(
        size,
        canvas,
        'Investment',
        const Offset(0.26, 0.62),
      );
      paintText(
        size,
        canvas,
        'Govt. spending',
        const Offset(0.26, 0.72),
      );
      paintText(
        size,
        canvas,
        'Export revenue',
        const Offset(0.26, 0.82),
      );
      paintText(
        size,
        canvas,
        'Saving',
        const Offset(0.72, 0.62),
      );
      paintText(
        size,
        canvas,
        'Taxation',
        const Offset(0.72, 0.72),
      );
      paintText(
        size,
        canvas,
        'Imports',
        const Offset(0.72, 0.82),
      );
    }
    if (type == DiagramType.macroCircularFlowOfIncomeClosed) {}
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
