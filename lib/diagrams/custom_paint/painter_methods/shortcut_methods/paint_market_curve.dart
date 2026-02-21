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

  // 1. DEFINE BASE GEOMETRY
  switch (type) {
    // --- DOWNWARD SLOPING (Linear) ---
    case MarketCurveType.demand:
    case MarketCurveType.moneyDemand:
    case MarketCurveType.demandDomestic:
    case MarketCurveType.demandWorld:
    case MarketCurveType.demandUSD:
    case MarketCurveType.dl:
    case MarketCurveType.dl1:
    case MarketCurveType.dl2:
    case MarketCurveType.d1:
    case MarketCurveType.d2:
    case MarketCurveType.dEqualsMPBMSB:
    case MarketCurveType.dEqualsMPB:
    case MarketCurveType.msb:
      baseStart = const Offset(0.10, 0.10);
      baseEnd = const Offset(0.90, 0.90);
      break;

    // --- PHILLIPS CURVE (SRPC - C-Shaped) ---
    // Refined coordinates for a nice convex "C" shape
    case MarketCurveType.srpc:
    case MarketCurveType.srpc1:
    case MarketCurveType.srpc2:
      baseStart = const Offset(0.05, 0.10); // High Inflation (Top Left)
      baseEnd = const Offset(0.95, 0.95); // High Unemployment (Bottom Right)
      beziers = [
        CustomBezier(
          // Control point pulls curve toward origin (bottom-left in visual terms)
          // creating the convex shape typical of Phillips Curves
          control: const Offset(0.15, 0.75),
          endPoint: const Offset(0.95, 0.95),
        ),
      ];
      break;

    // --- UPWARD SLOPING (Supply-like) ---
    case MarketCurveType.supply:
    case MarketCurveType.s1:
    case MarketCurveType.s2:
    case MarketCurveType.supplyDomestic:
    case MarketCurveType.supplyWorld:
    case MarketCurveType.supplyUSD:
    case MarketCurveType.sl:
    case MarketCurveType.sl1:
    case MarketCurveType.sl2:
    case MarketCurveType.sTax:
    case MarketCurveType.sSubsidy:
    case MarketCurveType.sSub:
    case MarketCurveType.sEqualsMPC:
    case MarketCurveType.sEqualsMPCMSC:
    case MarketCurveType.mpc:
    case MarketCurveType.msc:
    case MarketCurveType.mpcTax:
    case MarketCurveType.mscEqualsMpcTax1:
    case MarketCurveType.mpcSub:
    case MarketCurveType.mscEqualsMpcTax2:
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
    case MarketCurveType.perfectlyInelasticSupply:
    case MarketCurveType.lras:
    case MarketCurveType.lras1:
    case MarketCurveType.lras2:
    case MarketCurveType.moneySupply:
    case MarketCurveType.lrpc:
    case MarketCurveType.lrpc1:
    case MarketCurveType.lrpc2:
      baseStart = Offset(lrasX, 1.0);
      baseEnd = Offset(lrasX, 0.10);
      break;

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

  // 2. APPLY TRANSFORMATIONS (Scaling & Shifting)
  Offset start = baseStart;
  Offset end = baseEnd;

  // We exclude KeynesianAS from scaling as it has fixed breakpoints.
  // We Apply scaling to everything else (including SRPC) so lengthAdjustment works.
  if (type != MarketCurveType.keynesianAS) {
    // --- A. LENGTH ADJUSTMENT (SCALING) ---
    if (lengthAdjustment != 0.0) {
      // Calculate the midpoint of the curve
      final mid = Offset(
        (baseStart.dx + baseEnd.dx) / 2,
        (baseStart.dy + baseEnd.dy) / 2,
      );

      // Calculate scale factor (e.g. 0.8 for -0.2 adjustment)
      final scale = 1.0 + lengthAdjustment;

      // Helper to scale a point relative to the midpoint
      Offset scalePoint(Offset p) => Offset(
        mid.dx + (p.dx - mid.dx) * scale,
        mid.dy + (p.dy - mid.dy) * scale,
      );

      // Scale Start/End
      start = scalePoint(baseStart);
      end = scalePoint(baseEnd);

      // Scale Beziers (This preserves the C-Shape!)
      if (beziers != null) {
        beziers = beziers
            .map(
              (b) => CustomBezier(
                control: scalePoint(b.control),
                endPoint: scalePoint(b.endPoint),
              ),
            )
            .toList();
      }
    }

    // --- B. ROTATION (ANGLE) ---
    if (angle != 0.0) {
      final mid = Offset((start.dx + end.dx) / 2, (start.dy + end.dy) / 2);
      start = rotateAround(start, mid, angle);
      end = rotateAround(end, mid, angle);

      // Also rotate beziers
      if (beziers != null) {
        beziers = beziers
            .map(
              (b) => CustomBezier(
                control: rotateAround(b.control, mid, angle),
                endPoint: rotateAround(b.endPoint, mid, angle),
              ),
            )
            .toList();
      }
    }
  }

  // --- C. SHIFTING (Horizontal/Vertical) ---
  Offset shift(Offset o) =>
      Offset(o.dx + horizontalShift, o.dy + verticalShift);

  if (type == MarketCurveType.keynesianAS) {
    // Keynesian AS usually only shifts vertically or via keynesianAS parameter
    start = Offset(0.0, baseStart.dy + verticalShift);
  } else {
    start = shift(start);
  }

  // Shift Beziers if they exist
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
      case MarketCurveType.ad1:
        finalLabel2 = "AD1";
        break;
      case MarketCurveType.ad2:
        finalLabel2 = "AD2";
        break;
      case MarketCurveType.ad3:
        finalLabel2 = "AD3";
        break;
      case MarketCurveType.sras:
        finalLabel2 = "SRAS";
        break;
      case MarketCurveType.sras1:
        finalLabel2 = "SRAS1";
        break;
      case MarketCurveType.sras2:
        finalLabel2 = "SRAS2";
        break;
      case MarketCurveType.lras:
        finalLabel2 = "LRAS";
        break;
      case MarketCurveType.lras1:
        finalLabel2 = "LRAS1";
        break;
      case MarketCurveType.lras2:
        finalLabel2 = "LRAS2";
        break;
      case MarketCurveType.keynesianAS:
        finalLabel2 = "AS";
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
      case MarketCurveType.srpc1:
        finalLabel2 = "SRPC1";
        break;
      case MarketCurveType.srpc2:
        finalLabel2 = "SRPC2";
        break;

      case MarketCurveType.moneyDemand:
        finalLabel2 = "Md";
        break;
      case MarketCurveType.demandDomestic:
        finalLabel2 = "Dd";
        break;
      case MarketCurveType.supplyDomestic:
        finalLabel2 = "Sd";
        break;
      case MarketCurveType.demandWorld:
        finalLabel2 = "Dw";
        break;
      case MarketCurveType.supplyWorld:
        finalLabel2 = "Sw";
        break;
      case MarketCurveType.demandUSD:
        finalLabel2 = r'Dfor$';
        break;
      case MarketCurveType.supplyUSD:
        finalLabel2 = r'Sof$';
        break;
      case MarketCurveType.dl:
        finalLabel2 = "DL";
        break;
      case MarketCurveType.dl1:
        finalLabel2 = "DL1";
        break;
      case MarketCurveType.dl2:
        finalLabel2 = "DL2";
        break;
      case MarketCurveType.sl:
        finalLabel2 = "SL";
        break;
      case MarketCurveType.sl1:
        finalLabel2 = "SL1";
        break;
      case MarketCurveType.sl2:
        finalLabel2 = "SL2";
        break;
      case MarketCurveType.d1:
        finalLabel2 = "D1";
        break;
      case MarketCurveType.d2:
        finalLabel2 = "D2";
        break;
      case MarketCurveType.s1:
        finalLabel2 = "S1";
        break;
      case MarketCurveType.s2:
        finalLabel2 = "S2";
        break;
      case MarketCurveType.lrpc1:
        finalLabel2 = "LRPC1";
        break;
      case MarketCurveType.lrpc2:
        finalLabel2 = "LRPC2";
        break;
      case MarketCurveType.sTax:
        finalLabel2 = 'S+Tax';
        break;

      case MarketCurveType.sSubsidy:
        finalLabel2 = 'S+Subsidy';
        break;

      case MarketCurveType.sSub:
        finalLabel2 = 'S+Sub';
        break;
      case MarketCurveType.dEqualsMPBMSB:
        finalLabel2 = 'D=MPB=MSB';
        break;

      case MarketCurveType.dEqualsMPB:
        finalLabel2 = 'D=MPB';
        break;
      case MarketCurveType.sEqualsMPC:
        finalLabel2 = 'S=MPC';
        break;
      case MarketCurveType.sEqualsMPCMSC:
        finalLabel2 = 'S=MPC=MSC';
        break;

      case MarketCurveType.mpc:
        finalLabel2 = 'MPC';
        break;

      case MarketCurveType.msc:
        finalLabel2 = 'MSC';
        break;

      case MarketCurveType.msb:
        finalLabel2 = 'MSB';
        break;
      case MarketCurveType.mpcTax:
        finalLabel2 = 'MPC+Tax';
        break;

      case MarketCurveType.mscEqualsMpcTax1:
        finalLabel2 = 'MSC=MPC+Tax1';
        break;

      case MarketCurveType.mscEqualsMpcTax2:
        finalLabel2 = 'MSC=MPC+Tax2';
        break;

      case MarketCurveType.mpcSub:
        finalLabel2 = 'MPC+Sub';
        break;

      case MarketCurveType.perfectlyInelasticSupply:
        finalLabel2 = 'S';
        break;
    }
  }

  String? finalLabel1 = startLabel;

  // 4. DRAW
  if (beziers != null) {
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
