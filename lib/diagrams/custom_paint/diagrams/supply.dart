import 'dart:math';
import 'package:economics_app/diagrams/custom_paint/painter_methods/legend/legend_entry.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/legend/legend_shape.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/legend/paint_legend.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_dot.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_line_segment.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_text_2.dart';
import 'package:economics_app/diagrams/models/custom_bezier.dart';
import '../../enums/diagram_bundle_enum.dart';
import '../../enums/diagram_labels.dart';
import '../painter_methods/axis/label_align.dart';
import '../../models/base_painter_painter.dart';
import '../painter_methods/axis/paint_axis.dart';
import '../painter_methods/paint_diagram_dash_lines.dart';
import '../painter_methods/diagram_lines/paint_diagram_lines.dart';
import 'package:flutter/material.dart';
import '../painter_methods/shortcut_methods/paint_market_curve.dart';

class Supply extends BaseDiagramPainter2 {
  Supply(super.config, super.bundle);

  @override
  void paint(Canvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);


    String yLabel = DiagramLabel.price.label;
    String xLabel = DiagramLabel.quantity.label;
    if(bundle == DiagramBundleEnum.microMarginalProduct || bundle== DiagramBundleEnum.microTotalAndMarginalProduct){
      yLabel = DiagramLabel.product.label;
      xLabel = DiagramLabel.input.label;
    }
    if(bundle == DiagramBundleEnum.microMarginalCost || bundle == DiagramBundleEnum.microMarginalCostSupplyCurve){
      yLabel = DiagramLabel.costs.label;
      xLabel = DiagramLabel.quantity.label;
    }

    paintAxis(
      c,
      canvas,
      yAxisLabel: yLabel,
      xAxisLabel: xLabel,
    );
    // Supply extension/contraction (movement along the curve)
    if (bundle == DiagramBundleEnum.microSupplyExtension ||
        bundle == DiagramBundleEnum.microSupplyContraction) {
      paintMarketCurve(c, canvas, type: MarketCurveType.supply);

      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.40,
        xAxisEndPos: 0.60,
        yLabel: DiagramLabel.p2.label,
        xLabel: DiagramLabel.q2.label,
        addDotAtIntersection: true,
      );
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.60,
        xAxisEndPos: 0.40,
        yLabel: DiagramLabel.p1.label,
        xLabel: DiagramLabel.q1.label,
        addDotAtIntersection: true,
      );
      if (bundle == DiagramBundleEnum.microSupplyExtension) {
        paintLineSegment(c, canvas, origin: Offset(0.42, 0.51), angle: -pi / 4, length: 0.15);
      }
      if (bundle == DiagramBundleEnum.microSupplyContraction) {
        paintLineSegment(c, canvas, origin: Offset(0.44, 0.48), angle: pi / 1.35, length: 0.15);
      }
    }

    // Supply increase (rightward shift)
    if (bundle == DiagramBundleEnum.microSupplyIncrease) {


      paintMarketCurve(
        c,
        canvas,
        type: MarketCurveType.supply,
        label: DiagramLabel.s1.label, horizontalShift: -0.10
      );
      paintMarketCurve(
        c,
        canvas,
        type: MarketCurveType.supply,
        label: DiagramLabel.s2.label,
        horizontalShift: 0.10,
      );
      paintLineSegment(c, canvas, origin: Offset(0.58, 0.40), angle: pi * 2);
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.50,
        xAxisEndPos: 0.40,
        yLabel: DiagramLabel.p.label,
        xLabel: DiagramLabel.q1.label,
        hideYLine: true,
        addDotAtIntersection: true,
      );
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.50,
        xAxisEndPos: 0.60,
        yLabel: DiagramLabel.p.label,
        xLabel: DiagramLabel.q2.label,
        addDotAtIntersection: true,
      );
    }

    // Supply decrease (leftward shift)
    if (bundle == DiagramBundleEnum.microSupplyDecrease) {

      paintMarketCurve(
        c,
        canvas,
        type: MarketCurveType.supply,
        label: DiagramLabel.s1.label,
        horizontalShift: 0.10,
      );
      paintMarketCurve(
        c,
        canvas,
        type: MarketCurveType.supply,
        label: DiagramLabel.s2.label,
        horizontalShift: -0.10,
      );
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.50,
        xAxisEndPos: 0.40,
        yLabel: DiagramLabel.p.label,
        xLabel: DiagramLabel.q2.label,
        hideYLine: true,
        addDotAtIntersection: true,
      );
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.50,
        xAxisEndPos: 0.60,
        yLabel: DiagramLabel.p.label,
        xLabel: DiagramLabel.q1.label,
        addDotAtIntersection: true,
      );
      paintLineSegment(c, canvas, origin: Offset(0.61, 0.40), angle: pi / 1);
    }
    if (bundle == DiagramBundleEnum.microMarginalProduct ||
        bundle == DiagramBundleEnum.microTotalAndMarginalProduct) {
      final labelYPos = 0.05;

      if (bundle == DiagramBundleEnum.microTotalAndMarginalProduct) {
        paintDiagramLines(
          c,
          canvas,
          startPos: Offset(0, 1.0),
          bezierPoints: [
            CustomBezier(
              endPoint: Offset(0.73, 0.19),
              control: Offset(0.21, 0.15),
            ),
            CustomBezier(
              endPoint: Offset(0.83, 0.23),
              control: Offset(0.78, 0.19),
            ),
          ],
        );
        paintDiagramLines(
          c,
          canvas,
          startPos: Offset(0.02, 0.98),
          bezierPoints: [
            CustomBezier(
              endPoint: Offset(0.80, 1.06),
              control: Offset(0.28, 0.35),
            ),
          ],
          color: Colors.deepOrange,
        );
        paintDiagramDashedLines(
          c,
          canvas,
          yAxisStartPos: 0,
          xAxisEndPos: 0.32,
          hideYLine: true,
        );
        paintDiagramDashedLines(
          c,
          canvas,
          yAxisStartPos: 0,
          xAxisEndPos: 0.76,
          hideYLine: true,
        );
        paintLegend(canvas, size, [
          LegendEntry(
            label: DiagramLabel.marginalProduct.label,
            color: Colors.deepOrange,
          ),
          LegendEntry(
            label: DiagramLabel.totalProduct.label,
            color: c.colorScheme.primary,
          ),
        ]);

        paintText2(
          c,
          canvas,
          'Increasing\nReturns',
          Offset(0.15, labelYPos),
        );
        paintText2(
          c,
          canvas,
          'Diminishing\nReturns',
          Offset(0.52, labelYPos),
        );
        paintText2(
          c,
          canvas,
          'Negative\nReturns',
          Offset(0.90, labelYPos),
        );
        paintDot(c, canvas, pos: Offset(0.32, 0.34), color: Colors.black);
        paintDot(c, canvas, pos: Offset(0.32, 0.685), color: Colors.black);
        paintDot(c, canvas, pos: Offset(0.76, 0.195), color: Colors.black);
        paintDot(c, canvas, pos: Offset(0.76, 1.0), color: Colors.black);
      }
      if (bundle == DiagramBundleEnum.microMarginalProduct) {
        paintDiagramLines(
          c,
          canvas,
          startPos: Offset(0.05, 0.95),
          bezierPoints: [
            CustomBezier(
              endPoint: Offset(0.75, 0.50),
              control: Offset(0.37, -0.43),
            ),
          ],
          label2: DiagramLabel.marginalProduct.label,
        );

        paintDiagramDashedLines(
          c,
          canvas,
          yAxisStartPos: 0,
          xAxisEndPos: 0.45,
          hideYLine: true,
        );
        paintText2(
          c,
          canvas,
          DiagramLabel.increasingReturns.label,
          Offset(0.22, labelYPos),
        );
        paintText2(
          c,
          canvas,
          DiagramLabel.diminishingReturns.label,
          Offset(0.68, labelYPos),
        );
        paintLegend(canvas, size, [
          LegendEntry(
            label: DiagramLabel.diminishingReturnsSetIn.label,
            color: Colors.black,
            shape: LegendShape.circle,
          ),
        ]);
        paintDot(c, canvas, pos: Offset(0.45, 0.125), color: Colors.black);
      }
    }
    if (bundle == DiagramBundleEnum.microMarginalCost) {
      paintAxis(
        c,
        canvas,
        yAxisLabel: DiagramLabel.costs.label,
        xAxisLabel: DiagramLabel.quantity.label,
      );

      paintDiagramLines(
        c,
        canvas,
        startPos: const Offset(0.05, 0.60),
        bezierPoints: [
          CustomBezier(
            endPoint: const Offset(0.90, 0.10),
            control: const Offset(0.50, 1.3),
          ),
        ],
        label2: DiagramLabel.marginalCost.label,
        label2Align: LabelAlign.centerTop,
      );
      paintDiagramDashedLines(c, canvas, yAxisStartPos: 0, xAxisEndPos: 0.385, hideYLine: true,
      xLabel: 'Diminishing\nReturns\nSets In'
      );
      paintDot(c, canvas, pos: Offset(0.385, 0.855), color: Colors.black);
    }
  }
}
