import 'package:economics_app/sections/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_axis.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_custom_bezier.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_custom_bezier_normalized.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_diagram_dash_lines.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_dot.dart';
import 'package:economics_app/sections/diagrams/enums/diagram_subtype.dart';
import 'package:economics_app/sections/diagrams/enums/label_align.dart';
import 'package:economics_app/sections/diagrams/models/custom_bezier.dart';
import 'package:flutter/material.dart';
import '../../models/base_painter_painter.dart';
import '../../models/diagram_model.dart';
import '../../models/diagram_painter_config.dart';
import '../painter_methods/paint_curve_normalized.dart';

class PPCMicro extends BaseDiagramPainter {
  PPCMicro({
    required DiagramPainterConfig config,
    required DiagramModel model,
  }) : super(config, model);

  @override
  void paint(Canvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);
    String xLabel = MicroLabel.smartPhones.label;
    String yLabel = MicroLabel.tablets.label;

    paintAxis(
      c,
      canvas,
      xAxisLabel: xLabel,
      yAxisLabel: yLabel,
      yLabelIsHorizontal: false,
    );

    if (model.subtype == DiagramSubtype.opportunityCost ||
        model.subtype == DiagramSubtype.increasingOpportunityCost ||
        model.subtype == DiagramSubtype.outputPoints
    ) {
      paintCustomBezierNormalized(
        c,
        canvas,
        startPos: Offset(0, 0.20),
        points: [
          CustomBezier(
            control: Offset(0.70, 0.35),
            endPoint: Offset(
              0.80,
              (1),
            ),
          ),
        ],
      );

      if(model.subtype == DiagramSubtype.outputPoints){
        paintDot(c, canvas,
            pos: Offset(0.30, 0.70),
            label: MacroLabel.v.label,
            labelAlign: LabelAlign.centerTop);
        paintDot(c, canvas,
            pos: Offset(0.70,0.30),
            label: MacroLabel.w.label,
            labelAlign: LabelAlign.centerTop);

        paintDot(c, canvas,
            pos: Offset(0.30, 0.30),
            label: MacroLabel.x.label,
            labelAlign: LabelAlign.centerTop);

        paintDot(c, canvas,
            pos: Offset(0.58, 0.50),
            label: MacroLabel.y.label,
            labelAlign: LabelAlign.centerRight);
        paintDot(c, canvas,
            pos: Offset(0.75, 0.80),
            label: MacroLabel.z.label,
            labelAlign: LabelAlign.centerRight);

      }

      if (model.subtype == DiagramSubtype.opportunityCost ||
          model.subtype == DiagramSubtype.increasingOpportunityCost) {
        paintDiagramDashedLines(
          c,
          canvas,
          yAxisStartPos: 0.30,
          xAxisEndPos: 0.31,
          yLabel: '150',
          xLabel: '30',
        );
        paintDiagramDashedLines(
          c,
          canvas,
          yAxisStartPos: 0.50,
          xAxisEndPos: 0.59,
          yLabel: '110',
          xLabel: '70',
        );


        paintDot(c, canvas,
            pos: Offset(0.30, 0.30),
            label: MacroLabel.x.label,
            labelAlign: LabelAlign.centerTop);
        paintDot(c, canvas,
            pos: Offset(0.58, 0.50),
            label: MacroLabel.y.label,
            labelAlign: LabelAlign.centerRight);
      }
      if (model.subtype == DiagramSubtype.increasingOpportunityCost) {

        paintDot(c, canvas,
            pos: Offset(0.75, 0.80),
            label: MacroLabel.z.label,
            labelAlign: LabelAlign.centerRight);
        paintDiagramDashedLines(
          c,
          canvas,
          yAxisStartPos: 0.80,
          xAxisEndPos: 0.75,
          yLabel: '60',
          xLabel: '80',
        );
      }
    }
    if (model.subtype == DiagramSubtype.constantOpportunityCost) {
      ;
      paintCurveNormalized(c, canvas, Offset(0.0, 0.20), Offset(0.80, 1.0),);
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
      paintDot(c, canvas,
          pos: Offset(0.20, 0.40),
          label: MacroLabel.x.label, labelAlign: LabelAlign.centerTop);
      paintDot(c, canvas,
          pos: Offset(0.40, 0.60),
          label: MacroLabel.y.label, labelAlign: LabelAlign.centerTop);
      paintDot(c, canvas,
          pos: Offset(0.60, 0.80),
          label: MacroLabel.z.label, labelAlign: LabelAlign.centerTop);
    }
  }
}
