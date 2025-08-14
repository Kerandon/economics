import 'dart:math';

import 'package:flutter/material.dart';

import '../../enums/diagram_labels.dart';
import '../../enums/diagram_subtype.dart';
import '../../enums/label_align.dart';
import '../../models/base_painter_painter.dart';
import '../../models/diagram_model.dart';
import '../../models/diagram_painter_config.dart';
import '../painter_methods/paint_axis.dart';
import '../painter_methods/paint_diagram_custom_lines.dart';
import '../painter_methods/paint_diagram_dash_lines.dart';

class Demand extends BaseDiagramPainter {
  Demand({
    required DiagramPainterConfig config,
    required DiagramModel model,
  }) : super(config, model);

  @override
  void paint(Canvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);

    var demandLabel = DiagramLabel.demand.label;
    if(model.subtype == DiagramSubtype.determinants){
      demandLabel = DiagramLabel.d1.label;
    }

    paintAxis(
      c,
      canvas,
      yAxisLabel: DiagramLabel.p.label,
      xAxisLabel: DiagramLabel.q.label,
    );


      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(0.20, 0.20),
        polylineOffsets: [
          Offset(0.80, 0.80),
        ],
        label2: demandLabel,
        label2Align: LabelAlign.centerRight,
      );



    if (model.subtype == DiagramSubtype.determinants) {
      paintDiagramDashedLines(c, canvas, yAxisStartPos: 0.50, xAxisEndPos: 0.30,
          yLabel: DiagramLabel.p.label,
        xLabel: DiagramLabel.q1.label,hideYLine:true);

      paintDiagramDashedLines(c, canvas, yAxisStartPos: 0.50, xAxisEndPos: 0.50,
        yLabel: DiagramLabel.p.label,
      xLabel: DiagramLabel.q2.label,hideYLine:true);
      paintDiagramDashedLines(c, canvas, yAxisStartPos: 0.50, xAxisEndPos: 0.70,
        yLabel: DiagramLabel.p.label,
        xLabel: DiagramLabel.q3.label,);
      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(0.10, 0.30),
        polylineOffsets: [
          Offset(0.70, 0.90),
        ],
        label2: DiagramLabel.d3.label,
        label2Align: LabelAlign.centerRight,
      );
      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(0.30, 0.10),
        polylineOffsets: [
          Offset(0.90, 0.70),
        ],
        label2: DiagramLabel.d2.label,
        label2Align: LabelAlign.centerRight,
      );

      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(0.36, 0.40),
        polylineOffsets: [
          Offset(0.28, 0.40),
        ],
        arrowOnEnd: true,
        arrowOnEndAngle: pi * 1.5,
      );
      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(0.46, 0.40),
        polylineOffsets: [
          Offset(0.54, 0.40),
        ],
        arrowOnEnd: true,
        arrowOnEndAngle: pi * 0.5,
      );

    }

  }
}
