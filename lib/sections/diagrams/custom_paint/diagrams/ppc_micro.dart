import 'package:economics_app/sections/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_axis.dart';
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
        model.subtype == DiagramSubtype.outputPoints) {
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

      if (model.subtype == DiagramSubtype.outputPoints) {
        paintDot(c, canvas,
            pos: Offset(0.30, 0.70),
            label: MacroLabel.v.label,
            labelAlign: LabelAlign.centerTop);
        paintDot(c, canvas,
            pos: Offset(0.70, 0.30),
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
          yAxisStartPos: 0.40,
          xAxisEndPos: 0.46,
          yLabel: '150',
          xLabel: '70',
        );
        paintDiagramDashedLines(
          c,
          canvas,
          yAxisStartPos: 0.60,
          xAxisEndPos: 0.66,
          yLabel: '100',
          xLabel: '100',
        );

        paintDot(c, canvas,
            pos: Offset(0.45, 0.40),
            label: MacroLabel.x.label,
            labelAlign: LabelAlign.centerTop);
        paintDot(c, canvas,
            pos: Offset(0.65, 0.60),
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
          yLabel: '50',
          xLabel: '110',
        );
      }
    }
    if (model.subtype == DiagramSubtype.constantOpportunityCost) {

      paintCurveNormalized(
        c,
        canvas,
        Offset(0.0, 0.20),
        Offset(0.80, 1.0),
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
      paintDot(c, canvas,
          pos: Offset(0.20, 0.40),
          label: MacroLabel.x.label,
          labelAlign: LabelAlign.centerTop);
      paintDot(c, canvas,
          pos: Offset(0.40, 0.60),
          label: MacroLabel.y.label,
          labelAlign: LabelAlign.centerTop);
      paintDot(c, canvas,
          pos: Offset(0.60, 0.80),
          label: MacroLabel.z.label,
          labelAlign: LabelAlign.centerTop);
    }
    if (model.subtype == DiagramSubtype.increaseInPotentialOutput ||
        model.subtype == DiagramSubtype.decreaseInPotentialOutput ||
        model.subtype == DiagramSubtype.growth) {
      final increase =
          model.subtype == DiagramSubtype.increaseInPotentialOutput;
      paintCustomBezierNormalized(
        c,
        canvas,
        startPos: Offset(0, 0.10),
        points: [
          CustomBezier(
            control: Offset(0.85, 0.25),
            endPoint: Offset(
              0.90,
              (1.0),
            ),
          ),
        ],
      );
      paintCustomBezierNormalized(
        c,
        canvas,
        startPos: Offset(0, 0.30),
        points: [
          CustomBezier(
            control: Offset(0.60, 0.45),
            endPoint: Offset(
              0.70,
              (1),
            ),
          ),
        ],
      );
      if (model.subtype == DiagramSubtype.increaseInPotentialOutput ||
          model.subtype == DiagramSubtype.decreaseInPotentialOutput) {
        paintCurveNormalized(c, canvas, Offset(0.35, 0.40), Offset(0.45, 0.30),
            arrowAtEnd: increase, arrowAtStart: !increase);
        paintCurveNormalized(c, canvas, Offset(0.65, 0.70), Offset(0.78, 0.70),
            arrowAtEnd: increase, arrowAtStart: !increase);
        paintDot(c, canvas,
            pos: Offset(0.48, 0.55),
            label: increase ? 'PPC 1' : 'PPC 2',
            labelAlign: LabelAlign.centerRight);
        paintDot(c, canvas,
            pos: Offset(0.75, 0.52),
            label: increase ? 'PPC 2' : 'PPC 1',
            labelAlign: LabelAlign.centerRight);
      }
    }
    if (model.subtype == DiagramSubtype.growth) {
      paintCurveNormalized(c, canvas, Offset(0.35, 0.40), Offset(0.45, 0.30),
          arrowAtEnd: true);
      paintCurveNormalized(c, canvas, Offset(0.65, 0.70), Offset(0.78, 0.70),
          arrowAtEnd: true);
      paintCurveNormalized(c, canvas, Offset(0.24, 0.77), Offset(0.35, 0.72),
          arrowAtEnd: true);
      paintDot(c, canvas,
          pos: Offset(0.15, 0.80),
          label: MacroLabel.w.label,
          labelAlign: LabelAlign.centerRight);
      paintDot(c, canvas,
          pos: Offset(0.40, 0.70),
          label: MacroLabel.x.label,
          labelAlign: LabelAlign.centerRight);
      paintDot(c, canvas,
          pos: Offset(0.52, 0.60),
          label: MacroLabel.y.label,
          labelAlign: LabelAlign.centerRight);
      paintDot(c, canvas,
          pos: Offset(0.73, 0.50),
          label: MacroLabel.z.label,
          labelAlign: LabelAlign.centerRight);
    }
  }
}
