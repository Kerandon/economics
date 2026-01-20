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
  Canvas? canvas,
  Size size,
  List<LegendEntry> legendItems, {
  required DiagramPainterConfig config, // 👈 Required for Option 1
  IDiagramCanvas? iCanvas,
  double legendBoxSize = 12.0,
  double spacing = 8.0,
  double textSpacing = 4.0,
  double yAdjustment = kAxisIndent * 0.50,
  Brightness brightness = Brightness.light,
  LegendAlignment alignment = LegendAlignment.right,
}) {
  final textColor = brightness == Brightness.dark ? Colors.white : Colors.black;
  final fontSize = kFontSmall * config.averageRatio;

  final textPainter = TextPainter(textDirection: TextDirection.ltr);
  final double margin = size.width * 0.05;
  final double maxWidth = size.width - margin * 2;

  List<List<LegendItem>> rows = [[]];
  double currentRowWidth = 0;

  // 1. Compute Rows & Layout
  for (final entry in legendItems) {
    double textWidth;
    if (iCanvas != null) {
      // PDF Width Estimation (Standard for Helvetica)
      textWidth = entry.label.length * fontSize * 0.50;
    } else {
      textPainter.text = TextSpan(
        text: entry.label,
        style: TextStyle(color: textColor, fontSize: fontSize),
      );
      textPainter.layout();
      textWidth = textPainter.width;
    }

    final double itemWidth = legendBoxSize + textSpacing + textWidth;

    if (currentRowWidth + itemWidth + (rows.last.isEmpty ? 0 : spacing) >
        maxWidth) {
      rows.add([]);
      currentRowWidth = 0;
    }

    rows.last.add(LegendItem(entry, textWidth));
    currentRowWidth += itemWidth + (rows.last.length > 1 ? spacing : 0);
  }

  // 2. Initial Y Position (Bottom-up stacking)
  double currentY = size.height - legendBoxSize - (size.height * yAdjustment);

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
        startX = (size.width - rowTotalWidth) / 2;
        break;
      case LegendAlignment.right:
        startX = size.width - rowTotalWidth - margin;
        break;
    }

    for (final item in row) {
      final rect = Rect.fromLTWH(
        startX,
        currentY,
        legendBoxSize,
        legendBoxSize,
      );

      if (iCanvas != null) {
        // PDF Bridge Logic
        _drawLegendShapeBridged(
          iCanvas,
          item.entry.shape,
          rect,
          item.entry.color,
        );
        iCanvas.drawText(
          item.entry.label,
          Offset(
            startX + legendBoxSize + textSpacing,
            currentY + (legendBoxSize / 2),
          ),
          fontSize,
          textColor,
        );
      } else if (canvas != null) {
        // Flutter Canvas Logic
        _drawLegendShapeFlutter(
          config,
          canvas,
          item.entry.shape,
          rect,
          item.entry.color,
        );

        textPainter.text = TextSpan(
          text: item.entry.label,
          style: TextStyle(color: textColor, fontSize: fontSize),
        );
        textPainter.layout();
        textPainter.paint(
          canvas,
          Offset(
            startX + legendBoxSize + textSpacing,
            currentY + (legendBoxSize - textPainter.height) / 2,
          ),
        );
      }

      startX += legendBoxSize + textSpacing + item.textWidth + spacing;
    }
    currentY -= (legendBoxSize + spacing);
  }
}

// --- HELPERS ---

void _drawLegendShapeBridged(
  IDiagramCanvas iCanvas,
  LegendShape shape,
  Rect rect,
  Color color,
) {
  switch (shape) {
    case LegendShape.square:
      iCanvas.drawRect(rect, color, fill: true);
    case LegendShape.circle:
      iCanvas.drawDot(rect.center, color, radius: rect.width / 2);
    case LegendShape.diamond:
      final p = [
        Offset(rect.center.dx, rect.top),
        Offset(rect.right, rect.center.dy),
        Offset(rect.center.dx, rect.bottom),
        Offset(rect.left, rect.center.dy),
      ];
      iCanvas.drawPath(p, color, fill: true);
    case LegendShape.line:
      iCanvas.drawLine(
        Offset(rect.left, rect.center.dy),
        Offset(rect.right, rect.center.dy),
        color,
        2.0,
      );
    case LegendShape.dashedLine:
      iCanvas.drawDashedLine(
        Offset(rect.left, rect.center.dy),
        Offset(rect.right, rect.center.dy),
        color,
        2.0,
      );
  }
}

void _drawLegendShapeFlutter(
  DiagramPainterConfig config,
  Canvas canvas,
  LegendShape shape,
  Rect rect,
  Color color,
) {
  final paint = Paint()
    ..color = color
    ..style = PaintingStyle.fill;

  switch (shape) {
    case LegendShape.square:
      canvas.drawRect(rect, paint);
    case LegendShape.circle:
      canvas.drawCircle(rect.center, rect.width / 2, paint);
    case LegendShape.diamond:
      final path = Path()
        ..moveTo(rect.center.dx, rect.top)
        ..lineTo(rect.right, rect.center.dy)
        ..lineTo(rect.center.dx, rect.bottom)
        ..lineTo(rect.left, rect.center.dy)
        ..close();
      canvas.drawPath(path, paint);
    case LegendShape.line:
      paintSolidLine(
        config,
        canvas,
        p1: Offset(rect.left, rect.center.dy),
        p2: Offset(rect.right, rect.center.dy),
        color: color,
        strokeWidth: 2.0,
      );
    case LegendShape.dashedLine:
      paintDashedLine(
        config,
        canvas,
        p1: Offset(rect.left, rect.center.dy),
        p2: Offset(rect.right, rect.center.dy),
        color: color,
        strokeWidth: 2.0,
      );
  }
}
