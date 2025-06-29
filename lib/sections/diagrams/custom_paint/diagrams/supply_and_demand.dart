import 'dart:math';

import 'package:economics_app/sections/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_axis.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_curve_normalized.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_custom_bezier_normalized.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_diagram_dash_lines.dart';
import 'package:economics_app/sections/diagrams/enums/diagram_subtype.dart';
import 'package:economics_app/sections/diagrams/models/custom_bezier.dart';
import 'package:flutter/material.dart';
import '../../enums/label_align.dart';
import '../../models/base_painter_painter.dart';
import '../../models/diagram_model.dart';
import '../../models/diagram_painter_config.dart';
import '../painter_methods/paint_text.dart';
import '../painter_methods/paint_title.dart';

class SupplyAndDemand extends BaseDiagramPainter {
  SupplyAndDemand({
    required DiagramPainterConfig config,
    required DiagramModel model,
  }) : super(config, model);

  @override
  void paint(Canvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);

    // Original equilibrium dashed lines
    if (model.subtype == DiagramSubtype.equilibrium ||
        model.subtype == DiagramSubtype.shortage ||
        model.subtype == DiagramSubtype.surplus) {
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.50,
        xAxisEndPos: 0.50,
        yLabel: MicroLabel.pe.label,
        xLabel: MicroLabel.qe.label,
      );

      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(0.15, 0.15),
        bezierPoints: [
          CustomBezier(
            endPoint: Offset(0.85, 0.85),
          ),
        ],
        label2: MicroLabel.d.label,
        label2Align: LabelAlign.centerRight,
      );
      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(0.85, 0.15),
        bezierPoints: [
          CustomBezier(
            endPoint: Offset(0.15, 0.85),
          ),
        ],
        label1: MicroLabel.s.label,
        label1Align: LabelAlign.centerRight,
      );
    }

    final isDemandShift = model.subtype == DiagramSubtype.increaseInDemand ||
        model.subtype == DiagramSubtype.decreaseInDemand;
    final isSupplyShift = model.subtype == DiagramSubtype.increaseInSupply ||
        model.subtype == DiagramSubtype.decreaseInSupply;

    if (isDemandShift || isSupplyShift) {
      // Base curves

      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(0.15, 0.15),
        bezierPoints: [
          CustomBezier(
            endPoint: Offset(0.85, 0.85),
          ),
        ],
        label2: MicroLabel.d.label,
        label2Align: LabelAlign.centerRight,
      );
      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(0.85, 0.15),
        bezierPoints: [
          CustomBezier(
            endPoint: Offset(0.15, 0.85),
          ),
        ],
        label1: MicroLabel.s.label,
        label1Align: LabelAlign.centerRight,
      );

      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.50,
        xAxisEndPos: 0.50,
        yLabel: MicroLabel.p1.label,
        xLabel: MicroLabel.q1.label,
      );
    }

    if (model.subtype == DiagramSubtype.decreaseInDemand) {
      paintCurveNormalized(c, canvas, Offset(0.10, 0.30), Offset(0.70, 0.90),
          label2: MicroLabel.d1.label, label2Align: LabelAlign.centerRight);
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.60,
        xAxisEndPos: 0.40,
        yLabel: MicroLabel.p2.label,
        xLabel: MicroLabel.q2.label,
      );
    }

    if (model.subtype == DiagramSubtype.increaseInDemand) {
      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(0.30, 0.10),
        bezierPoints: [
          CustomBezier(
            endPoint: Offset(0.90, 0.70),
          ),
        ],
        label2: MicroLabel.d1.label,
        label2Align: LabelAlign.centerRight,
      );

      paintDiagramDashedLines(
        c,
        canvas,
        xAxisEndPos: 0.60,
        yAxisStartPos: 0.40,
        yLabel: MicroLabel.p2.label,
        xLabel: MicroLabel.q2.label,
      );
    }

    if (model.subtype == DiagramSubtype.increaseInSupply) {
      paintCurveNormalized(c, canvas, Offset(0.30, 0.90), Offset(0.90, 0.30),
          label2: MicroLabel.s1.label, label2Align: LabelAlign.centerRight);
      paintDiagramDashedLines(
        c,
        canvas,
        xAxisEndPos: 0.60,
        yAxisStartPos: 0.60,
        yLabel: MicroLabel.p2.label,
        xLabel: MicroLabel.q2.label,
      );
    }

    if (model.subtype == DiagramSubtype.decreaseInSupply) {
      paintCurveNormalized(c, canvas, Offset(0.05, 0.75), Offset(0.70, 0.10),
          label2: MicroLabel.s1.label, label2Align: LabelAlign.centerRight);
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.40,
        xAxisEndPos: 0.40,
        yLabel: MicroLabel.p2.label,
        xLabel: MicroLabel.q2.label,
      );
    }
    if (model.subtype == DiagramSubtype.shortage) {
      paintDiagramDashedLines(
        c,
        canvas,
        xAxisEndPos: 0.30,
        yAxisStartPos: 0.70,
        yLabel: MicroLabel.pm.label,
        xLabel: MicroLabel.qD.label,
      );
      paintDiagramDashedLines(
        c,
        canvas,
        xAxisEndPos: 0.70,
        yAxisStartPos: 0.70,
        xLabel: MicroLabel.qS.label,
      );
      paintCustomDiagramLines(
        color: c.colorScheme.onSurface,
        strokeWidth: kCurveWidthSlim,
        c,
        canvas,
        startPos: Offset(0.30, 1.10),
        bezierPoints: [
          CustomBezier(endPoint: Offset(0.30, 1.14)),
          CustomBezier(endPoint: Offset(0.70, 1.14)),
          CustomBezier(endPoint: Offset(0.70, 1.10)),
        ],
        arrowOnEnd: true,
        arrowOnStart: true,
        arrowOnStartAngle: pi / 0.50,
        arrowOnEndAngle: pi / 0.50,
      );
      paintText(c, canvas, MicroLabel.shortage.label, Offset(0.53, 0.98));
      paintCustomDiagramLines(
        circleAtStart: true,
        circleAtEnd: true,
        color: Colors.red,
        c,
        canvas,
        startPos: Offset(0.30, 0.70),
        bezierPoints: [
          CustomBezier(
            endPoint: Offset(0.70, 0.70),
          ),
        ],
      );
    }

    if (model.subtype == DiagramSubtype.surplus) {
      paintDiagramDashedLines(
        c,
        canvas,
        xAxisEndPos: 0.30,
        yAxisStartPos: 0.30,
        yLabel: MicroLabel.pm.label,
        xLabel: MicroLabel.qD.label,
      );
      paintDiagramDashedLines(
        c,
        canvas,
        xAxisEndPos: 0.70,
        yAxisStartPos: 0.30,
        xLabel: MicroLabel.qS.label,
      );
      paintCustomDiagramLines(
          strokeWidth: kCurveWidthSlim,
          color: c.colorScheme.onSurface,
          c,
          canvas,
          startPos: Offset(0.30, 0.25),
          bezierPoints: [
            CustomBezier(endPoint: Offset(0.30, 0.20)),
            CustomBezier(endPoint: Offset(0.70, 0.20)),
            CustomBezier(endPoint: Offset(0.70, 0.25)),
          ],
          arrowOnEnd: true,
          arrowOnStart: true,
          arrowOnStartAngle: pi,
          arrowOnEndAngle: pi);
      paintText(c, canvas, 'surplus', Offset(0.53, 0.20));
      paintCustomDiagramLines(
        circleAtStart: true,
        circleAtEnd: true,
        color: Colors.red,
        c,
        canvas,
        startPos: Offset(0.30, 0.30),
        bezierPoints: [
          CustomBezier(
            endPoint: Offset(0.70, 0.30),
          ),
        ],
      );
    }

    /// Perfect competition market supply and demand
    if (model.subtype == DiagramSubtype.perfectCompetitionNormalProfit ||
        model.subtype == DiagramSubtype.perfectCompetitionAbnormalProfit ||
        model.subtype == DiagramSubtype.perfectCompetitionLoss) {
      paintTitle(c, canvas, 'Industry');
      paintDiagramDashedLines(
        c,
        canvas,
        xAxisEndPos: 1.15,
        yAxisStartPos: 0.50,
        yLabel: kPm,
        hideXLine: true,
        xLabel: MicroLabel.q2.label,
      );
      paintAxis(
        c,
        canvas,
        yAxisLabel: MicroLabel.priceCostsRevenue.label,
        yLabelIsHorizontal: false,
        xAxisLabel: MicroLabel.industryQuantity.label,
      );
      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(0.85, 0.15),
        bezierPoints: [
          CustomBezier(
            endPoint: Offset(0.15, 0.85),
          ),
        ],
        label1: MicroLabel.sm.label,
        label1Align: LabelAlign.centerRight,
      );
      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(0.15, 0.15),
        bezierPoints: [
          CustomBezier(
            endPoint: Offset(0.85, 0.85),
          ),
        ],
        label2: MicroLabel.dm.label,
        label2Align: LabelAlign.centerRight,
      );
    }
    if (model.subtype == DiagramSubtype.perfectCompetitionAbnormalProfit) {
      paintDiagramDashedLines(
        c,
        canvas,
        xAxisEndPos: 1.15,
        yAxisStartPos: 0.40,
        yLabel: MicroLabel.pm1.label,
        hideXLine: true,
        xLabel: MicroLabel.q2.label,
      );
      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(0.90, 0.30),
        bezierPoints: [
          CustomBezier(
            endPoint: Offset(0.30, 0.90),
          ),
        ],
        label1: MicroLabel.sm1.label,
        label1Align: LabelAlign.centerRight,
      );
      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(
          0.25,
          0.05,
        ),
        bezierPoints: [
          CustomBezier(
            endPoint: Offset(0.85, 0.65),
          ),
        ],
        label2: MicroLabel.dm1.label,
        label2Align: LabelAlign.centerRight,
      );

      /// Arrows

      paintText(c, canvas, '2', Offset(0.46, 0.59));
      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(
          0.33,
          0.70,
        ),
        bezierPoints: [
          CustomBezier(
            endPoint: Offset(0.43, 0.70),
          ),
        ],
        arrowOnEnd: true,
        arrowOnEndAngle: pi / 2,
        color: c.colorScheme.onSurface,
      );
      paintText(c, canvas, '1', Offset(0.72, 0.55));
      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(
          0.68,
          0.65,
        ),
        bezierPoints: [
          CustomBezier(
            endPoint: Offset(0.78, 0.65),
          ),
        ],
        arrowOnEnd: true,
        arrowOnEndAngle: pi / 2,
        color: c.colorScheme.onSurface,
      );
    }
    if (model.subtype == DiagramSubtype.perfectCompetitionLoss){
      paintDiagramDashedLines(
        c,
        canvas,
        xAxisEndPos: 1.15,
        yAxisStartPos: 0.60,
        yLabel: MicroLabel.pm1.label,
        hideXLine: true,
        xLabel: MicroLabel.q2.label,
      );
      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(0.15, 0.35),
        straightEndPos: Offset(0.70,0.90),
        label2: MicroLabel.dm1.label,
        label2Align: LabelAlign.centerRight,
      );

    }
  }
}
