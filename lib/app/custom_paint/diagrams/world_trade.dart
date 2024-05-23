import 'package:economics_app/app/custom_paint/paint_enums/custom_align.dart';
import 'package:economics_app/app/custom_paint/painter_constants.dart';
import 'package:economics_app/app/custom_paint/painter_methods/paint_axis.dart';
import 'package:economics_app/app/custom_paint/painter_methods/paint_curve.dart';
import 'package:economics_app/app/custom_paint/painter_methods/paint_diagram_dash_lines.dart';
import 'package:economics_app/app/custom_paint/painter_methods/paint_text.dart';
import 'package:flutter/material.dart';

class WorldTrade extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;
    paintAxis(size, canvas, 'Price (\$)', 'Quantity');
    paintCurve(
      size,
      canvas,
      Offset(width * 0.20, height * 0.80),
      Offset(width * 0.85, height * 0.10),
      label2: 'S domestic',
      label2Align: CustomAlign.centerTop,
    );
    paintCurve(
      size,
      canvas,
      Offset(width * 0.22, height * 0.10),
      Offset(width * 0.80, height * 0.80),
      label2: 'D domestic',
      label2Align: CustomAlign.centerBottom,
    );
    paintCurve(size, canvas, Offset(width * kAxisIndent, height * 0.46),
        Offset(width * 0.52, height * 0.46),
        label1: 'Pd', label1Align: CustomAlign.centerLeft, makeDashed: true);
    paintCurve(
      size,
      canvas,
      Offset(width * kAxisIndent, height * 0.70),
      Offset(
        width - (width * kAxisIndent),
        height * 0.70,
      ),
      label1: 'Pw',
      label1Align: CustomAlign.centerLeft,
      label2: 'S world',
      label2Align: CustomAlign.centerRight,
    );

    paintCurve(
        size,
        canvas,
        Offset(width * kAxisIndent, height * 0.58),
        Offset(
          width - (width * kAxisIndent),
          height * 0.58,
        ),
        label1: 'Pwt',
        label1Align: CustomAlign.centerLeft,
        label2: 'S + tariff',
        label2Align: CustomAlign.centerRight);

    /// Vertical lines
    paintCurve(
        size,
        canvas,
        Offset(width * 0.29, height - (height * kAxisIndent)),
        Offset(
          width * 0.29,
          height * 0.70,
        ),
        makeDashed: true);
    paintCurve(
      size,
      canvas,
      Offset(width * 0.41, height - (height * kAxisIndent)),
      Offset(
        width * 0.41,
        height * 0.58,
      ),
      makeDashed: true,
    );
    paintCurve(
        size,
        canvas,
        Offset(width * 0.62, height - (height * kAxisIndent)),
        Offset(
          width * 0.62,
          height * 0.58,
        ),
        makeDashed: true);
    paintCurve(
      size,
      canvas,
      Offset(width * 0.72, height - (height * kAxisIndent)),
      Offset(
        width * 0.72,
        height * 0.70,
      ),
      makeDashed: true,
    );

    /// Label letters
    paintText(size, canvas, 'a', Offset(width * 0.25, height * 0.40));
    paintText(size, canvas, 'b', Offset(width * 0.52, height * 0.53));
    paintText(size, canvas, 'c', Offset(width * 0.25, height * 0.64));
    paintText(size, canvas, 'd', Offset(width * 0.38, height * 0.66));
    paintText(size, canvas, 'e', Offset(width * 0.52, height * 0.64));
    paintText(size, canvas, 'f', Offset(width * 0.65, height * 0.66));
    paintText(size, canvas, 'g', Offset(width * 0.20, height * 0.74));

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
