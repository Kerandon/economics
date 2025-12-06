import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/grid_lines/grid_line_style.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/label_align.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/paint_axis.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/diagram_lines/paint_diagram_lines.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_diagram_dash_lines.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_text_2.dart';
import 'package:economics_app/diagrams/enums/diagram_labels.dart';
import 'package:flutter/material.dart';

import '../../models/base_painter_painter.dart';

class PublicGoods extends BaseDiagramPainter2 {
  PublicGoods(super.config, super.bundle);

  @override
  void paint(Canvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);
    paintAxis(
      c,
      canvas,
      yAxisLabel: DiagramLabel.priceCostsBenefits.label,
      xAxisLabel: DiagramLabel.quantity.label,
      drawGridlines: true,
      yDivisions: 20,
      yMaxValue: 20,
      xDivisions: 20,
      xMaxValue: 20,
      gridLineStyle: GridLineStyle.indents,
    );

    paintDiagramLines(
      c,
      canvas,
      startPos: Offset(0, 0.80),
      polylineOffsets: [Offset(0.70, 1.0)],
    );
    paintDiagramLines(
      c,
      canvas,
      startPos: Offset(0, 0.60),
      polylineOffsets: [Offset(0.70, 1.0)],
    );
    paintDiagramLines(
      c,
      canvas,
      startPos: Offset(0, 0.40),
      polylineOffsets: [Offset(0.70, 1.0)],
      color: Colors.red,
    );
    paintDiagramLines(
      c,
      canvas,
      startPos: Offset(0.0, 0.70),
      polylineOffsets: [Offset(0.80, 0.70)],
      label2: DiagramLabel.msc.label,
      label2Align: LabelAlign.centerTop,
      color: Colors.red,
    );
    paintText2(
      c,
      canvas,
      'Individual MB1',
      Offset(0.80, 0.95),
      pointerLine: Offset(0.52, 0.95),
    );
    paintText2(
      c,
      canvas,
      'Individual MB2',
      Offset(0.80, 0.85),
      pointerLine: Offset(0.44, 0.85),
    );
    paintText2(
      c,
      canvas,
      'MSB = MB1 + MB2',
      Offset(0.30, 0.45),
      pointerLine: Offset(0.30, 0.655),
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.70,
      xAxisEndPos: 0.35,
      showDotAtIntersection: true,
      yLabel: '',
      xLabel: 'Qopt',
      hideYLine: true,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.80,
      xAxisEndPos: 0.35,
      showDotAtIntersection: true,
      hideXLine: true,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.90,
      xAxisEndPos: 0.35,
      showDotAtIntersection: true,
      hideXLine: true,
    );
  }
}
