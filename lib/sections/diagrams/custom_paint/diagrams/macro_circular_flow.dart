import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_color_label.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_text.dart';
import 'package:economics_app/sections/diagrams/enums/curve_align.dart';
import 'package:economics_app/sections/diagrams/utils/mixins.dart';
import 'package:flutter/material.dart';
import '../../enums/diagram_type.dart';
import '../../enums/text_box_shape.dart';
import '../../models/models.dart';
import '../painter_methods/paint_custom_bezier.dart';
import '../painter_methods/paint_text_box.dart';
import 'dart:math' as math;

class MacroCircularFlow extends CustomPainter with NameMixin {
  @override
  String get name => type.name;
  final Color color;
  final Color primaryColor;
  final DiagramType type;

  MacroCircularFlow({
    super.repaint,
    this.type = DiagramType.macro_CircularFlowOfIncome_Open,
    this.color = Colors.white,
    this.primaryColor = Colors.green,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (type == DiagramType.macro_CircularFlowOfIncome_Open) {
      paintTextBox(
        canvas,
        size,
        text: 'Households',
        position: const Offset(0.15, 0.30),
        shape: TextBoxShape.oval,
        lineColor: color,
      );

      paintTextBox(
        canvas,
        size,
        text: 'Firms',
        position: const Offset(0.85, 0.30),
        shape: TextBoxShape.oval,
        lineColor: color,
      );

      paintText(size, canvas, 'Factor payments', const Offset(0.50, 0.12));
      paintCustomBezier(
        size,
        canvas,
        startPos: const Offset(0.15, 0.22),
        points: [
          CustomBezier(
            control: const Offset(0.50, 0.10),
            endPoint: const Offset(0.85, 0.22),
          ),
        ],
        drawArrowOnStart: true,
        arrowOnStartAngle: math.pi * 1.2,
      );

      paintText(
          size, canvas, 'Household expenditure', const Offset(0.50, 0.49));
      paintCustomBezier(
        size,
        canvas,
        startPos: const Offset(0.15, 0.38),
        points: [
          CustomBezier(
            control: const Offset(0.50, 0.52),
            endPoint: const Offset(0.85, 0.38),
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
      );
      paintTextBox(
        canvas,
        size,
        text: 'Government',
        position: const Offset(0.50, 0.75),
        lineColor: color,
      );
      paintTextBox(
        canvas,
        size,
        text: 'Foreign',
        position: const Offset(0.50, 0.85),
        lineColor: color,
      );

      /// Leakages & injections

      _drawLeakagesAndInjections(size, canvas,
          label: 'Imports', isLeakage: true, xPosStart: 0.10, yPosEnd: 0.85);
      _drawLeakagesAndInjections(size, canvas,
          label: 'Taxation', isLeakage: true, xPosStart: 0.20, yPosEnd: 0.75);
      _drawLeakagesAndInjections(size, canvas,
          label: 'Savings', isLeakage: true, xPosStart: 0.30, yPosEnd: 0.65);
      _drawLeakagesAndInjections(size, canvas,
          label: 'Exports',
          isLeakage: false,
          xPosStart: 0.90,
          yPosEnd: 0.85,
          labelAdjustment: 0.12);
      _drawLeakagesAndInjections(size, canvas,
          label: 'Govt. Spending',
          isLeakage: false,
          xPosStart: 0.80,
          yPosEnd: 0.75,
          labelAdjustment: 0.20);
      _drawLeakagesAndInjections(size, canvas,
          label: 'Investment',
          isLeakage: false,
          xPosStart: 0.70,
          yPosEnd: 0.65,
          labelAdjustment: 0.15);
    }

    /// CLOSED MODEL
    if (type == DiagramType.macro_CircularFlowOfIncome_Closed_Default ||
        type == DiagramType.macro_CircularFlowOfIncome_Equivalence) {
      paintTextBox(canvas, size,
          text: 'Households',
          position: const Offset(0.15, 0.50),
          lineColor: color,
          shape: TextBoxShape.oval,
          scale: 0.25);
      paintTextBox(canvas, size,
          text: 'Firms',
          position: const Offset(0.85, 0.50),
          lineColor: color,
          shape: TextBoxShape.oval,
          scale: 0.25);
      paintText(size, canvas, 'Wages, rent, interest, profit',
          const Offset(0.50, 0.15));
      paintCustomBezier(
        size,
        canvas,
        startPos: const Offset(0.10, 0.40),
        points: [
          CustomBezier(
            control: const Offset(0.50, 0),
            endPoint: const Offset(0.90, 0.40),
          ),
        ],
        drawArrowOnStart: true,
        arrowOnStartAngle: math.pi * 1.1,
      );
      paintText(size, canvas, 'Labor, land, capital, enterprise',
          const Offset(0.50, 0.35));
      paintCustomBezier(
        size,
        canvas,
        startPos: const Offset(0.20, 0.40),
        points: [
          CustomBezier(
            control: const Offset(0.50, 0.15),
            endPoint: const Offset(0.80, 0.40),
          ),
        ],
        drawArrowOnEnd: true,
        arrowOnEndAngle: math.pi * 0.90,
      );
      paintText(size, canvas, 'Goods & services', const Offset(0.50, 0.65));
      paintCustomBezier(
        size,
        canvas,
        startPos: const Offset(0.20, 0.60),
        points: [
          CustomBezier(
            control: const Offset(0.50, 0.85),
            endPoint: const Offset(0.80, 0.60),
          ),
        ],
        drawArrowOnStart: true,
        arrowOnStartAngle: math.pi * -0.10,
      );
      paintText(size, canvas, 'Household expenditure / Firm Revenue',
          const Offset(0.50, 0.85));
      paintCustomBezier(
        size,
        canvas,
        startPos: const Offset(0.10, 0.60),
        points: [
          CustomBezier(
            control: const Offset(0.50, 1.0),
            endPoint: const Offset(0.90, 0.60),
          ),
        ],
        drawArrowOnEnd: true,
        arrowOnEndAngle: math.pi * 0.10,
      );
    }
    if (type == DiagramType.macro_CircularFlowOfIncome_Equivalence) {
      paintColorLabel(canvas, size, pos: const Offset(0.50, 0.20), text: 'A');
      paintColorLabel(canvas, size, pos: const Offset(0.50, 0.72), text: 'B');
      paintColorLabel(canvas, size, pos: const Offset(0.50, 0.80), text: 'C');
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

void _drawLeakagesAndInjections(Size size, Canvas canvas,
    {required bool isLeakage,
    required String label,
    required double xPosStart,
    required yPosEnd,
    double labelAdjustment = 0.07}) {
  paintText(size, canvas, label, Offset(xPosStart + labelAdjustment, 0.65),
      curveAlign: CurveAlign.centerLeft, angle: math.pi / -2);
  paintCustomBezier(
    size,
    canvas,
    startPos: Offset(xPosStart, 0.52),
    points: [
      CustomBezier(
        control: Offset(xPosStart, yPosEnd),
        endPoint: Offset(isLeakage ? 0.36 : 0.62, yPosEnd),
      ),
    ],
    drawArrowOnEnd: isLeakage,
    arrowOnEndAngle: math.pi / 2,
    drawArrowOnStart: !isLeakage,
  );
}
