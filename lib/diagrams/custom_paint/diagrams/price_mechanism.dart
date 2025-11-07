import 'dart:math';
import 'package:flutter/material.dart';
import '../../enums/diagram_labels.dart';
import '../../enums/diagram_subtype.dart';
import '../painter_methods/axis/label_align.dart';
import '../shade/shade_type.dart';
import '../../models/base_painter_painter.dart';
import '../../models/custom_bezier.dart';
import '../../models/diagram_model.dart';
import '../../models/diagram_painter_config.dart';
import '../painter_constants.dart';
import '../painter_methods/axis/paint_axis.dart';
import '../painter_methods/paint_diagram_dash_lines.dart';
import '../painter_methods/diagram_lines/paint_diagram_lines.dart';
import '../shade/paint_shading.dart';
import '../painter_methods/paint_text.dart';
import '../painter_methods/paint_text_2.dart';
import '../painter_methods/paint_title.dart';

class PriceMechanism extends BaseDiagramPainter {
  PriceMechanism({
    required DiagramPainterConfig config,
    required DiagramModel model,
  }) : super(config, model);

  @override
  void paint(Canvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);

    paintAxis(
      c,
      canvas,
      yAxisLabel: DiagramLabel.p.label,
      xAxisLabel: DiagramLabel.q.label,
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
        yLabel: DiagramLabel.pe.label,
        xLabel: DiagramLabel.qe.label,
      );

      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0.15, 0.15),
        polylineOffsets: [Offset(0.85, 0.85)],
        label2: DiagramLabel.d.label,
        label2Align: LabelAlign.centerRight,
      );
      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0.85, 0.15),
        polylineOffsets: [Offset(0.15, 0.85)],
        label1: DiagramLabel.s.label,
        label1Align: LabelAlign.centerRight,
      );
    }

    final isDemandShift =
        model.subtype == DiagramSubtype.increaseInDemand ||
        model.subtype == DiagramSubtype.decreaseInDemand;
    final isSupplyShift =
        model.subtype == DiagramSubtype.increaseInSupply ||
        model.subtype == DiagramSubtype.decreaseInSupply;

    if (isDemandShift || isSupplyShift) {
      // Base curves

      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0.15, 0.15),
        polylineOffsets: [Offset(0.85, 0.85)],
        label2: DiagramLabel.d.label,
        label2Align: LabelAlign.centerRight,
      );
      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0.85, 0.15),
        polylineOffsets: [Offset(0.15, 0.85)],
        label1: DiagramLabel.s.label,
        label1Align: LabelAlign.centerRight,
      );

      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.50,
        xAxisEndPos: 0.50,
        yLabel: DiagramLabel.p1.label,
        xLabel: DiagramLabel.q1.label,
      );
    }

    if (model.subtype == DiagramSubtype.decreaseInDemand) {
      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0.10, 0.30),
        polylineOffsets: [Offset(0.70, 0.90)],
        label2: DiagramLabel.d2.label,
        label2Align: LabelAlign.centerRight,
      );

      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.60,
        xAxisEndPos: 0.40,
        yLabel: DiagramLabel.p2.label,
        xLabel: DiagramLabel.q2.label,
      );

      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0.68, 0.80),
        polylineOffsets: [Offset(0.76, 0.80)],
        arrowOnStart: true,
        arrowOnStartAngle: pi * -0.50,
      );
    }

    if (model.subtype == DiagramSubtype.increaseInDemand) {
      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0.30, 0.10),
        polylineOffsets: [Offset(0.90, 0.70)],
        label2: DiagramLabel.d1.label,
        label2Align: LabelAlign.centerRight,
      );

      paintDiagramDashedLines(
        c,
        canvas,
        xAxisEndPos: 0.60,
        yAxisStartPos: 0.40,
        yLabel: DiagramLabel.p2.label,
        xLabel: DiagramLabel.q2.label,
      );
      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0.70, 0.65),
        polylineOffsets: [Offset(0.79, 0.65)],
        arrowOnEnd: true,
        arrowOnEndAngle: pi * 0.50,
      );
    }

    if (model.subtype == DiagramSubtype.increaseInSupply) {
      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0.30, 0.90),
        polylineOffsets: [Offset(0.90, 0.30)],
      );
      paintDiagramDashedLines(
        c,
        canvas,
        xAxisEndPos: 0.60,
        yAxisStartPos: 0.60,
        yLabel: DiagramLabel.p2.label,
        xLabel: DiagramLabel.q2.label,
      );
      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0.65, 0.40),
        polylineOffsets: [Offset(0.73, 0.40)],
        arrowOnEnd: true,
        arrowOnEndAngle: pi * 0.50,
      );
    }

    if (model.subtype == DiagramSubtype.decreaseInSupply) {
      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0.05, 0.75),
        polylineOffsets: [Offset(0.70, 0.10)],
        label2: DiagramLabel.s2.label,
        label2Align: LabelAlign.centerRight,
      );

      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.40,
        xAxisEndPos: 0.40,
        yLabel: DiagramLabel.p2.label,
        xLabel: DiagramLabel.q2.label,
      );
      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0.57, 0.30),
        polylineOffsets: [Offset(0.65, 0.30)],
        arrowOnStart: true,
        arrowOnStartAngle: pi * 1.50,
      );
    }
    if (model.subtype == DiagramSubtype.shortage) {
      paintDiagramDashedLines(
        c,
        canvas,
        xAxisEndPos: 0.30,
        yAxisStartPos: 0.70,
        yLabel: DiagramLabel.pm.label,
        xLabel: DiagramLabel.qD.label,
      );
      paintDiagramDashedLines(
        c,
        canvas,
        xAxisEndPos: 0.70,
        yAxisStartPos: 0.70,
        xLabel: DiagramLabel.qS.label,
      );
      paintDiagramLines(
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
      paintText(c, canvas, DiagramLabel.shortage.label, Offset(0.53, 0.98));
      paintDiagramLines(
        circleAtStart: true,
        circleAtEnd: true,
        color: Colors.red,
        c,
        canvas,
        startPos: Offset(0.30, 0.70),
        bezierPoints: [CustomBezier(endPoint: Offset(0.70, 0.70))],
      );
    }

    if (model.subtype == DiagramSubtype.surplus) {
      paintDiagramDashedLines(
        c,
        canvas,
        xAxisEndPos: 0.30,
        yAxisStartPos: 0.30,
        yLabel: DiagramLabel.pm.label,
        xLabel: DiagramLabel.qD.label,
      );
      paintDiagramDashedLines(
        c,
        canvas,
        xAxisEndPos: 0.70,
        yAxisStartPos: 0.30,
        xLabel: DiagramLabel.qS.label,
      );
      paintDiagramLines(
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
        arrowOnEndAngle: pi,
      );
      paintText(c, canvas, 'surplus', Offset(0.53, 0.20));
      paintDiagramLines(
        circleAtStart: true,
        circleAtEnd: true,
        color: Colors.red,
        c,
        canvas,
        startPos: Offset(0.30, 0.30),
        bezierPoints: [CustomBezier(endPoint: Offset(0.70, 0.30))],
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
        yAxisLabel: DiagramLabel.priceCostsRevenue.label,
        // yLabelIsVertical: false,
        xAxisLabel: DiagramLabel.industryQuantity.label,
      );
    }
    if (model.subtype == DiagramSubtype.longRunEquilibrium ||
        model.subtype == DiagramSubtype.socialWelfare) {
      paintDiagramDashedLines(
        c,
        canvas,
        yLabel: DiagramLabel.pm.label,
        hideXLine: true,
        yAxisStartPos: 0.50,
        xAxisEndPos: 1.1,
      );

      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0.15, 0.15),
        polylineOffsets: [Offset(0.85, 0.85)],
        label2: DiagramLabel.d.label,
        label2Align: LabelAlign.centerRight,
      );
      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0.15, 0.85),
        polylineOffsets: [Offset(0.85, 0.15)],
        label2: DiagramLabel.s.label,
        label2Align: LabelAlign.centerRight,
      );
    }
    if (model.subtype == DiagramSubtype.abnormalProfit) {
      paintDiagramDashedLines(
        c,
        canvas,
        xAxisEndPos: 1.15,
        yAxisStartPos: 0.40,
        yLabel: DiagramLabel.pm.label,
        hideXLine: true,
      );
      paintDiagramDashedLines(
        c,
        canvas,
        xAxisEndPos: 1.15,
        yAxisStartPos: 0.50,
        yLabel: DiagramLabel.pe.label,
        hideXLine: true,
      );
      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0.15, 0.15),
        polylineOffsets: [Offset(0.85, 0.85)],
        label2: DiagramLabel.d.label,
        label2Align: LabelAlign.centerRight,
      );
      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0.10, 0.70),
        polylineOffsets: [Offset(0.70, 0.10)],
        label2: DiagramLabel.s.label,
        label2Align: LabelAlign.centerRight,
      );
      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0.15, 0.85),
        polylineOffsets: [Offset(0.85, 0.15)],
        label2: DiagramLabel.s1.label,
        label2Align: LabelAlign.centerRight,
      );
      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0.60, 0.25),
        polylineOffsets: [Offset(0.68, 0.25)],
        arrowOnEnd: true,
        arrowOnEndAngle: pi / 2,
      );
      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0.80, 0.41),
        polylineOffsets: [Offset(0.80, 0.47)],
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
        yLabel: DiagramLabel.pm.label,
        hideXLine: true,
      );
      paintDiagramDashedLines(
        c,
        canvas,
        xAxisEndPos: 1.15,
        yAxisStartPos: 0.50,
        yLabel: DiagramLabel.pe.label,
        hideXLine: true,
      );
      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0.15, 0.15),
        polylineOffsets: [Offset(0.85, 0.85)],
        label2: DiagramLabel.d.label,
        label2Align: LabelAlign.centerRight,
      );
      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0.35, 0.85),
        polylineOffsets: [Offset(0.90, 0.30)],
        label2: DiagramLabel.s.label,
        label2Align: LabelAlign.centerRight,
      );
      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0.15, 0.85),
        polylineOffsets: [Offset(0.85, 0.15)],
        label2: DiagramLabel.s1.label,
        label2Align: LabelAlign.centerRight,
      );

      //Arrow across

      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0.72, 0.35),
        polylineOffsets: [Offset(0.80, 0.35)],
        arrowOnStart: true,
        arrowOnStartAngle: pi / -2,
      );

      /// Arrow up
      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0.80, 0.53),
        polylineOffsets: [Offset(0.80, 0.59)],
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

      paintText2(
        c,
        canvas,
        DiagramLabel.consumerSurplus.label,
        Offset(0.5, 0.10),
        pointerLine: Offset(0.15, 0.30),
        style: kLabelTextStyle,
      );
      paintText2(
        c,
        canvas,
        DiagramLabel.producerSurplus.label,
        Offset(0.5, 0.90),
        pointerLine: Offset(0.15, 0.60),
        style: kLabelTextStyle,
      );
    }
  }
}
