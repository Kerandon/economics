import 'package:flutter/material.dart';

import '../../enums/diagram_labels.dart';
import '../../enums/diagram_subtype.dart';
import '../painter_methods/axis/label_align.dart';
import '../../models/base_painter_painter.dart';
import '../../models/diagram_model.dart';
import '../../models/diagram_painter_config.dart';
import '../painter_methods/axis/paint_axis.dart';
import '../painter_methods/paint_diagram_dash_lines.dart';
import '../painter_methods/diagram_lines/paint_diagram_lines.dart';

class ManagedExchangeRate extends BaseDiagramPainter {
  ManagedExchangeRate({
    required DiagramPainterConfig config,
    required DiagramModel model,
  }) : super(config, model);

  @override
  void paint(Canvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);

    /// Upper band
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.30,
      xAxisEndPos: 1.0,
      hideXLine: true,
      yLabel: DiagramLabel.upperBand.label,
      makeDashed: false,
      color: Colors.red,
    );

    /// Lower band
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.70,
      xAxisEndPos: 1.0,
      hideXLine: true,
      yLabel: DiagramLabel.lowerBand.label,
      makeDashed: false,
      color: Colors.red,
    );

    paintAxis(
      c,
      canvas,
      yAxisLabel: DiagramLabel.exchangeRate.label,
      xAxisLabel: DiagramLabel.quantityOfCurrency.label,
    );

    paintDiagramLines(
      c,
      canvas,
      startPos: Offset(0.15, 0.15),
      polylineOffsets: [Offset(0.85, 0.85)],
      label2: DiagramLabel.d1.label,
      label2Align: LabelAlign.centerRight,
    );
    paintDiagramLines(
      c,
      canvas,
      startPos: Offset(0.85, 0.15),
      polylineOffsets: [Offset(0.15, 0.85)],
      label1: DiagramLabel.s.label,
      label1Align: LabelAlign.centerRight,
    );

    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.50,
      xAxisEndPos: 0.50,
      yLabel: DiagramLabel.ninety.label,
      hideXLine: true,
    );

    if (model.subtype == DiagramSubtype.appreciationIncreaseInDemand) {
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.40,
        xAxisEndPos: 0.60,
        yLabel: DiagramLabel.ninetyFive.label,
        hideXLine: true,
      );
      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0.25, 0.05),
        polylineOffsets: [Offset(0.85, 0.65)],
        label2: DiagramLabel.d2.label,
        label2Align: LabelAlign.centerRight,
      );
    }
  }
}
