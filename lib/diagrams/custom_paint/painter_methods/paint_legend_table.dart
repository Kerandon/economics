import 'package:economics_app/diagrams/custom_paint/i_diagram_canvas.dart';
import 'package:flutter/material.dart';

import '../../models/diagram_painter_config.dart';
import '../painter_constants.dart';

void paintLegendTable(
  IDiagramCanvas iCanvas,
  DiagramPainterConfig config, {
  required List<String> headers,
  required List<List<String>> data,
  double rowHeight = 16.0,
  Color? borderColor,
  double cellPadding = 6.0,
}) async {
  final primaryColor = config.colorScheme.onSurface;
  final size = config.painterSize;

  // 1. DETECT IF PRINTING TO PDF
  // We use runtimeType so we don't have to import the PDF package into your diagram logic.
  final bool isPdf = iCanvas.runtimeType.toString() == 'PdfDiagramCanvas';

  // 2. DYNAMIC SIZING (Shrink significantly if PDF)
  final double finalRowHeight = isPdf ? 9.0 : rowHeight;
  final double finalCellPadding = isPdf ? 2.0 : cellPadding;

  // Make the font much smaller for the PDF print
  final double fontSizeMultiplier = isPdf ? 0.45 : 0.9;
  final double fontSize =
      (kFontMedium * config.averageRatio) * fontSizeMultiplier;

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
    return tp.width + (finalCellPadding * 2);
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

  // Position at the bottom
  final double startX = (size.width - totalWidth) / 2.0;
  double currentY = size.height + -((kAxisIndent * size.height) / 1.2);

  // Helper to draw a full row
  void drawRow(List<String> rowData, bool isHeader) {
    double x = startX;

    // 3. REMOVE HEADER COLORING FOR PDF
    // It will only draw the shaded background on the screen.
    if (isHeader && !isPdf) {
      iCanvas.drawRect(
        Rect.fromLTWH(x, currentY, totalWidth, finalRowHeight),
        primaryColor.withOpacity(0.1),
        fill: true,
      );
    }

    for (int i = 0; i < numCols; i++) {
      final rect = Rect.fromLTWH(x, currentY, colWidths[i], finalRowHeight);

      // Thinner borders for the PDF so it doesn't look muddy
      iCanvas.drawRect(
        rect,
        borderColor ?? primaryColor.withOpacity(0.3),
        fill: false,
        strokeWidth: isPdf ? 0.3 : 0.5,
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
          rect.top + (finalRowHeight - tp.height) / 2,
        );

        iCanvas.drawText(rowData[i], textOffset, fontSize, primaryColor);
      }
      x += colWidths[i];
    }
    currentY += finalRowHeight;
  }

  // Execute Drawing
  drawRow(headers, true);
  for (var row in data) {
    drawRow(row, false);
  }
}
