import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import '../../app/configs/constants.dart';

import '../custom_paint/i_diagram_canvas.dart';


class PdfDiagramCanvas implements IDiagramCanvas {
  final PdfGraphics graphics;
  final PdfDocument document;
  final double pageHeight;
  final PdfFont pdfFont;

  /// 🔥 NEW: single source of truth for scaling
  final double scale;

  PdfDiagramCanvas(
      this.graphics,
      this.document,
      this.pageHeight, {
        required this.pdfFont,
        required this.scale,
      });

  PdfColor _toPdfColor(Color c) {
    return PdfColor.fromInt(c.toARGB32());
  }

  /// Convert Flutter Y (top-down) → PDF Y (bottom-up)
  double _transY(double y) => pageHeight - y;

  @override
  void drawLine(Offset p1, Offset p2, Color color, double width) {
    graphics
      ..setStrokeColor(_toPdfColor(color))
      ..setLineWidth(width * scale)
      ..moveTo(p1.dx, _transY(p1.dy))
      ..lineTo(p2.dx, _transY(p2.dy))
      ..strokePath();
  }

  @override
  void drawDashedLine(Offset p1, Offset p2, Color color, double width) {
    graphics
      ..saveContext()
      ..setLineDashPattern([3 * scale, 3 * scale])
      ..setStrokeColor(_toPdfColor(color))
      ..setLineWidth(width * scale)
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
      ..setLineWidth(0.5 * scale);

    graphics.moveTo(points.first.dx, _transY(points.first.dy));
    for (int i = 1; i < points.length; i++) {
      graphics.lineTo(points[i].dx, _transY(points[i].dy));
    }

    fill ? graphics.fillPath() : graphics.strokePath();
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
      ..setLineWidth(strokeWidth * scale);

    graphics.drawRect(rect.left, _transY(rect.bottom), rect.width, rect.height);

    fill ? graphics.fillPath() : graphics.strokePath();
  }

  @override
  void drawRRect(Rect rect, Radius radius, Color color, {bool fill = true}) {
    graphics
      ..setStrokeColor(_toPdfColor(color))
      ..setFillColor(_toPdfColor(color))
      ..setLineWidth(0.5 * scale);

    final double r = radius.x;
    final double top = rect.top;
    final double bottom = rect.bottom;
    final double left = rect.left;
    final double right = rect.right;

    void drawCorner(double cx, double cy, double startAngle, double sweepAngle) {
      const int steps = 6;
      for (int i = 0; i <= steps; i++) {
        final theta = startAngle + (sweepAngle * (i / steps));
        final px = cx + r * math.cos(theta);
        final py = cy + r * math.sin(theta);
        graphics.lineTo(px, _transY(py));
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

    fill ? graphics.fillPath() : graphics.strokePath();
  }

  @override
  void drawDot(Offset center, Color color, {double? radius, bool fill = true}) {
    final r = (radius ?? 4.0) * scale;

    graphics
      ..setStrokeColor(_toPdfColor(color))
      ..setFillColor(_toPdfColor(color));

    graphics.drawEllipse(center.dx, _transY(center.dy), r, r);

    fill ? graphics.fillPath() : graphics.strokePath();
  }

  @override
  void drawText(String text, Offset position, double fontSize, Color color) {
    graphics
      ..saveContext()
      ..setFillColor(_toPdfColor(color));

    final double finalFontSize = fontSize * kTextScale;

    final lines = text.split('\n');

    for (int i = 0; i < lines.length; i++) {
      final line = lines[i];

      double lineDy = position.dy + (i * (finalFontSize * 1.2));
      double pdfY = _transY(lineDy) - (finalFontSize * 0.8);

      graphics.drawString(
        pdfFont,
        finalFontSize,
        line,
        position.dx,
        pdfY,
      );
    }

    graphics.restoreContext();
  }

  @override
  void paintTextPainter(TextPainter painter, Offset offset) {
    final text = painter.text?.toPlainText() ?? '';
    if (text.isEmpty) return;

    final style = painter.text?.style;
    final baseFontSize = style?.fontSize ?? 12.0;
    final color = style?.color ?? Colors.black;

    final double finalFontSize = baseFontSize * kTextScale;

    final lines = text.split('\n');

    graphics
      ..saveContext()
      ..setFillColor(_toPdfColor(color));

    for (int i = 0; i < lines.length; i++) {
      final line = lines[i];

      double lineDx = offset.dx;

      if (painter.textAlign == TextAlign.center) {
        double lineW = line.length * (finalFontSize * 0.55);
        lineDx += (painter.width - lineW) / 2;
      } else if (painter.textAlign == TextAlign.right) {
        double lineW = line.length * (finalFontSize * 0.55);
        lineDx += (painter.width - lineW);
      }

      double lineDy = offset.dy + (i * (finalFontSize * 1.2));
      double pdfY = _transY(lineDy) - (finalFontSize * 0.8);

      graphics.drawString(pdfFont, finalFontSize, line, lineDx, pdfY);
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