import 'package:flutter/material.dart';

import '../../../models/diagram_painter_config.dart';
import '../../i_diagram_canvas.dart';
import '../../painter_constants.dart';

void paintLabelText(
  Canvas? canvas, // Made nullable
  DiagramPainterConfig config,
  String label,
  Offset pos, {
  IDiagramCanvas? iCanvas, // Added bridge
  Color? backgroundColor,
  LabelAlign labelAlign = LabelAlign.center,
}) {
  final widthAndHeight = config.painterSize.width;
  final fontSize = kFontMedium * config.averageRatio;
  final padding = widthAndHeight * 0.01;
  final textColor = config.colorScheme.onSurface;

  /// We still use TextPainter to calculate dimensions for the PDF bridge
  final textPainter = TextPainter(
    text: TextSpan(
      text: label,
      style: TextStyle(color: textColor, fontSize: fontSize),
    ),
    textDirection: TextDirection.ltr,
  )..layout(minWidth: 0, maxWidth: widthAndHeight);

  Offset baseOffset = Offset(pos.dx * widthAndHeight, pos.dy * widthAndHeight);

  double dx = 0;
  double dy = 0;

  // --- Alignment Logic (Identical to maintain consistency) ---
  switch (labelAlign) {
    case LabelAlign.center:
      dx = -textPainter.width / 2;
      dy = -textPainter.height / 2;
      break;
    case LabelAlign.centerLeft:
      dx = -textPainter.width - padding;
      dy = -textPainter.height / 2;
      break;
    case LabelAlign.centerRight:
      dx = padding;
      dy = -textPainter.height / 2;
      break;
    case LabelAlign.centerTop:
      dx = -textPainter.width / 2;
      dy = -textPainter.height - padding;
      break;
    case LabelAlign.centerBottom:
      dx = -textPainter.width / 2;
      dy = padding;
      break;
  }

  baseOffset = baseOffset.translate(dx, dy);

  // --- 1. Draw Background (if applicable) ---
  if (backgroundColor != null) {
    const bgPadding = 1.0;
    final rect = Rect.fromLTWH(
      baseOffset.dx - bgPadding,
      baseOffset.dy - bgPadding,
      textPainter.width + bgPadding * 2,
      textPainter.height + bgPadding * 2,
    );

    if (iCanvas != null) {
      iCanvas.drawRect(rect, backgroundColor, fill: true);
    } else if (canvas != null) {
      final bgPaint = Paint()
        ..color = backgroundColor
        ..style = PaintingStyle.fill;
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, const Radius.circular(6)),
        bgPaint,
      );
    }
  }

  // --- 2. Draw Text ---
  if (iCanvas != null) {
    // Translate our LabelAlign enum to the PDF bridge's TextAlign
    TextAlign pdfAlign = TextAlign.left;
    if (labelAlign == LabelAlign.center ||
        labelAlign == LabelAlign.centerTop ||
        labelAlign == LabelAlign.centerBottom) {
      pdfAlign = TextAlign.center;
    }

    iCanvas.drawText(
      label,
      baseOffset, // Use calculated baseOffset
      fontSize,
      textColor,
    );
  } else if (canvas != null) {
    textPainter.paint(canvas, baseOffset);
  }
}
