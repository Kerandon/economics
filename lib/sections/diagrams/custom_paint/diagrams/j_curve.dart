import 'dart:math';

import 'package:economics_app/sections/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_curve.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_custom_bezier.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_text.dart';
import 'package:economics_app/sections/diagrams/models/custom_bezier.dart';
import 'package:economics_app/sections/diagrams/models/diagram_painter_config.dart';
import 'package:flutter/material.dart';

import '../../models/base_painter_painter.dart';
import '../../models/diagram_model.dart';

class JCurve extends BaseDiagramPainter {
  JCurve({
    required DiagramPainterConfig config,
    required DiagramModel model,
  }) : super(config, model);

  @override
  void paint(Canvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);

    /// Y axis
    paintCurve(c, canvas, Offset(kAxisIndent, kAxisIndent),
        Offset(kAxisIndent, 1 - kAxisIndent),
        color: c.colorScheme.onSurface);

    /// X axis
    paintCurve(
        c, canvas, Offset(kAxisIndent, 0.50), Offset(1 - kAxisIndent, 0.50),
        color: c.colorScheme.onSurface);

    paintText(c, canvas, 'Trade Surplus (X>M)', Offset(0.20, 0.40),
        angle: pi * 1.5);
    paintText(c, canvas, 'Trade Deficit (X>M)', Offset(0.20, 0.80),
        angle: pi * 1.5);
    paintText(c, canvas, 'Trade\nBalance\n(X=M)', Offset(0.08, 0.50));

    paintCustomBezier(c, canvas, startPos: Offset(kAxisIndent, 0.60), points: [
      CustomBezier(
        control: Offset(kAxisIndent + 0.10, 0.60),
        endPoint: Offset(kAxisIndent + 0.10, 0.60),
      ),
      CustomBezier(
        control: Offset(kAxisIndent + 0.40, 0.90),
        endPoint: Offset(kAxisIndent + 0.70, 0.20),
      ),
    ]);
  }
}
