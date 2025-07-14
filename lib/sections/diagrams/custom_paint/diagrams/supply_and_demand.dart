import 'dart:math';
import 'package:economics_app/sections/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_axis.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_diagram_dash_lines.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_shading.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_text_normalized_within_axis.dart';
import 'package:economics_app/sections/diagrams/enums/diagram_subtype.dart';
import 'package:economics_app/sections/diagrams/enums/shade_type.dart';
import 'package:economics_app/sections/diagrams/models/custom_bezier.dart';
import 'package:flutter/material.dart';
import '../../enums/label_align.dart';
import '../../models/base_painter_painter.dart';
import '../../models/diagram_model.dart';
import '../../models/diagram_painter_config.dart';
import '../painter_methods/paint_diagram_custom_lines.dart';
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

    paintAxis(
      c,
      canvas,
      yAxisLabel: MicroLabel.p.label,
      xAxisLabel: MicroLabel.q.label,
    );

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
      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(0.10, 0.30),
        straightEndPos: Offset(0.70, 0.90),
        label2: MicroLabel.d2.label,
        label2Align: LabelAlign.centerRight,
      );

      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.60,
        xAxisEndPos: 0.40,
        yLabel: MicroLabel.p2.label,
        xLabel: MicroLabel.q2.label,
      );

      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(0.68, 0.80),
        straightEndPos: Offset(0.76, 0.80),
        arrowOnStart: true,
        arrowOnStartAngle: pi * -0.50
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
      paintCustomDiagramLines(
          c,
          canvas,
          startPos: Offset(0.70, 0.65),
          straightEndPos: Offset(0.79, 0.65),
          arrowOnEnd: true,
          arrowOnEndAngle: pi * 0.50,
      );
    }

    if (model.subtype == DiagramSubtype.increaseInSupply) {
      paintCustomDiagramLines(c, canvas,
          startPos: Offset(0.30, 0.90), straightEndPos: Offset(0.90, 0.30));
      paintDiagramDashedLines(
        c,
        canvas,
        xAxisEndPos: 0.60,
        yAxisStartPos: 0.60,
        yLabel: MicroLabel.p2.label,
        xLabel: MicroLabel.q2.label,
      );
      paintCustomDiagramLines(
          c,
          canvas,
          startPos: Offset(0.65, 0.40),
          straightEndPos: Offset(0.73, 0.40),
          arrowOnEnd: true,
          arrowOnEndAngle: pi * 0.50
      );
    }

    if (model.subtype == DiagramSubtype.decreaseInSupply) {
      paintCustomDiagramLines(c, canvas,
          startPos: Offset(0.05, 0.75),
          straightEndPos: Offset(0.70, 0.10),
          label2: MicroLabel.s2.label,
          label2Align: LabelAlign.centerRight);

      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.40,
        xAxisEndPos: 0.40,
        yLabel: MicroLabel.p2.label,
        xLabel: MicroLabel.q2.label,
      );
      paintCustomDiagramLines(
          c,
          canvas,
          startPos: Offset(0.57, 0.30),
          straightEndPos: Offset(0.65, 0.30),
          arrowOnStart: true,
          arrowOnStartAngle: pi * 1.50
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
    if (model.subtype == DiagramSubtype.longRunEquilibrium ||
        model.subtype == DiagramSubtype.abnormalProfit ||
        model.subtype == DiagramSubtype.loss ||
        model.subtype == DiagramSubtype.socialWelfare) {
      paintTitle(c, canvas, 'Industry / Market');
      paintAxis(
        c,
        canvas,
        yAxisLabel: MicroLabel.priceCostsRevenue.label,
        yLabelIsHorizontal: false,
        xAxisLabel: MicroLabel.industryQuantity.label,
      );
    }
    if (model.subtype == DiagramSubtype.longRunEquilibrium ||
        model.subtype == DiagramSubtype.socialWelfare) {
      paintDiagramDashedLines(c, canvas,
          yLabel: MicroLabel.pm.label,
          hideXLine: true,
          yAxisStartPos: 0.50,
          xAxisEndPos: 1.1);

      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(
          0.15,
          0.15,
        ),
        straightEndPos: Offset(0.85, 0.85),
        label2: MicroLabel.d.label,
        label2Align: LabelAlign.centerRight,
      );
      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(0.15, 0.85),
        straightEndPos: Offset(0.85, 0.15),
        label2: MicroLabel.s.label,
        label2Align: LabelAlign.centerRight,
      );
    }
    if (model.subtype == DiagramSubtype.abnormalProfit) {
      paintDiagramDashedLines(
        c,
        canvas,
        xAxisEndPos: 1.15,
        yAxisStartPos: 0.40,
        yLabel: MicroLabel.pm.label,
        hideXLine: true,
      );
      paintDiagramDashedLines(
        c,
        canvas,
        xAxisEndPos: 1.15,
        yAxisStartPos: 0.50,
        yLabel: MicroLabel.pe.label,
        hideXLine: true,
      );
      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(
          0.15,
          0.15,
        ),
        straightEndPos: Offset(0.85, 0.85),
        label2: MicroLabel.d.label,
        label2Align: LabelAlign.centerRight,
      );
      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(0.10, 0.70),
        straightEndPos: Offset(0.70, 0.10),
        label2: MicroLabel.s.label,
        label2Align: LabelAlign.centerRight,
      );
      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(0.15, 0.85),
        straightEndPos: Offset(0.85, 0.15),
        label2: MicroLabel.s1.label,
        label2Align: LabelAlign.centerRight,
      );
      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(0.60, 0.25),
        straightEndPos: Offset(0.68, 0.25),
        arrowOnEnd: true,
        arrowOnEndAngle: pi / 2,
      );
      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(0.80, 0.41),
        straightEndPos: Offset(0.80, 0.47),
        arrowOnEnd: true,
        arrowOnEndAngle: pi,
      );
    }
    if (model.subtype == DiagramSubtype.loss) {
      paintDiagramDashedLines(
        c,
        canvas,
        xAxisEndPos: 1.15,
        yAxisStartPos: 0.60,
        yLabel: MicroLabel.pm.label,
        hideXLine: true,
      );
      paintDiagramDashedLines(
        c,
        canvas,
        xAxisEndPos: 1.15,
        yAxisStartPos: 0.50,
        yLabel: MicroLabel.pe.label,
        hideXLine: true,
      );
      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(
          0.15,
          0.15,
        ),
        straightEndPos: Offset(0.85, 0.85),
        label2: MicroLabel.d.label,
        label2Align: LabelAlign.centerRight,
      );
      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(0.35, 0.85),
        straightEndPos: Offset(0.90, 0.30),
        label2: MicroLabel.s.label,
        label2Align: LabelAlign.centerRight,
      );
      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(0.15, 0.85),
        straightEndPos: Offset(0.85, 0.15),
        label2: MicroLabel.s1.label,
        label2Align: LabelAlign.centerRight,
      );

      //Arrow across

      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(0.72, 0.35),
        straightEndPos: Offset(0.80, 0.35),
        arrowOnStart: true,
        arrowOnStartAngle: pi / -2,
      );

      /// Arrow up
      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(0.80, 0.53),
        straightEndPos: Offset(0.80, 0.59),
        arrowOnStart: true,
        arrowOnStartAngle: 0,
      );
    }
    if (model.subtype == DiagramSubtype.socialWelfare) {
      paintShading(canvas, size, ShadeType.consumerSurplus, striped: true, [
        Offset(0, 0.50),
        Offset(0.50, 0.50),
        Offset(0, 0),
      ]);
      paintShading(canvas, size, ShadeType.producerSurplus, striped: true, [
        Offset(0, 0.50),
        Offset(0.50, 0.5),
        Offset(0, 1),
      ]);

      paintTextNormalizedWithinAxis(
        c,
        canvas,
        MicroLabel.consumerSurplus.label,
        Offset(0.5, 0.10),
        pointerLine: Offset(0.15, 0.30),
        style: kLabelTextStyle,
      );
      paintTextNormalizedWithinAxis(
        c,
        canvas,
        MicroLabel.producerSurplus.label,
        Offset(0.5, 0.90),
        pointerLine: Offset(0.15, 0.60),
        style: kLabelTextStyle,
      );
    }
  }
}
