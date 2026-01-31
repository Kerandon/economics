import 'dart:math' as math;
import 'dart:ui';
import 'package:economics_app/diagrams/custom_paint/painter_methods/diagram_lines/paint_diagram_lines.dart';
import 'package:economics_app/diagrams/enums/diagram_labels.dart';
import '../../../models/custom_bezier.dart';
import '../../i_diagram_canvas.dart';
import '../../../models/diagram_painter_config.dart';
import '../../painter_constants.dart';
import '../rotate_around.dart';

void paintMarketCurve(
  DiagramPainterConfig config,
  IDiagramCanvas canvas, {
  required MarketCurveType type,
  String? label, // Defaults to curve name (e.g. "LRAS") at the END
  String? startLabel, // New: Defaults to "Yp" for LRAS at the START
  double lengthAdjustment = 0.0,
  double horizontalShift = 0.0,
  double verticalShift = 0.0,
  double angle = 0.0,
  CurveStyle curveStyle = CurveStyle.standard,
  Color? color,
  double lrasX = 0.5,
}) {
  // 1. DEFINE BASE COORDINATES
  Offset baseStart;
  Offset baseEnd;
  List<CustomBezier>? beziers;

  switch (type) {
    case MarketCurveType.demand:
    case MarketCurveType.ad:
      baseStart = const Offset(0.15, 0.15);
      baseEnd = const Offset(0.85, 0.85);
      break;

    case MarketCurveType.supply:
    case MarketCurveType.sras:
      baseStart = const Offset(0.15, 0.85);
      baseEnd = const Offset(0.85, 0.15);
      break;

    case MarketCurveType.lras:
      // Start at bottom (1.0), End at top (0.10)
      baseStart = Offset(lrasX, 1.0);
      baseEnd = Offset(lrasX, 0.10);
      break;

    case MarketCurveType.keynesianAS:
      baseStart = const Offset(0.10, 0.80);
      baseEnd = const Offset(0.80, 0.10);
      beziers = [
        CustomBezier(endPoint: const Offset(0.50, 0.80)),
        CustomBezier(
          control: Offset(0.80, 0.80),
          endPoint: const Offset(0.80, 0.60),
        ),
        CustomBezier(endPoint: const Offset(0.80, 0.10)),
      ];
      break;
  }

  // 2. APPLY TRANSFORMATIONS
  Offset start = baseStart;
  Offset end = baseEnd;

  if (type != MarketCurveType.keynesianAS) {
    if (lengthAdjustment != 0.0) {
      final dx = baseEnd.dx - baseStart.dx;
      final dy = baseEnd.dy - baseStart.dy;
      start = Offset(
        baseStart.dx - dx * (lengthAdjustment / 2),
        baseStart.dy - dy * (lengthAdjustment / 2),
      );
      end = Offset(
        baseEnd.dx + dx * (lengthAdjustment / 2),
        baseEnd.dy + dy * (lengthAdjustment / 2),
      );
    }

    if (angle != 0.0) {
      final mid = Offset((start.dx + end.dx) / 2, (start.dy + end.dy) / 2);
      start = rotateAround(start, mid, angle);
      end = rotateAround(end, mid, angle);
    }
  }

  Offset shift(Offset o) =>
      Offset(o.dx + horizontalShift, o.dy + verticalShift);
  start = shift(start);

  if (beziers != null) {
    beziers = beziers
        .map(
          (b) => CustomBezier(
            control: shift(b.control),
            endPoint: shift(b.endPoint),
          ),
        )
        .toList();
  } else {
    end = shift(end);
  }

  // 3. DETERMINE LABELS
  // Label 2 (End of line / Top)
  String finalLabel2 = label ?? '';
  if (label == null) {
    switch (type) {
      case MarketCurveType.demand:
        finalLabel2 = "D";
        break;
      case MarketCurveType.supply:
        finalLabel2 = "S";
        break;
      case MarketCurveType.ad:
        finalLabel2 = "AD";
        break;
      case MarketCurveType.sras:
        finalLabel2 = "SRAS";
        break;
      case MarketCurveType.lras:
        finalLabel2 = "LRAS";
        break;
      case MarketCurveType.keynesianAS:
        finalLabel2 = "Keynesian AS";
        break;
    }
  }

  // Label 1 (Start of line / Bottom)
  String? finalLabel1 = startLabel;

  // *** LRAS SPECIAL LOGIC ***
  // If it's LRAS and no start label was provided, default to "Yp"
  if (type == MarketCurveType.lras && startLabel == null) {
    finalLabel1 = "Yp";
  }

  // 4. DRAW
  if (type == MarketCurveType.keynesianAS) {
    paintDiagramLines(
      config,
      canvas,
      startPos: start,
      bezierPoints: beziers,
      label1: finalLabel1,
      label2: finalLabel2,
      label2Align: LabelAlign.centerTop,
      curveStyle: curveStyle,
      color: color,
    );
  } else {
    paintDiagramLines(
      config,
      canvas,
      startPos: start,
      polylineOffsets: [end],

      // Pass the Start Label (Yp) and End Label (LRAS)
      label1: finalLabel1,
      label2: finalLabel2,

      // Alignments:
      // For LRAS: Top label centered, Bottom label centered
      // For Others: End label right-aligned
      label1Align: type == MarketCurveType.lras
          ? LabelAlign
                .centerBottom // Yp sits below the axis
          : LabelAlign.centerTop,
      label2Align: type == MarketCurveType.lras
          ? LabelAlign
                .centerTop // LRAS sits above the line
          : LabelAlign.centerRight,

      curveStyle: curveStyle,
      color: color,
    );
  }
}
