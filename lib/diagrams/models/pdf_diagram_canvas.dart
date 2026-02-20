import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import '../custom_paint/i_diagram_canvas.dart';

import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart' show TextPainter, TextSpan, Colors;
// Assuming you are using the 'pdf' package. Adjust imports if using 'syncfusion_flutter_pdf'.
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart' show TextPainter, TextSpan, Colors;
// Assuming you are using the 'pdf' package. Adjust imports if using 'syncfusion_flutter_pdf'.
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfDiagramCanvas implements IDiagramCanvas {
  final PdfGraphics graphics;
  final PdfDocument document;
  final double pageHeight;
  final PdfFont pdfFont;

  static const double pdfScale = 1.5;

  PdfDiagramCanvas(
    this.graphics,
    this.document,
    this.pageHeight, {
    required this.pdfFont,
  });

  /// Helper to convert Flutter Y (Top-Down) to PDF Y (Bottom-Up)
  double _transY(double y) => pageHeight - y;

  @override
  void drawLine(Offset p1, Offset p2, Color color, double width) {
    graphics
      ..setStrokeColor(PdfColor.fromInt(color.value))
      ..setLineWidth(width * pdfScale)
      ..moveTo(p1.dx, _transY(p1.dy))
      ..lineTo(p2.dx, _transY(p2.dy))
      ..strokePath();
  }

  @override
  void drawDashedLine(Offset p1, Offset p2, Color color, double width) {
    graphics
      ..saveContext()
      ..setLineDashPattern([3, 3])
      ..setStrokeColor(PdfColor.fromInt(color.value))
      ..setLineWidth(width * pdfScale)
      ..moveTo(p1.dx, _transY(p1.dy))
      ..lineTo(p2.dx, _transY(p2.dy))
      ..strokePath()
      ..restoreContext();
  }

  @override
  void drawPath(List<Offset> points, Color color, {bool fill = false}) {
    if (points.length < 2) return;

    graphics
      ..setStrokeColor(PdfColor.fromInt(color.value))
      ..setFillColor(PdfColor.fromInt(color.value))
      ..setLineWidth(0.5 * pdfScale);

    graphics.moveTo(points.first.dx, _transY(points.first.dy));
    for (int i = 1; i < points.length; i++) {
      graphics.lineTo(points[i].dx, _transY(points[i].dy));
    }

    if (fill) {
      graphics.fillPath(); // implicitly closes path
    } else {
      graphics.strokePath(); // usually open unless closed manually
    }
  }

  @override
  void drawRect(
    Rect rect,
    Color color, {
    bool fill = false,
    double strokeWidth = 1.0,
  }) {
    graphics
      ..setStrokeColor(PdfColor.fromInt(color.value))
      ..setFillColor(PdfColor.fromInt(color.value))
      ..setLineWidth(
        strokeWidth,
      ); // 👈 Tell the PDF canvas how thick to draw the line

    // Convert Top-Down Rect to Bottom-Up PDF Rect
    // PDF drawRect usually takes (x, y, width, height) where y is the bottom-left corner
    graphics.drawRect(
      rect.left,
      _transY(rect.bottom), // Bottom-left Y in PDF coords
      rect.width,
      rect.height,
    );

    if (fill) {
      graphics.fillPath();
    } else {
      graphics.strokePath();
    }
  }

  // --- UPDATED: Rounded Rectangle ---
  @override
  void drawRRect(Rect rect, Radius radius, Color color, {bool fill = true}) {
    graphics
      ..setStrokeColor(PdfColor.fromInt(color.value))
      ..setFillColor(PdfColor.fromInt(color.value))
      ..setLineWidth(0.5 * pdfScale);

    final double r = radius.x;
    final double top = rect.top;
    final double bottom = rect.bottom;
    final double left = rect.left;
    final double right = rect.right;

    // Helper to draw corners (Approximation)
    void drawCorner(
      double cx,
      double cy,
      double startAngle,
      double sweepAngle,
    ) {
      const int steps = 6;
      for (int i = 0; i <= steps; i++) {
        final double theta = startAngle + (sweepAngle * (i / steps));
        final double px = cx + r * math.cos(theta);
        final double py = cy + r * math.sin(theta);

        if (i == 0) {
          graphics.lineTo(px, _transY(py));
        } else {
          graphics.lineTo(px, _transY(py));
        }
      }
    }

    // Start drawing (Move to start of top line)
    graphics.moveTo(left + r, _transY(top));

    // Top Edge
    graphics.lineTo(right - r, _transY(top));

    // Top-Right Corner (approx -PI/2 to 0)
    drawCorner(right - r, top + r, -math.pi / 2, math.pi / 2);

    // Right Edge
    graphics.lineTo(right, _transY(bottom - r));

    // Bottom-Right Corner (0 to PI/2)
    drawCorner(right - r, bottom - r, 0, math.pi / 2);

    // Bottom Edge
    graphics.lineTo(left + r, _transY(bottom));

    // Bottom-Left Corner (PI/2 to PI)
    drawCorner(left + r, bottom - r, math.pi / 2, math.pi / 2);

    // Left Edge
    graphics.lineTo(left, _transY(top + r));

    // Top-Left Corner (PI to 3PI/2)
    drawCorner(left + r, top + r, math.pi, math.pi / 2);

    graphics.closePath();

    if (fill) {
      graphics.fillPath();
    } else {
      graphics.strokePath();
    }
  }

  @override
  void drawDot(Offset center, Color color, {double? radius, bool fill = true}) {
    final r = (radius ?? 4.0) * pdfScale;
    graphics
      ..setStrokeColor(PdfColor.fromInt(color.value))
      ..setFillColor(PdfColor.fromInt(color.value));

    // Draw Ellipse (PDF coordinates usually center-based or bounding box)
    // Assuming standard drawEllipse(x, y, rx, ry)
    graphics.drawEllipse(center.dx, _transY(center.dy), r, r);

    if (fill) {
      graphics.fillPath();
    } else {
      graphics.strokePath();
    }
  }

  @override
  void drawText(String text, Offset position, double fontSize, Color color) {
    graphics
      ..saveContext()
      ..setFillColor(PdfColor.fromInt(color.value));

    // Adjust Y because PDF draws from baseline, Flutter draws from Top-Left
    double pdfY = _transY(position.dy) - (fontSize * pdfScale * 0.8);

    // Note: This relies on your specific PDF library's API.
    // Standard 'pdf' package uses: drawString(font, size, text, x, y)
    graphics.drawString(pdfFont, fontSize * pdfScale, text, position.dx, pdfY);

    graphics.restoreContext();
  }

  // --- NEW: Implementation of paintTextPainter ---
  @override
  void paintTextPainter(TextPainter painter, Offset offset) {
    // 1. Extract plain text (PDF fonts don't support Flutter's TextSpans directly)
    final String text = painter.text?.toPlainText() ?? '';
    if (text.isEmpty) return;

    // 2. Extract basic style
    final TextStyle? style = painter.text?.style;
    final double fontSize = style?.fontSize ?? 12.0;
    final Color color = style?.color ?? Colors.black;

    // 3. Handle Multiline Text
    // Since we can't easily replicate Flutter's exact wrapping in raw PDF drawing
    // without a complex layout engine, we will check if the user wanted wrapping.

    // If the text is long, you might want to split it manually or assume
    // the string already has newline characters if you formatted it yourself.

    // For now, we map it to our existing drawText logic.
    // If your PDF library supports multi-line drawString (wraps at \n), this works.
    drawText(text, offset, fontSize, color);

    /* NOTE: If you need true automatic wrapping in PDF (like max-width),
       you typically need to use a high-level widget (like pw.Paragraph)
       rather than raw PdfGraphics commands.

       Since this class is for raw drawing commands, we assume the text
       passed in is either short labels or pre-formatted with \n.
    */
  }

  // --- Transformation Stubs ---

  @override
  void save() => graphics.saveContext();

  @override
  void restore() => graphics.restoreContext();

  @override
  void translate(double dx, double dy) {
    // Note: PDF matrices might differ. Usually (1, 0, 0, 1, dx, dy).
    // Be careful with Y-axis flipping if doing complex transforms.
    graphics.setTransform(Matrix4.translationValues(dx, -dy, 0));
  }

  @override
  void rotate(double radians) {
    // Rotate around Z axis
    graphics.setTransform(Matrix4.rotationZ(-radians));
  }

  @override
  void clipPath(List<Offset> points) {
    if (points.isEmpty) return;
    graphics.moveTo(points.first.dx, _transY(points.first.dy));
    for (var i = 1; i < points.length; i++) {
      graphics.lineTo(points[i].dx, _transY(points[i].dy));
    }
    graphics.closePath();
    graphics.clipPath();
  }
}
