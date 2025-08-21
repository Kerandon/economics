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
import '../painter_methods/paint_diagram_dash_lines.dart';
import '../painter_methods/paint_diagram_lines.dart';
import '../painter_methods/paint_shading.dart';
import '../painter_methods/paint_text_normalized_within_axis.dart';
import '../painter_methods/paint_title.dart';

class Monopoly extends BaseDiagramPainter {
  Monopoly({required DiagramPainterConfig config, required DiagramModel model})
    : super(config, model);

  @override
  void paint(Canvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);

    paintAxis(
      c,
      canvas,
      yAxisLabel: DiagramLabel.priceCostsRevenue.label,
      yLabelIsVertical: false,
      xAxisLabel: DiagramLabel.quantity.label,
    );

    if (model.subtype == DiagramSubtype.abnormalProfit ||
        model.subtype == DiagramSubtype.loss ||
        model.subtype == DiagramSubtype.socialWelfare) {
      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0.10, 0.20),
        polylineOffsets: [Offset(0.85, 0.85)],
        label2: DiagramLabel.dEqualsAR.label,
        label2Align: LabelAlign.centerRight,
      );

      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0.05, 0.25),
        polylineOffsets: [Offset(0.55, 1.05)],
        label2: DiagramLabel.mr.label,
        label2Align: LabelAlign.centerRight,
      );
      paintDiagramLines(
        c,
        canvas,
        label2: DiagramLabel.mc.label,
        label2Align: LabelAlign.centerTop,
        startPos: Offset(0.10, 0.85),
        bezierPoints: [
          CustomBezier(
            control: Offset(0.40, 1.0),
            endPoint: Offset(0.55, 0.10),
          ),
        ],
      );
    }
    if (model.subtype == DiagramSubtype.abnormalProfit ||
        model.subtype == DiagramSubtype.socialWelfare) {
      if (model.subtype == DiagramSubtype.abnormalProfit) {
        paintTitle(c, canvas, 'Monopoly - Abnormal Profits');
        paintShading(canvas, size, ShadeType.abnormalProfit, striped: true, [
          Offset(0, 0.42),
          Offset(0.35, 0.42),
          Offset(0.35, 0.57),
          Offset(0, 0.57),
        ]);
        paintTextNormalizedWithinAxis(
          c,
          canvas,
          DiagramLabel.abnormalProfit.label,
          Offset(0.25, 0.05),
          pointerLine: Offset(0.25, 0.45),
        );
      }

      /// Dashed Lines
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.42,
        xAxisEndPos: 0.355,
        yLabel: DiagramLabel.p.label,
        xLabel: DiagramLabel.q.label,
      );
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.57,
        xAxisEndPos: 0.355,
        hideXLine: true,
        yLabel: DiagramLabel.atc.label,
      );

      paintDiagramLines(
        c,
        canvas,
        label2: DiagramLabel.atc.label,
        label2Align: LabelAlign.centerTop,
        startPos: Offset(0.05, 0.25),
        bezierPoints: [
          CustomBezier(
            control: Offset(0.40, 0.92),
            endPoint: Offset(0.85, 0.25),
          ),
        ],
      );
    }

    if (model.subtype == DiagramSubtype.loss) {
      paintTitle(c, canvas, 'Monopoly - Losses');

      /// Dashed Lines
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.41,
        xAxisEndPos: 0.355,
        hideXLine: true,
        yLabel: DiagramLabel.p.label,
      );
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.32,
        xAxisEndPos: 0.36,
        yLabel: DiagramLabel.atc.label,
        xLabel: DiagramLabel.q.label,
      );

      paintShading(canvas, size, ShadeType.loss, striped: true, [
        Offset(0, 0.32),
        Offset(0.36, 0.32),
        Offset(0.36, 0.41),
        Offset(0, 0.41),
      ]);
      paintDiagramLines(
        c,
        canvas,
        label2: DiagramLabel.atc.label,
        label2Align: LabelAlign.centerTop,
        startPos: Offset(0.10, 0.10),
        bezierPoints: [
          CustomBezier(
            control: Offset(0.50, 0.60),
            endPoint: Offset(0.90, 0.10),
          ),
        ],
      );
      paintTextNormalizedWithinAxis(
        c,
        canvas,
        DiagramLabel.loss.label,
        Offset(0.20, 0.05),
        pointerLine: Offset(0.20, 0.36),
      );
    }

    if (model.subtype == DiagramSubtype.naturalMonopoly) {
      paintTitle(c, canvas, 'Natural Monopoly');
      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0.05, 0.35),
        bezierPoints: [
          CustomBezier(
            control: Offset(0.50, 0.80),
            endPoint: Offset(0.90, 0.70),
          ),
        ],
        label2: DiagramLabel.lrac.label,
        label2Align: LabelAlign.centerRight,
      );

      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0.20, 0.20),
        polylineOffsets: [Offset(0.70, 0.90)],
        label2: DiagramLabel.dEqualsAR.label,
        label2Align: LabelAlign.centerRight,
      );
    }
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
      paintShading(canvas, size, ShadeType.welfareLoss, striped: true, [
        Offset(0.36, 0.42),
        Offset(0.46, 0.50),
        Offset(0.36, 0.72),
      ]);
      paintTextNormalizedWithinAxis(
        c,
        canvas,
        DiagramLabel.consumerSurplus.label,
        Offset(0.25, 0.05),
        pointerLine: Offset(0.20, 0.36),
      );
      paintTextNormalizedWithinAxis(
        c,
        canvas,
        DiagramLabel.producerSurplus.label,
        Offset(0.10, 0.95),
        pointerLine: Offset(0.20, 0.70),
      );
      paintTextNormalizedWithinAxis(
        c,
        canvas,
        DiagramLabel.welfareLoss.label,
        Offset(0.38, 0.25),
        pointerLine: Offset(0.40, 0.50),
      );
    }
  }
}
