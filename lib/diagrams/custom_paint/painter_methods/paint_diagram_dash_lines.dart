import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_dashed_line.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_dot.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_solid_line.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_text.dart';
import 'package:flutter/material.dart';
import '../../models/diagram_painter_config.dart';
import '../diagrams/demand_diagram.dart';
import '../i_diagram_canvas.dart';
import '../painter_constants.dart';

void paintDiagramDashedLines(
  DiagramPainterConfig config,
  IDiagramCanvas canvas, {
  required double yAxisStartPos,
  required double xAxisEndPos, // Primary X Position
  List<double>? additionalXPositions, // Additional X Positions
  String? yLabel,
  String? xLabel,
  List<String>? additionalXLabels,
  String? rightYLabel,

  // --- VISIBILITY FLAGS (Only affect Primary Lines) ---
  bool hideYLine = false, // Hides the Primary Horizontal Line
  bool hideXLine = false, // Hides the Primary Vertical Line
  bool hideYLabels = false, // Hides Primary Left Axis Label
  bool hideXLabels = false, // Hides Primary Bottom Axis Label

  bool makeDashed = true,
  Color? color,
  bool showDotAtIntersection = false,
  double dotRadius = kDotRadius,
  Color? dotColor,
}) {
  final c = color ?? config.colorScheme.onSurface;
  final width = config.painterSize.width;

  // 1. SETUP COORDINATES
  final top = kAxisIndent * kTopAxisIndent;
  final bottom = 1 - (kAxisIndent * kBottomAxisIndent);
  final left = kAxisIndent;
  final spanY = bottom - top;

  final yPos = (top + yAxisStartPos * spanY) * width;
  final axisLeft = left * width;
  final axisBottom = bottom * width;
  final strokeWidth = 1.5 * config.averageRatio;

  // 2. CALCULATE MAX WIDTH (Horizontal line must stretch to cover ALL X lines)
  double maxXValue = xAxisEndPos;
  if (additionalXPositions != null) {
    for (final pos in additionalXPositions) {
      if (pos > maxXValue) maxXValue = pos;
    }
  }
  final furthestXPixel = (left + maxXValue * spanY) * width;

  // 3. DRAW PRIMARY HORIZONTAL LINE (Controlled by hideYLine)
  if (!hideYLine) {
    final p1 = Offset(axisLeft, yPos);
    final p2 = Offset(furthestXPixel, yPos);

    if (makeDashed) {
      canvas.drawDashedLine(p1, p2, c, strokeWidth);
    } else {
      canvas.drawLine(p1, p2, c, strokeWidth);
    }
  }

  // 4. DRAW PRIMARY VERTICAL LINE (Controlled by hideXLine)
  final mainXPixel = (left + xAxisEndPos * spanY) * width;

  if (!hideXLine) {
    canvas.drawDashedLine(
      Offset(mainXPixel, yPos),
      Offset(mainXPixel, axisBottom),
      c,
      strokeWidth,
    );
  }

  // Draw Primary Dot (Controlled by showDotAtIntersection)
  // Note: We generally draw the dot even if line is hidden if 'showDot' is true
  if (showDotAtIntersection) {
    final r = dotRadius * config.averageRatio * 0.60;
    canvas.drawDot(
      Offset(mainXPixel, yPos),
      dotColor ?? c,
      radius: r,
      fill: true,
    );
  }

  // Draw Primary X Label (Controlled by hideXLabels)
  if (xLabel != null && !hideXLabels) {
    _paintTextForDashedLines(config, canvas, xLabel, xAxisEndPos, CustomAxis.x);
  }

  // 5. DRAW ADDITIONAL VERTICAL LINES (ALWAYS VISIBLE)
  // These ignore 'hideXLine' because they were explicitly added.
  if (additionalXPositions != null) {
    for (int i = 0; i < additionalXPositions.length; i++) {
      final xVal = additionalXPositions[i];
      final xPixel = (left + xVal * spanY) * width;

      // Always draw additional lines
      canvas.drawDashedLine(
        Offset(xPixel, yPos),
        Offset(xPixel, axisBottom),
        c,
        strokeWidth,
      );

      // Always draw additional dots if main dot is enabled
      if (showDotAtIntersection) {
        final r = dotRadius * config.averageRatio * 0.60;
        canvas.drawDot(
          Offset(xPixel, yPos),
          dotColor ?? c,
          radius: r,
          fill: true,
        );
      }

      // Always draw additional labels if they exist
      if (additionalXLabels != null && i < additionalXLabels.length) {
        _paintTextForDashedLines(
          config,
          canvas,
          additionalXLabels[i],
          xVal,
          CustomAxis.x,
        );
      }
    }
  }

  // 6. DRAW PRIMARY Y LABELS (Controlled by hideYLabels)
  if (yLabel != null && !hideYLabels) {
    _paintTextForDashedLines(
      config,
      canvas,
      yLabel,
      yAxisStartPos,
      CustomAxis.y,
    );
  }

  // 7. DRAW RIGHT-SIDE LABEL (Always Visible if provided)
  if (rightYLabel != null) {
    const padding = 0.04;
    paintText(
      config,
      canvas,
      rightYLabel,
      Offset(maxXValue + padding, yAxisStartPos),
      horizontalPivot: LabelPivot.left,
      verticalPivot: LabelPivot.middle,
      normalize: true,
      style: TextStyle(color: config.colorScheme.onSurface),
    );
  }
}

/// Simplified Helper using paintText2 and Pivots
void _paintTextForDashedLines(
  DiagramPainterConfig config,
  IDiagramCanvas canvas,
  String label,
  double pos, // 0.0 to 1.0 position along the span
  CustomAxis axis,
) {
  const padding = 0.015; // Normalized padding

  if (axis == CustomAxis.x) {
    // X-Axis labels (Quantities)
    // We anchor at the bottom of the diagram area
    paintText(
      config,
      canvas,
      label,
      Offset(pos, 1.0 + padding), // Positioned just below the X-axis
      horizontalPivot: LabelPivot.center,
      verticalPivot: LabelPivot.top,
      normalize: true,
      style: TextStyle(color: config.colorScheme.onSurface),
    );
  } else {
    // Y-Axis labels (Prices)
    // We anchor at the left of the diagram area
    paintText(
      config,
      canvas,
      label,
      Offset(0.0 - padding, pos), // Positioned just to the left of the Y-axis
      horizontalPivot: LabelPivot.right,
      verticalPivot: LabelPivot.middle,
      normalize: true,
      style: TextStyle(color: config.colorScheme.onSurface),
    );
  }
}
