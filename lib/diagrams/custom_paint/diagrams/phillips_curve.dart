import 'package:flutter/material.dart';
import '../../enums/diagram_labels.dart';
import '../../enums/label_align.dart';
import '../../models/base_painter_painter.dart';
import '../../models/custom_bezier.dart';
import '../../models/diagram_model.dart';
import '../../models/diagram_painter_config.dart';
import '../painter_methods/paint_axis.dart';
import '../painter_methods/paint_custom_bezier.dart';

class PhillipsCurve extends BaseDiagramPainter {
  PhillipsCurve({
    required DiagramPainterConfig config,
    required DiagramModel model,
  }) : super(config, model);

  @override
  void paint(Canvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);

    paintAxis(
      c,
      canvas,
      yAxisLabel: DiagramLabel.inflationRate.label,
      xAxisLabel: DiagramLabel.inflationRate.label,
    );

    /// SRPC
    paintCustomBezier(
      c,
      canvas,
      startPos: Offset(0.25, 0.30),
      points: [
        CustomBezier(control: Offset(0.30, 0.70), endPoint: Offset(0.80, 0.75)),
      ],
      label1: DiagramLabel.sRPC.label,
      label1Align: LabelAlign.centerRight,
    );
  }
}
