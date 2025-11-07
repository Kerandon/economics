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
      double lengthAdjustment = 0.0, // +ve = extend, -ve = shorten, applied evenly both ends
      double horizontalShift = 0.0,
      double verticalShift = 0.0,
      double angle = 0.0,
      CurveStyle curveStyle = CurveStyle.standard,
      Color? color,
    }) {
  // Base start/end depending on curve type
  final baseStart = switch (type) {
    MarketCurveType.demand => const Offset(0.10, 0.10),
    MarketCurveType.supply => const Offset(0.10, 0.90),
  };

  final baseEnd = switch (type) {
    MarketCurveType.demand => const Offset(0.90, 0.90),
    MarketCurveType.supply => const Offset(0.90, 0.10),
  };

  // Compute adjusted start and end (shorten or extend evenly)
  Offset start, end;
  if (lengthAdjustment != 0.0) {
    final dx = baseEnd.dx - baseStart.dx;
    final dy = baseEnd.dy - baseStart.dy;

    // shorten or extend evenly from both ends
    final startAdjusted = Offset(
      baseStart.dx - dx * (lengthAdjustment / 2),
      baseStart.dy - dy * (lengthAdjustment / 2),
    );
    final endAdjusted = Offset(
      baseEnd.dx + dx * (lengthAdjustment / 2),
      baseEnd.dy + dy * (lengthAdjustment / 2),
    );

    start = startAdjusted;
    end = endAdjusted;
  } else {
    start = baseStart;
    end = baseEnd;
  }

  // Apply horizontal & vertical shifts
  Offset shift(Offset o) => Offset(o.dx + horizontalShift, o.dy + verticalShift);
  start = shift(start);
  end = shift(end);

  // Apply rotation (elasticity simulation)
  if (angle != 0.0) {
    final mid = Offset((start.dx + end.dx) / 2, (start.dy + end.dy) / 2);
    start = _rotateAround(start, mid, angle);
    end = _rotateAround(end, mid, angle);
  }

  // Default label
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
