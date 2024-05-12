import 'package:economics_app/app/custom_paint/paint_enums/text_box_shape.dart';
import 'package:flutter/material.dart';

import '../painter_methods/paint_text_box.dart';

class CircularFlowClosed extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;
    paintTextBox(canvas, size,
        text: 'Resource Markets',
        scale: 0.30,
        position: Offset(width * 0.50, height * 0.20),
        shape: TextBoxShape.diamond);
    paintTextBox(canvas, size,
        text: 'Product Markets',
        scale: 0.30,
        position: Offset(width * 0.50, height * 0.80),
        shape: TextBoxShape.diamond);
    paintTextBox(canvas, size,
        text: 'Households',
        scale: 0.30,
        position: Offset(width * 0.20, height * 0.50),
        shape: TextBoxShape.rectangle);
    paintTextBox(canvas, size,
        text: 'Firms',
        scale: 0.30,
        position: Offset(width * 0.80, height * 0.50),
        shape: TextBoxShape.rectangle);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
