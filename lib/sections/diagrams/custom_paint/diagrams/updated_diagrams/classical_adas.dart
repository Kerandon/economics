import 'package:flutter/material.dart';

import '../../../enums/label_align.dart';
import '../../../models/base_painter_painter.dart';
import '../../../models/diagram_model.dart';
import '../../../models/diagram_painter_config.dart';
import '../../painter_constants.dart';
import '../../painter_methods/paint_axis.dart';
import '../../painter_methods/paint_curve.dart';
import '../../painter_methods/paint_diagram_dash_lines.dart';

class ClassicalADAS extends BaseDiagramPainter {
  ClassicalADAS({
    required DiagramPainterConfig config,
    required DiagramModel model,
  }) : super(config, model);

  @override
  void paint(Canvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);

    /// Dashed Lines
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.50,
      xAxisEndPos: 0.40,
      yLabel: kPLe,
      xLabel: kYe,
    );

    paintAxis(
      c,
      canvas,
      yAxisLabel: kPriceLevel,
      xAxisLabel: kRealGDP,
    );

    /// AD
    paintCurve(
      c,
      canvas,
      Offset(0.30, 0.30),
      Offset(0.80, 0.70),
      label2: kAD,
      label2Align: LabelAlign.centerRight,
    );

    /// SRAS
    paintCurve(
      c,
      canvas,
      Offset(0.30, 0.70),
      Offset(0.80, 0.30),
      label2: kSRAS,
      label2Align: LabelAlign.centerRight,
    );

    /// LRAS
    paintCurve(
      c,
      canvas,
      Offset(0.55, kAxisIndent),
      Offset(0.55, (1 - kAxisIndent)),
      label1: kLRAS,
      label1Align: LabelAlign.centerTop,
    );
  }
}
