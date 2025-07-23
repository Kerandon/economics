import 'dart:math';

import 'package:economics_app/sections/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_axis.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_curve.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_diagram_dash_lines.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_shading.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_text_box.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_title.dart';
import 'package:economics_app/sections/diagrams/enums/diagram_subtype.dart';
import 'package:economics_app/sections/diagrams/enums/label_align.dart';
import 'package:economics_app/sections/diagrams/enums/shade_type.dart';
import 'package:economics_app/sections/diagrams/models/diagram_painter_config.dart';
import 'package:flutter/material.dart';
import '../../models/base_painter_painter.dart';
import '../../models/custom_bezier.dart';
import '../../models/diagram_model.dart';
import '../painter_methods/paint_diagram_custom_lines.dart';

class FixedExchangeRate extends BaseDiagramPainter {
  FixedExchangeRate({
    required DiagramPainterConfig config,
    required DiagramModel model,
  }) : super(config, model);

  @override
  void paint(Canvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);

    paintCustomDiagramLines(
      c,
      canvas,
      startPos: Offset(0.0, 0.50),
      polylineOffsets: [
        Offset(0.50, 0.50),
      ],
      label1: DiagramLabel.ninetyFive.label,
      label1Align: LabelAlign.centerLeft,
    );

    paintAxis(
      c,
      canvas,
      yAxisLabel: DiagramLabel.exchangeRate.label,
      yLabelIsHorizontal: false,
      xAxisLabel: DiagramLabel.quantityOfCurrency.label,
    );

    paintCustomDiagramLines(
      c,
      canvas,
      startPos: Offset(0.15, 0.15),
      polylineOffsets: [
        Offset(0.85, 0.85),
      ],
      label2: DiagramLabel.d1.label,
      label2Align: LabelAlign.centerRight,
    );
    paintCustomDiagramLines(
      c,
      canvas,
      startPos: Offset(0.85, 0.15),
      polylineOffsets: [
        Offset(0.15, 0.85),
      ],
      label1: DiagramLabel.s.label,
      label1Align: LabelAlign.centerRight,
    );

    if(model.subtype == DiagramSubtype.fixedRateIncreaseInDemand){
      paintTitle(c, canvas, 'Fig. 1 Higher Demand For Exports');
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.40,
        xAxisEndPos: 0.60,
        hideXLine: true,
        yLabel: DiagramLabel.oneHundredAndFive.label,
      );

      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(0.30, 0.10),
        polylineOffsets: [
          Offset(0.90, 0.70),
        ],
        label2: DiagramLabel.d2.label,
        label2Align: LabelAlign.centerRight,
      );
      paintShading(canvas, size, ShadeType.surplus,
          [Offset(0.50, 0.50), Offset(0.70, 0.50), Offset(0.60, 0.40)]);
      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(0.65, 0.60),
        polylineOffsets: [
          Offset(0.73, 0.60),
        ],
        arrowOnEnd: true,
        arrowOnEndAngle: pi / 2,
      );
    }
    if(model.subtype == DiagramSubtype.fixedRateSellCurrency){
      paintTitle(c, canvas, 'Fig. 2 Central Bank Sells Domestic Currency');
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.40,
        xAxisEndPos: 0.60,
        hideXLine: true,
        yLabel: DiagramLabel.oneHundredAndFive.label,
      );

      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(0.30, 0.10),
        polylineOffsets: [
          Offset(0.90, 0.70),
        ],
        label2: DiagramLabel.d2.label,
        label2Align: LabelAlign.centerRight,
      );
      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(0.68, 0.60),
        polylineOffsets: [
          Offset(0.76, 0.60),
        ],
        arrowOnStart: true,
        arrowOnStartAngle: pi / -2,
      );
    }

    if (model.subtype == DiagramSubtype.fixedRateDecreaseInDemand) {
      paintTitle(c, canvas, 'Fig. 1 Lower Demand For Exports');
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.60,
        xAxisEndPos: 0.40,
        hideXLine: true,
        yLabel: DiagramLabel.ninety.label,
      );

      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(0.15, 0.35),
        polylineOffsets: [
          Offset(0.70, 0.90),
        ],
        label2: DiagramLabel.d2.label,
        label2Align: LabelAlign.centerRight,
      );
      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(0.58, 0.70),
        polylineOffsets: [
          Offset(0.66, 0.70),
        ],
        arrowOnStart: true,
        arrowOnStartAngle: pi / -2,
      );
      paintShading(canvas, size, ShadeType.surplus,
          [Offset(0.30, 0.50), Offset(0.50, 0.50), Offset(0.40, 0.60)]);
    }
    if (model.subtype == DiagramSubtype.fixedRateRaiseInterestRates) {
      paintTitle(c, canvas, 'Fig. 2 Central Banks Raises Interest Rates');
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.60,
        xAxisEndPos: 0.40,
        hideXLine: true,
        yLabel: DiagramLabel.ninety.label,
      );

      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(0.15, 0.35),
        polylineOffsets: [
          Offset(0.70, 0.90),
        ],
        label2: DiagramLabel.d2.label,
        label2Align: LabelAlign.centerRight,
      );
      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(0.55, 0.70),
        polylineOffsets: [
          Offset(0.63, 0.70),
        ],
        arrowOnEnd: true,
        arrowOnEndAngle: pi / 2,
      );
    }
  }
}
