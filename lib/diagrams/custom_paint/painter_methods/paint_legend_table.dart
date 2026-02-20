import 'package:economics_app/diagrams/custom_paint/i_diagram_canvas.dart';
import 'package:flutter/material.dart';

import '../../models/diagram_painter_config.dart';
import '../painter_constants.dart';

void paintLegendTable(
  IDiagramCanvas iCanvas,
  DiagramPainterConfig config, {
  required List<String> headers,
  required List<List<String>> data,
  // 1. Reduced rowHeight from 14.0 to 12.0 for a tighter look
  double rowHeight = 12.0,
  Color? borderColor,
  // 2. Reduced padding slightly from 6.0 to 4.0
  double cellPadding = 4.0,
}) async {
  final primaryColor = config.colorScheme.onSurface;
  final size = config.painterSize;

  // 3. Made font slightly smaller (multiplier from 0.65 -> 0.6)
  final double fontSize = (kFontMedium * config.averageRatio) * 0.6;

  // Measure Column Widths
  final int numCols = headers.length;
  List<double> colWidths = List.filled(numCols, 0.0);

  double measure(String text) {
    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(fontSize: fontSize),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    return tp.width + (cellPadding * 2);
  }

  for (int i = 0; i < numCols; i++) {
    colWidths[i] = measure(headers[i]);
    for (var row in data) {
      if (i < row.length) {
        final w = measure(row[i]);
        if (w > colWidths[i]) colWidths[i] = w;
      }
    }
  }

  final double totalWidth = colWidths.reduce((a, b) => a + b);

  // 4. CHANGE: Instead of subtracting height, we start AT the bottom edge
  // and push down by the offset. This ensures it doesn't overlap the diagram.
  final double startX = (size.width - totalWidth) / 2.0;
  double currentY = size.height + -((kAxisIndent * size.height) / 2);

  // Helper to draw a full row
  void drawRow(List<String> rowData, bool isHeader) {
    double x = startX;

    if (isHeader) {
      iCanvas.drawRect(
        Rect.fromLTWH(x, currentY, totalWidth, rowHeight),
        primaryColor.withOpacity(0.1),
        fill: true,
      );
    }

    for (int i = 0; i < numCols; i++) {
      final rect = Rect.fromLTWH(x, currentY, colWidths[i], rowHeight);

      // Thinner borders (0.5 stroke)
      iCanvas.drawRect(
        rect,
        borderColor ??
            primaryColor.withOpacity(0.3), // Slightly lighter opacity
        fill: false,
        strokeWidth: 0.5,
      );

      if (i < rowData.length) {
        final tp = TextPainter(
          text: TextSpan(
            text: rowData[i],
            style: TextStyle(fontSize: fontSize),
          ),
          textDirection: TextDirection.ltr,
        )..layout();

        // Centering the text inside the cell
        final textOffset = Offset(
          rect.left + (rect.width - tp.width) / 2,
          rect.top +
              (rowHeight - tp.height) /
                  2, // Using tp.height for vertical precision
        );

        iCanvas.drawText(rowData[i], textOffset, fontSize, primaryColor);
      }
      x += colWidths[i];
    }
    currentY += rowHeight;
  }

  // Execute Drawing
  drawRow(headers, true);
  for (var row in data) {
    drawRow(row, false);
  }
}
