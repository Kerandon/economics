import 'dart:math';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_arrow_head.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/diagram_lines/paint_label_text.dart';
import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';
import '../../i_diagram_canvas.dart';
import '../../../models/custom_bezier.dart';
import '../../../models/diagram_painter_config.dart';
import '../../painter_constants.dart';

void paintDiagramLines(
  DiagramPainterConfig config,
  Canvas? canvas, {
  IDiagramCanvas? iCanvas,
  required Offset startPos,
  List<CustomBezier>? bezierPoints,
  List<Offset>? polylineOffsets,
  Color? color,
  double strokeWidth = kCurveWidth,
  String? label1,
  String? label2,
  LabelAlign label1Align = LabelAlign.centerTop,
  LabelAlign label2Align = LabelAlign.centerBottom,
  bool arrowOnStart = false,
  bool arrowOnEnd = false,
  double arrowOnStartAngle = 0,
  double arrowOnEndAngle = 0,
  bool circleAtEnd = false,
  bool circleAtStart = false,
  double circleRadius = 10,
  CurveStyle curveStyle = CurveStyle.standard,
  bool normalizeToDiagramArea = true,
  Color? backgroundColor,
}) {
  assert(
    (bezierPoints != null && bezierPoints.isNotEmpty ? 1 : 0) +
            (polylineOffsets != null && polylineOffsets.isNotEmpty ? 1 : 0) ==
        1,
    'Exactly one of bezierPoints or polylineOffsets must be provided.',
  );

  final double widthAndHeight = config.painterSize.width;
  final double normalize = normalizeToDiagramArea ? 1 - (kAxisIndent * 2) : 1.0;
  final double widthAndHeightNormalized = widthAndHeight * normalize;
  final double indent = widthAndHeight * kAxisIndent;
  final Color mainColor = color ?? config.colorScheme.primary;

  Offset computeOffset(Offset pos) {
    final dx = pos.dx * widthAndHeightNormalized;
    final dy = pos.dy * widthAndHeightNormalized;
    if (normalizeToDiagramArea) {
      return Offset(dx + indent, dy + indent * kTopAxisIndent);
    } else {
      return Offset(dx, dy);
    }
  }

  Offset computeTextOffset(Offset pos) {
    var dx = pos.dx * normalize;
    var dy = pos.dy * normalize;
    if (normalizeToDiagramArea) {
      dx += kAxisIndent;
      dy += kAxisIndent * kTopAxisIndent;
    }
    return Offset(dx, dy);
  }

  final double effectiveWidth =
      (curveStyle == CurveStyle.bold ? strokeWidth * 2 : strokeWidth) *
      config.averageRatio;

  final Offset start = computeOffset(startPos);

  // --- 1. PDF Bridge Logic (Flattened Beziers) ---
  if (iCanvas != null) {
    final List<Offset> points = [start];

    if (polylineOffsets != null) {
      for (var p in polylineOffsets) {
        points.add(computeOffset(p));
      }
    } else if (bezierPoints != null) {
      Offset lastPoint = start;
      for (var b in bezierPoints) {
        final control = computeOffset(b.control);
        final endPoint = computeOffset(b.endPoint);

        for (double t = 0.1; t <= 1.0; t += 0.1) {
          final x =
              (1 - t) * (1 - t) * lastPoint.dx +
              2 * (1 - t) * t * control.dx +
              t * t * endPoint.dx;
          final y =
              (1 - t) * (1 - t) * lastPoint.dy +
              2 * (1 - t) * t * control.dy +
              t * t * endPoint.dy;
          points.add(Offset(x, y));
        }
        lastPoint = endPoint;
      }
    }

    if (curveStyle == CurveStyle.dashed || curveStyle == CurveStyle.dotted) {
      for (int i = 0; i < points.length - 1; i++) {
        iCanvas.drawDashedLine(
          points[i],
          points[i + 1],
          mainColor,
          effectiveWidth,
        );
      }
    } else {
      iCanvas.drawPath(points, mainColor, fill: false);
    }
  }

  // --- 2. Flutter Canvas Logic ---
  if (canvas != null) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = mainColor
      ..strokeWidth = effectiveWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path();
    path.moveTo(start.dx, start.dy);

    if (polylineOffsets != null) {
      for (final point in polylineOffsets) {
        final next = computeOffset(point);
        path.lineTo(next.dx, next.dy);
      }
    } else if (bezierPoints != null) {
      for (final point in bezierPoints) {
        final control = computeOffset(point.control);
        final endPoint = computeOffset(point.endPoint);
        path.quadraticBezierTo(
          control.dx,
          control.dy,
          endPoint.dx,
          endPoint.dy,
        );
      }
    }

    if (curveStyle == CurveStyle.dashed) {
      canvas.drawPath(
        dashPath(
          path,
          dashArray: CircularIntervalList<double>(<double>[8.0, 5.0]),
        ),
        paint,
      );
    } else if (curveStyle == CurveStyle.dotted) {
      canvas.drawPath(
        dashPath(
          path,
          dashArray: CircularIntervalList<double>(<double>[2.0, 4.0]),
        ),
        paint,
      );
    } else {
      canvas.drawPath(path, paint);
    }
  }

  // --- 3. Labels, Arrows, and Dots ---
  if (label1 != null) {
    paintLabelText(
      canvas,
      config,
      label1,
      computeTextOffset(startPos),
      iCanvas: iCanvas,
      labelAlign: label1Align,
    );
  }

  final Offset end = computeOffset(
    polylineOffsets != null
        ? polylineOffsets.last
        : bezierPoints!.last.endPoint,
  );

  if (label2 != null) {
    final lastLogicalPos = polylineOffsets != null
        ? polylineOffsets.last
        : bezierPoints!.last.endPoint;
    paintLabelText(
      canvas,
      config,
      label2,
      computeTextOffset(lastLogicalPos),
      iCanvas: iCanvas,
      labelAlign: label2Align,
    );
  }

  if (arrowOnStart) {
    paintArrowHead(
      config,
      canvas,
      iCanvas: iCanvas,
      color: mainColor,
      positionOfArrow: start,
      rotationAngle: arrowOnStartAngle,
    );
  }

  if (arrowOnEnd) {
    double finalAngle = arrowOnEndAngle;
    if (finalAngle == 0) {
      final Offset reference = (bezierPoints != null)
          ? computeOffset(bezierPoints.last.control)
          : start;
      finalAngle = atan2(end.dy - reference.dy, end.dx - reference.dx);
    }
    paintArrowHead(
      config,
      canvas,
      iCanvas: iCanvas,
      color: mainColor,
      positionOfArrow: end,
      rotationAngle: finalAngle,
    );
  }

  final r = circleRadius * config.averageRatio;
  if (circleAtStart) {
    if (iCanvas != null) {
      iCanvas.drawDot(start, mainColor, radius: r);
    } else {
      canvas!.drawCircle(
        start,
        r,
        Paint()
          ..color = mainColor
          ..style = PaintingStyle.fill,
      );
    }
  }
  if (circleAtEnd) {
    if (iCanvas != null) {
      iCanvas.drawDot(end, mainColor, radius: r);
    } else {
      canvas!.drawCircle(
        end,
        r,
        Paint()
          ..color = mainColor
          ..style = PaintingStyle.fill,
      );
    }
  }
}
