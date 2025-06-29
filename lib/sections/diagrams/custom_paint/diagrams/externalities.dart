import 'package:economics_app/sections/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_axis.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_diagram_dash_lines.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_shading.dart';
import 'package:economics_app/sections/diagrams/enums/axis_label_margin.dart';
import 'package:economics_app/sections/diagrams/enums/diagram_subtype.dart';
import 'package:economics_app/sections/diagrams/enums/shade_type.dart';
import 'package:flutter/material.dart';

import '../../enums/label_align.dart';
import '../../models/base_painter_painter.dart';
import '../../models/custom_bezier.dart';
import '../../models/diagram_model.dart';
import '../../models/diagram_painter_config.dart';
import '../painter_methods/paint_custom_bezier_normalized.dart';

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


    String supplyLabel = MicroLabel.sEqualsMPCMSC.label;
    String demandLabel = MicroLabel.dEqualsMPBMSB.label;
    if (negProd) {
      supplyLabel = MicroLabel.sEqualsMPC.label;
      paintShading(
        canvas,
        size,
        ShadeType.welfareLoss,
        [
          Offset(0.50, 0.50),
          Offset(0.40, 0.40),
          Offset(0.50, 0.30),
        ],
      );

      /// Dashed Lines Optimum
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.40,
        xAxisEndPos: 0.40,
        yLabel: MicroLabel.pOpt.label,
        xLabel: MicroLabel.qOpt.label,
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
        label1: MicroLabel.msc.label,
        label1Align: LabelAlign.centerRight,
      );
    }
    if (negCon) {
      demandLabel = MicroLabel.dEqualsMPB.label;
      paintShading(
        canvas,
        size,
        ShadeType.welfareLoss,
        [
          Offset(0.50, 0.50),
          Offset(0.40, 0.60),
          Offset(0.50, 0.70),
        ],
      );
      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(0.10, 0.30),
        bezierPoints: [
          CustomBezier(
            endPoint: Offset(0.70, 0.90),
          ),
        ],
        label2: MicroLabel.msb.label,
        label2Align: LabelAlign.centerRight,
      );

      /// Dashed Lines Optimum
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.60,
        xAxisEndPos: 0.41,
        yLabel: MicroLabel.pOpt.label,
        xLabel: MicroLabel.qOpt.label,
      );
    }
    if (posProd) {
      supplyLabel = MicroLabel.sEqualsMPC.label;
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
        yLabel: MicroLabel.pOpt.label,
        xLabel: MicroLabel.qOpt.label,
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
        label1: MicroLabel.msc.label,
        label1Align: LabelAlign.centerRight,
      );
    }
    if (posCon) {
      demandLabel = MicroLabel.dEqualsMPB.label;
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
        yLabel: MicroLabel.pOpt.label,
        xLabel: MicroLabel.qOpt.label,
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
        label2: MicroLabel.msb.label,
        label2Align: LabelAlign.centerRight,
      );
    }

    /// Dashed Lines market
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.50,
      xAxisEndPos: 0.51,
      yLabel: MicroLabel.pm.label,
      xLabel: MicroLabel.qm.label,
    );

    paintAxis(
      c,
      canvas,
      yAxisLabel: MicroLabel.p.label,
      xAxisLabel: MicroLabel.q.label,
      axisLabelMargin: AxisLabelMargin.close,
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
