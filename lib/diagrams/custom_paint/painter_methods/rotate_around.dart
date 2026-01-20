import 'dart:math' as math;
import 'dart:ui';

/// Rotates a point around a center by a given angle (in radians)
Offset rotateAround(Offset point, Offset center, double angle) {
  final dx = point.dx - center.dx;
  final dy = point.dy - center.dy;
  final cosA = math.cos(angle);
  final sinA = math.sin(angle);
  final newX = center.dx + dx * cosA - dy * sinA;
  final newY = center.dy + dx * sinA + dy * cosA;
  return Offset(newX, newY);
}
