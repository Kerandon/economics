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
  String? label,
  String? startLabel,
  double lengthAdjustment = 0.0,
  double horizontalShift = 0.0,
  double verticalShift = 0.0,
  double angle = 0.0,
  CurveStyle curveStyle = CurveStyle.standard,
  Color? color,
  double lrasX = 0.5,
  double keynesianAS = 0.80,
}) {
  // 1. DEFINE BASE COORDINATES
  Offset baseStart;
  Offset baseEnd;
  List<CustomBezier>? beziers;

  // Helper to identify vertical curves
  bool isVertical =
      type == MarketCurveType.lras ||
      type == MarketCurveType.moneySupply ||
      type == MarketCurveType.lrpc;

  switch (type) {
    // --- DOWNWARD SLOPING (DEMAND-LIKE) ---
    case MarketCurveType.demand:
    case MarketCurveType.srpc:
    case MarketCurveType.moneyDemand:
    case MarketCurveType.demandDomestic: // New
    case MarketCurveType.demandWorld:
    case MarketCurveType.demandUSD:
      baseStart = const Offset(0.10, 0.10);
      baseEnd = const Offset(0.90, 0.90);
      break;

    // --- UPWARD SLOPING (SUPPLY-LIKE) ---
    case MarketCurveType.supply:
    case MarketCurveType.sras:
    case MarketCurveType.supplyDomestic: // New
    case MarketCurveType.supplyWorld:
    case MarketCurveType.supplyUSD:
      baseStart = const Offset(0.10, 0.90);
      baseEnd = const Offset(0.90, 0.10);
      break;

    // --- SPECIAL AD CURVE ---
    case MarketCurveType.ad:
      // Steeper & Lower
      baseStart = const Offset(0.30, 0.20);
      baseEnd = const Offset(0.70, 0.90);
      break;

    // --- VERTICAL CURVES ---
    case MarketCurveType.lras:
    case MarketCurveType.moneySupply:
    case MarketCurveType.lrpc:
      baseStart = Offset(lrasX, 1.0);
      baseEnd = Offset(lrasX, 0.10);
      break;

    // --- COMPLEX CURVES ---
    case MarketCurveType.keynesianAS:
      baseStart = Offset(0.10, 0.80);
      baseEnd = Offset(keynesianAS, 0.10);
      beziers = [
        CustomBezier(endPoint: Offset(keynesianAS - 0.30, 0.80)),
        CustomBezier(
          control: Offset(keynesianAS, 0.80),
          endPoint: Offset(keynesianAS, 0.60),
        ),
        CustomBezier(endPoint: Offset(keynesianAS, 0.10)),
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
      case MarketCurveType.moneySupply:
        finalLabel2 = "MS";
        break;
      case MarketCurveType.lrpc:
        finalLabel2 = "LRPC";
        break;
      case MarketCurveType.srpc:
        finalLabel2 = "SRPC";
        break;
      case MarketCurveType.moneyDemand:
        finalLabel2 = "Md";
        break;

      // --- NEW TRADE LABELS ---
      case MarketCurveType.demandDomestic:
        finalLabel2 = "Dd"; // Domestic Demand
        break;
      case MarketCurveType.supplyDomestic:
        finalLabel2 = "Sd"; // Domestic Supply
        break;
      case MarketCurveType.demandWorld:
        finalLabel2 = "Dw"; // World Demand (Assuming interpretation)
        break;
      case MarketCurveType.supplyWorld:
        finalLabel2 = "Sw"; // World Supply
        break;
      case MarketCurveType.demandUSD:
        // TODO: Handle this case.
        finalLabel2 = 'Dfor\$';
      case MarketCurveType.supplyUSD:
        finalLabel2 = 'Sof\$';
    }
  }

  String? finalLabel1 = startLabel;

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
      label1: finalLabel1,
      label2: finalLabel2,
      label1Align: isVertical ? LabelAlign.centerBottom : LabelAlign.centerTop,
      label2Align: isVertical ? LabelAlign.centerTop : LabelAlign.centerRight,
      curveStyle: curveStyle,
      color: color,
    );
  }
}
