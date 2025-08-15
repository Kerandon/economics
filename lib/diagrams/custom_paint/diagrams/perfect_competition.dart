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
import '../painter_methods/paint_title.dart';

class PerfectCompetition extends BaseDiagramPainter {
  PerfectCompetition({
    required DiagramPainterConfig config,
    required DiagramModel model,
  }) : super(config, model);

  @override
  void paint(Canvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);

    if (model.subtype == DiagramSubtype.longRunEquilibrium ||
        model.subtype == DiagramSubtype.socialWelfare) {
      /// Dashed Lines
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.50,
        xAxisEndPos: 0.50,
        yLabel: DiagramLabel.pe.label,
        xLabel: DiagramLabel.qe.label,
      );
      paintCustomDiagramLines(
        c,
        canvas,
        label2: DiagramLabel.dEqualsARMR.label,
        label2Align: LabelAlign.centerRight,
        startPos: Offset(0, 0.50),
        polylineOffsets: [Offset(0.90, 0.50)],
      );
    }
    if (model.subtype == DiagramSubtype.abnormalProfit) {
      paintShading(canvas, size, ShadeType.abnormalProfit, striped: true, [
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
        xLabel: '${DiagramLabel.qe.label}   ',
      );
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.40,
        xAxisEndPos: 0.55,
        yLabel: DiagramLabel.p.label,
        xLabel: '    ${DiagramLabel.q1.label}',
      );
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.50,
        xAxisEndPos: 1,
        hideXLine: true,
        yLabel: DiagramLabel.pe.label,
      );

      paintTextNormalizedWithinAxis(
        c,
        canvas,
        DiagramLabel.d1EqualsAR1MR1.label,
        Offset(1.0, 0.50),
        align: LabelAlign.centerRight,
      );
      paintCustomDiagramLines(
        c,
        canvas,
        label2: DiagramLabel.dEqualsARMR.label,
        label2Align: LabelAlign.centerRight,
        startPos: Offset(0, 0.40),
        polylineOffsets: [Offset(1, 0.40)],
      );

      /// Arrows

      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(0.80, 0.41),
        polylineOffsets: [Offset(0.80, 0.47)],
        arrowOnEnd: true,
        arrowOnEndAngle: pi,
      );
      paintTextNormalizedWithinAxis(
        c,
        canvas,
        DiagramLabel.abnormalProfit.label,
        Offset(0.25, 0.85),
        pointerLine: Offset(0.25, 0.45),
      );
    }
    if (model.subtype == DiagramSubtype.loss) {
      paintShading(canvas, size, ShadeType.loss, striped: true, [
        Offset(0, 0.50),
        Offset(0.45, 0.50),
        Offset(0.45, 0.60),
        Offset(0, 0.60),
      ]);

      /// Dashed Lines

      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.5,
        xAxisEndPos: 0.45,
        xLabel: '${DiagramLabel.q1.label} ',
        hideYLine: true,
      );
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.5,
        xAxisEndPos: 0.51,
        xLabel: '  ${DiagramLabel.qe.label}',
        hideYLine: true,
      );
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.5,
        xAxisEndPos: 0.90,
        hideXLine: true,
        yLabel: DiagramLabel.p.label,
      );
      paintCustomDiagramLines(
        c,
        canvas,
        label1: DiagramLabel.p.label,
        label1Align: LabelAlign.centerLeft,
        label2: DiagramLabel.d1EqualsAR1MR1.label,
        label2Align: LabelAlign.centerRight,
        startPos: Offset(0, 0.60),
        polylineOffsets: [Offset(0.90, 0.60)],
      );
      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(0.80, 0.53),
        polylineOffsets: [Offset(0.80, 0.59)],
        arrowOnStart: true,
        arrowOnStartAngle: 0,
      );
      paintTextNormalizedWithinAxis(
        c,
        canvas,
        DiagramLabel.loss.label,
        Offset(0.20, 0.90),
        pointerLine: Offset(0.20, 0.55),
      );
    }
    paintAxis(
      c,
      canvas,
      yAxisLabel: DiagramLabel.priceCostsRevenue.label,
      yLabelIsVertical: false,
      xAxisLabel: DiagramLabel.quantityFirm.label,
    );

    paintCustomDiagramLines(
      c,
      canvas,
      label2: DiagramLabel.mc.label,
      label2Align: LabelAlign.centerTop,
      startPos: Offset(0.15, 0.65),
      bezierPoints: [
        CustomBezier(control: Offset(0.40, 1.0), endPoint: Offset(0.64, 0.10)),
      ],
    );
    paintCustomDiagramLines(
      c,
      canvas,
      label2: DiagramLabel.atc.label,
      label2Align: LabelAlign.centerTop,
      startPos: Offset(0.15, 0.20),
      bezierPoints: [
        CustomBezier(control: Offset(0.50, 0.80), endPoint: Offset(0.85, 0.20)),
      ],
    );

    paintTitle(c, canvas, 'Firm');
  }
}
