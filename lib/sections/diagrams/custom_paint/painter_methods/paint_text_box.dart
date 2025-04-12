import 'package:economics_app/sections/diagrams/custom_paint/painter_constants.dart';
import 'package:flutter/material.dart';

import '../../models/diagram_painter_config.dart';
import '../../utils/helper_methods/get_scale_ratio.dart';

paintTextBox({
  required Canvas canvas,
  required DiagramPainterConfig config,
  required String text,
  required Offset position,
  double fontSize = 32,
  Offset? linePoint,
  bool addLineDot = false,
  Color? lineColor,
  bool showBoxBorder = false,
  Color? boxFillColor,
  Color? boxStrokeColor,
}) {
  final sizeAdjustment = config.averageRatio;




  final adjustedPos = Offset(position.dx * config.painterSize.width,
      position.dy * config.painterSize.height);

  if (linePoint != null) {
    final lineEndX = config.painterSize.width * linePoint.dx;
    final lineEndY = config.painterSize.height * linePoint.dy;
    final linePaint = Paint()
      ..color = lineColor ?? config.colorScheme.onSurface
    ..strokeWidth = kCurveWidth / 5;
    canvas.drawLine(
      adjustedPos,
      Offset(lineEndX, lineEndY),
      linePaint,
    );
    if (addLineDot) {
      canvas.drawCircle(Offset(lineEndX, lineEndY), 3, linePaint);
    }
  }
  final textStyle = TextStyle(
      fontSize: fontSize * sizeAdjustment, color: config.colorScheme.onSurface);
  final textSpan = TextSpan(text: text, style: textStyle);
  final textPainter = TextPainter(
    text: textSpan, textAlign: TextAlign.left, // Or any alignment you need
    textDirection: TextDirection.ltr,
  );
  textPainter.layout(minWidth: 0, maxWidth: config.painterSize.width);
  final textSize = Size(textPainter.width, textPainter.height);

  /// Box fill
  final boxPaintFill = Paint()
    ..style = PaintingStyle.fill
    ..color = boxFillColor ?? config.colorScheme.surface;
  final boxPathFill = Path()
    ..addRect(
      Rect.fromCenter(
        center: adjustedPos,
        width: textSize.width + (3 * sizeAdjustment),
        height: textSize.height + (3 * sizeAdjustment),
      ),
    );
  canvas.drawPath(
    boxPathFill,
    boxPaintFill,
  );

  if (showBoxBorder) {
    /// Box border
    final boxPaintBorder = Paint()
      ..style = PaintingStyle.stroke
      ..color = boxStrokeColor ?? config.colorScheme.onSurface
      ..strokeWidth = 1 * sizeAdjustment;
    final boxPathBorder = Path()
      ..addRect(
        Rect.fromCenter(
          center: adjustedPos,
          width: textSize.width + (20 * sizeAdjustment),
          height: textSize.height + (20 * sizeAdjustment),
        ),
      );
    canvas.drawPath(
      boxPathBorder,
      boxPaintBorder,
    );
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
