import 'dart:ui';
import 'package:economics_app/diagrams/custom_paint/painter_methods/diagram_lines/paint_diagram_lines.dart';
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
  Offset baseStart;
  Offset baseEnd;
  List<CustomBezier>? beziers;

  bool isVertical =
      type == MarketCurveType.lras ||
          type == MarketCurveType.lras1 ||
          type == MarketCurveType.lras2 ||
          type == MarketCurveType.moneySupply ||
          type == MarketCurveType.lrpc;

  switch (type) {
  // --- DOWNWARD SLOPING (Demand-like) ---
    case MarketCurveType.demand:
    case MarketCurveType.srpc:
    case MarketCurveType.moneyDemand:
    case MarketCurveType.demandDomestic:
    case MarketCurveType.demandWorld:
    case MarketCurveType.demandUSD:
    case MarketCurveType.dl:   // Labor Demand
    case MarketCurveType.dl1:
    case MarketCurveType.dl2:
    case MarketCurveType.d1:


    case MarketCurveType.d2:


      baseStart = const Offset(0.10, 0.10);
      baseEnd = const Offset(0.90, 0.90);
      break;

  // --- UPWARD SLOPING (Supply-like) ---
    case MarketCurveType.supply:

    case MarketCurveType.s1:


    case MarketCurveType.s2:
    case MarketCurveType.supplyDomestic:
    case MarketCurveType.supplyWorld:
    case MarketCurveType.supplyUSD:
    case MarketCurveType.sl:   // Labor Supply
    case MarketCurveType.sl1:
    case MarketCurveType.sl2:
      baseStart = const Offset(0.10, 0.90);
      baseEnd = const Offset(0.90, 0.10);
      break;

    case MarketCurveType.sras:
    case MarketCurveType.sras1:
    case MarketCurveType.sras2:
      baseStart = const Offset(0.20, 0.80);
      baseEnd = const Offset(0.80, 0.20);
      break;

    case MarketCurveType.ad:
    case MarketCurveType.ad1:
    case MarketCurveType.ad2:
    case MarketCurveType.ad3:
      baseStart = const Offset(0.20, 0.20);
      baseEnd = const Offset(0.80, 0.80);
      break;

    case MarketCurveType.lras:
    case MarketCurveType.lras1:
    case MarketCurveType.lras2:
    case MarketCurveType.moneySupply:
    case MarketCurveType.lrpc:
      baseStart = Offset(lrasX, 1.0);
      baseEnd = Offset(lrasX, 0.10);
      break;

    case MarketCurveType.keynesianAS:
      baseStart = Offset(0.10, 0.80);
      baseEnd = Offset(keynesianAS, 0.10);
      beziers = [
        CustomBezier(endPoint: Offset(keynesianAS - 0.30, 0.80)),
        CustomBezier(control: Offset(keynesianAS, 0.80), endPoint: Offset(keynesianAS, 0.60)),
        CustomBezier(endPoint: Offset(keynesianAS, 0.10)),
      ];
      break;



  }

  // 2. APPLY TRANSFORMATIONS (Logic unchanged)
  Offset start = baseStart;
  Offset end = baseEnd;

  if (type != MarketCurveType.keynesianAS) {
    if (lengthAdjustment != 0.0) {
      final dx = baseEnd.dx - baseStart.dx;
      final dy = baseEnd.dy - baseStart.dy;
      start = Offset(baseStart.dx - dx * (lengthAdjustment / 2), baseStart.dy - dy * (lengthAdjustment / 2));
      end = Offset(baseEnd.dx + dx * (lengthAdjustment / 2), baseEnd.dy + dy * (lengthAdjustment / 2));
    }
    if (angle != 0.0) {
      final mid = Offset((start.dx + end.dx) / 2, (start.dy + end.dy) / 2);
      start = rotateAround(start, mid, angle);
      end = rotateAround(end, mid, angle);
    }
  }

  Offset shift(Offset o) => Offset(o.dx + horizontalShift, o.dy + verticalShift);
  if (type == MarketCurveType.keynesianAS) {
    start = Offset(0.0, baseStart.dy + verticalShift);
  } else {
    start = shift(start);
  }

  if (beziers != null) {
    beziers = beziers.map((b) => CustomBezier(control: shift(b.control), endPoint: shift(b.endPoint))).toList();
  } else {
    end = shift(end);
  }

  // 3. DETERMINE LABELS
  String finalLabel2 = label ?? '';
  if (label == null) {
    switch (type) {
      case MarketCurveType.demand: finalLabel2 = "D"; break;
      case MarketCurveType.supply: finalLabel2 = "S"; break;
      case MarketCurveType.ad: finalLabel2 = "AD"; break;
      case MarketCurveType.ad1: finalLabel2 = "AD1"; break;
      case MarketCurveType.ad2: finalLabel2 = "AD2"; break;
      case MarketCurveType.ad3: finalLabel2 = "AD3"; break;
      case MarketCurveType.sras: finalLabel2 = "SRAS"; break;
      case MarketCurveType.sras1: finalLabel2 = "SRAS1"; break;
      case MarketCurveType.sras2: finalLabel2 = "SRAS2"; break;
      case MarketCurveType.lras: finalLabel2 = "LRAS"; break;
      case MarketCurveType.lras1: finalLabel2 = "LRAS1"; break;
      case MarketCurveType.lras2: finalLabel2 = "LRAS2"; break;
      case MarketCurveType.keynesianAS: finalLabel2 = "AS"; break;
      case MarketCurveType.moneySupply: finalLabel2 = "MS"; break;
      case MarketCurveType.lrpc: finalLabel2 = "LRPC"; break;
      case MarketCurveType.srpc: finalLabel2 = "SRPC"; break;
      case MarketCurveType.moneyDemand: finalLabel2 = "Md"; break;
      case MarketCurveType.demandDomestic: finalLabel2 = "Dd"; break;
      case MarketCurveType.supplyDomestic: finalLabel2 = "Sd"; break;
      case MarketCurveType.demandWorld: finalLabel2 = "Dw"; break;
      case MarketCurveType.supplyWorld: finalLabel2 = "Sw"; break;
      case MarketCurveType.demandUSD: finalLabel2 = r'Dfor$'; break;
      case MarketCurveType.supplyUSD: finalLabel2 = r'Sof$'; break;
    // Labor Market Labels
      case MarketCurveType.dl: finalLabel2 = "DL"; break;
      case MarketCurveType.dl1: finalLabel2 = "DL1"; break;
      case MarketCurveType.dl2: finalLabel2 = "DL2"; break;
      case MarketCurveType.sl: finalLabel2 = "SL"; break;
      case MarketCurveType.sl1: finalLabel2 = "SL1"; break;
      case MarketCurveType.sl2: finalLabel2 = "SL2"; break;
      case MarketCurveType.d1:finalLabel2 = "D1"; break;
   
  
      case MarketCurveType.d2:finalLabel2 = "D2"; break;
   
  
      case MarketCurveType.s1:finalLabel2 = "S1"; break;
   
  
      case MarketCurveType.s2:finalLabel2 = "S2"; break;
   
  
    }
  }

  String? finalLabel1 = startLabel;

  // 4. DRAW (Logic unchanged)
  if (type == MarketCurveType.keynesianAS) {
    paintDiagramLines(config, canvas, startPos: start, bezierPoints: beziers, label1: finalLabel1, label2: finalLabel2, label2Align: LabelAlign.centerTop, curveStyle: curveStyle, color: color);
  } else {
    paintDiagramLines(config, canvas, startPos: start, polylineOffsets: [end], label1: finalLabel1, label2: finalLabel2, label1Align: isVertical ? LabelAlign.centerBottom : LabelAlign.centerTop, label2Align: isVertical ? LabelAlign.centerTop : LabelAlign.centerRight, curveStyle: curveStyle, color: color);
  }
}
