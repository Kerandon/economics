import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_arrow_head.dart';
import 'package:flutter/material.dart';
import 'axis/label_align.dart';
import '../../models/custom_bezier.dart';
import '../../models/diagram_painter_config.dart';
import '../../models/size_adjuster.dart';
import '../painter_constants.dart';

void paintCustomBezier(
  DiagramPainterConfig config,
  Canvas canvas, {
  required Offset startPos,
  required List<CustomBezier> points,
  Color? mainColor,
  double strokeWidth = kCurveWidth,
  SizeAdjustor sizeAdjustor = const SizeAdjustor(),
  String? label1,
  String? label2,
  LabelAlign label1Align = LabelAlign.center,
  LabelAlign label2Align = LabelAlign.center,
  bool drawArrowOnStart = false,
  bool drawArrowOnEnd = false,
  double arrowOnStartAngle = 0,
  double arrowOnEndAngle = 0,
}) {
  final width = config.painterSize.width;
  final height = config.painterSize.height;
  final color = mainColor ?? config.colorScheme.primary;
  final paint = Paint()
    ..style = PaintingStyle.stroke
    ..color = color
    ..strokeWidth = strokeWidth * config.averageRatio;
  final path = Path();
  path.moveTo(startPos.dx * width, startPos.dy * height);
  for (int i = 0; i < points.length; i++) {
    path.quadraticBezierTo(
      points[i].control.dx * width,
      points[i].control.dy * height,
      points[i].endPoint.dx * width,
      points[i].endPoint.dy * height,
    );
  }

  canvas.drawPath(path, paint);
  if (label1 != null) {
    // paintText(
    //   config,
    //   canvas,
    //   label1,
    //   Offset(
    //     points[points.length - 1].endPoint.dx,
    //     points[points.length - 1].endPoint.dy,
    //   ),
    // );
  }
  if (label2 != null) {
    // paintText(
    //   config,
    //   canvas,
    //   label2,
    //   Offset(startPos.dx, startPos.dy),
    //   labelAlign: label2Align,
    // );
  }
  if (drawArrowOnStart) {
    paintArrowHead(
      config,
      canvas,
      color: color,
      positionOfArrow: Offset(startPos.dx * width, startPos.dy * height),
      rotationAngle: arrowOnStartAngle,
    );
  }
  if (drawArrowOnEnd) {
    paintArrowHead(
      config,
      canvas,
      color: color,
      positionOfArrow: Offset(
        points.last.endPoint.dx * width,
        points.last.endPoint.dy * height,
      ),
      rotationAngle: arrowOnEndAngle,
    );
  }
}
