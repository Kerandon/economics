import 'package:economics_app/diagrams/custom_paint/painter_constants.dart';
import 'package:flutter/material.dart';

import '../../enums/shade_type.dart';

void paintLegend(
  Canvas canvas,
  Size size,
  List<LegendEntry> legendItems, {
  bool rounded = false,
  double legendBoxSize = 12.0,
  double spacing = 8.0,
  double textSpacing = 2.0,
  double margin = 2,
  Brightness brightness = Brightness.light,
  LegendAlignment alignment = LegendAlignment.center,
}) {
  final textColor = brightness == Brightness.dark ? Colors.white : Colors.black;
  final textStyle = TextStyle(color: textColor, fontSize: kFontSize * 0.60);
  final textPainter = TextPainter(textDirection: TextDirection.ltr);

  double maxWidth = size.width - margin * 2;
  List<List<_LegendItem>> rows = [[]];
  double currentRowWidth = 0;

  // Prepare items first (compute row widths for alignment)
  for (final entry in legendItems) {
    textPainter.text = TextSpan(text: entry.label, style: textStyle);
    textPainter.layout();

    final double itemWidth = legendBoxSize + textSpacing + textPainter.width;

    if (currentRowWidth + itemWidth + (rows.last.isEmpty ? 0 : spacing) >
        maxWidth) {
      rows.add([]);
      currentRowWidth = 0;
    }

    rows.last.add(_LegendItem(entry, textPainter.width));
    currentRowWidth += itemWidth + (rows.last.length > 1 ? spacing : 0);
  }

  // Draw from bottom to top
  double currentY = size.height - legendBoxSize - margin;

  for (final row in rows.reversed) {
    double rowWidth =
        row.fold<double>(
          0,
          (sum, item) => sum + legendBoxSize + textSpacing + item.textWidth,
        ) +
        spacing * (row.length - 1);

    double startX = alignment == LegendAlignment.center
        ? (size.width - rowWidth) / 2
        : margin;

    for (final item in row) {
      final paint = Paint()..color = item.entry.color;

      final rect = Rect.fromLTWH(
        startX,
        currentY,
        legendBoxSize,
        legendBoxSize,
      );

      if (rounded) {
        canvas.drawRRect(
          RRect.fromRectAndRadius(rect, Radius.circular(4)),
          paint,
        );
      } else {
        canvas.drawRect(rect, paint);
      }

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

/// LegendEntry model for flexibility
class LegendEntry {
  final String label;
  final Color color;

  LegendEntry({required this.label, required this.color});

  /// Convenience constructor for ShadeType with custom label support
  factory LegendEntry.fromShade(ShadeType shade, {String? customLabel}) {
    return LegendEntry(
      label: customLabel ?? shade.defaultLabel,
      color: shade.setShadeColor(),
    );
  }
}

class _LegendItem {
  final LegendEntry entry;
  final double textWidth;
  _LegendItem(this.entry, this.textWidth);
}

enum LegendAlignment { left, center }
