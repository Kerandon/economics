import 'dart:math';
import 'dart:ui';

import 'package:economics_app/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/axis_enum.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/paint_axis.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/diagram_lines/paint_diagram_lines.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_line_segment_MAKEREDUNDANT.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_text.dart';
import 'package:economics_app/diagrams/enums/diagram_labels.dart';
import 'package:economics_app/diagrams/models/custom_bezier.dart';

import '../../enums/diagram_enum.dart';
import '../../models/base_painter_painter.dart';
import '../i_diagram_canvas.dart';

class LorenzCurveDiagram extends BaseDiagramPainter {
  LorenzCurveDiagram(super.config, super.diagram);

  @override
  void drawDiagram(IDiagramCanvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);
    paintAxis(
      c,
      canvas,
      yAxisLabel: DiagramLabel.cumulativePercentageOfIncome.label,
      xAxisLabel: DiagramLabel.cumulativePercentageOfPopulation.label,
      drawGridlines: true,
      xDivisions: 5,
      yDivisions: 5,
      xMaxValue: 100,
      yMaxValue: 100,
      gridLineStyle: GridLineStyle.indents,
    );
    paintDiagramLines(
      c,
      canvas,
      startPos: Offset(0, 1),
      polylineOffsets: [Offset(1, 0)],
    );
    paintDiagramLines(
      c,
      canvas,
      startPos: Offset(0, 1),
      bezierPoints: [
        CustomBezier(control: Offset(1.0, 0.90), endPoint: Offset(1, 0)),
      ],
    );
    if (diagram == DiagramEnum.macroLorenzCurveCalculation) {
      paintText(c, canvas, 'A', Offset(0.60, 0.60));
      paintText(c, canvas, 'B', Offset(0.80, 0.80));
      paintText(c, canvas, 'Gini Coefficient = A / (A + B)', Offset(0.50, 1.3));
    }
    if (diagram == DiagramEnum.macroLorenzCurveImprovedEquality) {
      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0, 1),
        bezierPoints: [
          CustomBezier(control: Offset(0.95, 0.50), endPoint: Offset(1, 0)),
        ],
      );
      paintLineSegment(c, canvas, origin: Offset(0.65, 0.68), angle: pi * 1.2);
    }
  }
}
