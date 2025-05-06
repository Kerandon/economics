import 'package:economics_app/sections/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_axis.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_custom_bezier_normalized.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_shading.dart';
import 'package:economics_app/sections/diagrams/enums/diagram_subtype.dart';
import 'package:economics_app/sections/diagrams/enums/shade_type.dart';
import 'package:economics_app/sections/diagrams/models/diagram_painter_config.dart';
import 'package:flutter/material.dart';
import '../../enums/label_align.dart';
import '../../models/base_painter_painter.dart';
import '../../models/custom_bezier.dart';
import '../../models/diagram_model.dart';
import '../painter_methods/paint_diagram_dash_lines.dart';

class PerfectCompetition extends BaseDiagramPainter {
  PerfectCompetition({
    required DiagramPainterConfig config,
    required DiagramModel model,
  }) : super(config, model);

  @override
  void paint(Canvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);

   

    if (model.subtype == DiagramSubtype.perfectCompetitionNormalProfit) {
      /// Dashed Lines
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
        label2: MicroLabel.pEqualsDARMR.label,
        label2Align: LabelAlign.centerRight,
        startPos: Offset(0, 0.50),
        points: [
          CustomBezier(
            endPoint: Offset(0.90, 0.50),
          ),
        ],
      );
    }
    if (model.subtype == DiagramSubtype.perfectCompetitionAbnormalProfit) {
      paintShading(canvas, size, ShadeType.abnormalProfits, [
        Offset(0, 0.40),
        Offset(0.54, 0.40),
        Offset(0.54, 0.49),
        Offset(0, 0.49),
      ]);

      /// Dashed Lines
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.40,
        xAxisEndPos: 0.55,
        yLabel: MicroLabel.p1.label,
        xLabel: MicroLabel.qe.label,
      );
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.49,
        xAxisEndPos: 0.55,
        hideXLine: true,
        yLabel: MicroLabel.ac.label,
      );
      paintCustomBezierNormalized(
        c,
        canvas,
        label2: MicroLabel.pEqualsDARMR.label,
        label2Align: LabelAlign.centerRight,
        startPos: Offset(0, 0.40),
        points: [
          CustomBezier(
            endPoint: Offset(0.90, 0.40),
          ),
        ],
      );
    }
    if (model.subtype == DiagramSubtype.perfectCompetitionLoss) {
      paintShading(canvas, size, ShadeType.loss, [
        Offset(0, 0.50),
        Offset(0.45, 0.50),
        Offset(0.45, 0.60),
        Offset(0, 0.60),
      ]);

      /// Dashed Lines
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.60,
        xAxisEndPos: 0.45,
        yLabel: MicroLabel.p1.label,
        xLabel: MicroLabel.qe.label,
      );
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.50,
        xAxisEndPos: 0.55,
        hideXLine: true,
        yLabel: MicroLabel.ac.label,
      );
      paintCustomBezierNormalized(
        c,
        canvas,
        label2: MicroLabel.pEqualsDARMR.label,
        label2Align: LabelAlign.centerRight,
        startPos: Offset(0, 0.60),
        points: [
          CustomBezier(
            endPoint: Offset(0.90, 0.60),
          ),
        ],
      );
    }
    paintAxis(
      c,
      canvas,
      yAxisLabel: kPriceCostsRevenue,
      yLabelIsHorizontal: false,
      xAxisLabel: kQuantity,
    );

    paintCustomBezierNormalized(
      c,
      canvas,
      label2: MicroLabel.mc.label,
      label2Align: LabelAlign.centerTop,
      startPos: Offset(0.15, 0.60),
      points: [
        CustomBezier(
          control: Offset(0.32, 1.10),
          endPoint: Offset(0.70, 0.00),
        ),
      ],
    );
    paintCustomBezierNormalized(
      c,
      canvas,
      label2: MicroLabel.ac.label,
      label2Align: LabelAlign.centerTop,
      startPos: Offset(0.15, 0.20),
      points: [
        CustomBezier(
          control: Offset(0.50, 0.80),
          endPoint: Offset(0.85, 0.20),
        ),
      ],
    );
  }
}
