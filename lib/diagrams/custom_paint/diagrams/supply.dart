import 'dart:math';
import 'dart:ui';

import 'package:economics_app/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/grid_lines/grid_line_style.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/legend/legend_entry.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/legend/legend_shape.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/legend/paint_legend.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_dot.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_text.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_text_normalized_within_axis.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_title.dart';
import 'package:economics_app/diagrams/models/custom_bezier.dart';
import '../../enums/diagram_bundle_enum.dart';
import '../../enums/diagram_labels.dart';
import '../../enums/diagram_subtype.dart';
import '../painter_methods/axis/label_align.dart';
import '../../models/base_painter_painter.dart';
import '../../models/diagram_model.dart';
import '../../models/diagram_painter_config.dart';
import '../painter_methods/axis/paint_axis.dart';
import '../painter_methods/paint_arrow_helper.dart';
import '../painter_methods/paint_diagram_dash_lines.dart';
import '../painter_methods/diagram_lines/paint_diagram_lines.dart';

import 'dart:math';
import 'package:flutter/material.dart';

import '../painter_methods/shortcut_methods/paint_demand.dart';

class Supply extends BaseDiagramPainter2 {
  Supply(super.config, super.diagramBundleEnum);

  @override
  void paint(Canvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);

    // Supply extension/contraction (movement along the curve)
    if (diagramBundleEnum == DiagramBundleEnum.microSupplyExtension ||
        diagramBundleEnum == DiagramBundleEnum.microSupplyContraction) {
      paintMarketCurve(c, canvas, type: MarketCurveType.supply);
      paintAxis(
        c,
        canvas,
        yAxisLabel: DiagramLabel.price$.label,
        xAxisLabel: DiagramLabel.quantityOfChocolateBars.label,
      );
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.40,
        xAxisEndPos: 0.60,
        yLabel: '\$12',
        xLabel: '24',
      );
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.60,
        xAxisEndPos: 0.40,
        yLabel: '\$8',
        xLabel: '16',
      );
      if (diagramBundleEnum == DiagramBundleEnum.microSupplyExtension) {
        paintArrowHelper(c, canvas, origin: Offset(0.40, 0.50), angle: -pi / 4);
      }
      if (diagramBundleEnum == DiagramBundleEnum.microSupplyContraction) {
        paintArrowHelper(
          c,
          canvas,
          origin: Offset(0.40, 0.50),
          angle: pi * 2.75,
        );
      }
    }

    // Supply increase (rightward shift)
    if (diagramBundleEnum == DiagramBundleEnum.microSupplyIncrease) {
      paintAxis(
        c,
        canvas,
        yAxisLabel: DiagramLabel.p.label,
        xAxisLabel: DiagramLabel.q.label,
      );

      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.50,
        xAxisEndPos: 0.50,
        yLabel: DiagramLabel.p.label,
        xLabel: DiagramLabel.q1.label,
        hideYLine: true,
      );
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.50,
        xAxisEndPos: 0.70,
        yLabel: DiagramLabel.p.label,
        xLabel: DiagramLabel.q2.label,
      );
      paintMarketCurve(
        c,
        canvas,
        type: MarketCurveType.supply,
        label: DiagramLabel.s1.label,
      );
      paintMarketCurve(
        c,
        canvas,
        type: MarketCurveType.supply,
        label: DiagramLabel.s2.label,
        horizontalShift: 0.20,
      );
      paintArrowHelper(c, canvas, origin: Offset(0.69, 0.40), angle: pi * 2);
    }

    // Supply decrease (leftward shift)
    if (diagramBundleEnum == DiagramBundleEnum.microSupplyDecrease) {
      paintAxis(
        c,
        canvas,
        yAxisLabel: DiagramLabel.p.label,
        xAxisLabel: DiagramLabel.q.label,
      );
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.50,
        xAxisEndPos: 0.40,
        yLabel: DiagramLabel.p.label,
        xLabel: DiagramLabel.q2.label,
        hideYLine: true,
      );
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.50,
        xAxisEndPos: 0.60,
        yLabel: DiagramLabel.p.label,
        xLabel: DiagramLabel.q1.label,
      );
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
      paintArrowHelper(c, canvas, origin: Offset(0.60, 0.40), angle: pi / 1);
    }
    if (diagramBundleEnum == DiagramBundleEnum.microMarginalProduct ||
        diagramBundleEnum == DiagramBundleEnum.microTotalAndMarginalProduct) {
      final labelSize = kFontSize / 1.8;
      final labelYPos = 0.05;
      paintAxis(
        c,
        canvas,
        xAxisLabel: DiagramLabel.input.label,

        yAxisLabel: DiagramLabel.product.label,
      );

      if (diagramBundleEnum == DiagramBundleEnum.microTotalAndMarginalProduct) {
        paintDiagramLines(
          c,
          canvas,
          startPos: Offset(0, 1.0),
          bezierPoints: [
            CustomBezier(
              endPoint: Offset(0.76, 0.19),
              control: Offset(0.21, 0.15),
            ),
            CustomBezier(
              endPoint: Offset(0.83, 0.27),
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

        paintTextNormalizedWithinAxis(
          c,
          canvas,
          DiagramLabel.increasingReturns.label,
          Offset(0.28, labelYPos),
          fontSize: labelSize,
        );
        paintTextNormalizedWithinAxis(
          c,
          canvas,
          DiagramLabel.diminishingReturns.label,
          Offset(0.60, labelYPos),
          fontSize: labelSize,
        );
        paintTextNormalizedWithinAxis(
          c,
          canvas,
          DiagramLabel.negativeReturns.label,
          Offset(0.90, labelYPos),
          fontSize: labelSize,
        );
      }
      if (diagramBundleEnum == DiagramBundleEnum.microMarginalProduct) {
        paintDiagramLines(
          c,
          canvas,
          startPos: Offset(0.05, 0.95),
          bezierPoints: [
            CustomBezier(
              endPoint: Offset(0.80, 0.60),
              control: Offset(0.38, -0.5),
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
        paintTextNormalizedWithinAxis(
          c,
          canvas,
          DiagramLabel.increasingReturns.label,
          Offset(0.30, labelYPos),
          fontSize: labelSize,
        );
        paintTextNormalizedWithinAxis(
          c,
          canvas,
          DiagramLabel.diminishingReturns.label,
          Offset(0.80, labelYPos),
          fontSize: labelSize,
        );
        paintLegend(canvas, size, [
          LegendEntry(
            label: DiagramLabel.diminishingReturnsSetIn.label,
            color: Colors.red,
            shape: LegendShape.circle,
          ),
        ]);
        paintDot(c, canvas, pos: Offset(0.52, 0.11), color: Colors.red);
      }
    }
    if (diagramBundleEnum == DiagramBundleEnum.microMarginalCost) {
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
        label2: DiagramLabel.marginalProduct.label,
        label2Align: LabelAlign.centerTop,
      );
    }
  }
}
