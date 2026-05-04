import 'package:flutter/material.dart';
import '../../models/diagram_painter_config.dart';
import '../i_diagram_canvas.dart';
import '../painter_methods/paint_text.dart';
import 'shade_type.dart';
import '../../models/custom_bezier.dart';
import '../painter_constants.dart';
void paintShading(
    DiagramPainterConfig config,
    IDiagramCanvas canvas,
    ShadeType shade,
    List<dynamic> pointsAndBeziers, {
      bool striped = true,
      double stripeSpacing = 30.0,
      double strokeWidth = 2.0,
      int alpha = 80,
      bool invertStripes = false,
      String? label,
      Color? labelColor,
      LabelAlign labelAlign = LabelAlign.center,
      bool showLabelBackground = true,
      double labelPadding = 20.0,
    }) {
  if (pointsAndBeziers.isEmpty) return;

  // 🌟 MAGIC CHECK: Detect if we are printing to the PDF
  final bool isPdf = canvas.runtimeType.toString() == 'PdfDiagramCanvas';

  final double width = config.painterSize.width;
  final double height = config.painterSize.height;

  // Coordinate math
  final double normalizeW = 1 - (kAxisIndent * 2);
  final double normalizeH =
      1 - (kAxisIndent * (kTopAxisIndent + kBottomAxisIndent));
  final double indentX = width * kAxisIndent;
  final double indentY = height * (kAxisIndent * kTopAxisIndent);

  Offset toCanvasCoords(Offset pos) {
    return Offset(
      pos.dx * (width * normalizeW) + indentX,
      pos.dy * (height * normalizeH) + indentY,
    );
  }

  // 1. Build the Polyline
  final List<Offset> polyline = [];
  for (final item in pointsAndBeziers) {
    if (item is Offset) {
      polyline.add(toCanvasCoords(item));
    } else if (item is CustomBezier) {
      final startPoint = polyline.isNotEmpty
          ? polyline.last
          : toCanvasCoords(Offset.zero);
      final control = toCanvasCoords(item.control);
      final endPoint = toCanvasCoords(item.endPoint);
      for (double t = 0.1; t <= 1.0; t += 0.1) {
        polyline.add(
          Offset(
            (1 - t) * (1 - t) * startPoint.dx +
                2 * (1 - t) * t * control.dx +
                t * t * endPoint.dx,
            (1 - t) * (1 - t) * startPoint.dy +
                2 * (1 - t) * t * control.dy +
                t * t * endPoint.dy,
          ),
        );
      }
    }
  }

  final color = shade.setShadeColor();

  // 2. Draw Background Fill
  // FIX: Only draw this on the screen. PDF viewers often merge transparent fills
  // and stripes into a single solid block.
  if (!isPdf) {
    canvas.drawPath(polyline, color.withAlpha(alpha ~/ 3), fill: true);
  }

  // 3. Draw the Stripes
  if (striped) {
    canvas.save();
    canvas.clipPath(polyline);

    final double maxDim = width + height;
    final stripeColor = color.withAlpha(alpha + 20);

// FIX: Bring the PDF spacing way down so the stripes are tightly packed,
    // but keep the stroke ultra-thin so they don't merge into a block again.
    final double spacing = isPdf ? 5.0 : (stripeSpacing * config.averageRatio);
    final double actualStroke = isPdf ? 0.30 : (strokeWidth * config.averageRatio);

    for (double i = -maxDim; i < maxDim; i += spacing) {
      Offset p1 = invertStripes ? Offset(0, i + width) : Offset(0, i);
      Offset p2 = invertStripes ? Offset(width, i) : Offset(width, i + width);
      canvas.drawLine(p1, p2, stripeColor, actualStroke);
    }

    canvas.restore();
  }

  // 4. Draw Center Label
  if (label != null && polyline.isNotEmpty) {
    double minX = polyline.first.dx;
    double maxX = polyline.first.dx;
    double minY = polyline.first.dy;
    double maxY = polyline.first.dy;

    for (final p in polyline) {
      if (p.dx < minX) minX = p.dx;
      if (p.dx > maxX) maxX = p.dx;
      if (p.dy < minY) minY = p.dy;
      if (p.dy > maxY) maxY = p.dy;
    }

    final Offset centerPos = Offset((minX + maxX) / 2, (minY + maxY) / 2);
    final double gapValue = labelPadding * config.averageRatio;
    Offset nudge = Offset.zero;
    LabelPivot hPivot = LabelPivot.center;
    LabelPivot vPivot = LabelPivot.middle;

    switch (labelAlign) {
      case LabelAlign.centerTop: hPivot = LabelPivot.center; vPivot = LabelPivot.bottom; nudge = Offset(0, -gapValue); break;
      case LabelAlign.centerBottom: hPivot = LabelPivot.center; vPivot = LabelPivot.top; nudge = Offset(0, gapValue); break;
      case LabelAlign.left: hPivot = LabelPivot.right; vPivot = LabelPivot.middle; nudge = Offset(-gapValue, 0); break;
      case LabelAlign.right: hPivot = LabelPivot.left; vPivot = LabelPivot.middle; nudge = Offset(gapValue, 0); break;
      case LabelAlign.topLeft: hPivot = LabelPivot.right; vPivot = LabelPivot.bottom; nudge = Offset(-gapValue, -gapValue); break;
      case LabelAlign.topRight: hPivot = LabelPivot.left; vPivot = LabelPivot.bottom; nudge = Offset(gapValue, -gapValue); break;
      case LabelAlign.bottomLeft: hPivot = LabelPivot.right; vPivot = LabelPivot.top; nudge = Offset(-gapValue, gapValue); break;
      case LabelAlign.bottomRight: hPivot = LabelPivot.left; vPivot = LabelPivot.top; nudge = Offset(gapValue, gapValue); break;
      case LabelAlign.center: hPivot = LabelPivot.center; vPivot = LabelPivot.middle; nudge = Offset.zero; break;
    }

    paintText(
      config,
      canvas,
      label,
      centerPos + nudge,
      fontSize: kFontTiny * 0.85,
      style: TextStyle(color: labelColor ?? config.colorScheme.onSurface),
      horizontalPivot: hPivot,
      verticalPivot: vPivot,
      normalize: false,
      showBackground: showLabelBackground,
      shape: DiagramShape.none,
    );
  }
}