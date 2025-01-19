import 'package:economics_app/sections/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_axis.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_curve.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_diagram_dash_lines.dart';
import 'package:economics_app/sections/diagrams/enums/label_align.dart';
import 'package:economics_app/sections/diagrams/models/diagram_painter_config.dart';
import 'package:flutter/material.dart';
import '../../models/base_painter_painter.dart';
import '../../models/diagram_model.dart';

class FloatingExchangeRate extends BaseDiagramPainter {
  FloatingExchangeRate({
    required DiagramPainterConfig config,
    required DiagramModel model,
  }) : super(config, model);

  @override
  void paint(Canvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);

    paintAxis(c, canvas, yAxisLabel: kEuroPerUS, xAxisLabel: kQuantityOfUSD);

    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.50,
      xAxisEndPos: 0.38,
      yLabel: kExchangeRateEquilibrium,
      hideXLine: true,
    );

    paintCurve(
      c,
      canvas,
      Offset(0.25, 0.25),
      Offset(0.80, 0.75),
      label2: kDemandForUSD,
      label2Align: LabelAlign.centerBottom,
    );
    paintCurve(
      c,
      canvas,
      Offset(0.25, 0.75),
      Offset(0.80, 0.25),
      label2: kSupplyOfUSD,
      label2Align: LabelAlign.centerTop,
    );
  }
}
