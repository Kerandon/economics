import 'dart:math';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_arrow_head.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_text.dart';
import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';
import '../../enums/label_align.dart';
import '../../models/custom_bezier.dart';
import '../../models/diagram_painter_config.dart';
import '../../models/size_adjuster.dart';
import '../painter_constants.dart';

void paintDiagramLines(
  DiagramPainterConfig config,
  Canvas canvas, {
  required Offset startPos,
  List<CustomBezier>? bezierPoints,
  List<Offset>? polylineOffsets,
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
  bool normalizeToDiagramArea = true,
}) {
  assert(
    (bezierPoints != null && bezierPoints.isNotEmpty ? 1 : 0) +
            (polylineOffsets != null && polylineOffsets.isNotEmpty ? 1 : 0) ==
        1,
    'Exactly one of bezierPoints or polylineOffsets must be provided.',
  );

  final width = config.painterSize.width;
  final height = config.painterSize.height;
  final mainColor = color ?? config.colorScheme.primary;
  final normalize = normalizeToDiagramArea ? 1 - (kAxisIndent * 1.5) : 1.0;

  Offset computeOffset(Offset pos) {
    final dx = pos.dx * width * normalize;
    final dy = pos.dy * height * normalize;
    if (normalizeToDiagramArea) {
      return Offset(
        dx + (kAxisIndent * width),
        dy + (kAxisIndent * (height / 2)),
      );
    } else {
      return Offset(dx, dy);
    }
  }

  Offset computeTextOffset(Offset pos) {
    var dx = pos.dx * normalize;
    var dy = pos.dy * normalize;
    if (normalizeToDiagramArea) {
      dx += kAxisIndent;
      dy += kAxisIndent / 2;
    }
    return Offset(dx, dy);
  }

  final paint = Paint()
    ..style = PaintingStyle.stroke
    ..color = mainColor
    ..strokeWidth = strokeWidth * config.averageRatio;

  final path = Path();

  // --- Start point
  final Offset start = computeOffset(startPos);
  path.moveTo(start.dx, start.dy);

  // --- Polyline path
  if (polylineOffsets != null && polylineOffsets.isNotEmpty) {
    for (final point in polylineOffsets) {
      final next = computeOffset(point);
      path.lineTo(next.dx, next.dy);
    }

    final dashedPath = dashed
        ? dashPath(
            path,
            dashArray: CircularIntervalList<double>(<double>[10.0, 5.0]),
          )
        : path;

    canvas.drawPath(dashedPath, paint);

    if (label1 != null) {
      final labelOffset = computeTextOffset(startPos);
      paintText(config, canvas, label1, labelOffset, labelAlign: label1Align);
    }

    if (label2 != null) {
      final last = polylineOffsets.last;
      final labelOffset = computeTextOffset(last);
      paintText(config, canvas, label2, labelOffset, labelAlign: label2Align);
    }

    if (arrowOnStart) {
      paintArrowHead(
        config,
        canvas,
        color: mainColor,
        positionOfArrow: start,
        rotationAngle: arrowOnStartAngle,
      );
    }

    if (arrowOnEnd) {
      final end = computeOffset(polylineOffsets.last);
      final autoEndAngle = atan2(end.dy - start.dy, end.dx - start.dx);
      paintArrowHead(
        config,
        canvas,
        color: mainColor,
        positionOfArrow: end,
        rotationAngle: arrowOnEndAngle != 0 ? arrowOnEndAngle : autoEndAngle,
      );
    }

    final r = circleRadius * config.averageRatio;
    if (circleAtStart) {
      canvas.drawCircle(start, r, paint..style = PaintingStyle.fill);
    }
    if (circleAtEnd) {
      final end = computeOffset(polylineOffsets.last);
      canvas.drawCircle(end, r, paint..style = PaintingStyle.fill);
    }

    return;
  }

  // --- Bezier path
  final end = computeOffset(bezierPoints!.last.endPoint);

  for (final point in bezierPoints) {
    final control = computeOffset(point.control);
    final endPoint = computeOffset(point.endPoint);
    path.quadraticBezierTo(control.dx, control.dy, endPoint.dx, endPoint.dy);
  }

  final dashedPath = dashed
      ? dashPath(
          path,
          dashArray: CircularIntervalList<double>(<double>[10.0, 5.0]),
        )
      : path;

  canvas.drawPath(dashedPath, paint);

  if (label1 != null) {
    final labelOffset = computeTextOffset(startPos);
    paintText(config, canvas, label1, labelOffset, labelAlign: label1Align);
  }

  if (label2 != null) {
    final labelOffset = computeTextOffset(bezierPoints.last.endPoint);
    paintText(config, canvas, label2, labelOffset, labelAlign: label2Align);
  }

  if (arrowOnStart) {
    paintArrowHead(
      config,
      canvas,
      color: mainColor,
      positionOfArrow: start,
      rotationAngle: arrowOnStartAngle,
    );
  }

  if (arrowOnEnd) {
    final autoEndAngle = atan2(end.dy - start.dy, end.dx - start.dx);
    paintArrowHead(
      config,
      canvas,
      color: mainColor,
      positionOfArrow: end,
      rotationAngle: arrowOnEndAngle != 0 ? arrowOnEndAngle : autoEndAngle,
    );
  }

  final r = circleRadius * config.averageRatio;
  if (circleAtStart) {
    canvas.drawCircle(start, r, paint..style = PaintingStyle.fill);
  }
  if (circleAtEnd) {
    canvas.drawCircle(end, r, paint..style = PaintingStyle.fill);
  }
  // Factory method to create a straight polyline
}
