import 'package:economics_app/diagrams/custom_paint/i_diagram_canvas.dart';
import 'package:flutter/material.dart';

import '../../models/diagram_painter_config.dart';
import '../painter_constants.dart';

void paintLegendTable(
  IDiagramCanvas iCanvas, // 👈 Required interface
  DiagramPainterConfig config, {
  Offset normalizedTopLeft = const Offset(
    kAxisIndent,
    1 - (kAxisIndent * 0.95),
  ),
  required List<String> headers,
  required List<List<String>> data,
  double rowHeight = 14.0,
  Color? borderColor,
  double cellPadding = 6.0, // Adjusted for typical table padding
}) async {
  final primaryColor = config.colorScheme.onSurface;
  final size = config.painterSize;
  final double startX = normalizedTopLeft.dx * size.width;
  double currentY = normalizedTopLeft.dy * size.height;

  // 1. Unified Style
  final double fontSize = kFontMedium * config.averageRatio;

  // 2. Measure Column Widths
  // We use TextPainter locally for measurement as it's the most reliable cross-platform tool
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

  // 3. Helper to draw a full row
  void drawRow(List<String> rowData, bool isHeader) {
    double x = startX;

    if (isHeader) {
      // Light background for header
      iCanvas.drawRect(
        Rect.fromLTWH(x, currentY, totalWidth, rowHeight),
        primaryColor.withOpacity(0.1),
        fill: true,
      );
    }

    for (int i = 0; i < numCols; i++) {
      final rect = Rect.fromLTWH(x, currentY, colWidths[i], rowHeight);

      // Cell Border
      iCanvas.drawRect(rect, borderColor ?? primaryColor, fill: false);

      if (i < rowData.length) {
        // Center text horizontally, and slightly adjust vertically for the baseline
        // Note: position needs to be Top-Left for your bridge logic
        final tp = TextPainter(
          text: TextSpan(
            text: rowData[i],
            style: TextStyle(fontSize: fontSize),
          ),
          textDirection: TextDirection.ltr,
        )..layout();

        final textOffset = Offset(
          rect.left + (rect.width - tp.width) / 2,
          rect.top + (rowHeight - fontSize) / 2,
        );

        iCanvas.drawText(rowData[i], textOffset, fontSize, primaryColor);
      }
      x += colWidths[i];
    }
    currentY += rowHeight;
  }

  // 4. Execute Drawing
  drawRow(headers, true);
  for (var row in data) {
    drawRow(row, false);
  }
}
