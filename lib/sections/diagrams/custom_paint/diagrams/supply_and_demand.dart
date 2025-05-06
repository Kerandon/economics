import 'dart:math';

import 'package:economics_app/sections/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_axis.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_curve_normalized.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_custom_bezier_normalized.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_diagram_dash_lines.dart';
import 'package:economics_app/sections/diagrams/enums/axis_label_margin.dart';
import 'package:economics_app/sections/diagrams/enums/diagram_subtype.dart';
import 'package:economics_app/sections/diagrams/models/custom_bezier.dart';
import 'package:flutter/material.dart';
import '../../enums/label_align.dart';
import '../../models/base_painter_painter.dart';
import '../../models/diagram_model.dart';
import '../../models/diagram_painter_config.dart';
import '../painter_methods/paint_text.dart';

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
      axisLabelMargin: AxisLabelMargin.close,
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

      paintCustomBezierNormalized(
        c,
        canvas,
        startPos: Offset(0.15, 0.15),
        points: [
          CustomBezier(
            endPoint: Offset(0.85, 0.85),
          ),
        ],
        label2: MicroLabel.d.label,
        label2Align: LabelAlign.centerRight,
      );
      paintCustomBezierNormalized(
        c,
        canvas,
        startPos: Offset(0.85, 0.15),
        points: [
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

      paintCustomBezierNormalized(
        c,
        canvas,
        startPos: Offset(0.15, 0.15),
        points: [
          CustomBezier(
            endPoint: Offset(0.85, 0.85),
          ),
        ],
        label2: MicroLabel.d.label,
        label2Align: LabelAlign.centerRight,
      );
      paintCustomBezierNormalized(
        c,
        canvas,
        startPos: Offset(0.85, 0.15),
        points: [
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
      paintCustomBezierNormalized(
        c,
        canvas,
        startPos: Offset(0.30, 0.10),
        points: [
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
      paintCustomBezierNormalized(
          color: c.colorScheme.onSurface,
          strokeWidth: kCurveWidthSlim,
          c,
          canvas,
          startPos: Offset(0.30, 1.10),
          points: [
            CustomBezier(endPoint: Offset(0.30, 1.14)),
            CustomBezier(endPoint: Offset(0.70, 1.14)),
            CustomBezier(endPoint: Offset(0.70, 1.10)),
          ],
          arrowOnEnd: true,
          arrowOnStart: true,
          arrowOnStartAngle: pi / 0.50,
          arrowOnEndAngle: pi / 0.50, );
      paintText(c, canvas, MicroLabel.shortage.label, Offset(0.53, 0.98));
      paintCustomBezierNormalized(
        circleAtStart: true,
        circleAtEnd: true,
        color: Colors.red,
        c,
        canvas,

        startPos: Offset(0.30, 0.70),
        points: [
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
      paintCustomBezierNormalized(
          strokeWidth: kCurveWidthSlim,
          color: c.colorScheme.onSurface,
          c,
          canvas,
          startPos: Offset(0.30, 0.25),
          points: [
            CustomBezier(endPoint: Offset(0.30, 0.20)),
            CustomBezier(endPoint: Offset(0.70, 0.20)),
            CustomBezier(endPoint: Offset(0.70, 0.25)),
          ],
          arrowOnEnd: true,
          arrowOnStart: true,
          arrowOnStartAngle: pi,
          arrowOnEndAngle: pi);
      paintText(c, canvas, 'surplus', Offset(0.53, 0.20));
      paintCustomBezierNormalized(
        circleAtStart: true,
        circleAtEnd: true,
        color: Colors.red,
        c,
        canvas,
        startPos: Offset(0.30, 0.30),
        points: [
          CustomBezier(
            endPoint: Offset(0.70, 0.30),
          ),
        ],
      );
    }
  }
}
