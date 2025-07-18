import 'package:economics_app/sections/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_axis.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_diagram_custom_lines.dart';
import 'package:economics_app/sections/diagrams/enums/diagram_subtype.dart';
import 'package:economics_app/sections/diagrams/models/diagram_painter_config.dart';
import 'package:flutter/material.dart';
import '../../enums/label_align.dart';
import '../../enums/shade_type.dart';
import '../../models/base_painter_painter.dart';
import '../../models/custom_bezier.dart';
import '../../models/diagram_model.dart';
import '../painter_methods/paint_diagram_dash_lines.dart';
import '../painter_methods/paint_shading.dart';
import '../painter_methods/paint_text_normalized_within_axis.dart';
import '../painter_methods/paint_title.dart';

class Oligopoly extends BaseDiagramPainter {
  Oligopoly({
    required DiagramPainterConfig config,
    required DiagramModel model,
  }) : super(config, model);

  @override
  void paint(Canvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);

    paintAxis(
      c,
      canvas,
      yAxisLabel: kPriceCostsRevenue,
      yLabelIsHorizontal: false,
      xAxisLabel: MicroLabel.q.label,
    );

      paintCustomDiagramLines(c, canvas,
          startPos: Offset(0.10, 0.20),
          straightEndPos: Offset(0.85, 0.85),
          label2: MicroLabel.dEqualsAR.label,
          label2Align: LabelAlign.centerRight);

      paintCustomDiagramLines(c, canvas,
          startPos: Offset(0.05, 0.25),
          straightEndPos: Offset(0.55, 1.05),
          label2: MicroLabel.mr.label,
          label2Align: LabelAlign.centerRight);
      paintCustomDiagramLines(
        c,
        canvas,
        label2: MicroLabel.mc.label,
        label2Align: LabelAlign.centerTop,
        startPos: Offset(0.10, 0.85),
        bezierPoints: [
          CustomBezier(
            control: Offset(0.40, 1.0),
            endPoint: Offset(0.55, 0.10),
          ),
        ],
      );



        paintTitle(c, canvas, 'Oligopoly - Cartel');
        paintShading(canvas, size, ShadeType.abnormalProfit, striped: true, [
          Offset(0, 0.42),
          Offset(0.35, 0.42),
          Offset(0.35, 0.57),
          Offset(0, 0.57),
        ]);
        paintTextNormalizedWithinAxis(
          c,
          canvas,
          MicroLabel.abnormalProfit.label,
          Offset(0.25, 0.05),
          pointerLine: Offset(0.25, 0.45),
        );


      /// Dashed Lines
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.42,
        xAxisEndPos: 0.355,
        yLabel: MicroLabel.p.label,
        xLabel: MicroLabel.qpi.label,
      );
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.57,
        xAxisEndPos: 0.355,
        hideXLine: true,
        yLabel: MicroLabel.atc.label,
      );

      paintCustomDiagramLines(
        c,
        canvas,
        label2: MicroLabel.atc.label,
        label2Align: LabelAlign.centerTop,
        startPos: Offset(0.05, 0.25),
        bezierPoints: [
          CustomBezier(
            control: Offset(0.40, 0.92),
            endPoint: Offset(0.85, 0.25),
          ),
        ],
      );


    if (model.subtype == DiagramSubtype.socialWelfare) {
      paintTitle(c, canvas, 'Monopoly - Social Welfare');
      paintShading(canvas, size, ShadeType.consumerSurplus, striped: true, [
        Offset(0, 0.12),
        Offset(0.36, 0.42),
        Offset(0, 0.42),
      ]);
      paintShading(canvas, size, ShadeType.producerSurplus, striped: true, [
        Offset(0, 0.42),
        Offset(0.36, 0.42),
        Offset(0.36, 0.72),
        CustomBezier(control: Offset(0.20, 1.0), endPoint: Offset(0, 0.78)),
      ]);
      paintShading(
        canvas,
        size,
        ShadeType.welfareLoss,
        striped: true,
        [
          Offset(0.36, 0.42),
          Offset(0.46, 0.50),
          Offset(0.36, 0.72),
        ],
      );
      paintTextNormalizedWithinAxis(
        c,
        canvas,
        MicroLabel.consumerSurplus.label,
        Offset(0.25, 0.05),
        pointerLine: Offset(0.20, 0.36),
      );
      paintTextNormalizedWithinAxis(
        c,
        canvas,
        MicroLabel.producerSurplus.label,
        Offset(0.10, 0.95),
        pointerLine: Offset(0.20, 0.70),
      );
      paintTextNormalizedWithinAxis(
        c,
        canvas,
        MicroLabel.welfareLoss.label,
        Offset(0.38, 0.25),
        pointerLine: Offset(0.40, 0.50),
      );
    }
  }
}
