
import 'package:flutter/material.dart';

import '../../models/diagram_painter_config.dart';
import '../painter_constants.dart';
Future<void> paintLegendTable(
    Canvas canvas,
    DiagramPainterConfig config, {
      Offset normalizedTopLeft = const Offset(kAxisIndent * 1.5, 1 - (kAxisIndent * 0.80)),
      required List<String> headers,
      required List<List<String>> data,
      double cellHeight = 28,
      double headerHeight = 32,
      Color? borderColor,
      Color? headerColor,
      TextStyle? headerStyle,
      TextStyle? cellStyle,
      String? title,
      double titleHeight = 30,
      TextStyle? titleStyle,
      String? caption,
      double captionHeight = 22,
      TextStyle? captionStyle,
      double cellPadding = 12.0,
    }) async {
  // ✅ Default color for all table elements
  final primaryColor = config.colorScheme.onSurface;

  // 💥 Convert normalized coordinates to pixel coordinates
  final Size painterSize = config.painterSize;
  final double pixelStartX = normalizedTopLeft.dx * painterSize.width;
  final double pixelStartY = normalizedTopLeft.dy * painterSize.height;

  // ✅ Border paint uses default color
  final paintBorder = Paint()
    ..color = borderColor ?? primaryColor
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1.5;

  double startY = pixelStartY;
  double startX = pixelStartX;

  // --- Dynamic Column Width Calculation ---
  final int numColumns = headers.length;
  List<double> columnWidths = List.filled(numColumns, 0.0);

  double measureTextWidth(String text, TextStyle style) {
    final tp = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    return tp.width;
  }

  // ✅ Default text styles
  final effectiveHeaderStyle = headerStyle ??
      TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: kFontSmall * 0.80,
        color: primaryColor,
      );

  final effectiveCellStyle = cellStyle ??
      TextStyle(
        fontSize: kFontSmall * 0.90,
        color: primaryColor,
      );

  final effectiveTitleStyle = titleStyle ??
      TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: kFontSmall * 0.80,
        color: primaryColor,
      );

  final effectiveCaptionStyle = captionStyle ??
      TextStyle(
        fontSize: 12,
        color: primaryColor,
      );

  for (int col = 0; col < numColumns; col++) {
    final headerTextWidth = measureTextWidth(headers[col], effectiveHeaderStyle);
    columnWidths[col] = headerTextWidth + cellPadding * 2;
  }

  for (int row = 0; row < data.length; row++) {
    for (int col = 0; col < numColumns && col < data[row].length; col++) {
      final cellTextWidth = measureTextWidth(data[row][col], effectiveCellStyle);
      final requiredWidth = cellTextWidth + cellPadding * 2;
      if (requiredWidth > columnWidths[col]) {
        columnWidths[col] = requiredWidth;
      }
    }
  }

  final double totalTableWidth = columnWidths.reduce((a, b) => a + b);

  // --- Drawing ---

  // Draw title
  if (title != null) {
    final tp = TextPainter(
      text: TextSpan(text: title, style: effectiveTitleStyle),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    tp.layout(maxWidth: totalTableWidth);
    tp.paint(canvas, Offset(startX + (totalTableWidth - tp.width) / 2, startY));
    startY += titleHeight;
  }

  // Draw header background
  final headerRect = Rect.fromLTWH(startX, startY, totalTableWidth, headerHeight);
  final paintHeader = Paint()..color = headerColor ?? primaryColor.withOpacity(0.1);
  canvas.drawRect(headerRect, paintHeader);

  double currentX = startX;

  // Draw header text and borders
  for (int col = 0; col < numColumns; col++) {
    final double colWidth = columnWidths[col];
    final rect = Rect.fromLTWH(currentX, startY, colWidth, headerHeight);
    canvas.drawRect(rect, paintBorder);

    final tp = TextPainter(
      text: TextSpan(text: headers[col], style: effectiveHeaderStyle),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    tp.layout(maxWidth: colWidth - cellPadding * 2);
    tp.paint(
      canvas,
      Offset(
        rect.left + (colWidth - tp.width) / 2,
        rect.top + (headerHeight - tp.height) / 2,
      ),
    );
    currentX += colWidth;
  }

  startY += headerHeight;

  // Draw data rows
  for (int row = 0; row < data.length; row++) {
    currentX = startX;
    for (int col = 0; col < numColumns && col < data[row].length; col++) {
      final double colWidth = columnWidths[col];
      final rect = Rect.fromLTWH(
        currentX,
        startY + row * cellHeight,
        colWidth,
        cellHeight,
      );
      canvas.drawRect(rect, paintBorder);

      final tp = TextPainter(
        text: TextSpan(text: data[row][col], style: effectiveCellStyle),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );
      tp.layout(maxWidth: colWidth - cellPadding * 2);
      tp.paint(
        canvas,
        Offset(
          rect.left + (colWidth - tp.width) / 2,
          rect.top + (cellHeight - tp.height) / 2,
        ),
      );
      currentX += colWidth;
    }
  }

  startY += data.length * cellHeight;

  // Draw caption if provided
  if (caption != null) {
    final tp = TextPainter(
      text: TextSpan(text: caption, style: effectiveCaptionStyle),
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
    );
    tp.layout(maxWidth: totalTableWidth);
    tp.paint(canvas, Offset(startX, startY));
  }
}
