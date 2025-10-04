import 'package:economics_app/diagrams/custom_paint/painter_methods/legend/paint_legend.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_diagram_dash_lines.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_title.dart';
import 'package:economics_app/diagrams/enums/diagram_bundle_enum.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/grid_lines/grid_line_style.dart';
import 'package:flutter/material.dart';
import '../../enums/diagram_labels.dart';
import '../../models/base_painter_painter.dart';
import '../painter_methods/axis/paint_axis.dart';
import '../painter_methods/legend/legend_entry.dart';
import '../painter_methods/legend/legend_shape.dart';
import '../painter_methods/diagram_lines/paint_diagram_lines.dart';

class ComparativeAdvantage extends BaseDiagramPainter2 {
  ComparativeAdvantage(super.config, super.diagramBundleEnum);

  @override
  void paint(Canvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);

    // France (blue from the flag)
    final franceColor = const Color(0xFF0055A4); // deep flag blue

    // Spain (red from the flag)
    final spainColor = const Color(0xFFC60B1E); // strong flag red

    paintAxis(
      c,
      canvas,
      yAxisLabel: DiagramLabel.cheese.label,
      xAxisLabel: DiagramLabel.wineBottles.label,
      yMaxValue: 180,
      yDivisions: 12,
      gridLineStyle: GridLineStyle.indents,
      xMaxValue: 30,
      xDivisions: 10,
    );
    paintLegend(canvas, size, [
      LegendEntry(label: 'Spain', color: spainColor, shape: LegendShape.line),
      LegendEntry(label: 'France', color: franceColor, shape: LegendShape.line),
    ]);
    paintTitle(c, canvas, 'Wine & Cheese Production');
    if (diagramBundleEnum ==
        DiagramBundleEnum.globalAbsoluteAdvantageDifferentGoods) {
      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0, 0.25),
        polylineOffsets: [Offset(0.50, 1)],
        color: franceColor,
      );
      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0, 0.41),
        polylineOffsets: [Offset(0.70, 1)],
        color: spainColor,
      );
    }
    if (diagramBundleEnum ==
            DiagramBundleEnum.globalAbsoluteAdvantageBothGoods ||
        diagramBundleEnum ==
            DiagramBundleEnum.globalComparativeAdvantageTradeAndConsumption) {
      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0, 0.33),
        polylineOffsets: [Offset(0.60, 1)],
        color: franceColor,
      );
      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0, 0.41),
        polylineOffsets: [Offset(0.30, 1)],
        color: spainColor,
      );
    }
    if (diagramBundleEnum ==
            DiagramBundleEnum.globalComparativeAdvantageTradeAndConsumption ||
        diagramBundleEnum ==
            DiagramBundleEnum
                .globalComparativeAdvantageTradeAndConsumptionMixed) {
      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0, 0.17),
        polylineOffsets: [Offset(0.60, 1)],
        color: franceColor,
        curveStyle: CurveStyle.dashed,
      );
      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0, 0.41),
        polylineOffsets: [Offset(0.53, 1)],
        color: spainColor,
        curveStyle: CurveStyle.dashed,
      );

      if (diagramBundleEnum ==
          DiagramBundleEnum
              .globalComparativeAdvantageTradeAndConsumptionMixed) {
        paintDiagramDashedLines(
          c,
          canvas,
          yAxisStartPos: 0.63,
          xAxisEndPos: 0.33,
        );
      }
    }
  }
}
