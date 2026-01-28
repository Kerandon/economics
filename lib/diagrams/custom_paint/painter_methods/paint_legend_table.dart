import 'package:economics_app/diagrams/custom_paint/i_diagram_canvas.dart';
import 'package:flutter/material.dart';

import '../../models/diagram_painter_config.dart';
import '../flutter_diagram_canvas.dart';
import '../painter_constants.dart';
Future<void> paintLegendTable(
    Canvas? canvas,
    DiagramPainterConfig config, {
      Offset normalizedTopLeft = const Offset(kAxisIndent, 1 - (kAxisIndent * 0.95)),
      required List<String> headers,
      required List<List<String>> data,
      double rowHeight = 14.0, // Unified height for header and cells
      Color? borderColor,
      double cellPadding = 25.0, // Reduced padding for compactness
      IDiagramCanvas? iCanvas,
    }) async {
  iCanvas ??= canvas != null ? FlutterDiagramCanvas(canvas) : null;
  if (iCanvas == null) return;

  final primaryColor = config.colorScheme.onSurface;
  final double startX = normalizedTopLeft.dx * config.painterSize.width;
  double currentY = normalizedTopLeft.dy * config.painterSize.height;

  // 1. Unified Compact Style
  final baseStyle = TextStyle(
    fontSize: kFontTiny, // Using your smallest constant
    color: primaryColor,
  );

  // 2. Measure Column Widths (Unified for both headers and data)
  final int numCols = headers.length;
  List<double> colWidths = List.filled(numCols, 0.0);

  double measure(String text) {
    return (TextPainter(
      text: TextSpan(text: text, style: baseStyle),
      textDirection: TextDirection.ltr,
    )..layout()).width + (cellPadding * 2);
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

  // 3. Helper to draw a full row (Header or Data)
  void drawRow(List<String> rowData, bool isHeader) {
    double x = startX;
    if (isHeader) {
      iCanvas!.drawRect(Rect.fromLTWH(x, currentY, totalWidth, rowHeight),
          primaryColor.withOpacity(0.1), fill: true);
    }

    for (int i = 0; i < numCols; i++) {
      final rect = Rect.fromLTWH(x, currentY, colWidths[i], rowHeight);
      iCanvas!.drawRect(rect, borderColor ?? primaryColor, fill: false);

      if (i < rowData.length) {
        iCanvas.drawText(
          rowData[i],
          rect.center,
          baseStyle.fontSize!,
          baseStyle.color!,
          align: TextAlign.center,
        );
      }
      x += colWidths[i];
    }
    currentY += rowHeight;
  }

  // 4. Execute Drawing
  drawRow(headers, true); // Draw Header
  for (var row in data) {
    drawRow(row, false); // Draw Data Rows
  }
}