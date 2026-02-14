import 'package:economics_app/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/paint_axis.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/diagram_lines/paint_diagram_lines.dart';
import 'package:economics_app/diagrams/enums/diagram_labels.dart';
import 'package:economics_app/diagrams/models/custom_bezier.dart';
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

    // --- 2. SHADING (Painted first so lines sit on top) ---

    // A. Inflationary Gap (The Peak)
    // Region: From Start (0.0, 0.70) -> Curve Up -> Curve Down -> Intersection (~0.34, 0.59)
    paintShading(
      c,
      canvas,
      ShadeType
          .gainedRevenue, // "Gain" usually maps to Green/Red depending on config (Inflation)
      [
        Offset(0.0, 0.70), // Start at axis intersection
        // Up to Peak
        CustomBezier(control: Offset(0.12, 0.50), endPoint: Offset(0.25, 0.55)),
        // Down to Line Intersection (Approximated at x=0.34)
        CustomBezier(control: Offset(0.30, 0.57), endPoint: Offset(0.34, 0.59)),
      ],
      invertStripes: false,
    );

    // B. Deflationary Gap (The Trough)
    // Region: Intersection (~0.34, 0.59) -> Curve Down -> Curve Up -> Intersection (~0.63, 0.49)
    paintShading(
      c,
      canvas,
      ShadeType.loss,
      [
        Offset(0.34, 0.59), // Start at previous intersection
        // Down to Trough (using the rest of the recession bezier)
        CustomBezier(control: Offset(0.38, 0.65), endPoint: Offset(0.50, 0.62)),
        // Up to Line Intersection (Approximated at x=0.63)
        CustomBezier(control: Offset(0.58, 0.60), endPoint: Offset(0.65, 0.49)),
      ],
      invertStripes: true, // Distinguish visually from the other gap
    );

    // --- 3. LINES ---

    // Potential GDP (Trend Line)
    paintDiagramLines(
      c,
      canvas,
      startPos: Offset(0.0, 0.70),
      polylineOffsets: [Offset(0.92, 0.40)],
      label2: DiagramLabel.potentialGDP.label,
      label2Align: LabelAlign.centerRight,
      color: c.colorScheme.onSurface,
      curveStyle: CurveStyle.dashed,
    );

    // Real GDP (Oscillating Business Cycle)
    paintDiagramLines(
      c,
      canvas,
      startPos: Offset(0.0, 0.70),
      bezierPoints: [
        // 1. First Boom (Expansion)
        CustomBezier(control: Offset(0.12, 0.50), endPoint: Offset(0.25, 0.55)),
        // 2. First Recession
        CustomBezier(control: Offset(0.38, 0.65), endPoint: Offset(0.50, 0.62)),
        // 3. Second Boom (Recovery)
        CustomBezier(control: Offset(0.60, 0.60), endPoint: Offset(0.70, 0.40)),
        // 4. Second Contraction
        CustomBezier(control: Offset(0.80, 0.28), endPoint: Offset(0.95, 0.48)),
      ],
      color: config.colorScheme.primary,
      strokeWidth: 3.0,
      label2: DiagramLabel.realGDP.label,
      label2Align: LabelAlign.centerRight,
      arrowOnEnd: true,
    );

    // --- 4. PHASE LABELS ---

    // Peak
    paintText(
      c,
      canvas,
      DiagramLabel.peak.label,
      Offset(0.15, 0.35),
      pointerLine: Offset(0.15, 0.55), // Points to the gap/peak
      shape: DiagramShape.none,
    );

    // Contraction
    paintText(
      c,
      canvas,
      DiagramLabel.contraction.label,
      Offset(0.34, 0.75),
      pointerLine: Offset(0.34, 0.60),
    );

    // Trough
    paintText(
      c,
      canvas,
      DiagramLabel.trough.label,
      Offset(0.50, 0.85),
      pointerLine: Offset(0.50, 0.62),
    );

    // Expansion
    paintText(
      c,
      canvas,
      DiagramLabel.expansion.label,
      Offset(0.65, 0.30),
      pointerLine: Offset(0.65, 0.50),
      shape: DiagramShape.none,
    );

    // Gap Labels
    paintText(
      c,
      canvas,
      DiagramLabel.inflationaryGap.label,
      Offset(0.40, 0.45), // Moved up slightly to clear the shading
      pointerLine: Offset(0.20, 0.60), // Points into the shaded area
      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
      shape: DiagramShape.none,
    );

    paintText(
      c,
      canvas,
      DiagramLabel.deflationaryGap.label,
      Offset(0.75, 0.70), // Moved down to clear shading
      pointerLine: Offset(0.55, 0.55), // Points into the shaded area
      style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
      shape: DiagramShape.none,
    );
  }
}
