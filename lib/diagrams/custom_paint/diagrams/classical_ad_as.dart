import 'package:flutter/material.dart';
import '../../enums/diagram_labels.dart';
import '../../enums/diagram_subtype.dart';
import '../../enums/diagram_title.dart';
import '../../enums/label_align.dart';
import '../../models/base_painter_painter.dart';
import '../../models/custom_bezier.dart';
import '../../models/diagram_model.dart';
import '../../models/diagram_painter_config.dart';
import '../painter_methods/paint_axis.dart';

import '../painter_methods/paint_diagram_dash_lines.dart';
import '../painter_methods/paint_diagram_lines.dart';
import '../painter_methods/paint_title.dart';

class ClassicalADAS extends BaseDiagramPainter {
  ClassicalADAS({
    required DiagramPainterConfig config,
    required DiagramModel model,
  }) : super(config, model);

  @override
  void paint(Canvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);

    paintAxis(
      c,
      canvas,
      yAxisLabel: DiagramLabel.priceLevel.label,
      xAxisLabel: DiagramLabel.realGDP.label,
    );

    if (model.subtype == DiagramSubtype.sras ||
        model.subtype == DiagramSubtype.increase) {
      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0.15, 0.85),
        polylineOffsets: [Offset(0.85, 0.15)],
        label2: DiagramLabel.sRAS.label,
        label2Align: LabelAlign.centerRight,
      );
    }
    if (model.subtype == DiagramSubtype.increase) {
      paintTitle(c, canvas, DiagramTitle.keynesianModel.title());
      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0.35, 0.85),
        polylineOffsets: [Offset(0.85, 0.15)],
        label2: DiagramLabel.sRAS.label,
        label2Align: LabelAlign.centerRight,
      );
    }

    if (model.subtype == DiagramSubtype.fullEmploymentClassical ||
        model.subtype == DiagramSubtype.fullEmploymentKeynesian) {
      var aDLabel = DiagramLabel.aggregateDemand.label;

      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0.15, 0.15),
        polylineOffsets: [Offset(0.85, 0.85)],
        label2: aDLabel,
        label2Align: LabelAlign.centerRight,
      );
    }
    if (model.subtype == DiagramSubtype.fullEmploymentClassical) {
      paintTitle(c, canvas, DiagramTitle.monetaristNewClassicalModel.title());
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.50,
        xAxisEndPos: 0.50,
        yLabel: DiagramLabel.pL.label,
        xLabel: DiagramLabel.yF.label,
      );

      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0.15, 0.85),
        polylineOffsets: [Offset(0.85, 0.15)],
        label2: DiagramLabel.sRAS.label,
        label2Align: LabelAlign.centerRight,
      );
    }

    if (model.subtype == DiagramSubtype.keynesianAggregateSupply) {
      paintKeynesianAS(c, canvas);
    }

    if (model.subtype == DiagramSubtype.fullEmploymentKeynesian) {
      paintTitle(c, canvas, DiagramTitle.keynesianModel.title());
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.72,
        xAxisEndPos: 0.73,
        yLabel: DiagramLabel.pL.label,
        xLabel: DiagramLabel.yF.label,
      );
    }

    if (model.subtype == DiagramSubtype.inflationaryGapKeynesian) {
      paintTitle(c, canvas, DiagramTitle.keynesianModel.title());
      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0.55, 0.10),
        polylineOffsets: [Offset(1.0, 0.80)],
        label2: DiagramLabel.aD.label,
        label2Align: LabelAlign.centerRight,
      );
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.56,
        xAxisEndPos: 0.84,
        yLabel: DiagramLabel.pL.label,
        xLabel: DiagramLabel.yInf.label,
      );
    }

    if (model.subtype == DiagramSubtype.deflationaryGapKeynesian) {
      paintTitle(c, canvas, DiagramTitle.keynesianModel.title());
      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0.15, 0.15),
        polylineOffsets: [Offset(0.60, 0.900)],
        label2: DiagramLabel.aD.label,
        label2Align: LabelAlign.centerRight,
      );
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.75,
        xAxisEndPos: 0.51,
        yLabel: DiagramLabel.pL.label,
        xLabel: DiagramLabel.yDef.label,
      );
    }
    if (model.subtype == DiagramSubtype.fullEmploymentKeynesian ||
        model.subtype == DiagramSubtype.deflationaryGapKeynesian ||
        model.subtype == DiagramSubtype.inflationaryGapKeynesian) {
      paintKeynesianAS(c, canvas);
    }
    if (model.subtype == DiagramSubtype.fullEmploymentClassical ||
        model.subtype == DiagramSubtype.inflationaryGapClassical ||
        model.subtype == DiagramSubtype.deflationaryGapClassical) {
      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0.50, 0.05),
        polylineOffsets: [Offset(0.50, 1.0)],
        label1: DiagramLabel.lRAS.label,
        label1Align: LabelAlign.centerTop,
      );
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 1,
        xAxisEndPos: 0.5,
        hideYLine: true,
        hideXLine: true,
        xLabel: DiagramLabel.yF.label,
      );
    }

    /// Classical Deflationary Gap

    if (model.subtype == DiagramSubtype.deflationaryGapClassical) {
      paintTitle(c, canvas, DiagramTitle.monetaristNewClassicalModel.title());
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.55,
        xAxisEndPos: 0.37,
        yLabel: DiagramLabel.pL.label,
        xLabel: DiagramLabel.yDef.label,
      );
      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0.05, 0.25),
        polylineOffsets: [Offset(0.70, 0.85)],
        label2: DiagramLabel.aD.label,
        label2Align: LabelAlign.centerRight,
      );
      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0.05, 0.85),
        polylineOffsets: [Offset(0.70, 0.25)],
        label2: DiagramLabel.sRAS.label,
        label2Align: LabelAlign.centerRight,
      );
    }

    /// Classical inflationary Gap

    if (model.subtype == DiagramSubtype.inflationaryGapClassical) {
      paintTitle(c, canvas, DiagramTitle.monetaristNewClassicalModel.title());
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.55,
        xAxisEndPos: 0.63,
        yLabel: DiagramLabel.pL.label,
        xLabel: DiagramLabel.yInf.label,
      );
      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0.35, 0.25),
        polylineOffsets: [Offset(0.90, 0.85)],
        label2: DiagramLabel.aD.label,
        label2Align: LabelAlign.centerRight,
      );
      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0.35, 0.85),
        polylineOffsets: [Offset(0.90, 0.25)],
        label2: DiagramLabel.sRAS.label,
        label2Align: LabelAlign.centerRight,
      );
    }
  }
}

paintKeynesianAS(DiagramPainterConfig c, Canvas canvas) {
  paintDiagramLines(
    c,
    canvas,
    startPos: Offset(0.10, 0.75),
    bezierPoints: [
      CustomBezier(endPoint: Offset(0.65, 0.75)),
      CustomBezier(control: Offset(0.85, 0.70), endPoint: Offset(0.85, 0.50)),
      CustomBezier(endPoint: Offset(0.85, 0.15)),
    ],
    label2: DiagramLabel.keynesianAS.label,
    label2Align: LabelAlign.centerTop,
  );
}
