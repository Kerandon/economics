import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import '../custom_paint/i_diagram_canvas.dart';

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
      ..setLineWidth(0.5); // Very thin stroke for filled shapes

    graphics.moveTo(points.first.dx, _transY(points.first.dy));
    for (int i = 1; i < points.length; i++) {
      graphics.lineTo(points[i].dx, _transY(points[i].dy));
    }

    if (fill) {
      graphics.closePath();
      graphics.fillPath();
    } else {
      graphics.strokePath();
    }
  }

  @override
  void drawRect(Rect rect, Color color, {bool fill = false}) {
    graphics
      ..setStrokeColor(PdfColor.fromInt(color.value))
      ..setFillColor(PdfColor.fromInt(color.value));

    // Convert Top-Down Rect to Bottom-Up PDF Rect
    graphics.drawRect(
      rect.left,
      _transY(rect.top) - rect.height,
      rect.width,
      rect.height,
    );

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
      ..setFillColor(PdfColor.fromInt(color.value))
      ..drawEllipse(center.dx, _transY(center.dy), r, r);

    fill ? graphics.fillPath() : graphics.strokePath();
  }

  @override
  void drawText(String text, Offset position, double fontSize, Color color) {
    graphics
      ..saveContext()
      ..setFillColor(PdfColor.fromInt(color.value));

    // PDF draws text from the baseline; adjust slightly so 'position' is Top-Left
    double pdfY = _transY(position.dy) - (fontSize * 0.85);

    graphics.drawString(pdfFont, fontSize * pdfScale, text, position.dx, pdfY);

    graphics.restoreContext();
  }

  // --- Transformation Stubs (Safely ignored or implemented simply) ---

  @override
  void save() => graphics.saveContext();

  @override
  void restore() => graphics.restoreContext();

  @override
  void translate(double dx, double dy) {
    // We handle translation in the points now, but we'll keep the logic
    // for other potential uses. Use Matrix4 for absolute positioning.
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
