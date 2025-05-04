import 'package:economics_app/sections/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_axis.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_curve.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_diagram_dash_lines.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_text_box.dart';
import 'package:economics_app/sections/diagrams/enums/label_align.dart';
import 'package:economics_app/sections/diagrams/models/diagram_painter_config.dart';
import 'package:flutter/material.dart';
import '../../models/base_painter_painter.dart';
import '../../models/diagram_model.dart';

class FixedExchangeRate extends BaseDiagramPainter {
  FixedExchangeRate({
    required DiagramPainterConfig config,
    required DiagramModel model,
  }) : super(config, model);

  @override
  void paint(Canvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);

    paintAxis(c, canvas,
        yAxisLabel: kExchangeRate, xAxisLabel: kQuantityOfDomesticCurrency);

    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.50,
      xAxisEndPos: 0.29,
      yLabel: kExchangeRateEquilibrium1,
      hideXLine: true,
    );

    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.59,
      xAxisEndPos: 0.36,
      yLabel: kExchangeRateEquilibrium2,
      hideXLine: true,
    );

    /// Demand #1
    paintCurve(
      c,
      canvas,
      Offset(0.22, 0.28),
      Offset(0.70, 0.78),
      label2: kD1,
      label2Align: LabelAlign.centerRight,
    );

    /// Demand #2
    paintCurve(
      c,
      canvas,
      Offset(0.30, 0.17),
      Offset(0.75, 0.65),
      label2: kD2,
      label2Align: LabelAlign.centerRight,
    );

    /// Supply #1
    paintCurve(
      c,
      canvas,
      Offset(0.22, 0.70),
      Offset(0.75, 0.20),
      label2: kS1,
      label2Align: LabelAlign.centerRight,
    );

    /// Supply #2
    paintCurve(
      c,
      canvas,
      Offset(0.35, 0.75),
      Offset(0.80, 0.32),
      label2: kS2,
      label2Align: LabelAlign.centerRight,
    );

    paintCurve(c, canvas, Offset(0.63, 0.35), Offset(0.72, 0.35),
        arrowAtEnd: true, color: c.colorScheme.onSurface);

    paintCurve(c, canvas, Offset(0.61, 0.65), Offset(0.70, 0.65),
        arrowAtEnd: true, color: c.colorScheme.onSurface);

    paintTextBox(
      canvas: canvas,
      config: c,
      text:
          '1. Increase in supply of domestic currency on forex market\ndue to more spending on imports',
      position: Offset(0.55, 0.10),
      fontSize: 8,
      linePoint: Offset(0.65, 0.35),
    );

    paintTextBox(
      canvas: canvas,
      config: c,
      text:
          '2. Central bank uses official reserves\nto buy domestic currency thus increasing demand',
      position: Offset(0.35, 0.92),
      fontSize: 8,
      linePoint: Offset(0.65, 0.65),
    );
  }
}
