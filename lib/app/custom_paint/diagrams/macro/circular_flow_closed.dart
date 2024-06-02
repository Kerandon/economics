import 'dart:math' as math;
import 'package:economics_app/app/custom_paint/paint_enums/text_box_shape.dart';
import 'package:economics_app/app/custom_paint/painter_methods/paint_curve.dart';
import 'package:economics_app/app/custom_paint/painter_methods/paint_text.dart';
import 'package:flutter/material.dart';

import '../../painter_methods/paint_right_angle_curves.dart';
import '../../painter_methods/paint_text_box.dart';

class CircularFlowClosed extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;

    final leftBox = 0.20 * width;
    final rightBox = 0.80 * width;
    final sideBoxHeight = 0.30 * height;

    paintTextBox(canvas, size,
        text: 'Households',
        scale: 0.25,
        position: Offset(leftBox, sideBoxHeight),
        shape: TextBoxShape.rectangle);
    paintTextBox(canvas, size,
        text: 'Firms',
        scale: 0.25,
        position: Offset(rightBox, sideBoxHeight),
        shape: TextBoxShape.rectangle);

    /// Top curves
    paintRightAngleArrowCurves(canvas, size,
        xPosR: 0.15,
        xPosL: 0.85,
        yPos: 0.22,
        showLeftArrow: true,
        curveHeight: 0.10);

    paintRightAngleArrowCurves(canvas, size,
        xPosR: 0.25,
        xPosL: 0.75,
        yPos: 0.22,
        showRightArrow: true,
        curveHeight: 0.05);

    /// Bottom curves

    paintRightAngleArrowCurves(canvas, size,
        xPosR: 0.15,
        xPosL: 0.85,
        yPos: 0.62,
        showLeftArrow: true,
        angle: math.pi,
        curveHeight: 0.10);
    paintRightAngleArrowCurves(canvas, size,
        xPosR: 0.25,
        xPosL: 0.75,
        yPos: 0.62,
        showRightArrow: true,
        angle: math.pi,
        curveHeight: 0.05);

    paintText(
        size,
        canvas,
        'Factors of Production'
        ' (land, labor, capital, enterprise)',
        Offset(width * 0.50, height * 0.09));
    paintText(size, canvas, 'Factor Incomes (rent, wages, interest, profit',
        Offset(width * 0.50, height * 0.20));
    paintText(size, canvas, 'Household spending / firm revenue',
        Offset(width * 0.50, height * 0.40));
    paintText(
        size, canvas, 'Goods & services', Offset(width * 0.50, height * 0.51));

    paintText(
      size,
      canvas,
      'RESOURCES MARKET',
      Offset(width * 0.50, height * 0.15),
    );
    paintText(
      size,
      canvas,
      'PRODUCT MARKET',
      Offset(width * 0.50, height * 0.46),
    );

    /// Injections & withdrawals

    paintTextBox(canvas, size,
        text: 'Government',
        position: Offset(width / 2, height * 0.65),
        scale: 0.20);
    paintTextBox(canvas, size,
        text: 'Financial sector',
        position: Offset(width / 2, height * 0.75),
        scale: 0.20);
    paintTextBox(canvas, size,
        text: 'Foreign sector',
        position: Offset(width / 2, height * 0.85),
        scale: 0.20);

    paintRightAngleArrowCurves(canvas, size,
        xPosR: 0.60,
        xPosL: 0.85,
        yPos: 0.45,
        flipVertically: true,
        curveHeight: 0.30,
        removeFirstAngle: true,
        removeSecondAngle: true);

    paintRightAngleArrowCurves(canvas, size,
        xPosR: 0.60,
        xPosL: 0.85,
        yPos: 0.45,
        showLeftArrow: true,
        flipVertically: true,
        flipHorizontally: true,
        curveHeight: 0.30,
        removeSecondAngle: true);

    paintCurve(size, canvas, Offset(width * 0.40, height * 0.65),
        Offset(width * 0.15, height * 0.65),
        strokeWidth: 1);

    paintCurve(size, canvas, Offset(width * 0.40, height * 0.75),
        Offset(width * 0.15, height * 0.75),
        strokeWidth: 1);

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

    paintText(size, canvas, 'Injections', Offset(width * 0.12, height * 0.70),
        angle: math.pi / -2);
    paintText(size, canvas, 'Leakages / Withdrawals',
        Offset(width * 0.88, height * 0.70),
        angle: math.pi / 2);

    paintText(
      size,
      canvas,
      'Government spending',
      Offset(width * 0.27, height * 0.62),
    );
    paintText(
      size,
      canvas,
      'Investment',
      Offset(width * 0.27, height * 0.72),
    );
    paintText(
      size,
      canvas,
      'Exports',
      Offset(width * 0.27, height * 0.82),
    );
    paintText(
      size,
      canvas,
      'Taxation',
      Offset(width * 0.72, height * 0.62),
    );
    paintText(
      size,
      canvas,
      'Saving',
      Offset(width * 0.72, height * 0.72),
    );
    paintText(
      size,
      canvas,
      'Imports',
      Offset(width * 0.72, height * 0.82),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
