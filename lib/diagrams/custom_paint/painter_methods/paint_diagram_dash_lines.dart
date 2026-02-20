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
  required double xAxisEndPos,
  List<double>? additionalXPositions,
  List<double>? additionalYPositions,
  String? yLabel,
  String? xLabel,
  List<String>? additionalXLabels,
  List<String>? additionalYLabels,
  String? rightYLabel,
  List<String>? additionalRightYLabels,
  bool hideYLine = false,
  bool hideXLine = false,
  bool hideYLabels = false,
  bool hideXLabels = false,
  bool makeDashed = true,
  Color? color,
  bool showDotAtIntersection = false,
  double dotRadius = kDotRadius,
  Color? dotColor,
  // NEW: Label Padding Passthrough
  Offset xLabelPadding = Offset.zero,
  Offset yLabelPadding = Offset.zero,
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

  double maxXValue = xAxisEndPos;
  if (additionalXPositions != null) {
    for (final pos in additionalXPositions) {
      if (pos > maxXValue) maxXValue = pos;
    }
  }
  final furthestXPixel = (left + maxXValue * spanY) * width;
  final mainXPixel = (left + xAxisEndPos * spanY) * width;

  // 3. DRAW PRIMARY HORIZONTAL LINE
  if (!hideYLine) {
    final p1 = Offset(axisLeft, yPos);
    final p2 = Offset(furthestXPixel, yPos);
    makeDashed
        ? canvas.drawDashedLine(p1, p2, c, strokeWidth)
        : canvas.drawLine(p1, p2, c, strokeWidth);
  }

  // 4. DRAW ADDITIONAL HORIZONTAL LINES
  if (additionalYPositions != null) {
    for (int i = 0; i < additionalYPositions.length; i++) {
      final yVal = additionalYPositions[i];
      final yPixelLocal = (top + yVal * spanY) * width;
      canvas.drawDashedLine(
        Offset(axisLeft, yPixelLocal),
        Offset(furthestXPixel, yPixelLocal),
        c,
        strokeWidth,
      );

      if (showDotAtIntersection) {
        canvas.drawDot(
          Offset(mainXPixel, yPixelLocal),
          dotColor ?? c,
          radius: dotRadius * config.averageRatio * 0.6,
          fill: true,
        );
      }

      if (additionalYLabels != null && i < additionalYLabels.length) {
        _paintTextForDashedLines(
          config,
          canvas,
          additionalYLabels[i],
          yVal,
          CustomAxis.y,
          paddingOffset: yLabelPadding,
        );
      }

      if (additionalRightYLabels != null && i < additionalRightYLabels.length) {
        paintText(
          config,
          canvas,
          additionalRightYLabels[i],
          Offset(maxXValue + 0.04, yVal),
          horizontalPivot: LabelPivot.left,
          verticalPivot: LabelPivot.middle,
          normalize: true,
          showBackground: false,
        );
      }
    }
  }

  // 5. DRAW PRIMARY VERTICAL LINE
  if (!hideXLine) {
    canvas.drawDashedLine(
      Offset(mainXPixel, yPos),
      Offset(mainXPixel, axisBottom),
      c,
      strokeWidth,
    );
  }

  if (showDotAtIntersection) {
    canvas.drawDot(
      Offset(mainXPixel, yPos),
      dotColor ?? c,
      radius: dotRadius * config.averageRatio * 0.6,
      fill: true,
    );
  }

  // Draw Primary X Label
  if (xLabel != null && !hideXLabels) {
    _paintTextForDashedLines(
      config,
      canvas,
      xLabel,
      xAxisEndPos,
      CustomAxis.x,
      paddingOffset: xLabelPadding,
    );
  }

  // 6. DRAW ADDITIONAL VERTICAL LINES
  if (additionalXPositions != null) {
    for (int i = 0; i < additionalXPositions.length; i++) {
      final xVal = additionalXPositions[i];
      final xPixel = (left + xVal * spanY) * width;
      canvas.drawDashedLine(
        Offset(xPixel, yPos),
        Offset(xPixel, axisBottom),
        c,
        strokeWidth,
      );

      if (showDotAtIntersection) {
        canvas.drawDot(
          Offset(xPixel, yPos),
          dotColor ?? c,
          radius: dotRadius * config.averageRatio * 0.6,
          fill: true,
        );
      }

      if (additionalXLabels != null && i < additionalXLabels.length) {
        _paintTextForDashedLines(
          config,
          canvas,
          additionalXLabels[i],
          xVal,
          CustomAxis.x,
          paddingOffset: xLabelPadding,
        );
      }
    }
  }

  // 7. DRAW PRIMARY Y LABELS
  if (yLabel != null && !hideYLabels) {
    _paintTextForDashedLines(
      config,
      canvas,
      yLabel,
      yAxisStartPos,
      CustomAxis.y,
      paddingOffset: yLabelPadding,
    );
  }

  // 8. DRAW PRIMARY RIGHT-SIDE LABEL
  if (rightYLabel != null) {
    paintText(
      config,
      canvas,
      rightYLabel,
      Offset(maxXValue + 0.04, yAxisStartPos),
      horizontalPivot: LabelPivot.left,
      verticalPivot: LabelPivot.middle,
      normalize: true,
    );
  }
}

void _paintTextForDashedLines(
  DiagramPainterConfig config,
  IDiagramCanvas canvas,
  String label,
  double pos,
  CustomAxis axis, {
  Offset paddingOffset = Offset.zero, // 👈 New Helper parameter
}) {
  const basePadding = 0.015;

  if (axis == CustomAxis.x) {
    paintText(
      config,
      canvas,
      label,
      Offset(pos, 1.0 + basePadding),
      horizontalPivot: LabelPivot.center,
      verticalPivot: LabelPivot.top,
      normalize: true,
      showBackground: false,
      textPadding: paddingOffset, // 👈 Applied here
    );
  } else {
    paintText(
      config,
      canvas,
      label,
      Offset(0.0 - basePadding, pos),
      horizontalPivot: LabelPivot.right,
      verticalPivot: LabelPivot.middle,
      normalize: true,
      showBackground: false,
      textPadding: paddingOffset, // 👈 Applied here
    );
  }
}
