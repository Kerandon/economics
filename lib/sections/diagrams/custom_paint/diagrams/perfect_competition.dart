import 'dart:math';

import 'package:economics_app/sections/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_axis.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_custom_bezier_normalized.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_shading.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_title.dart';
import 'package:economics_app/sections/diagrams/enums/diagram_subtype.dart';
import 'package:economics_app/sections/diagrams/enums/shade_type.dart';
import 'package:economics_app/sections/diagrams/models/diagram_painter_config.dart';
import 'package:flutter/material.dart';
import '../../enums/label_align.dart';
import '../../models/base_painter_painter.dart';
import '../../models/custom_bezier.dart';
import '../../models/diagram_model.dart';
import '../painter_methods/paint_diagram_dash_lines.dart';
import '../painter_methods/paint_text.dart';

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
        label2: MicroLabel.pEqualsDARMR.label,
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
      paintShading(canvas, size, ShadeType.abnormalProfits,  striped: true,[
        Offset(0, 0.40),
        Offset(0.54, 0.40),
        Offset(0.54, 0.50),
        Offset(0, 0.50),
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
        yAxisStartPos: 0.50,
        xAxisEndPos: 1,
        hideXLine: true,
        yLabel: MicroLabel.pe.label,
      );
      paintCustomDiagramLines(
        c,
        canvas,
        label2: MicroLabel.pEqualsDARMR.label,
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
        label2: MicroLabel.p1EqualsD1AR1MR1.label,
        label2Align: LabelAlign.centerRight,
        startPos: Offset(0, 0.40),
        bezierPoints: [
          CustomBezier(
            endPoint: Offset(1, 0.40),
          ),
        ],
      );

      /// Arrows
      paintText(c, canvas, '1', Offset(0.73, 0.42));
      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(
          0.80,
          0.43,
        ),
        bezierPoints: [
          CustomBezier(
            endPoint: Offset(0.80, 0.50),
          ),
        ],
        arrowOnStart: true,
        arrowOnEndAngle: pi,
        color: c.colorScheme.onSurface,
      );
      paintText(c, canvas, '2', Offset(0.88, 0.42));
      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(
          0.90,
          0.40,
        ),
        bezierPoints: [
          CustomBezier(
            endPoint: Offset(0.90, 0.47),
          ),
        ],
        arrowOnEnd: true,
        arrowOnEndAngle: pi,
        color: c.colorScheme.onSurface,
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
        yAxisStartPos: 0.0,
        xAxisEndPos: 1.0,
        yLabel: MicroLabel.p1.label,
        xLabel: MicroLabel.qe.label,
      );
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.50,
        xAxisEndPos: 0.55,
        hideXLine: true,
        yLabel: MicroLabel.atc.label,
      );
      paintCustomDiagramLines(
        c,
        canvas,
        label2: MicroLabel.pEqualsDARMR.label,
        label2Align: LabelAlign.centerRight,
        startPos: Offset(0, 0.60),
        bezierPoints: [
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
