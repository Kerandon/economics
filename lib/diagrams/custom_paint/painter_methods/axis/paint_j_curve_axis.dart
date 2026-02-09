import 'dart:math';

import 'package:flutter/cupertino.dart';

import '../../../models/diagram_painter_config.dart';
import '../../i_diagram_canvas.dart';
import '../../painter_constants.dart';
import '../paint_arrow_head.dart';
import '../paint_text.dart';

void paintJCurveAxes(
  DiagramPainterConfig config,
  IDiagramCanvas canvas,
  String xLabel, // Ignored -> 'Time'
  String yLabel, // Ignored -> 'Current Account'
) {
  final widthAndHeight = config.painterSize.width;
  final indent = widthAndHeight * kAxisIndent;

  // Calculate drawing bounds
  final top = indent * kTopAxisIndent;
  final bottom = widthAndHeight - (indent * kBottomAxisIndent);
  final left = indent;
  final right = widthAndHeight * (1 - kAxisIndent);
  final centerY = top + (bottom - top) / 2;

  final axisColor = config.colorScheme.onSurface;
  final axisWidth = kAxisWidth * config.averageRatio;

  // 1. Draw Vertical Y-Axis (Left side, Full Height)
  canvas.drawLine(
    Offset(left, bottom),
    Offset(left, top),
    axisColor,
    axisWidth,
  );

  // 2. Draw Horizontal X-Axis (Centered vertically)
  canvas.drawLine(
    Offset(left, centerY),
    Offset(right, centerY),
    axisColor,
    axisWidth,
  );

  // 3. Draw Arrows
  // Y-Axis Top
  paintArrowHead(
    config,
    canvas,
    color: axisColor,
    positionOfArrow: Offset(left, top),
    rotationAngle: 0,
    isCentered: false,
  );
  // Y-Axis Bottom
  paintArrowHead(
    config,
    canvas,
    color: axisColor,
    positionOfArrow: Offset(left, bottom),
    rotationAngle: pi,
    isCentered: false,
  );
  // X-Axis Right
  paintArrowHead(
    config,
    canvas,
    color: axisColor,
    positionOfArrow: Offset(right, centerY),
    rotationAngle: pi / 2,
    isCentered: false,
  );

  // 4. Paint Axis Labels
  final textStyle = TextStyle(color: axisColor, fontStyle: FontStyle.italic);

  // X Label: "Time"
  paintText(
    config,
    canvas,
    'Time',
    Offset(1.0, 0.54),
    fontSize: kFontMedium,
    horizontalPivot: LabelPivot.right,
    verticalPivot: LabelPivot.top,
    normalize: true,
    style: textStyle,
  );

  // 5. Paint Specific J-Curve Region Labels
  // These remain Pivot.left because they are inside the graph
  final regionLabelStyle = TextStyle(color: axisColor, fontSize: kFontSmall);

  final yIndent = -0.03;
  // Top: Surplus
  paintText(
    config,
    canvas,
    'Surplus\n(X > M)',
    Offset(yIndent, 0.15),
    horizontalPivot: LabelPivot.right,
    normalize: true,
    style: regionLabelStyle,
  );

  // Middle: Balance
  paintText(
    config,
    canvas,
    'Balance\n(X = M)',
    Offset(yIndent, 0.50),
    horizontalPivot: LabelPivot.right,
    style: regionLabelStyle,
  );

  // Bottom: Deficit
  paintText(
    config,
    canvas,
    'Deficit\n(X < M)',
    Offset(yIndent, 0.85),
    horizontalPivot: LabelPivot.right,
    style: regionLabelStyle,
  );
}
