import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../enums/diagram_labels.dart';
import '../../enums/diagram_subtype.dart';
import '../../enums/label_align.dart';
import '../../models/base_painter_painter.dart';
import '../../models/custom_bezier.dart';
import '../../models/diagram_model.dart';
import '../../models/diagram_painter_config.dart';
import '../painter_methods/paint_axis.dart';
import '../painter_methods/paint_diagram_dash_lines.dart';
import '../painter_methods/paint_diagram_lines.dart';
import '../painter_methods/paint_dot.dart';

class PPCMicro extends BaseDiagramPainter {
  PPCMicro({required DiagramPainterConfig config, required DiagramModel model})
    : super(config, model);

  @override
  void paint(Canvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);
    String xLabel = DiagramLabel.phones.label;
    String yLabel = DiagramLabel.tablets.label;

    paintAxis(
      c,
      canvas,
      xAxisLabel: xLabel,
      yAxisLabel: yLabel,
      yLabelIsVertical: false,
    );

    if (model.subtype == DiagramSubtype.increasingOpportunityCost ||
        model.subtype == DiagramSubtype.productionPoints ||
        model.subtype == DiagramSubtype.actualGrowth) {
      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0, 0.20),
        bezierPoints: [
          CustomBezier(
            control: Offset(0.70, 0.35),
            endPoint: Offset(0.80, (1)),
          ),
        ],
      );

      if (model.subtype == DiagramSubtype.productionPoints) {
        paintDot(
          c,
          canvas,
          pos: Offset(0.20, 0.80),
          label: DiagramLabel.a.label,
        );
        paintDot(
          c,
          canvas,
          pos: Offset(0.39, 0.35),
          label: DiagramLabel.b.label,
        );
        paintDot(
          c,
          canvas,
          pos: Offset(0.71, 0.70),
          label: DiagramLabel.c.label,
        );
        paintDot(
          c,
          canvas,
          pos: Offset(0.80, 0.30),
          label: DiagramLabel.c.label,
        );
      }

      if (model.subtype == DiagramSubtype.increasingOpportunityCost) {
        paintDiagramDashedLines(
          c,
          canvas,
          yAxisStartPos: 0.20,
          xAxisEndPos: 0.0,
          yLabel: '100',
        );
        paintDiagramDashedLines(
          c,
          canvas,
          yAxisStartPos: 0.40,
          xAxisEndPos: 0.46,
          yLabel: '75',
          xLabel: '10',
        );
        paintDiagramDashedLines(
          c,
          canvas,
          yAxisStartPos: 0.60,
          xAxisEndPos: 0.65,
          yLabel: '50',
          xLabel: '16',
        );
        paintDiagramDashedLines(
          c,
          canvas,
          yAxisStartPos: 0.80,
          xAxisEndPos: 0.75,
          yLabel: '25',
          xLabel: '19',
        );
        paintDiagramDashedLines(
          c,
          canvas,
          yAxisStartPos: 1.0,
          xAxisEndPos: 0.82,
          xLabel: '20',
        );
        paintDot(
          c,
          canvas,
          pos: Offset(0.0, 0.20),
          label: DiagramLabel.a.label,
        );
        paintDot(
          c,
          canvas,
          pos: Offset(0.46, 0.40),
          label: DiagramLabel.b.label,
        );
        paintDot(
          c,
          canvas,
          pos: Offset(0.65, 0.60),
          label: DiagramLabel.c.label,
        );
        paintDot(
          c,
          canvas,
          pos: Offset(0.75, 0.80),
          label: DiagramLabel.d.label,
        );
        paintDot(
          c,
          canvas,
          pos: Offset(0.80, 1.00),
          label: DiagramLabel.e.label,
        );
      }
    }
    if (model.subtype == DiagramSubtype.constantOpportunityCost) {
      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0.0, 0.20),
        polylineOffsets: [Offset(0.80, 1.0)],
      );
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.20,
        xAxisEndPos: 0.0,
        hideYLine: true,
        hideXLine: true,
        yLabel: '200',
      );
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.40,
        xAxisEndPos: 0.20,
        yLabel: '150',
        xLabel: '30',
      );
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.60,
        xAxisEndPos: 0.40,
        yLabel: '100',
        xLabel: '60',
      );
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.80,
        xAxisEndPos: 0.60,
        yLabel: '50',
        xLabel: '90',
      );
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 1.00,
        xAxisEndPos: 0.80,
        hideYLine: true,
        hideXLine: true,
        xLabel: '120',
      );
      paintDot(c, canvas, pos: Offset(0.0, 0.20), label: DiagramLabel.a.label);
      paintDot(c, canvas, pos: Offset(0.20, 0.40), label: DiagramLabel.b.label);
      paintDot(c, canvas, pos: Offset(0.40, 0.60), label: DiagramLabel.c.label);
      paintDot(c, canvas, pos: Offset(0.60, 0.80), label: DiagramLabel.d.label);
      paintDot(c, canvas, pos: Offset(0.80, 1.00), label: DiagramLabel.e.label);
    }
    bool increaseInPotential = true;
    if (model.subtype == DiagramSubtype.decreaseInProductionPotential) {
      increaseInPotential = false;
    }
    if (model.subtype == DiagramSubtype.increaseInProductionPotential ||
        model.subtype == DiagramSubtype.decreaseInProductionPotential) {
      final String label1 = increaseInPotential
          ? DiagramLabel.pPC1.label
          : DiagramLabel.pPC2.label;
      final String label2 = increaseInPotential
          ? DiagramLabel.pPC2.label
          : DiagramLabel.pPC1.label;

      paintDot(c, canvas, pos: Offset(0.59, 0.70), label: label1);
      paintDot(c, canvas, pos: Offset(0.74, 0.50), label: label2);

      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0, 0.10),
        bezierPoints: [
          CustomBezier(
            control: Offset(0.85, 0.25),
            endPoint: Offset(0.90, (1.0)),
          ),
        ],
      );
      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0, 0.30),
        bezierPoints: [
          CustomBezier(
            control: Offset(0.60, 0.45),
            endPoint: Offset(0.70, (1)),
          ),
        ],
      );

      if (model.subtype == DiagramSubtype.increaseInProductionPotential ||
          model.subtype == DiagramSubtype.decreaseInProductionPotential) {
        paintDiagramLines(
          c,
          canvas,
          startPos: Offset(0.60, 0.60),
          polylineOffsets: [Offset(0.68, 0.55)],
          arrowOnStart: !increaseInPotential,
          arrowOnStartAngle: math.pi * 1.3,
          arrowOnEnd: increaseInPotential,
          arrowOnEndAngle: math.pi / 3,
        );
      }
    }
    if (model.subtype == DiagramSubtype.actualGrowth) {
      paintDot(
        c,
        canvas,
        pos: Offset(0.20, 0.70),
        label: DiagramLabel.a.label,
        labelAlign: LabelAlign.centerLeft,
      );
      paintDot(c, canvas, pos: Offset(0.40, 0.60), label: DiagramLabel.b.label);
      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0.25, 0.68),
        polylineOffsets: [Offset(0.34, 0.63)],
        arrowOnEnd: true,
        arrowOnEndAngle: math.pi / 3.5,
      );
    }
  }
}
