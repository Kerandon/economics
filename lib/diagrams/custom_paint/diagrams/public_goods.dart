import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/paint_axis.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/diagram_lines/paint_diagram_lines.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_diagram_dash_lines.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_text.dart';
import 'package:economics_app/diagrams/enums/diagram_labels.dart';
import 'package:flutter/material.dart';

import '../../models/base_painter_painter.dart';
import '../i_diagram_canvas.dart';
import '../painter_constants.dart';
import '../painter_methods/legend/legend_display.dart';

class PublicGoods extends BaseDiagramPainter {
  PublicGoods(super.config, super.diagram);

  @override
  void drawDiagram(IDiagramCanvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);

    // 1. Setup specialized Axis for Public Goods (Vertical Summation)
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

    // 2. Individual Marginal Benefit Curves (MB1 and MB2)
    // MB1 (Bottom Curve)
    paintDiagramLines(
      c,
      canvas,

      startPos: const Offset(0, 0.80),
      polylineOffsets: [const Offset(0.70, 1.0)],
    );

    // MB2 (Middle Curve)
    paintDiagramLines(
      c,
      canvas,

      startPos: const Offset(0, 0.60),
      polylineOffsets: [const Offset(0.70, 1.0)],
    );

    // 3. MSB (Vertical Summation: MSB = MB1 + MB2)
    paintDiagramLines(
      c,
      canvas,

      startPos: const Offset(0, 0.40),
      polylineOffsets: [const Offset(0.70, 1.0)],
      color: Colors.red,
    );

    // 4. Marginal Social Cost (MSC) - Horizontal Supply in this context
    paintDiagramLines(
      c,
      canvas,

      startPos: const Offset(0.0, 0.70),
      polylineOffsets: [const Offset(0.80, 0.70)],
      label2: DiagramLabel.msc.label,
      label2Align: LabelAlign.centerTop,
      color: Colors.red,
    );

    // 5. Annotations and Labels
    paintText(
      c,
      canvas,
      'Individual MB1',
      const Offset(0.80, 0.95),
      pointerLine: const Offset(0.52, 0.95),
    );
    paintText(
      c,
      canvas,
      'Individual MB2',
      const Offset(0.80, 0.85),
      pointerLine: const Offset(0.44, 0.85),
    );
    paintText(
      c,
      canvas,
      'MSB = MB1 + MB2',
      const Offset(0.30, 0.45),
      pointerLine: const Offset(0.30, 0.655),
    );

    // 6. Optimal Quantity Projections (Where MSC = MSB)
    // Q_opt intersection
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

    // Projections down to individual MBs at Q_opt
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

  LegendDisplay get legendDisplay => LegendDisplay.shading;
}
