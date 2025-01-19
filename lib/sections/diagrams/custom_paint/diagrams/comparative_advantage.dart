import 'package:economics_app/sections/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_axis.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_curve.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_text.dart';
import 'package:economics_app/sections/diagrams/models/diagram_painter_config.dart';
import 'package:flutter/material.dart';
import '../../models/base_painter_painter.dart';
import '../../models/diagram_model.dart';

class ComparativeAdvantage extends BaseDiagramPainter {
  ComparativeAdvantage({
    required DiagramPainterConfig config,
    required DiagramModel model,
  }) : super(config, model);

  @override
  void paint(Canvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);

    paintAxis(c, canvas, yAxisLabel: kPrice, xAxisLabel: kQ);

    paintCurve(
      c,
      canvas,
      Offset(kAxisIndent, 0.30),
      Offset(
        0.50,
        (1 - kAxisIndent),
      ),
    );
    paintCurve(
      c,
      canvas,
      Offset(kAxisIndent, 0.20),
      Offset(
        0.80,
        (1 - kAxisIndent),
      ),
    );

    /// Country A label
    paintText(
      c,
      canvas,
      kCountryA,
      Offset(0.55, 0.50),
    );

    /// Country B label
    paintText(
      c,
      canvas,
      kCountryB,
      Offset(0.48, 0.70),
    );
  }
}
