import 'dart:math';

import 'package:economics_app/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/paint_axis.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/diagram_lines/paint_diagram_lines.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_legend_table.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_line_segment.dart';
import 'package:economics_app/diagrams/enums/diagram_enum.dart';
import 'package:economics_app/diagrams/enums/diagram_labels.dart';
import 'package:economics_app/diagrams/models/custom_bezier.dart';
import 'package:economics_app/diagrams/models/diagram_painter_config.dart';
import 'package:flutter/material.dart';
import '../../models/base_painter_painter.dart';
import '../i_diagram_canvas.dart';
import '../painter_methods/paint_text.dart';
import '../shade/paint_shading.dart';
import '../shade/shade_type.dart';

class BizDiagram extends BaseDiagramPainter {
  BizDiagram(super.config, super.diagram);

  @override
  void drawDiagram(IDiagramCanvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);

    // 1. Draw Axes
    paintAxis(
      c,
      canvas,
      yAxisLabel: DiagramLabel.realGDP.label,
      xAxisLabel: DiagramLabel.timeYears.label,
    );

    switch (diagram) {
      case DiagramEnum.macroBusinessCycle:
        _paintBusinessCycleStandard(c, canvas);
      case DiagramEnum.macroBusinessCycleNRU:
        _paintBusinessCycleNRU(c, canvas);
      case DiagramEnum.macroBusinessCycleIncreaseInPotentialGDP:
        _paintBusinessCycleIncreasePotentialGDP(c, canvas);
      case DiagramEnum.macroBusinessCycleStabilizationPolicies:
        _paintBusinessCycleStabilization(c, canvas);
      default:
    }
  }
}

void _paintBusinessCycleStandard(
  DiagramPainterConfig c,
  IDiagramCanvas canvas,
) {
  // --- 2. SHADING ---
  // A. Inflationary Gap (The Peak)
  paintShading(c, canvas, ShadeType.loss, [
    Offset(0.0, 0.70),
    CustomBezier(control: Offset(0.12, 0.50), endPoint: Offset(0.25, 0.55)),
    CustomBezier(control: Offset(0.30, 0.60), endPoint: Offset(0.34, 0.59)),
  ], invertStripes: false);

  // B. Deflationary Gap (The Trough)
  paintShading(c, canvas, ShadeType.loss, [
    Offset(0.34, 0.59),
    CustomBezier(control: Offset(0.38, 0.65), endPoint: Offset(0.50, 0.62)),
    CustomBezier(control: Offset(0.58, 0.60), endPoint: Offset(0.65, 0.49)),
  ], invertStripes: true);

  // --- 3. LINES ---
  // Real GDP (Oscillating Business Cycle)
  paintDiagramLines(
    c,
    canvas,
    startPos: Offset(0.0, 0.70),
    bezierPoints: [
      CustomBezier(control: Offset(0.12, 0.50), endPoint: Offset(0.25, 0.55)),
      CustomBezier(control: Offset(0.38, 0.65), endPoint: Offset(0.50, 0.62)),
      CustomBezier(control: Offset(0.60, 0.60), endPoint: Offset(0.70, 0.40)),
      CustomBezier(control: Offset(0.80, 0.28), endPoint: Offset(0.95, 0.48)),
    ],
    color: c.colorScheme.primary,
    strokeWidth: 3.0,
    label2: DiagramLabel.realGDP.label,
    label2Align: LabelAlign.right,
    arrowOnEnd: true,
  );

  // --- 4. PHASE LABELS ---
  // Brought the label text Offsets much closer to the pointerLine target

  // Peak
  paintText(
    c,
    canvas,
    '1',
    Offset(0.15, 0.50), // Moved closer
    pointerLine: Offset(0.15, 0.55),
    shape: DiagramShape.none,
  );

  // Contraction
  paintText(
    c,
    canvas,
    '2',
    Offset(0.36, 0.65), // Moved closer
    pointerLine: Offset(0.36, 0.61),
  );

  // Trough
  paintText(
    c,
    canvas,
    '3',
    Offset(0.50, 0.68), // Moved closer
    pointerLine: Offset(0.50, 0.62),
  );

  // Expansion
  paintText(
    c,
    canvas,
    '4',
    Offset(0.65, 0.40), // Moved closer
    pointerLine: Offset(0.68, 0.43),
    shape: DiagramShape.none,
  );

  // Gap Labels (Removed hardcoded colors, moved closer to gaps)
  paintText(
    c,
    canvas,
    DiagramLabel.inflationaryGap.label,
    Offset(0.20, 0.40),
    pointerLine: Offset(0.20, 0.55),
    type: DiagramTextType.label,
    shape: DiagramShape.none,
  );

  paintText(
    c,
    canvas,
    DiagramLabel.deflationaryGap.label,
    Offset(0.55, 0.75),
    pointerLine: Offset(0.55, 0.56),
    type: DiagramTextType.label,
    shape: DiagramShape.none,
  );
  paintLegendTable(
    canvas,
    c,
    headers: ['', 'Stage'],
    data: [
      ['1', 'Peak'],
      ['2', 'Contraction'],
      ['3', 'Trough'],
      ['4', 'Expansion'],
    ],
  );
}

void _paintBusinessCycleNRU(DiagramPainterConfig c, IDiagramCanvas canvas) {
  _paintTrendLine(c, canvas);
  // --- 2. SHADING ---
  // A. Inflationary Gap (The P
  paintDiagramLines(
    c,
    canvas,
    startPos: Offset(0.0, 0.70),
    bezierPoints: [
      // --- Cycle 1 ---
      // Crest 1 (Pulls UP)
      CustomBezier(
        control: Offset(0.125, 0.325),
        endPoint: Offset(0.250, 0.550),
      ),
      // Trough 1 (Pulls DOWN - exaggerated as you had it)
      CustomBezier(
        control: Offset(0.400, 1.100),
        endPoint: Offset(0.550, 0.500),
      ),

      // --- Cycle 2 ---
      // Crest 2 (Pulls UP)
      CustomBezier(
        control: Offset(0.625, 0.225),
        endPoint: Offset(0.700, 0.450),
      ),
      // Trough 2 (Pulls DOWN, then sweeps high UP)
      CustomBezier(
        control: Offset(0.875, 0.775),
        endPoint: Offset(0.9000, 0.2500), // Changed from 0.400 to 0.100
      ),
    ],
    color: c.colorScheme.primary,
    strokeWidth: 3.0,
    label2: DiagramLabel.realGDP.label,
    label2Align: LabelAlign.centerTop,
    textType: DiagramTextType.label,
  );

  // Gap Labels (Removed hardcoded colors, moved closer to gaps)
  paintText(
    c,
    canvas,
    'Inflationary Gap\n'
    'U < NRU',
    Offset(0.25, 0.38),
    pointerLine: Offset(0.15, 0.47),
    type: DiagramTextType.label,
    shape: DiagramShape.none,
  );

  paintText(
    c,
    canvas,
    'Deflationary Gap\n'
    'U > NRU',
    Offset(0.50, 0.90),
    pointerLine: Offset(0.40, 0.815),
    type: DiagramTextType.label,
    shape: DiagramShape.none,
  );
}

void _paintBusinessCycleStabilization(
  DiagramPainterConfig c,
  IDiagramCanvas canvas,
) {
  _paintTrendLine(c, canvas, label: DiagramLabel.potentialGDP.label);

  paintDiagramLines(
    c,
    canvas,
    startPos: Offset(0.0, 0.80),
    bezierPoints: [
      CustomBezier(control: Offset(0.15, 0.00), endPoint: Offset(0.30, 0.60)),
      CustomBezier(control: Offset(0.45, 1.15), endPoint: Offset(0.55, 0.55)),
      CustomBezier(control: Offset(0.70, 0.05), endPoint: Offset(0.85, 0.40)),
      CustomBezier(control: Offset(0.95, 0.75), endPoint: Offset(1.0, 0.55)),
    ],
    color: c.colorScheme.primary,
    label2: DiagramLabel.realGDP.label,
    label2Align: LabelAlign.right,
    textType: DiagramTextType.label,
  );
  paintLineSegment(c, canvas, origin: Offset(0.18, 0.45), angle: pi / 2);
  paintText(
    c,
    canvas,
    'Progressive\nTaxation',
    Offset(0.40, 0.40),
    type: DiagramTextType.label,
    pointerLine: Offset(0.18, 0.40),
  );
  paintLineSegment(c, canvas, origin: Offset(0.44, 0.75), angle: -pi / 2);
  paintText(
    c,
    canvas,
    'Unemployment\nPayments',
    Offset(0.70, 0.80),
    type: DiagramTextType.label,
    pointerLine: Offset(0.44, 0.80),
  );

  // Stabilized curve
  paintDiagramLines(
    c,
    canvas,
    startPos: Offset(0.0, 0.75),
    bezierPoints: [
      CustomBezier(control: Offset(0.15, 0.45), endPoint: Offset(0.30, 0.60)),
      CustomBezier(control: Offset(0.45, 0.70), endPoint: Offset(0.54, 0.55)),
      CustomBezier(control: Offset(0.70, 0.35), endPoint: Offset(0.80, 0.40)),
      CustomBezier(control: Offset(1.0, 0.50), endPoint: Offset(0.96, 0.48)),
    ],
    color: c.colorScheme.secondary,
    // Swapped Colors.red for a theme color
    label2: 'Real GDP + Stabl. Policies',
    label2Align: LabelAlign.right,
    curveStyle: CurveStyle.dashed,
    textType: DiagramTextType.label,
  );
}

void _paintBusinessCycleIncreasePotentialGDP(
  DiagramPainterConfig c,
  IDiagramCanvas canvas,
) {
  paintDiagramLines(
    c,
    canvas,
    startPos: Offset(0.0, 0.70),
    polylineOffsets: [Offset(0.90, 0.40)],
    label2: DiagramLabel.potentialGDP1.label,
    label2Align: LabelAlign.right,
    color: c.colorScheme.onSurface,
    curveStyle: CurveStyle.dotted,
  );
  paintDiagramLines(
    c,
    canvas,
    startPos: Offset(0.0, 0.70),
    polylineOffsets: [Offset(0.90, 0.20)],
    label2: DiagramLabel.potentialGDP2.label,
    label2Align: LabelAlign.right,
    color: c.colorScheme.onSurface,
    curveStyle: CurveStyle.dotted,
  );
  paintLineSegment(c, canvas, origin: Offset(0.90, 0.31), angle: -pi / 2);
}

void _paintTrendLine(
  DiagramPainterConfig c,
  IDiagramCanvas canvas, {
  String? label,
}) {
  paintDiagramLines(
    c,
    canvas,
    startPos: Offset(0.0, 0.70),
    polylineOffsets: [Offset(1.09, 0.38)],
    label2: label ?? 'Potential GDP\nU = NRU\n(Full Employment)',
    label2Align: LabelAlign.right,
    color: c.colorScheme.onSurface,
    curveStyle: CurveStyle.dotted,
    textType: DiagramTextType.label,
  );
}
