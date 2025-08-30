import 'package:flutter/material.dart';
import '../../models/diagram_painter_config.dart';
import '../painter_constants.dart';

enum TextAlignment { left, center, right }

void paintText(
  DiagramPainterConfig config,
  Canvas canvas,
  String label,
  Offset position, {
  double fontSize = kFontSize,
  TextStyle? style,
  double angle = 0,
  TextAlignment alignment = TextAlignment.center,
}) {
  /// Width and height will always be the same length
  final widthAndHeight = config.painterSize.width;
  fontSize *= config.averageRatio;
  Offset pos = Offset(
    position.dx * widthAndHeight,
    position.dy * widthAndHeight,
  );
  final defaultStyle = TextStyle(
    color: config.colorScheme.onSurface,
    fontSize: fontSize,
  );

  style =
      style?.copyWith(
        color: style.color ?? config.colorScheme.onSurface,
        fontSize: style.fontSize ?? fontSize,
      ) ??
      defaultStyle;

  final textSpan = TextSpan(text: label, style: style);
  final textPainter = TextPainter(
    text: textSpan,
    textDirection: TextDirection.ltr,
  );
  textPainter.layout(minWidth: 0, maxWidth: widthAndHeight);
  switch (alignment) {
    case TextAlignment.left:
      pos = Offset(pos.dx, pos.dy);
      break;
    case TextAlignment.center:
      pos = Offset(pos.dx - textPainter.width / 2, pos.dy);
      break;
    case TextAlignment.right:
      pos = Offset(pos.dx - textPainter.width, pos.dy);
      break;
  }

  canvas.save();

  // 🟢 Rotate around label's anchor point
  final rotationCenter = Offset(0, 0);
  canvas.translate(rotationCenter.dx, rotationCenter.dy);
  canvas.rotate(angle);
  canvas.translate(-rotationCenter.dx, -rotationCenter.dy);

  // Draw text
  textPainter.paint(canvas, pos);
  canvas.restore();
}

//
// Offset baseOffset = Offset(position.dx * width, position.dy * height);
//
// double dx = 0;
// double dy = 0;
// final adjustment = 8.0;
//
// switch (labelAlign) {
//   case LabelAlign.center:
//     dx = -textPainter.width / 2;
//     dy = -textPainter.height / 2;
//     break;
//   case LabelAlign.centerLeft:
//     dx = -textPainter.width - adjustment;
//     dy = -textPainter.height / 2;
//     break;
//   case LabelAlign.centerRight:
//     dx = adjustment;
//     dy = -textPainter.height / 2;
//     break;
//   case LabelAlign.centerTop:
//     dx = -textPainter.width / 2;
//     dy = -textPainter.height - adjustment;
//     break;
//   case LabelAlign.centerBottom:
//     dx = -textPainter.width / 2;
//     dy = adjustment;
//     break;
// }
//
// baseOffset = baseOffset.translate(dx, dy);

// Axis text overrides (as-is)
// if (axis != null) {
//   final widthIndent = kAxisIndent * width;
//   final heightIndent = kAxisIndent * height;
//   final textWidth = textPainter.width;
//   final textYIndent = kAxisTextIndent * (config.painterSize.width);
//
//   if (axis == Axis.vertical) {
//     baseOffset = Offset(
//       -textWidth + widthIndent - textYIndent,
//       heightIndent / 2,
//     );
//
//     if (yLabelIsVertical == true) {
//       baseOffset = Offset(
//         widthIndent - textYIndent,
//         heightIndent / 2 + textWidth,
//       );
//       angle = math.pi / -2;
//     }
//   } else if (axis == Axis.horizontal) {
//     double horizontalAxis = height - heightIndent + kAxisTextIndent;
//     horizontalAxis += kAxisTextIndent * width;
//     baseOffset = Offset(
//       width - (widthIndent / 2) - textWidth,
//       horizontalAxis,
//     );
//   }
// }

// 🟡 Optional Background
// if (paintBackground) {
//   const padding = 1.0;
//   final bgRect = RRect.fromRectAndRadius(
//     Rect.fromLTWH(
//       baseOffset.dx - padding,
//       baseOffset.dy - padding,
//       textPainter.width + padding * 2,
//       textPainter.height + padding * 2,
//     ),
//     const Radius.circular(6),
//   );
//
//   final bgPaint = Paint()
//     ..color = backgroundColor ?? config.colorScheme.scrim
//     ..style = PaintingStyle.fill;
//
//   canvas.drawRRect(bgRect, bgPaint);
// }
