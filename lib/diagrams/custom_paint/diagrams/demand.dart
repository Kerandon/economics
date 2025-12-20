import 'dart:math';

import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/grid_lines/grid_line_style.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/legend/legend_display.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_dot.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_line_segment.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_title.dart';
import 'package:economics_app/diagrams/enums/diagram_enum.dart';
import 'package:flutter/material.dart';
import '../../enums/diagram_labels.dart';
import '../painter_methods/axis/label_align.dart';
import '../../models/base_painter_painter.dart';
import '../painter_methods/axis/paint_axis.dart';
import '../painter_methods/paint_arrow_helper.dart';
import '../painter_methods/paint_diagram_dash_lines.dart';
import '../painter_methods/diagram_lines/paint_diagram_lines.dart';
import '../painter_methods/shortcut_methods/paint_market_curve.dart';

class Demand extends BaseDiagramPainter3 {
  Demand(super.config, super.diagram);

  @override
  void paint(Canvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);
    if (diagram == DiagramEnum.microDemandApples) {
      paintAxis(c, canvas);
    }
  }
}

// class Demand extends BaseDiagramPainter2 {
//   Demand(super.config, super.bundle);
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final c = config.copyWith(painterSize: size);
//     if(bundle == DiagramEnum.microDemandApples){
//       paintAxis(
//         c,
//         canvas,
//         yAxisLabel: DiagramLabel.price$.label,
//         xAxisLabel: 'Quantity of Apples',
//         yMaxValue: 6,
//         yDivisions: 6,
//         xMaxValue:12,
//         xDivisions: 6,
//         gridLineStyle: GridLineStyle.dashes
//       );
//       paintDiagramLines(c, canvas, startPos: Offset(0,0.16), polylineOffsets: [Offset(0.84,1)], label2: DiagramLabel.demand.label,
//       label2Align: LabelAlign.centerTop,
//       );
//       paintDot(c, canvas, pos: Offset(0.0,0.16));
//       paintDot(c, canvas, pos: Offset(0.17,0.33));
//       paintDot(c, canvas, pos: Offset(0.33,0.495));
//       paintDot(c, canvas, pos: Offset(0.50,0.66));
//       paintDot(c, canvas, pos: Offset(0.67,0.83));
//       paintDot(c, canvas, pos: Offset(0.835,1.0));
//     }else {
//       paintAxis(
//         c,
//         canvas,
//         yAxisLabel: DiagramLabel.price.label,
//         xAxisLabel: DiagramLabel.quantity.label,
//       );
//     }
//
//
//     if (bundle == DiagramEnum.microDemandExtension ||
//         bundle == DiagramEnum.microDemandContraction) {
//       paintMarketCurve(c, canvas, type: MarketCurveType.demand);
//
//       paintDiagramDashedLines(
//         c,
//         canvas,
//         yAxisStartPos: 0.40,
//         xAxisEndPos: 0.40,
//         yLabel: DiagramLabel.p1.label,
//         xLabel: DiagramLabel.q1.label,
//         showDotAtIntersection: true,
//       );
//       paintDiagramDashedLines(
//         c,
//         canvas,
//         yAxisStartPos: 0.60,
//         xAxisEndPos: 0.60,
//         yLabel: DiagramLabel.p2.label,
//         xLabel: DiagramLabel.q2.label,
//         showDotAtIntersection: true,
//       );
//       if (bundle == DiagramEnum.microDemandExtension) {
//         paintLineSegment(
//           c,
//           canvas,
//           origin: Offset(0.52, 0.46),
//           angle: pi / 4,
//           length: 0.20,
//         );
//       }
//       if (bundle == DiagramEnum.microDemandContraction) {
//         paintLineSegment(
//           c,
//           canvas,
//           origin: Offset(0.53, 0.47),
//           angle: pi * 3.25,
//           length: 0.20,
//         );
//       }
//     }
//     if (bundle == DiagramEnum.microDemandIncrease) {
//       paintMarketCurve(
//         c,
//         canvas,
//         type: MarketCurveType.demand,
//         label: DiagramLabel.d1.label,
//       );
//       paintMarketCurve(
//         c,
//         canvas,
//         type: MarketCurveType.demand,
//         label: DiagramLabel.d2.label,
//         horizontalShift: 0.10,
//         verticalShift: -0.10,
//         lengthAdjustment: -0.05,
//       );
//       paintDiagramDashedLines(
//         c,
//         canvas,
//         yAxisStartPos: 0.50,
//         xAxisEndPos: 0.50,
//         yLabel: DiagramLabel.p.label,
//         xLabel: DiagramLabel.q1.label,
//         hideYLine: true,
//         showDotAtIntersection: true,
//       );
//       paintDiagramDashedLines(
//         c,
//         canvas,
//         yAxisStartPos: 0.50,
//         xAxisEndPos: 0.70,
//         yLabel: DiagramLabel.p.label,
//         xLabel: DiagramLabel.q2.label,
//         showDotAtIntersection: true,
//       );
//
//       paintLineSegment(c, canvas, origin: Offset(0.49, 0.40), angle: pi * 2);
//     }
//
//     if (bundle == DiagramEnum.microDemandDecrease) {
//       paintMarketCurve(
//         c,
//         canvas,
//         type: MarketCurveType.demand,
//         label: DiagramLabel.d2.label,
//       );
//       paintMarketCurve(
//         c,
//         canvas,
//         type: MarketCurveType.demand,
//         label: DiagramLabel.d1.label,
//         horizontalShift: 0.10,
//         lengthAdjustment: -0.10,
//         verticalShift: -0.10,
//       );
//       paintDiagramDashedLines(
//         c,
//         canvas,
//         yAxisStartPos: 0.50,
//         xAxisEndPos: 0.50,
//         yLabel: DiagramLabel.p.label,
//         xLabel: DiagramLabel.q2.label,
//         hideYLine: true,
//         showDotAtIntersection: true,
//       );
//       paintDiagramDashedLines(
//         c,
//         canvas,
//         yAxisStartPos: 0.50,
//         xAxisEndPos: 0.70,
//         yLabel: DiagramLabel.p.label,
//         xLabel: DiagramLabel.q1.label,
//         showDotAtIntersection: true,
//       );
//
//       paintLineSegment(c, canvas, origin: Offset(0.51, 0.40), angle: pi / 1);
//     }
//   }
//
// }
