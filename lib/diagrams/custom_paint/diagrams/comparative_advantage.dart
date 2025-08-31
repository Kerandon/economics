import 'package:economics_app/diagrams/custom_paint/painter_methods/legend/paint_legend.dart';
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

    paintAxis(
      c,
      canvas,
      yAxisLabel: DiagramLabel.cheese.label,
      xAxisLabel: DiagramLabel.wineBottles.label,
      yMaxValue: 160,
      yDivisions: 8,
      gridLineStyle: GridLineStyle.indents,
      xMaxValue: 20,
      xDivisions: 5,
    );

    if (diagramBundleEnum ==
        DiagramBundleEnum.globalAbsoluteAdvantageDifferentGoods) {
      paintTitle(c, canvas, 'Wine & Cheese Production');
      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0, 0.25),
        polylineOffsets: [Offset(0.80, 1)],
        color: Colors.deepPurple,
      );
      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0, 0.12),
        polylineOffsets: [Offset(0.60, 1)],
        color: Colors.deepOrange,
      );
      paintLegend(canvas, size, [
        LegendEntry(
          label: 'France',
          color: Colors.deepOrange,
          shape: LegendShape.line,
        ),
        LegendEntry(
          label: 'Spain',
          color: Colors.deepPurple,
          shape: LegendShape.line,
        ),
      ]);
    }
    if (diagramBundleEnum ==
        DiagramBundleEnum.globalAbsoluteAdvantageDifferentGoods) {}
  }
}
