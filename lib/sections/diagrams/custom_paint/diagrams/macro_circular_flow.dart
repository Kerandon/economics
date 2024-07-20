import 'dart:math' as math;
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_curve.dart';
import 'package:economics_app/sections/diagrams/utils/mixins.dart';
import 'package:flutter/material.dart';
import '../../enums/diagram_type.dart';
import '../../enums/text_box_shape.dart';
import '../painter_methods/paint_right_angle_curves.dart';
import '../painter_methods/paint_text.dart';
import '../painter_methods/paint_text_box.dart';

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
    this.primaryColor = Colors.green,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final primaryColorAdjusted = primaryColor.withOpacity(0.20);
    if (type == DiagramType.macro_CircularFlowOfIncome_Default) {
      paintTextBox(
        canvas,
        size,
        text: 'Households',
        position: const Offset(0.15, 0.30),
        shape: TextBoxShape.diamond,
        color: Colors.white,
        fillColor: primaryColorAdjusted,
        lineColor: color,
      );

      paintTextBox(
        canvas,
        size,
        text: 'Firms',
        position: const Offset(0.85, 0.30),
        shape: TextBoxShape.diamond,
        fillColor: primaryColorAdjusted,
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

      paintText(size, canvas, 'Factor payments', const Offset(0.50, 0.10));
      paintText(
          size, canvas, 'Household expenditure', const Offset(0.50, 0.40));

      /// Injections & Leakages

      paintTextBox(
        canvas,
        size,
        text: 'Financial sector',
        position: const Offset(0.50, 0.65),
        lineColor: color,
        fillColor: primaryColorAdjusted,
      );
      paintTextBox(
        canvas,
        size,
        text: 'Government',
        position: const Offset(0.50, 0.75),
        lineColor: color,
        fillColor: primaryColorAdjusted,
      );
      paintTextBox(
        canvas,
        size,
        text: 'Foreign sector',
        position: const Offset(0.50, 0.85),
        lineColor: color,
        fillColor: primaryColorAdjusted,
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
        const Offset(0.26, 0.60),
      );
      paintText(
        size,
        canvas,
        'Govt. expenditure',
        const Offset(0.26, 0.70),
      );
      paintText(
        size,
        canvas,
        'Export revenue',
        const Offset(0.26, 0.80),
      );
      paintText(
        size,
        canvas,
        'Savings',
        const Offset(0.74, 0.60),
      );
      paintText(
        size,
        canvas,
        'Taxation',
        const Offset(0.74, 0.70),
      );
      paintText(
        size,
        canvas,
        'Import expenditure',
        const Offset(0.74, 0.80),
      );
    }
    if (type == DiagramType.macro_CircularFlowOfIncome_Closed) {
      paintTextBox(
        canvas,
        size,
        text: 'Households',
        position: const Offset(0.20, 0.50),
        shape: TextBoxShape.diamond,
        color: Colors.white,
        fillColor: primaryColorAdjusted,
        lineColor: color,
      );
      paintTextBox(
        canvas,
        size,
        text: 'Firms',
        position: const Offset(0.80, 0.50),
        shape: TextBoxShape.diamond,
        color: Colors.white,
        fillColor: primaryColorAdjusted,
        lineColor: color,
      );

      /// Top curves
      paintRightAngleArrowCurves(
        canvas,
        size,
        xPosR: 0.25,
        xPosL: 0.75,
        yPos: 0.40,
        showRightArrow: true,
        angle: math.pi * -2,
        curveHeight: 0.10,
        color: color,
      );
      paintRightAngleArrowCurves(
        canvas,
        size,
        xPosR: 0.15,
        xPosL: 0.85,
        yPos: 0.40,
        showLeftArrow: true,
        angle: math.pi * 2,
        curveHeight: 0.20,
        color: color,
      );

      /// Bottom curves

      paintRightAngleArrowCurves(
        canvas,
        size,
        xPosR: 0.25,
        xPosL: 0.75,
        yPos: 0.40,
        showRightArrow: true,
        angle: math.pi,
        curveHeight: 0.10,
        color: color,
      );
      paintRightAngleArrowCurves(
        canvas,
        size,
        xPosR: 0.15,
        xPosL: 0.85,
        yPos: 0.40,
        showLeftArrow: true,
        angle: math.pi,
        curveHeight: 0.20,
        color: color,
      );

      paintText(
          size,
          canvas,
          'Factors of production (labor, land, capital, entrepreneurship)',
          const Offset(0.50, 0.15));
      paintText(
          size,
          canvas,
          'Factors payments (wages, rent, interest, profit)',
          const Offset(0.50, 0.25));
      paintText(
          size, canvas, 'Household expenditure', const Offset(0.50, 0.75));
      paintText(size, canvas, 'Goods & services', const Offset(0.50, 0.85));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
