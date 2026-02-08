import 'package:economics_app/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/paint_axis.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/diagram_lines/paint_diagram_lines.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_diagram_dash_lines.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_legend_table.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_text.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/shortcut_methods/paint_description.dart';
import 'package:economics_app/diagrams/enums/diagram_enum.dart';
import 'package:economics_app/diagrams/enums/diagram_labels.dart';
import 'package:flutter/material.dart';

import '../../models/base_painter_painter.dart';
import '../../models/diagram_painter_config.dart';
import '../i_diagram_canvas.dart';
class ComparativeAdvantageDiagram extends BaseDiagramPainter {
  ComparativeAdvantageDiagram(super.config, super.diagram);

  @override
  void drawDiagram(IDiagramCanvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);
    paintAxis(
      c,
      canvas,
      yAxisLabel: DiagramLabel.wineBottles.label,
      xAxisLabel: DiagramLabel.cheeseKG.label,
    );

    switch (diagram) {
      case DiagramEnum.globalAbsoluteAdvantageDifferentGoods:
        _paintAbsoluteAdvantage(c, canvas);
        break;
      case DiagramEnum.globalComparativeAdvantage:
        _paintComparativeAdvantage(c, canvas);
        break;
      case DiagramEnum.globalNoComparativeAdvantage:
        _paintNoComparativeAdvantage(c, canvas);
        break;
      default:
        break;
    }
  }

  // --- New Diagram: No Comparative Advantage (Parallel Lines) ---
  void _paintNoComparativeAdvantage(DiagramPainterConfig c, IDiagramCanvas canvas) {
    // Slopes must be equal for parallel lines.
    // France: (1.0 - 0.20) / 0.80 = 1.0
    // Germany: (1.0 - 0.60) / 0.40 = 1.0

    _paintCountryPPC(c, canvas,
        yPoint: 0.20, xPoint: 0.80, label: 'France');

    _paintCountryPPC(c, canvas,
        yPoint: 0.60, xPoint: 0.40, label: 'Germany', color: Colors.blue);

    paintDescription(c, canvas, '''Parallel PPCs indicate same opportunity costs. Neither country has a Comparative Advantage. No benefit to trade''');
  }

  // --- Existing Diagrams (Refactored) ---
  void _paintComparativeAdvantage(DiagramPainterConfig c, IDiagramCanvas canvas) {
    _paintCountryPPC(c, canvas,
        yPoint: 0.20, xPoint: 0.80, label: 'France');

    _paintCountryPPC(c, canvas,
        yPoint: 0.40, xPoint: 0.30, label: 'Germany', color: Colors.blue);

    paintLegendTable(
      canvas,
      c,
      headers: [
        '',
        DiagramLabel.wineBottles.label,
        DiagramLabel.cheeseKG.label,
      ],
      data: [
        ['France', '(80/8)=8', '(8/80)=0.10 (CA)'],
        ['Germany', '(30/6)=5 (CA)', '(6/30)=0.20'],
      ],
    );

    paintText(
        c,
        canvas,
        '''Steeper PPC 
     has a CA in the good 
     on vertical axis
     (e.g., Germany in Wine)''',
        Offset(0.45, 0.20),
        pointerLine: Offset(0.10, 0.60));

    paintText(
        c,
        canvas,
        '''Flatter PPC 
     has a CA in the good 
     on horizontal axis
     (e.g., France in Cheese)''',
        Offset(0.85, 0.60),
        pointerLine: Offset(0.70, 0.90));
  }

  void _paintAbsoluteAdvantage(DiagramPainterConfig c, IDiagramCanvas canvas) {
    _paintCountryPPC(c, canvas,
        yPoint: 0.50, xPoint: 0.80, label: 'France');

    _paintCountryPPC(c, canvas,
        yPoint: 0.20, xPoint: 0.50, label: 'Germany', color: Colors.blue);

    paintDescription(c, canvas, '''When PPCs cross each country has an Absolute Advantage (AA) in one good each. E.g., Germany AA is in wine, France AA is in Cheese.''');
  }

  // --- Helper for Tidying Up ---
  void _paintCountryPPC(
      DiagramPainterConfig c,
      IDiagramCanvas canvas, {
        required double yPoint,
        required double xPoint,
        required String label,
        Color color = Colors.black,
      }) {
    paintDiagramLines(
      c,
      canvas,
      startPos: Offset(0.0, yPoint),
      polylineOffsets: [Offset(xPoint, 1.0)],
      middleLabel: label,
      middleLabelAlign: LabelAlign.centerRight,
      color: color,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: yPoint,
      xAxisEndPos: xPoint,
      hideXLine: true,
      hideYLine: true,
      yLabel: ((1 - yPoint) * 10).toInt().toString(),
      xLabel: (xPoint * 100).toInt().toString(),
    );
  }
}