import 'package:flutter/material.dart';

void drawDashedLineForGrid(
  Canvas canvas,
  Offset start,
  Offset end,
  Paint paint, {
  double dashWidth = 5,
  double gap = 5,
}) {
  final totalDistance = (end - start).distance;
  final direction = (end - start) / totalDistance;
  double currentDistance = 0;

  while (currentDistance < totalDistance) {
    final segmentStart = start + direction * currentDistance;
    currentDistance += dashWidth;
    if (currentDistance > totalDistance) currentDistance = totalDistance;
    final segmentEnd = start + direction * currentDistance;
    canvas.drawLine(segmentStart, segmentEnd, paint);
    currentDistance += gap;
  }
}
