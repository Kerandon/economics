import 'package:flutter/material.dart';
import '../../enums/diagram_labels.dart';
import '../../enums/diagram_subtype.dart';
import '../../models/base_painter_painter.dart';
import '../../models/diagram_model.dart';
import '../../models/diagram_painter_config.dart';
import '../painter_methods/axis/paint_axis.dart';
import '../painter_methods/paint_diagram_dash_lines.dart';
import '../painter_methods/shortcut_methods/paint_keyensian_curve.dart';

class KeynesianADAS extends BaseDiagramPainter {
  KeynesianADAS({
    required DiagramPainterConfig config,
    required DiagramModel model,
  }) : super(config, model);

  @override
  void paint(Canvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);

    if (model.subtype == DiagramSubtype.fullEmploymentKeynesian) {
      /// Dashed Lines
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.82,
        xAxisEndPos: 0.77,
        xLabel: DiagramLabel.yE.label,
      );
    }

    paintAxis(
      c,
      canvas,
      yAxisLabel: DiagramLabel.priceLevel.label,
      xAxisLabel: DiagramLabel.realGDP.label,
    );

    paintKeynesianCurve(config: c, canvas: canvas);
  }
}
