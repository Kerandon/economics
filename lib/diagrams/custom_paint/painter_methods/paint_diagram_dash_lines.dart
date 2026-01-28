import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_dashed_line.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_dot.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_solid_line.dart';
import 'package:flutter/material.dart';
import '../../models/diagram_painter_config.dart';
import '../diagrams/demand_diagram.dart';
import '../i_diagram_canvas.dart';
import '../painter_constants.dart';

void paintDiagramDashedLines(
  DiagramPainterConfig config,
  Canvas? canvas, {
  IDiagramCanvas? iCanvas,
  required double yAxisStartPos,
  required double xAxisEndPos,
  String? yLabel,
  String? xLabel,
  bool hideYLine = false,
  bool hideXLine = false,
  bool makeDashed = true,
  Color? color,
  Color? backgroundColor,
  bool showDotAtIntersection = false,
  double dotRadius = kDotRadius,
  Color? dotColor,
}) {
  final c = color ?? config.colorScheme.onSurface;
  final width = config.painterSize.width;

  // Normalized math (multiplying by width at the end to get absolute pixels)
  final top = kAxisIndent * kTopAxisIndent;
  final bottom = 1 - (kAxisIndent * kBottomAxisIndent);
  final left = kAxisIndent;
  final spanY = bottom - top;

  final yPos = (top + yAxisStartPos * spanY) * width;
  final xEndPos = (left + xAxisEndPos * spanY) * width;
  final axisLeft = left * width;
  final axisBottom = bottom * width;

  final strokeWidth = 1.5 * config.averageRatio;

  // 1. Draw horizontal (Y) line
  if (!hideYLine) {
    final p1 = Offset(axisLeft, yPos);
    final p2 = Offset(xEndPos, yPos);

    if (iCanvas != null) {
      makeDashed
          ? iCanvas.drawDashedLine(p1, p2, c, strokeWidth)
          : iCanvas.drawLine(p1, p2, c, strokeWidth);
    } else if (canvas != null) {
      makeDashed
          ? paintDashedLine(config, canvas, p1: p1, p2: p2, color: c)
          : paintSolidLine(config, canvas, p1: p1, p2: p2, color: c);
    }
  }

  // 2. Draw vertical (X) line
  if (!hideXLine) {
    final p1 = Offset(xEndPos, yPos);
    final p2 = Offset(xEndPos, axisBottom);

    if (iCanvas != null) {
      // Typically vertical dashed lines are always dashed in these diagrams
      iCanvas.drawDashedLine(p1, p2, c, strokeWidth);
    } else if (canvas != null) {
      paintDashedLine(config, canvas, p1: p1, p2: p2, color: c);
    }
  }

  // 3. Labels
  if (yLabel != null) {
    _paintTextForDashedLines(
      config,
      canvas,
      yLabel,
      yAxisStartPos,
      CustomAxis.y,
      iCanvas: iCanvas,
    );
  }
  if (xLabel != null) {
    _paintTextForDashedLines(
      config,
      canvas,
      xLabel,
      xAxisEndPos,
      CustomAxis.x,
      iCanvas: iCanvas,
    );
  }

  // 4. Draw dot at intersection
  if (showDotAtIntersection) {
    final r = dotRadius * config.averageRatio * 0.60;
    final dColor = dotColor ?? c;
    final intersection = Offset(xEndPos, yPos);

    if (iCanvas != null) {
      iCanvas.drawDot(intersection, dColor, radius: r);
    } else if (canvas != null) {
      canvas.drawCircle(
        intersection,
          kDotRadius,
        Paint()
          ..color = dColor
          ..style = PaintingStyle.fill,
      );
    }
  }
}

void _paintTextForDashedLines(
  DiagramPainterConfig config,
  Canvas? canvas,
  String label,
  double pos,
  CustomAxis axis, {
  IDiagramCanvas? iCanvas,
  double fontSize = kFontMedium,
}) {
  fontSize *= config.averageRatio;
  final width = config.painterSize.width;
  final normalizedArea = (width - (width * (kAxisIndent * 2)));
  final indent = width * kAxisIndent;
  const padding = 6.0;

  if (iCanvas != null) {
    // For the Bridge, we calculate the anchor point and use TextAlign
    late Offset offset;
    late TextAlign align;

    if (axis == CustomAxis.x) {
      offset = Offset(
        pos * normalizedArea + (indent),
        width - indent + padding,
      );
      align = TextAlign.center;
    } else {
      offset = Offset(
        indent - padding,
        pos * normalizedArea + (indent * kTopAxisIndent),
      );
      align = TextAlign.right;
    }
    iCanvas.drawText(
      label,
      offset,
      fontSize,
      config.colorScheme.onSurface,
      align: align,
    );
  } else if (canvas != null) {
    // Standard Flutter TextPainter logic
    final textPainter = TextPainter(
      text: TextSpan(
        text: label,
        style: TextStyle(
          color: config.colorScheme.onSurface,
          fontSize: fontSize,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    late Offset offset;
    if (axis == CustomAxis.x) {
      offset = Offset(
        pos * normalizedArea + (indent) - (textPainter.width / 2),
        width - indent * kBottomAxisIndent + padding,
      );
    } else {
      offset = Offset(
        indent - textPainter.width - padding,
        pos * normalizedArea + (indent * kTopAxisIndent) - (textPainter.height / 2),
      );
    }
    textPainter.paint(canvas, offset);
  }
}
