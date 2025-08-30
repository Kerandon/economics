import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_dashed_line.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_solid_line.dart';
import 'package:flutter/material.dart';
import '../../models/diagram_painter_config.dart';
import '../painter_constants.dart';

void paintDiagramDashedLines(
  DiagramPainterConfig config,
  Canvas canvas, {
  required double yAxisStartPos,
  required double xAxisEndPos,
  String? yLabel,
  String? xLabel,
  bool hideYLine = false,
  bool hideXLine = false,
  bool makeDashed = true,
  Color? color,
  Color? backgroundColor,
}) {
  final c = color ?? config.colorScheme.onSurface;

  // Axis box (normalized) with the requested vertical shift:
  final top = kAxisIndent * 0.50;
  final bottom = 1 - (kAxisIndent * 1.5);
  final left = kAxisIndent * 1.5;

  final spanY = bottom - top; // == 1 - 2*kAxisIndent

  final yPos = top + yAxisStartPos * spanY; // normalized 0..1
  final xEndPos = left + xAxisEndPos * spanY; // normalized 0..1

  if (!hideYLine) {
    final p1 = Offset(left, yPos);
    final p2 = Offset(xEndPos, yPos);
    if (makeDashed) {
      paintDashedLine(config, canvas, p1: p1, p2: p2, color: c);
    } else {
      paintSolidLine(config, canvas, p1: p1, p2: p2, color: c);
    }
  }

  if (yLabel != null) {
    // x is ignored in Y mode; pass 0.0. y is honored.
    _paintTextForDashedLines(
      config,
      canvas,
      yLabel,
      yAxisStartPos,
      CustomAxis.y,
    );
  }

  if (!hideXLine) {
    paintDashedLine(
      config,
      canvas,
      p1: Offset(xEndPos, yPos),
      p2: Offset(xEndPos, bottom),
      color: c,
    );
  }

  if (xLabel != null) {
    _paintTextForDashedLines(
      config,
      canvas,
      xLabel,
      xAxisEndPos, // <-- dy is now respected
      CustomAxis.x,
    );
  }
}

void _paintTextForDashedLines(
  DiagramPainterConfig config,
  Canvas canvas,
  String label,
  double pos, // normalized 0..1 in both axes
  CustomAxis axis, {
  double fontSize = kFontSize,
}) {
  fontSize *= config.averageRatio;

  final widthAndHeight = config.painterSize.width;
  final normalizedWidthAndHeight =
      (widthAndHeight - (widthAndHeight * (kAxisIndent * 2)));
  final indent = widthAndHeight * kAxisIndent;

  final textPainter = TextPainter(
    text: TextSpan(
      text: label,
      style: TextStyle(color: config.colorScheme.onSurface, fontSize: fontSize),
    ),
    textDirection: TextDirection.ltr,
  )..layout(minWidth: 0, maxWidth: widthAndHeight);

  late final Offset offset;

  final padding = 6;
  switch (axis) {
    case CustomAxis.x:
      // Center the label at (dx, dy) in normalized coordinates
      offset = Offset(
        pos * normalizedWidthAndHeight +
            (indent * 1.50) -
            textPainter.width / 2,
        widthAndHeight - indent * 1.5 + 6,
      );
      break;

    case CustomAxis.y:
      // Keep it left of the Y-axis indent, vertically centered at dy.
      offset = Offset(
        indent * 1.5 - textPainter.width - padding,
        pos * normalizedWidthAndHeight +
            (indent * 0.50) -
            (textPainter.height / 2),
      );
      break;
  }

  canvas.save();
  textPainter.paint(canvas, offset);
  canvas.restore();
}

enum CustomAxis { x, y }
