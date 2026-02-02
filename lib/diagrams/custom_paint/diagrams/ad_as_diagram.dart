import 'package:economics_app/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/paint_axis.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/diagram_lines/paint_diagram_lines.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_diagram_dash_lines.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/shortcut_methods/paint_market_curve.dart';
import 'package:economics_app/diagrams/enums/diagram_enum.dart';
import 'package:economics_app/diagrams/enums/diagram_labels.dart';
import 'package:flutter/material.dart';
import '../../models/base_painter_painter.dart';
import '../../models/diagram_painter_config.dart';
import '../i_diagram_canvas.dart';

class ADASDiagram extends BaseDiagramPainter {
  ADASDiagram(super.config, super.diagram);

  @override
  void drawDiagram(IDiagramCanvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);
    paintAxis(
      c,
      canvas,
      yAxisLabel: DiagramLabel.priceLevel.label,
      xAxisLabel: DiagramLabel.realGDP.label,
    );
    switch (diagram) {
      case DiagramEnum.macroADASClassicalFullEmployment:
      case DiagramEnum.macroADASClassicalDeflationaryGap:
      case DiagramEnum.macroADASClassicalInflationaryGap:
        _paintClassicalADAS(c, canvas, diagram);
      case DiagramEnum.macroADASKeynesianFullEmployment:
      case DiagramEnum.macroADASKeynesianInflationaryGap:
      case DiagramEnum.macroADASKeynesianDeflationaryGap:
        _paintKeynesianADAS(c, canvas, diagram);
      default:
    }
  }
}

void _paintClassicalADAS(
  DiagramPainterConfig c,
  IDiagramCanvas canvas,
  DiagramEnum diagram,
) {
  paintMarketCurve(c, canvas, type: MarketCurveType.lras);
  if (diagram == DiagramEnum.macroADASClassicalFullEmployment) {
    paintMarketCurve(c, canvas, type: MarketCurveType.ad);
    paintMarketCurve(c, canvas, type: MarketCurveType.sras);
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.50,
      xAxisEndPos: 0.50,
      showDotAtIntersection: true,
      yLabel: DiagramLabel.pL.label,
      hideXLine: true,
    );
  }
  if (diagram == DiagramEnum.macroADASClassicalDeflationaryGap) {
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.ad,
      horizontalShift: -0.10,
      verticalShift: 0.10,
    );
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.sras,
      horizontalShift: -0.10,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.55,
      xAxisEndPos: 0.35,
      showDotAtIntersection: true,
      yLabel: DiagramLabel.pL.label,
      xLabel: DiagramLabel.pLe.label,
    );
  }
  if (diagram == DiagramEnum.macroADASClassicalInflationaryGap) {
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.ad,
      horizontalShift: 0.15,
      verticalShift: 0,
    );
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.sras,
      horizontalShift: 0.10,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.475,
      xAxisEndPos: 0.625,
      showDotAtIntersection: true,
      yLabel: DiagramLabel.pL.label,
      xLabel: DiagramLabel.pLe.label,
    );
  }
}

void _paintKeynesianADAS(
  DiagramPainterConfig c,
  IDiagramCanvas canvas,
  DiagramEnum diagram,
) {
  if (diagram == DiagramEnum.macroADASKeynesianFullEmployment) {
    paintMarketCurve(c, canvas, type: MarketCurveType.ad);
    paintMarketCurve(c, canvas, type: MarketCurveType.keynesianAS);
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.74,
      xAxisEndPos: 0.74,
      yLabel: DiagramLabel.pLf.label,
      xLabel: DiagramLabel.yF.label,
      showDotAtIntersection: true,
    );
  }
  if (diagram == DiagramEnum.macroADASKeynesianDeflationaryGap) {
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.ad,
      horizontalShift: -0.20,
      verticalShift: 0.10,

      lengthAdjustment: -0.15,
      angle: 0.15,
    );
    paintMarketCurve(c, canvas, type: MarketCurveType.keynesianAS);
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.80,
      xAxisEndPos: 0.45,
      yLabel: DiagramLabel.pLf.label,
      xLabel: DiagramLabel.yF.label,
      showDotAtIntersection: true,
    );
  }
  if (diagram == DiagramEnum.macroADASKeynesianInflationaryGap) {
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.ad,
      horizontalShift: 0.20,
      verticalShift: -0.02,

      lengthAdjustment: -0.15,
      angle: 0.15,
    );
    paintMarketCurve(c, canvas, type: MarketCurveType.keynesianAS);
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.62,
      xAxisEndPos: 0.80,
      yLabel: DiagramLabel.plInF.label,
      xLabel: DiagramLabel.yInf.label,
      showDotAtIntersection: true,
    );
  }
}
