import 'dart:math';
import 'dart:ui';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_axis.dart';
import 'package:economics_app/sections/diagrams/enums/diagram_subtype.dart';
import 'package:economics_app/sections/diagrams/models/base_painter_painter.dart';
import '../../enums/label_align.dart';
import '../painter_constants.dart';
import '../painter_methods/paint_diagram_custom_lines.dart';
import '../painter_methods/paint_diagram_dash_lines.dart';

class TaxesAndSubsidies extends BaseDiagramPainter {
  TaxesAndSubsidies(super.config, super.model);

  @override
  void paint(Canvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);
    paintAxis(
      c,
      canvas,
      yAxisLabel: MicroLabel.p.label,
      xAxisLabel: MicroLabel.q.label,
    );

    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.50,
      xAxisEndPos: 0.50,
      yLabel: MicroLabel.pe.label,
      xLabel: MicroLabel.qe.label,
    );

    paintCustomDiagramLines(
      c,
      canvas,
      startPos: Offset(0.15, 0.15),
      straightEndPos: Offset(0.85, 0.85),
      label2: MicroLabel.d.label,
      label2Align: LabelAlign.centerRight,
    );
    paintCustomDiagramLines(
      c,
      canvas,
      startPos: Offset(0.85, 0.15),
      straightEndPos: Offset(0.15, 0.85),
      label1: MicroLabel.s.label,
      label1Align: LabelAlign.centerRight,
    );
    if (model.subtype == DiagramSubtype.perUnitSalesTax) {
      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(0.75, 0.05),
        straightEndPos: Offset(0.05, 0.75),
        label1: MicroLabel.sTax.label,
        label1Align: LabelAlign.centerRight,
      );
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.40,
        xAxisEndPos: 0.40,
        yLabel: MicroLabel.p1.label,
        xLabel: MicroLabel.q1.label,
      );
      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(0.62, 0.24),
        straightEndPos: Offset(0.62, 0.34),
        arrowOnStart: true,
      );
    }
    if (model.subtype == DiagramSubtype.adValoremSalesTax) {
      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(0.65, 0.05),
        straightEndPos: Offset(0.15, 0.75),
        label1: MicroLabel.sTax.label,
        label1Align: LabelAlign.centerRight,
      );
      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(0.62, 0.20),
        straightEndPos: Offset(0.62, 0.30),
        arrowOnStart: true,
      );
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.40,
        xAxisEndPos: 0.40,
        yLabel: MicroLabel.p1.label,
        xLabel: MicroLabel.q1.label,
      );
    }
  }
}
