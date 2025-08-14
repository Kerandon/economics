
import 'package:flutter/material.dart';
import '../../models/diagram_painter_config.dart';
import '../painter_constants.dart';

paintTextBox({
  required Canvas canvas,
  required DiagramPainterConfig config,
  required String text,
  required Offset position,
  double fontSize = 38,
  Offset? linePoint,
  bool addLineDot = false,
  Color? lineColor,
  bool showBoxBorder = false,
  Color? boxFillColor,
  Color? boxStrokeColor,
  bool dottedBorder = false,
  double? boxBorderWidth, // ✅ New parameter
}) {
  final sizeAdjustment = config.averageRatio;

  final adjustedPos = Offset(
    position.dx * config.painterSize.width,
    position.dy * config.painterSize.height,
  );

  if (linePoint != null) {
    final lineEndX = config.painterSize.width * linePoint.dx;
    final lineEndY = config.painterSize.height * linePoint.dy;
    final linePaint = Paint()
      ..color = lineColor ?? config.colorScheme.onSurface
      ..strokeWidth = kCurveWidth / 5;
    canvas.drawLine(adjustedPos, Offset(lineEndX, lineEndY), linePaint);

    if (addLineDot) {
      canvas.drawCircle(Offset(lineEndX, lineEndY), 3, linePaint);
    }
  }

  final textStyle = TextStyle(
    fontSize: fontSize * sizeAdjustment,
    color: config.colorScheme.onSurface,
  );
  final textSpan = TextSpan(text: text, style: textStyle);
  final textPainter = TextPainter(
    text: textSpan,
    textAlign: TextAlign.left,
    textDirection: TextDirection.ltr,
  );
  textPainter.layout(minWidth: 0, maxWidth: config.painterSize.width);
  final textSize = Size(textPainter.width, textPainter.height);

  final boxRect = Rect.fromCenter(
    center: adjustedPos,
    width: textSize.width + (20 * sizeAdjustment),
    height: textSize.height + (20 * sizeAdjustment),
  );

  /// Box fill (default to white)
  final boxPaintFill = Paint()
    ..style = PaintingStyle.fill
    ..color = boxFillColor ?? config.colorScheme.surface;
  canvas.drawRect(boxRect, boxPaintFill);

  /// Optional box border
  if (showBoxBorder) {
    final borderWidth = (boxBorderWidth ?? 1.0) * sizeAdjustment;

    final boxPaintBorder = Paint()
      ..style = PaintingStyle.stroke
      ..color = boxStrokeColor ?? config.colorScheme.onSurface
      ..strokeWidth = borderWidth;

    if (dottedBorder) {
      final dashWidth = 5.0;
      final dashSpace = 3.0;
      final path = Path()..addRect(boxRect);
      final dashedPath = Path();

      for (final metric in path.computeMetrics()) {
        double distance = 0.0;
        while (distance < metric.length) {
          dashedPath.addPath(
            metric.extractPath(distance, distance + dashWidth),
            Offset.zero,
          );
          distance += dashWidth + dashSpace;
        }
      }
      canvas.drawPath(dashedPath, boxPaintBorder);
    } else {
      canvas.drawRect(boxRect, boxPaintBorder);
    }
  }

  canvas.save();
  textPainter.paint(
    canvas,
    Offset(
      adjustedPos.dx - (textSize.width / 2),
      adjustedPos.dy - (textSize.height / 2),
    ),
  );
  canvas.restore();
}
