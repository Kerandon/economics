import 'dart:math' as math;
import 'dart:ui';
import 'package:economics_app/diagrams/custom_paint/painter_methods/diagram_lines/paint_diagram_lines.dart';
import 'package:economics_app/diagrams/enums/diagram_labels.dart';
import '../../i_diagram_canvas.dart';
import '../../../models/diagram_painter_config.dart';
import '../../painter_constants.dart';
import '../rotate_around.dart';

void paintMarketCurve(
  DiagramPainterConfig config,
  IDiagramCanvas canvas, { // 1. Nullable/ 2. Bridge
  required MarketCurveType type,
  String? label,
  double lengthAdjustment = 0.0,
  double horizontalShift = 0.0,
  double verticalShift = 0.0,
  double angle = 0.0,
  CurveStyle curveStyle = CurveStyle.standard,
  Color? color,
}) {
  // Base start/end depending on curve type
  final baseStart = switch (type) {
    MarketCurveType.demand => const Offset(0.15, 0.15),
    MarketCurveType.supply => const Offset(0.15, 0.85),
  };

  final baseEnd = switch (type) {
    MarketCurveType.demand => const Offset(0.85, 0.85),
    MarketCurveType.supply => const Offset(0.85, 0.15),
  };

  // Compute adjusted start and end
  Offset start, end;
  if (lengthAdjustment != 0.0) {
    final dx = baseEnd.dx - baseStart.dx;
    final dy = baseEnd.dy - baseStart.dy;

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
  Offset shift(Offset o) =>
      Offset(o.dx + horizontalShift, o.dy + verticalShift);
  start = shift(start);
  end = shift(end);

  // Apply rotation
  if (angle != 0.0) {
    final mid = Offset((start.dx + end.dx) / 2, (start.dy + end.dy) / 2);
    start = rotateAround(start, mid, angle);
    end = rotateAround(end, mid, angle);
  }

  // Default label
  final defaultLabel = switch (type) {
    MarketCurveType.demand => DiagramLabel.d.label.toUpperCase(),
    MarketCurveType.supply => DiagramLabel.s.label,
  };

  // 3. PASS THE BRIDGE TO paintDiagramLines
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
