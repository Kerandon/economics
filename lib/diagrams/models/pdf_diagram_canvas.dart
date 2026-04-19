import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import '../custom_paint/i_diagram_canvas.dart';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import '../custom_paint/i_diagram_canvas.dart';

class PdfDiagramCanvas implements IDiagramCanvas {
  final PdfGraphics graphics;
  final PdfDocument document;
  final double pageHeight;
  final PdfFont pdfFont;

  // FIX FOR ISSUE 2 & 4: Setting scale to 1.0 ensures text bounding boxes
  // match exactly with Flutter's calculations, preventing labels from overlapping axes
  // and keeping text contained in the drawn shape borders.
  static const double pdfScale = 1.0;

  PdfDiagramCanvas(
    this.graphics,
    this.document,
    this.pageHeight, {
    required this.pdfFont,
  });

  // FIX FOR ISSUE 3 & 4: Properly extract the Alpha channel from Flutter Color
  // so transparent colors (like the legend header and shaded areas) don't render as solid black.
  PdfColor _toPdfColor(Color c) {
    return PdfColor(
      c.red / 255.0,
      c.green / 255.0,
      c.blue / 255.0,
      c.alpha / 255.0,
    );
  }

  /// Helper to convert Flutter Y (Top-Down) to PDF Y (Bottom-Up)
  double _transY(double y) => pageHeight - y;

  @override
  void drawLine(Offset p1, Offset p2, Color color, double width) {
    graphics
      ..setStrokeColor(_toPdfColor(color))
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
      ..setStrokeColor(_toPdfColor(color))
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
      ..setStrokeColor(_toPdfColor(color))
      ..setFillColor(_toPdfColor(color))
      ..setLineWidth(0.5 * pdfScale);

    graphics.moveTo(points.first.dx, _transY(points.first.dy));
    for (int i = 1; i < points.length; i++) {
      graphics.lineTo(points[i].dx, _transY(points[i].dy));
    }

    if (fill) {
      graphics.fillPath();
    } else {
      graphics.strokePath();
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
      ..setStrokeColor(_toPdfColor(color))
      ..setFillColor(_toPdfColor(color))
      ..setLineWidth(strokeWidth * pdfScale);

    graphics.drawRect(rect.left, _transY(rect.bottom), rect.width, rect.height);

    if (fill) {
      graphics.fillPath();
    } else {
      graphics.strokePath();
    }
  }

  @override
  void drawRRect(Rect rect, Radius radius, Color color, {bool fill = true}) {
    graphics
      ..setStrokeColor(_toPdfColor(color))
      ..setFillColor(_toPdfColor(color))
      ..setLineWidth(0.5 * pdfScale);

    final double r = radius.x;
    final double top = rect.top;
    final double bottom = rect.bottom;
    final double left = rect.left;
    final double right = rect.right;

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

    graphics.moveTo(left + r, _transY(top));
    graphics.lineTo(right - r, _transY(top));
    drawCorner(right - r, top + r, -math.pi / 2, math.pi / 2);
    graphics.lineTo(right, _transY(bottom - r));
    drawCorner(right - r, bottom - r, 0, math.pi / 2);
    graphics.lineTo(left + r, _transY(bottom));
    drawCorner(left + r, bottom - r, math.pi / 2, math.pi / 2);
    graphics.lineTo(left, _transY(top + r));
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
      ..setStrokeColor(_toPdfColor(color))
      ..setFillColor(_toPdfColor(color));

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
      ..setFillColor(_toPdfColor(color));

    // FIX FOR ISSUE 1: Split simple text by newline to render multi-line labels
    final lines = text.split('\n');
    for (int i = 0; i < lines.length; i++) {
      final line = lines[i];
      double lineDy = position.dy + (i * (fontSize * 1.2));
      double pdfY = _transY(lineDy) - (fontSize * pdfScale * 0.8);
      graphics.drawString(
        pdfFont,
        fontSize * pdfScale,
        line,
        position.dx,
        pdfY,
      );
    }

    graphics.restoreContext();
  }

  @override
  void paintTextPainter(TextPainter painter, Offset offset) {
    final String text = painter.text?.toPlainText() ?? '';
    if (text.isEmpty) return;

    final TextStyle? style = painter.text?.style;
    final double fontSize = style?.fontSize ?? 12.0;
    final Color color = style?.color ?? Colors.black;

    // FIX FOR ISSUE 1: Split string by newline character for complex painters
    final lines = text.split('\n');

    graphics
      ..saveContext()
      ..setFillColor(_toPdfColor(color));

    for (int i = 0; i < lines.length; i++) {
      final line = lines[i];

      // Approximate X alignment based on Flutter's text layout width
      double lineDx = offset.dx;
      if (painter.textAlign == TextAlign.center) {
        double lineW = line.length * (fontSize * 0.55 * pdfScale);
        lineDx += (painter.width - lineW) / 2;
      } else if (painter.textAlign == TextAlign.right) {
        double lineW = line.length * (fontSize * 0.55 * pdfScale);
        lineDx += (painter.width - lineW);
      }

      // Adjust Y for multiple lines
      double lineDy = offset.dy + (i * (fontSize * 1.2));
      double pdfY = _transY(lineDy) - (fontSize * pdfScale * 0.8);

      graphics.drawString(pdfFont, fontSize * pdfScale, line, lineDx, pdfY);
    }

    graphics.restoreContext();
  }

  @override
  void save() => graphics.saveContext();

  @override
  void restore() => graphics.restoreContext();

  @override
  void translate(double dx, double dy) {
    graphics.setTransform(Matrix4.translationValues(dx, -dy, 0));
  }

  @override
  void rotate(double radians) {
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
