import 'package:economics_app/diagrams/custom_paint/painter_constants.dart';
import 'package:flutter/material.dart';
import 'legend_alignment.dart';
import 'legend_entry.dart';
import 'legend_item.dart';
import 'legend_shape.dart';

void paintLegend(
  Canvas canvas,
  Size size,
  List<LegendEntry> legendItems, {
  double legendBoxSize = 12.0,
  double spacing = 8.0,
  double textSpacing = 4.0,
  double margin = 20,
  Brightness brightness = Brightness.light,
  LegendAlignment alignment = LegendAlignment.right,
}) {
  final textColor = brightness == Brightness.dark ? Colors.white : Colors.black;
  final textStyle = TextStyle(color: textColor, fontSize: kFontSmall);
  final textPainter = TextPainter(textDirection: TextDirection.ltr);
  margin = size.width * 0.05;
  double maxWidth = size.width - margin * 2;
  List<List<LegendItem>> rows = [[]];
  double currentRowWidth = 0;

  // ✅ Compute rows
  for (final entry in legendItems) {
    textPainter.text = TextSpan(text: entry.label, style: textStyle);
    textPainter.layout();

    final double itemWidth = legendBoxSize + textSpacing + textPainter.width;

    if (currentRowWidth + itemWidth + (rows.last.isEmpty ? 0 : spacing) >
        maxWidth) {
      rows.add([]);
      currentRowWidth = 0;
    }

    rows.last.add(LegendItem(entry, textPainter.width));
    currentRowWidth += itemWidth + (rows.last.length > 1 ? spacing : 0);
  }

  double currentY = size.height - legendBoxSize - size.height * 0.12;

  for (final row in rows.reversed) {
    double rowWidth =
        row.fold<double>(
          0,
          (sum, item) => sum + legendBoxSize + textSpacing + item.textWidth,
        ) +
        spacing * (row.length - 1);

    // ✅ Correct alignment
    double startX;
    switch (alignment) {
      case LegendAlignment.left:
        startX = margin;
        break;
      case LegendAlignment.center:
        startX = (size.width - rowWidth) / 2;
        break;
      case LegendAlignment.right:
        startX = size.width - rowWidth - margin;
        break;
    }

    for (final item in row) {
      final paint = Paint()
        ..color = item.entry.color
        ..strokeWidth = 2.0;

      final rect = Rect.fromLTWH(
        startX,
        currentY,
        legendBoxSize,
        legendBoxSize,
      );

      // ✅ Draw shape
      switch (item.entry.shape) {
        case LegendShape.square:
          canvas.drawRect(rect, paint);
          break;

        case LegendShape.circle:
          canvas.drawCircle(rect.center, legendBoxSize / 2, paint);
          break;

        case LegendShape.diamond:
          final path = Path()
            ..moveTo(rect.center.dx, rect.top)
            ..lineTo(rect.right, rect.center.dy)
            ..lineTo(rect.center.dx, rect.bottom)
            ..lineTo(rect.left, rect.center.dy)
            ..close();
          canvas.drawPath(path, paint);
          break;

        case LegendShape.line:
          final yCenter = currentY + legendBoxSize / 2;
          canvas.drawLine(
            Offset(startX, yCenter),
            Offset(startX + legendBoxSize, yCenter),
            paint,
          );
          break;

        case LegendShape.dashedLine:
          final yCenter = currentY + legendBoxSize / 2;
          _drawDashedLine(
            canvas,
            Offset(startX, yCenter),
            Offset(startX + legendBoxSize, yCenter),
            paint,
          );
          break;
      }

      // ✅ Draw text
      textPainter.text = TextSpan(text: item.entry.label, style: textStyle);
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(
          startX + legendBoxSize + textSpacing,
          currentY + (legendBoxSize - textPainter.height) / 2,
        ),
      );

      startX += legendBoxSize + textSpacing + item.textWidth + spacing;
    }

    currentY -= legendBoxSize + spacing;
  }
}

// Helper for dashed lines
void _drawDashedLine(
  Canvas canvas,
  Offset start,
  Offset end,
  Paint paint, {
  double dashWidth = 4,
  double gap = 3,
}) {
  final totalDistance = (end - start).distance;
  final direction = (end - start) / totalDistance;
  double currentDistance = 0;

  while (currentDistance < totalDistance) {
    final segmentStart = start + direction * currentDistance;
    currentDistance += dashWidth;
    if (currentDistance > totalDistance) currentDistance = totalDistance;
    final segmentEnd = start + direction * currentDistance;
    canvas.drawLine(segmentStart, segmentEnd, paint);
    currentDistance += gap;
  }
}
