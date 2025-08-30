import 'dart:ui';
import '../../enums/diagram_labels.dart';
import '../../enums/diagram_subtype.dart';
import '../painter_methods/axis/label_align.dart';
import '../shade/shade_type.dart';
import '../../models/base_painter_painter.dart';
import '../painter_methods/axis/paint_axis.dart';
import '../painter_methods/paint_diagram_dash_lines.dart';
import '../painter_methods/paint_diagram_lines.dart';
import '../shade/paint_shading.dart';

class TaxesAndSubsidies extends BaseDiagramPainter {
  TaxesAndSubsidies(super.config, super.model);

  @override
  void paint(Canvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);
    paintAxis(
      c,
      canvas,
      yAxisLabel: DiagramLabel.p.label,
      xAxisLabel: DiagramLabel.q.label,
    );

    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.50,
      xAxisEndPos: 0.50,
      yLabel: DiagramLabel.pe.label,
      xLabel: DiagramLabel.qe.label,
    );

    paintDiagramLines(
      c,
      canvas,
      startPos: Offset(0.15, 0.15),
      polylineOffsets: [Offset(0.85, 0.85)],
      label2: DiagramLabel.d.label,
      label2Align: LabelAlign.centerRight,
    );
    paintDiagramLines(
      c,
      canvas,
      startPos: Offset(0.85, 0.15),
      polylineOffsets: [Offset(0.15, 0.85)],
      label1: DiagramLabel.s.label,
      label1Align: LabelAlign.centerRight,
    );
    if (model.subtype == DiagramSubtype.perUnitSalesTax ||
        model.subtype == DiagramSubtype.salesTaxSocialWelfare) {
      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0.75, 0.05),
        polylineOffsets: [Offset(0.05, 0.75)],
        label1: DiagramLabel.sTax.label,
        label1Align: LabelAlign.centerRight,
      );
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.40,
        xAxisEndPos: 0.40,
        yLabel: DiagramLabel.pc.label,
        xLabel: DiagramLabel.q1.label,
      );
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.60,
        xAxisEndPos: 0.40,
        yLabel: DiagramLabel.pp.label,
        hideXLine: true,
      );
      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0.62, 0.24),
        polylineOffsets: [Offset(0.62, 0.34)],
        arrowOnStart: true,
      );
    }
    if (model.subtype == DiagramSubtype.adValoremSalesTax) {
      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0.65, 0.05),
        polylineOffsets: [Offset(0.15, 0.75)],
        label1: DiagramLabel.sTax.label,
        label1Align: LabelAlign.centerRight,
      );
      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0.62, 0.20),
        polylineOffsets: [Offset(0.62, 0.30)],
        arrowOnStart: true,
      );
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.40,
        xAxisEndPos: 0.40,
        yLabel: DiagramLabel.p1.label,
        xLabel: DiagramLabel.q1.label,
      );
    }
    if (model.subtype == DiagramSubtype.salesTaxSocialWelfare) {
      paintShading(canvas, size, ShadeType.consumerSurplus, [
        Offset(0, 0),
        Offset(0.40, 0.40),
        Offset(0, 0.40),
      ]);
      paintShading(canvas, size, ShadeType.consumerBurden, [
        Offset(0, 0.40),
        Offset(0.40, 0.40),
        Offset(0.40, 0.50),
        Offset(0.0, 0.50),
      ]);
      paintShading(canvas, size, ShadeType.producerBurden, [
        Offset(0, 0.50),
        Offset(0.40, 0.50),
        Offset(0.40, 0.60),
        Offset(0.0, 0.60),
      ]);
      paintShading(canvas, size, ShadeType.welfareLoss, [
        Offset(0.40, 0.40),
        Offset(0.50, 0.50),
        Offset(0.40, 0.60),
      ]);
      paintShading(canvas, size, ShadeType.producerSurplus, [
        Offset(0, 0.60),
        Offset(0.4, 0.60),
        Offset(0.0, 1.0),
      ]);
    }
    if (model.subtype == DiagramSubtype.subsidy ||
        model.subtype == DiagramSubtype.subsidySocialWelfare) {
      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0.90, 0.30),
        polylineOffsets: [Offset(0.30, 0.90)],

        label1: DiagramLabel.sSub.label,
        label1Align: LabelAlign.centerRight,
      );
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.60,
        xAxisEndPos: 0.60,
        yLabel: DiagramLabel.pc.label,
        xLabel: DiagramLabel.qe.label,
      );
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.70,
        xAxisEndPos: 0.50,
        hideXLine: true,
        yLabel: DiagramLabel.pc.label,
      );
    }
  }
}
