import 'package:economics_app/diagrams/custom_paint/painter_constants.dart';
import 'package:flutter/material.dart';
import '../../../models/diagram_painter_config.dart';
import '../../i_diagram_canvas.dart';
import '../paint_dashed_line.dart';
import '../paint_solid_line.dart';
import 'legend_alignment.dart';
import 'legend_entry.dart';
import 'legend_item.dart';
import 'legend_shape.dart';

void paintLegend(
  IDiagramCanvas iCanvas, // 👈 Unified interface
  List<LegendEntry> legendItems, {
  required DiagramPainterConfig config,
  double legendBoxSize = 12.0,
  double spacing = 8.0,
  double textSpacing = 4.0,
  double yAdjustment = kAxisIndent * 0.50,
  LegendAlignment alignment = LegendAlignment.right,
}) {
  // Extract dimensions from config to ensure parity between Flutter and PDF
  final size = config.painterSize;
  final width = size.width;
  final height = size.height;

  final textColor = config.colorScheme.onSurface;
  final fontSize = kFontSmall * config.averageRatio;

  final double margin = width * 0.05;
  final double maxWidth = width - margin * 2;

  List<List<LegendItem>> rows = [[]];
  double currentRowWidth = 0;

  // 1. Compute Rows & Layout
  for (final entry in legendItems) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: entry.label,
        style: TextStyle(fontSize: fontSize),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    final double textWidth = textPainter.width;
    final double itemWidth = legendBoxSize + textSpacing + textWidth;

    if (currentRowWidth + itemWidth + (rows.last.isEmpty ? 0 : spacing) >
        maxWidth) {
      rows.add([]);
      currentRowWidth = 0;
    }

    rows.last.add(LegendItem(entry, textWidth));
    currentRowWidth += itemWidth + (rows.last.length > 1 ? spacing : 0);
  }

  // 2. Initial Y Position (Bottom-up stacking based on painter height)
  double currentY = height - legendBoxSize - (height * yAdjustment);

  // 3. Draw Legend Rows
  for (final row in rows.reversed) {
    double rowTotalWidth =
        row.fold<double>(
          0,
          (sum, item) => sum + legendBoxSize + textSpacing + item.textWidth,
        ) +
        spacing * (row.length - 1);

    double startX;
    switch (alignment) {
      case LegendAlignment.left:
        startX = margin;
        break;
      case LegendAlignment.center:
        startX = (width - rowTotalWidth) / 2;
        break;
      case LegendAlignment.right:
        startX = width - rowTotalWidth - margin;
        break;
    }

    for (final item in row) {
      final rect = Rect.fromLTWH(
        startX,
        currentY,
        legendBoxSize,
        legendBoxSize,
      );

      // A. Draw the Shape via Bridge
      _drawLegendShapeBridged(
        iCanvas,
        item.entry.shape,
        rect,
        item.entry.color,
      );

      // B. Draw the Text via Bridge
      // We use the same vertical centering logic: (box height / 2) - (font size / 2)
      iCanvas.drawText(
        item.entry.label,
        Offset(
          startX + legendBoxSize + textSpacing,
          currentY + (legendBoxSize / 2) - (fontSize / 2),
        ),
        fontSize,
        textColor,
      );

      startX += legendBoxSize + textSpacing + item.textWidth + spacing;
    }
    // Move up for the next row
    currentY -= (legendBoxSize + spacing);
  }
}

void _drawLegendShapeBridged(
  IDiagramCanvas iCanvas,
  LegendShape shape,
  Rect rect,
  Color color,
) {
  switch (shape) {
    case LegendShape.square:
      iCanvas.drawRect(rect, color, fill: true);
      break;
    case LegendShape.circle:
      // Using the center of the legend rect and half the width as radius
      iCanvas.drawDot(rect.center, color, radius: rect.width / 2);
      break;
    case LegendShape.diamond:
      // Constructing a diamond path from the rect boundaries
      final p = [
        Offset(rect.center.dx, rect.top),
        Offset(rect.right, rect.center.dy),
        Offset(rect.center.dx, rect.bottom),
        Offset(rect.left, rect.center.dy),
      ];
      iCanvas.drawPath(p, color, fill: true);
      break;
    case LegendShape.line:
      // Horizontal line through the middle of the rect
      iCanvas.drawLine(
        Offset(rect.left, rect.center.dy),
        Offset(rect.right, rect.center.dy),
        color,
        2.0,
      );
      break;
    case LegendShape.dashedLine:
      // Dashed horizontal line through the middle of the rect
      iCanvas.drawDashedLine(
        Offset(rect.left, rect.center.dy),
        Offset(rect.right, rect.center.dy),
        color,
        2.0,
      );
      break;
  }
}
