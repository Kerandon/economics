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

class MonopolisticCompetition extends BaseDiagramPainter {
  MonopolisticCompetition({
    required DiagramPainterConfig config,
    required DiagramModel model,
  }) : super(config, model);

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
    paintCustomDiagramLines(
      c,
      canvas,
      label2: DiagramLabel.mc.label,
      label2Align: LabelAlign.centerTop,
      startPos: Offset(0.05, 0.70),
      bezierPoints: [
        CustomBezier(control: Offset(0.30, 1.1), endPoint: Offset(0.60, 0.25)),
      ],
    );

    paintCustomDiagramLines(
      c,
      canvas,
      label2: DiagramLabel.atc.label,
      label2Align: LabelAlign.centerTop,
      startPos: Offset(0.10, 0.25),
      bezierPoints: [
        CustomBezier(control: Offset(0.50, 0.76), endPoint: Offset(0.90, 0.25)),
      ],
    );
    if (model.subtype == DiagramSubtype.longRunEquilibrium ||
        model.subtype == DiagramSubtype.socialWelfare) {
      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(0.10, 0.35),
        polylineOffsets: [Offset(0.90, 0.75)],
        label2: DiagramLabel.dEqualsAR.label,
        label2Align: LabelAlign.centerRight,
      );
      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(0.10, 0.45),
        polylineOffsets: [Offset(0.60, 1.05)],
        label2: DiagramLabel.mr.label,
        label2Align: LabelAlign.centerRight,
      );
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.48,
        xAxisEndPos: 0.35,
        yLabel: DiagramLabel.p.label,
        xLabel: DiagramLabel.q.label,
      );
    }
    if (model.subtype == DiagramSubtype.longRunEquilibrium) {
      paintTitle(c, canvas, 'Monopolistic Competition - Long-Run Equilibrium');

      /// Dashed Lines
    }
    if (model.subtype == DiagramSubtype.socialWelfare) {
      paintTitle(c, canvas, 'Monopolistic Competition - Social Welfare');
      paintShading(canvas, size, ShadeType.consumerSurplus, striped: true, [
        Offset(0, 0.30),
        Offset(0.36, 0.48),
        Offset(0, 0.48),
      ]);
      paintShading(canvas, size, ShadeType.producerSurplus, striped: true, [
        Offset(0, 0.48),
        Offset(0.35, 0.48),
        Offset(0.35, 0.72),
        CustomBezier(control: Offset(0.22, 0.95), endPoint: Offset(0, 0.65)),
      ]);
      paintShading(canvas, size, ShadeType.welfareLoss, striped: true, [
        Offset(0.36, 0.48),
        Offset(0.48, 0.55),
        Offset(0.36, 0.72),
      ]);

      paintTextNormalizedWithinAxis(
        c,
        canvas,
        DiagramLabel.consumerSurplus.label,
        Offset(0.20, 0.05),
        pointerLine: Offset(0.15, 0.42),
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
        pointerLine: Offset(0.40, 0.60),
      );
    }
    if (model.subtype == DiagramSubtype.abnormalProfit) {
      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(0.10, 0.22),
        polylineOffsets: [Offset(0.95, 0.70)],
        label2: DiagramLabel.dEqualsAR.label,
        label2Align: LabelAlign.centerRight,
      );
      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(0.10, 0.35),
        polylineOffsets: [Offset(0.70, 1.05)],
        label2: DiagramLabel.mr.label,
        label2Align: LabelAlign.centerRight,
      );
      paintTitle(c, canvas, 'Monopolistic Competition - Abnormal Profit');
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.45,
        xAxisEndPos: 0.30,
        yLabel: DiagramLabel.atc.label,
        hideXLine: true,
      );
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.33,
        xAxisEndPos: 0.30,
        yLabel: DiagramLabel.p.label,
        xLabel: DiagramLabel.q.label,
      );
      paintShading(canvas, size, ShadeType.abnormalProfit, striped: true, [
        Offset(0, 0.33),
        Offset(0.30, 0.33),
        Offset(0.30, 0.45),
        Offset(0.00, 0.45),
      ]);
      paintTextNormalizedWithinAxis(
        c,
        canvas,
        DiagramLabel.abnormalProfit.label,
        Offset(0.20, 0.10),
        pointerLine: Offset(0.20, 0.38),
      );
    }
    if (model.subtype == DiagramSubtype.loss) {
      paintTitle(c, canvas, 'Monopolistic Competition - Loss');
      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(0.10, 0.45),
        polylineOffsets: [Offset(0.80, 0.85)],
        label2: DiagramLabel.dEqualsAR.label,
        label2Align: LabelAlign.centerRight,
      );
      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(0.10, 0.55),
        polylineOffsets: [Offset(0.50, 1.05)],
        label2: DiagramLabel.mr.label,
        label2Align: LabelAlign.centerRight,
      );
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.45,
        xAxisEndPos: 0.30,
        yLabel: DiagramLabel.atc.label,
        xLabel: DiagramLabel.q.label,
      );
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.57,
        xAxisEndPos: 0.30,
        yLabel: DiagramLabel.p.label,
        hideXLine: true,
      );
      paintShading(canvas, size, ShadeType.loss, striped: true, [
        Offset(0, 0.45),
        Offset(0.30, 0.45),
        Offset(0.30, 0.57),
        Offset(0.00, 0.57),
      ]);
      paintTextNormalizedWithinAxis(
        c,
        canvas,
        DiagramLabel.loss.label,
        Offset(0.20, 0.10),
        pointerLine: Offset(0.20, 0.48),
      );
    }
  }
}
