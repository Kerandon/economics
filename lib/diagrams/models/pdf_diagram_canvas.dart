import 'dart:math' as math;

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

  // --- NEW IMPLEMENTATION: Rounded Rectangle ---
  @override
  void drawRRect(Rect rect, Radius radius, Color color, {bool fill = true}) {
    graphics
      ..setStrokeColor(PdfColor.fromInt(color.value))
      ..setFillColor(PdfColor.fromInt(color.value))
      ..setLineWidth(0.5); // Thin stroke for filled shapes

    // Helper to draw a corner using line segments (Approximation)
    // This ensures compatibility regardless of whether 'curveTo' or 'drawBezier' exists.
    void lineToCorner(
      double centerX,
      double centerY,
      double r,
      double startAngle,
      double sweepAngle,
    ) {
      const int steps = 8; // High resolution for smooth PDF look
      for (int i = 0; i <= steps; i++) {
        final double theta = startAngle + (sweepAngle * (i / steps));
        final double dx = centerX + r * math.cos(theta);
        final double dy = centerY + r * math.sin(theta);
        // Note: _transY logic handles the Y-flip, so we calculate "visual" dy here
        // but pass it to a method that calls _transY, OR we handle it manually.
        // Since we are using 'lineTo' which calls _transY, we pass Flutter coordinates.
        graphics.lineTo(dx, _transY(dy));
      }
    }

    final double left = rect.left;
    final double right = rect.right;
    final double top = rect.top;
    final double bottom = rect.bottom;
    final double r = radius.x; // Assuming uniform radius for simplicity

    // Start at Top-Left (after corner)
    graphics.moveTo(left + r, _transY(top));

    // Top Edge
    graphics.lineTo(right - r, _transY(top));

    // Top-Right Corner (0 to PI/2 visually, but math varies by coord system)
    // Standard Trig: 0 is Right, PI/2 is Down (in Flutter coords).
    // We draw the arc manually.
    // Corner Center: (right - r, top + r)
    // Start Angle: -PI/2 (Top), Sweep: PI/2 (to Right) -> In flutter Top is -Y?
    // Let's keep it simple: We know the points.

    // Top-Right Corner
    // Center: (right - r, top + r)
    // From (right - r, top) to (right, top + r)
    // Angle: -PI/2 to 0
    _drawCornerApprox(
      graphics,
      right - r,
      top + r,
      r,
      -math.pi / 2,
      math.pi / 2,
    );

    // Right Edge
    graphics.lineTo(right, _transY(bottom - r));

    // Bottom-Right Corner
    // Center: (right - r, bottom - r)
    // Angle: 0 to PI/2
    _drawCornerApprox(graphics, right - r, bottom - r, r, 0, math.pi / 2);

    // Bottom Edge
    graphics.lineTo(left + r, _transY(bottom));

    // Bottom-Left Corner
    // Center: (left + r, bottom - r)
    // Angle: PI/2 to PI
    _drawCornerApprox(
      graphics,
      left + r,
      bottom - r,
      r,
      math.pi / 2,
      math.pi / 2,
    );

    // Left Edge
    graphics.lineTo(left, _transY(top + r));

    // Top-Left Corner
    // Center: (left + r, top + r)
    // Angle: PI to 3PI/2 (or -PI)
    _drawCornerApprox(graphics, left + r, top + r, r, math.pi, math.pi / 2);

    graphics.closePath();

    if (fill) {
      graphics.fillPath();
    } else {
      graphics.strokePath();
    }
  }

  // Helper for drawing arc approximation using lineTo
  void _drawCornerApprox(
    PdfGraphics g,
    double cx,
    double cy,
    double r,
    double startAngle,
    double sweepAngle,
  ) {
    const int steps = 6;
    for (int i = 1; i <= steps; i++) {
      final double t = startAngle + (sweepAngle * i / steps);
      final double px = cx + r * math.cos(t);
      final double py = cy + r * math.sin(t);
      g.lineTo(px, _transY(py));
    }
  }
  // ---------------------------------------------

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

  // --- Transformation Stubs ---

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
