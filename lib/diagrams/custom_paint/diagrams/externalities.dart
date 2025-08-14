import 'dart:math';
import 'package:flutter/material.dart';
import '../../enums/diagram_labels.dart';
import '../../enums/diagram_subtype.dart';
import '../../enums/label_align.dart';
import '../../enums/shade_type.dart';
import '../../models/base_painter_painter.dart';
import '../../models/custom_bezier.dart';
import '../../models/diagram_model.dart';
import '../../models/diagram_painter_config.dart';
import '../painter_methods/paint_axis.dart';
import '../painter_methods/paint_diagram_custom_lines.dart';
import '../painter_methods/paint_diagram_dash_lines.dart';
import '../painter_methods/paint_shading.dart';
import '../painter_methods/paint_text_normalized_within_axis.dart';

class Externalities extends BaseDiagramPainter {
  Externalities({
    required DiagramPainterConfig config,
    required DiagramModel model,
  }) : super(config, model);

  @override
  void paint(Canvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);

    final negProd = model.subtype == DiagramSubtype.negativeProduction;
    final negCon = model.subtype == DiagramSubtype.negativeConsumption;
    final posProd = model.subtype == DiagramSubtype.positiveProduction;
    final posCon = model.subtype == DiagramSubtype.positiveConsumption;


    String supplyLabel = DiagramLabel.sEqualsMPCMSC.label;
    String demandLabel = DiagramLabel.dEqualsMPBMSB.label;
    if (negProd) {
      supplyLabel = DiagramLabel.sEqualsMPC.label;
      paintShading(
        canvas,
        size,
        ShadeType.welfareLoss,
        [
          Offset(0.51, 0.50),
          Offset(0.40, 0.40),
          Offset(0.51, 0.30),
        ],
      );

      /// Dashed Lines Optimum
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.40,
        xAxisEndPos: 0.40,
        yLabel: DiagramLabel.pOpt.label,
        xLabel: DiagramLabel.qOpt.label,
      );
      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(0.70, 0.10),
        bezierPoints: [
          CustomBezier(
            endPoint: Offset(0.10, 0.70),
          ),
        ],
        label1: DiagramLabel.msc.label,
        label1Align: LabelAlign.centerRight,
      );
      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(0.65, 0.20),
    polylineOffsets: [ Offset(0.65, 0.30),],
        arrowOnStart: true,
        arrowOnEnd: true,
        arrowOnEndAngle: pi,
      );
      paintTextNormalizedWithinAxis(
        c,
        canvas,
        DiagramLabel.externality.label,
        Offset(0.90, 0.30),
        pointerLine: Offset(0.65,0.25),
      );
      paintTextNormalizedWithinAxis(
        c,
        canvas,
        DiagramLabel.welfareLoss.label,
        Offset(0.46, 0.10),
        pointerLine: Offset(0.46,0.38),
      );
    }
    if (negCon) {
      demandLabel = DiagramLabel.dEqualsMPB.label;
      paintShading(
        canvas,
        size,
        ShadeType.welfareLoss,
        [
          Offset(0.51, 0.50),
          Offset(0.40, 0.60),
          Offset(0.51, 0.70),
        ],
      );
      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(0.10, 0.30),
       polylineOffsets: [Offset(0.70, 0.90),],
        label2: DiagramLabel.msb.label,
        label2Align: LabelAlign.centerRight,
      );

      /// Dashed Lines Optimum
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.60,
        xAxisEndPos: 0.41,
        yLabel: DiagramLabel.pOpt.label,
        xLabel: DiagramLabel.qOpt.label,
      );
      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(0.65, 0.70),
        polylineOffsets: [ Offset(0.65, 0.80),],
        arrowOnStart: true,
        arrowOnEnd: true,
        arrowOnEndAngle: pi,
      );
      paintTextNormalizedWithinAxis(
        c,
        canvas,
        DiagramLabel.externality.label,
        Offset(0.90, 0.65),
        pointerLine: Offset(0.65,0.75),
      );
      paintTextNormalizedWithinAxis(
        c,
        canvas,
        DiagramLabel.welfareLoss.label,
        Offset(0.46, 0.20),
        pointerLine: Offset(0.46,0.58),
      );
    }
    if (posProd) {
      supplyLabel = DiagramLabel.sEqualsMPC.label;
      paintShading(
        canvas,
        size,
        ShadeType.welfareLoss,
        [
          Offset(0.50, 0.50),
          Offset(0.60, 0.60),
          Offset(0.50, 0.70),
        ],
      );

      /// Dashed Lines Optimum
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.60,
        xAxisEndPos: 0.61,
        yLabel: DiagramLabel.pOpt.label,
        xLabel: DiagramLabel.qOpt.label,
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
        label1: DiagramLabel.msc.label,
        label1Align: LabelAlign.centerRight,
      );
      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(0.75, 0.30),
        polylineOffsets: [Offset(0.75, 0.40),],
        arrowOnStart: true,
        arrowOnEnd: true,
        arrowOnEndAngle: pi,
      );
      paintTextNormalizedWithinAxis(
        c,
        canvas,
        DiagramLabel.externality.label,
        Offset(0.90, 0.50),
        pointerLine: Offset(0.75,0.35),
      );
      paintTextNormalizedWithinAxis(
        c,
        canvas,
        DiagramLabel.welfareLoss.label,
        Offset(0.54, 0.20),
        pointerLine: Offset(0.54,0.58),
      );
    }
    if (posCon) {
      demandLabel = DiagramLabel.dEqualsMPB.label;
      paintShading(
        canvas,
        size,
        ShadeType.welfareLoss,
        [
          Offset(0.50, 0.30),
          Offset(0.60, 0.40),
          Offset(0.50, 0.50),
        ],
      );

      /// Dashed Lines Optimum
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.40,
        xAxisEndPos: 0.61,
        yLabel: DiagramLabel.pOpt.label,
        xLabel: DiagramLabel.qOpt.label,
      );
      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(0.25, 0.05),
        bezierPoints: [
          CustomBezier(
            endPoint: Offset(0.90, 0.70),
          ),
        ],
        label2: DiagramLabel.msb.label,
        label2Align: LabelAlign.centerRight,
      );

      paintTextNormalizedWithinAxis(
        c,
        canvas,
        DiagramLabel.welfareLoss.label,
        Offset(0.54, 0.10),
        pointerLine: Offset(0.54,0.38),
      );
      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(0.35, 0.20),
        polylineOffsets: [Offset(0.35, 0.30),],
        arrowOnStart: true,
        arrowOnEnd: true,
        arrowOnEndAngle: pi,
      );
      paintTextNormalizedWithinAxis(
        c,
        canvas,
        DiagramLabel.externality.label,
        Offset(0.15, 0.30),
        pointerLine: Offset(0.35,0.25),
      );
    }

    /// Dashed Lines market
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.50,
      xAxisEndPos: 0.51,
      yLabel: DiagramLabel.pm.label,
      xLabel: DiagramLabel.qm.label,
    );

    paintAxis(
      c,
      canvas,
      yAxisLabel: DiagramLabel.p.label,
      xAxisLabel: DiagramLabel.q.label,
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
      label2: demandLabel,
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
      label1: supplyLabel,
      label1Align: LabelAlign.centerRight,
    );
  }
}
