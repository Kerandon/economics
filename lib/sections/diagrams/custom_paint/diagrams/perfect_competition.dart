import 'dart:math';

import 'package:economics_app/sections/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_axis.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_shading.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_text.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_title.dart';
import 'package:economics_app/sections/diagrams/enums/diagram_subtype.dart';
import 'package:economics_app/sections/diagrams/enums/shade_type.dart';
import 'package:economics_app/sections/diagrams/models/diagram_painter_config.dart';
import 'package:flutter/material.dart';
import '../../enums/label_align.dart';
import '../../models/base_painter_painter.dart';
import '../../models/custom_bezier.dart';
import '../../models/diagram_model.dart';
import '../painter_methods/paint_diagram_custom_lines.dart';
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
      paintCustomDiagramLines(
        c,
        canvas,
        label2: MicroLabel.dEqualsARMR.label,
        label2Align: LabelAlign.centerRight,
        startPos: Offset(0, 0.50),
        bezierPoints: [
          CustomBezier(
            endPoint: Offset(0.90, 0.50),
          ),
        ],
      );
    }
    if (model.subtype == DiagramSubtype.perfectCompetitionAbnormalProfit) {
      paintShading(canvas, size, ShadeType.abnormalProfits, striped: true, [
        Offset(0, 0.40),
        Offset(0.54, 0.40),
        Offset(0.54, 0.50),
        Offset(0, 0.50),
      ]);

      /// Dashed Lines
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.50,
        xAxisEndPos: 0.50,
        hideYLine: true,
        xLabel: '${MicroLabel.qe.label}   ',
      );
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.40,
        xAxisEndPos: 0.55,
        yLabel: MicroLabel.p.label,
        xLabel: '    ${MicroLabel.q1.label}',
      );
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.50,
        xAxisEndPos: 1,
        hideXLine: true,
        yLabel: MicroLabel.pe.label,
      );
      paintCustomDiagramLines(
        c,
        canvas,
        label2: MicroLabel.d1EqualsAR1MR1.label,
        label2Align: LabelAlign.centerRight,
        startPos: Offset(1, 0.50),
        bezierPoints: [
          CustomBezier(
            endPoint: Offset(1, 0.50),
          ),
        ],
      );
      paintCustomDiagramLines(
        c,
        canvas,
        label2: MicroLabel.dEqualsARMR.label,
        label2Align: LabelAlign.centerRight,
        startPos: Offset(0, 0.40),
        bezierPoints: [
          CustomBezier(
            endPoint: Offset(1, 0.40),
          ),
        ],
      );

      /// Arrows

      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(0.80, 0.41),
        straightEndPos: Offset(0.80, 0.47),
        arrowOnEnd: true,
        arrowOnEndAngle: pi,
      );
    }
    if (model.subtype == DiagramSubtype.perfectCompetitionLoss) {
      paintShading(canvas, size, ShadeType.loss, striped: true, [
        Offset(0, 0.50),
        Offset(0.45, 0.50),
        Offset(0.45, 0.60),
        Offset(0, 0.60),
      ]);

      /// Dashed Lines


      paintDiagramDashedLines(c, canvas,
          yAxisStartPos: 0.5,
          xAxisEndPos: 0.45,
          xLabel: '${MicroLabel.q1.label} ',
          hideYLine: true);
      paintDiagramDashedLines(c, canvas,
          yAxisStartPos: 0.5,
          xAxisEndPos: 0.51,
          xLabel: '  ${MicroLabel.qe.label}',
          hideYLine: true);
      paintDiagramDashedLines(c, canvas,
          yAxisStartPos: 0.6,
          xAxisEndPos: 0.90,
          hideXLine: true,
          yLabel: MicroLabel.p.label,
      );
      paintCustomDiagramLines(
        c,
        canvas,
        label1: MicroLabel.pe.label,
        label1Align: LabelAlign.centerLeft,
        label2: MicroLabel.d1EqualsAR1MR1.label,
        label2Align: LabelAlign.centerRight,
        startPos: Offset(0, 0.50),
        straightEndPos: Offset(0.90, 0.50),
      );
      paintCustomDiagramLines(c, canvas, startPos: Offset(0.80,0.53),
        straightEndPos: Offset(0.80,0.59),
        arrowOnStart: true,
        arrowOnStartAngle: 0,
      );


    }
    paintAxis(
      c,
      canvas,
      yAxisLabel: kPriceCostsRevenue,
      yLabelIsHorizontal: false,
      xAxisLabel: MicroLabel.quantityFirm.label,
    );

    paintCustomDiagramLines(
      c,
      canvas,
      label2: MicroLabel.mc.label,
      label2Align: LabelAlign.centerTop,
      startPos: Offset(0.15, 0.60),
      bezierPoints: [
        CustomBezier(
          control: Offset(0.35, 1.10),
          endPoint: Offset(0.64, 0.10),
        ),
      ],
    );
    paintCustomDiagramLines(
      c,
      canvas,
      label2: MicroLabel.atc.label,
      label2Align: LabelAlign.centerTop,
      startPos: Offset(0.15, 0.20),
      bezierPoints: [
        CustomBezier(
          control: Offset(0.50, 0.80),
          endPoint: Offset(0.85, 0.20),
        ),
      ],
    );

    paintTitle(c, canvas, 'Firm');
  }
}
