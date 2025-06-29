import 'dart:math';
import 'package:economics_app/sections/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_arrow_head.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_text.dart';
import 'package:economics_app/sections/diagrams/models/size_adjuster.dart';
import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';
import '../../enums/label_align.dart';
import '../../models/custom_bezier.dart';
import '../../models/diagram_painter_config.dart';
void paintCustomDiagramLines(
    DiagramPainterConfig config,
    Canvas canvas, {
      required Offset startPos,
      List<CustomBezier>? bezierPoints, // nullable now
      Offset? straightEndPos,            // optional
      Color? color,
      double strokeWidth = kCurveWidth,
      SizeAdjustor sizeAdjustor = const SizeAdjustor(),
      String? label1,
      String? label2,
      LabelAlign label1Align = LabelAlign.center,
      LabelAlign label2Align = LabelAlign.center,
      bool arrowOnStart = false,
      bool arrowOnEnd = false,
      double arrowOnStartAngle = 0,
      double arrowOnEndAngle = 0,
      bool circleAtEnd = false,
      bool circleAtStart = false,
      double circleRadius = 10,
      bool dashed = false,
    }) {
  assert(
  (bezierPoints != null && bezierPoints.isNotEmpty) ^ (straightEndPos != null),
  'Exactly one of bezierPoints (non-empty) or straightEndPos must be provided, but not both.',
  );

  final width = config.painterSize.width;
  final height = config.painterSize.height;
  final mainColor = color ?? config.colorScheme.primary;
  final normalize = 1 - (kAxisIndent * 1.5);

  final paint = Paint()
    ..style = PaintingStyle.stroke
    ..color = mainColor
    ..strokeWidth = strokeWidth * config.averageRatio;

  final path = Path();

  final startX = startPos.dx * width * normalize + (kAxisIndent * width);
  final startY = startPos.dy * height * normalize + (kAxisIndent * (height / 2));

  path.moveTo(startX, startY);

  if (straightEndPos != null) {
    // Draw straight line from startPos to straightEndPos
    final endX = straightEndPos.dx * width * normalize + (kAxisIndent * width);
    final endY = straightEndPos.dy * height * normalize + (kAxisIndent * (height / 2));
    path.lineTo(endX, endY);

    if (dashed) {
      final dashedPath = dashPath(
        path,
        dashArray: CircularIntervalList<double>(<double>[10.0, 5.0]),
      );
      canvas.drawPath(dashedPath, paint);
    } else {
      canvas.drawPath(path, paint);
    }

    // Labels for straight line
    if (label1 != null) {
      paintText(
        config,
        canvas,
        label1,
        Offset(
          startPos.dx * normalize + kAxisIndent,
          startPos.dy * normalize + kAxisIndent / 2,
        ),
        labelAlign: label1Align,
      );
    }

    if (label2 != null) {
      paintText(
        config,
        canvas,
        label2,
        Offset(
          straightEndPos.dx * normalize + kAxisIndent,
          straightEndPos.dy * normalize + kAxisIndent / 2,
        ),
        labelAlign: label2Align,
      );
    }

    // Arrows for straight line
    if (arrowOnStart) {
      paintArrowHead(
        config,
        canvas,
        color: mainColor,
        positionOfArrow: Offset(startX, startY),
        rotationAngle: arrowOnStartAngle,
      );
    }

    if (arrowOnEnd) {
      final autoEndAngle = atan2(
        straightEndPos.dy - startPos.dy,
        straightEndPos.dx - startPos.dx,
      );
      paintArrowHead(
        config,
        canvas,
        color: mainColor,
        positionOfArrow: Offset(endX, endY),
        rotationAngle: arrowOnEndAngle != 0 ? arrowOnEndAngle : autoEndAngle,
      );
    }

    final r = circleRadius * config.averageRatio;
    if (circleAtStart) {
      canvas.drawCircle(Offset(startX, startY), r, paint..style = PaintingStyle.fill);
    }
    if (circleAtEnd) {
      canvas.drawCircle(Offset(endX, endY), r, paint..style = PaintingStyle.fill);
    }

    return; // early return after drawing straight line
  }

  // Bezier curve drawing (bezierPoints is non-null and not empty here)
  final endX = bezierPoints!.last.endPoint.dx * width * normalize + (kAxisIndent * width);
  final endY = bezierPoints.last.endPoint.dy * height * normalize + (kAxisIndent * (height / 2));

  for (final point in bezierPoints) {
    final controlX = point.control.dx * width * normalize + (kAxisIndent * width);
    final controlY = point.control.dy * height * normalize + (kAxisIndent * (height / 2));
    final eX = point.endPoint.dx * width * normalize + (kAxisIndent * width);
    final eY = point.endPoint.dy * height * normalize + (kAxisIndent * (height / 2));
    path.quadraticBezierTo(controlX, controlY, eX, eY);
  }

  if (dashed) {
    final dashedPath = dashPath(
      path,
      dashArray: CircularIntervalList<double>(<double>[10.0, 5.0]),
    );
    canvas.drawPath(dashedPath, paint);
  } else {
    canvas.drawPath(path, paint);
  }

  // Labels for Bezier curves
  if (label1 != null) {
    paintText(
      config,
      canvas,
      label1,
      Offset(
        startPos.dx * normalize + kAxisIndent,
        startPos.dy * normalize + kAxisIndent / 2,
      ),
      labelAlign: label1Align,
    );
  }

  if (label2 != null) {
    paintText(
      config,
      canvas,
      label2,
      Offset(
        bezierPoints.last.endPoint.dx * normalize + kAxisIndent,
        bezierPoints.last.endPoint.dy * normalize + kAxisIndent / 2,
      ),
      labelAlign: label2Align,
    );
  }

  // Arrows for Bezier curves
  if (arrowOnStart) {
    paintArrowHead(
      config,
      canvas,
      color: mainColor,
      positionOfArrow: Offset(startX, startY),
      rotationAngle: arrowOnStartAngle,
    );
  }

  if (arrowOnEnd) {
    final autoEndAngle = atan2(endY - startY, endX - startX);
    paintArrowHead(
      config,
      canvas,
      color: mainColor,
      positionOfArrow: Offset(endX, endY),
      rotationAngle: arrowOnEndAngle != 0 ? arrowOnEndAngle : autoEndAngle,
    );
  }

  final r = circleRadius * config.averageRatio;
  if (circleAtStart) {
    canvas.drawCircle(Offset(startX, startY), r, paint..style = PaintingStyle.fill);
  }
  if (circleAtEnd) {
    canvas.drawCircle(Offset(endX, endY), r, paint..style = PaintingStyle.fill);
  }
}
