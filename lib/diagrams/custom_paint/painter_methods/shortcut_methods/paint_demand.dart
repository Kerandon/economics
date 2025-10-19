import 'dart:math' as math;
import 'dart:ui';
import 'package:economics_app/diagrams/custom_paint/painter_methods/diagram_lines/paint_diagram_lines.dart';
import 'package:economics_app/diagrams/enums/diagram_labels.dart';
import '../axis/label_align.dart';
import '../../../models/diagram_painter_config.dart';

void paintMarketCurve(
  DiagramPainterConfig config,
  Canvas canvas, {
  required MarketCurveType type,
  String? label,
  bool extend = false,
  double horizontalShift = 0.0, // -0.1 shifts left, +0.1 shifts right
  double elasticityAngle =
      0.0, // in radians, e.g. +0.1 makes curve flatter (more elastic)
  CurveStyle curveStyle = CurveStyle.standard,
  Color? color,
}) {
  // Base start/end depending on curve type
  final baseStart = switch (type) {
    MarketCurveType.demand =>
      extend ? const Offset(0.10, 0.10) : const Offset(0.20, 0.20),
    MarketCurveType.supply =>
      extend ? const Offset(0.10, 0.90) : const Offset(0.20, 0.80),
  };

  final baseEnd = switch (type) {
    MarketCurveType.demand =>
      extend ? const Offset(0.90, 0.90) : const Offset(0.80, 0.80),
    MarketCurveType.supply =>
      extend ? const Offset(0.90, 0.10) : const Offset(0.80, 0.20),
  };

  // Apply horizontal shift
  Offset shift(Offset o) => Offset(o.dx + horizontalShift, o.dy);
  var start = shift(baseStart);
  var end = shift(baseEnd);

  // Apply rotation to simulate elasticity (rotation about midpoint)
  if (elasticityAngle != 0.0) {
    final mid = Offset((start.dx + end.dx) / 2, (start.dy + end.dy) / 2);
    start = _rotateAround(start, mid, elasticityAngle);
    end = _rotateAround(end, mid, elasticityAngle);
  }

  // Pick default label if not provided
  final defaultLabel = switch (type) {
    MarketCurveType.demand => DiagramLabel.d.label,
    MarketCurveType.supply => DiagramLabel.s.label,
  };

  paintDiagramLines(
    config,
    canvas,
    startPos: start,
    polylineOffsets: [end],
    label2: label ?? defaultLabel,
    label2Align: LabelAlign.centerRight,
    curveStyle: curveStyle,
    color: color,
  );
}

/// Helper to rotate a point around a center by a given angle (in radians)
Offset _rotateAround(Offset point, Offset center, double angle) {
  final dx = point.dx - center.dx;
  final dy = point.dy - center.dy;
  final cosA = math.cos(angle);
  final sinA = math.sin(angle);
  final newX = center.dx + dx * cosA - dy * sinA;
  final newY = center.dy + dx * sinA + dy * cosA;
  return Offset(newX, newY);
}

enum MarketCurveType { demand, supply }
