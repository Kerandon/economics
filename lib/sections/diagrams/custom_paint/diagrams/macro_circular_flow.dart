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
  final Color onSurfaceColor;
  final Color primaryColor;
  final DiagramType type;

  MacroCircularFlow({
    super.repaint,
    this.type = DiagramType.macro_CircularFlowOfIncome_Open,
    required this.onSurfaceColor,
    required this.primaryColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (type == DiagramType.macro_CircularFlowOfIncome_Open) {
      paintTextBox(
        canvas,
        size,
        color: onSurfaceColor,
        text: 'Households',
        position: const Offset(0.15, 0.30),
        shape: TextBoxShape.oval,
        lineColor: onSurfaceColor,
      );

      paintTextBox(
        canvas,
        size,
        color: onSurfaceColor,
        text: 'Firms',
        position: const Offset(0.85, 0.30),
        shape: TextBoxShape.oval,
        lineColor: onSurfaceColor,
      );

      paintText(size, canvas, 'Factor payments', const Offset(0.50, 0.12),
          color: onSurfaceColor);
      paintCustomBezier(
        size,
        canvas,
        onSurfaceColor,
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
        size,
        canvas,
        color: onSurfaceColor,
        'Household expenditure',
        const Offset(0.50, 0.49),
      );
      paintCustomBezier(
        size,
        canvas,
        onSurfaceColor,
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
        color: onSurfaceColor,
        text: 'Financial',
        position: const Offset(0.50, 0.65),
        lineColor: onSurfaceColor,
      );
      paintTextBox(
        canvas,
        size,
        color: onSurfaceColor,
        text: 'Government',
        position: const Offset(0.50, 0.75),
        lineColor: onSurfaceColor,
      );
      paintTextBox(
        canvas,
        size,
        color: onSurfaceColor,
        text: 'Foreign',
        position: const Offset(0.50, 0.85),
        lineColor: onSurfaceColor,
      );

      /// Leakages & injections

      _drawLeakagesAndInjections(size, canvas, onSurfaceColor,
          label: 'Imports', isLeakage: true, xPosStart: 0.10, yPosEnd: 0.85);
      _drawLeakagesAndInjections(size, canvas, onSurfaceColor,
          label: 'Taxation', isLeakage: true, xPosStart: 0.20, yPosEnd: 0.75);
      _drawLeakagesAndInjections(size, canvas, onSurfaceColor,
          label: 'Savings', isLeakage: true, xPosStart: 0.30, yPosEnd: 0.65);
      _drawLeakagesAndInjections(size, canvas, onSurfaceColor,
          label: 'Exports',
          isLeakage: false,
          xPosStart: 0.90,
          yPosEnd: 0.85,
          labelAdjustment: 0.12);
      _drawLeakagesAndInjections(size, canvas, onSurfaceColor,
          label: 'Govt. Spending',
          isLeakage: false,
          xPosStart: 0.80,
          yPosEnd: 0.75,
          labelAdjustment: 0.20);
      _drawLeakagesAndInjections(size, canvas, onSurfaceColor,
          label: 'Investment',
          isLeakage: false,
          xPosStart: 0.70,
          yPosEnd: 0.65,
          labelAdjustment: 0.15);
    }

    /// CLOSED MODEL
    if (type == DiagramType.macro_CircularFlowOfIncome_Closed_Default ||
        type ==
            DiagramType.macro_CircularFlowOfIncome_IncomeOutputExpenditure) {
      paintTextBox(canvas, size,
          color: onSurfaceColor,
          text: 'Households',
          position: const Offset(0.15, 0.50),
          lineColor: onSurfaceColor,
          shape: TextBoxShape.oval,
          scale: 0.25);
      paintTextBox(canvas, size,
          color: onSurfaceColor,
          text: 'Firms',
          position: const Offset(0.85, 0.50),
          lineColor: onSurfaceColor,
          shape: TextBoxShape.oval,
          scale: 0.25);
      paintText(
          size,
          canvas,
          color: onSurfaceColor,
          'Wages, rent, interest, profit',
          const Offset(0.50, 0.15));
      paintCustomBezier(
        size,
        canvas,
        onSurfaceColor,
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
      paintText(
          size,
          canvas,
          color: onSurfaceColor,
          'Labor, land, capital, enterprise',
          const Offset(0.50, 0.35));
      paintCustomBezier(
        size,
        canvas,
        onSurfaceColor,
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
      paintText(
          size,
          canvas,
          color: onSurfaceColor,
          'Goods & services',
          const Offset(0.50, 0.65));
      paintCustomBezier(
        size,
        canvas,
        onSurfaceColor,
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
      paintText(
          size,
          canvas,
          color: onSurfaceColor,
          'Household expenditure / Firm Revenue',
          const Offset(0.50, 0.85));
      paintCustomBezier(
        size,
        canvas,
        onSurfaceColor,
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
    if (type ==
        DiagramType.macro_CircularFlowOfIncome_IncomeOutputExpenditure) {
      paintColorLabel(canvas, size,
          color: primaryColor, pos: const Offset(0.50, 0.20), text: 'A');
      paintColorLabel(canvas, size,
          color: primaryColor, pos: const Offset(0.50, 0.72), text: 'B');
      paintColorLabel(canvas, size,
          color: primaryColor, pos: const Offset(0.50, 0.80), text: 'C');
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

void _drawLeakagesAndInjections(
  Size size,
  Canvas canvas,
  Color color, {
  required bool isLeakage,
  required String label,
  required double xPosStart,
  required yPosEnd,
  double labelAdjustment = 0.07,
}) {
  paintText(
      size,
      canvas,
      color: color,
      label,
      Offset(xPosStart + labelAdjustment, 0.65),
      curveAlign: CurveAlign.centerLeft,
      angle: math.pi / -2);
  paintCustomBezier(
    size,
    canvas,
    color,
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
