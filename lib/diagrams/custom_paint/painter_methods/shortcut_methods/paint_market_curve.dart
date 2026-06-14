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
  // ==========================================
  // 0. HANDLE "COMBO" TYPES FIRST
  // ==========================================
  if (type == MarketCurveType.mcAtc) {
    paintMarketCurve(
      config,
      canvas,
      type: MarketCurveType.ac,
      lengthAdjustment: lengthAdjustment,
      horizontalShift: horizontalShift,
      verticalShift: verticalShift,
      angle: angle,
      curveStyle: curveStyle,
      color: color,
      lrasX: lrasX,
      keynesianAS: keynesianAS,
    );
    paintMarketCurve(
      config,
      canvas,
      type: MarketCurveType.mc,
      lengthAdjustment: lengthAdjustment,
      horizontalShift: horizontalShift,
      verticalShift: verticalShift,
      angle: angle,
      curveStyle: curveStyle,
      color: color,
      lrasX: lrasX,
      keynesianAS: keynesianAS,
    );
    return;
  }

  if (type == MarketCurveType.dArMrMonopoly) {
    paintMarketCurve(
      config,
      canvas,
      type: MarketCurveType.dArMonopoly,
      lengthAdjustment: lengthAdjustment,
      horizontalShift: horizontalShift,
      verticalShift: verticalShift,
      angle: angle,
      curveStyle: curveStyle,
      color: color,
      lrasX: lrasX,
      keynesianAS: keynesianAS,
    );
    paintMarketCurve(
      config,
      canvas,
      type: MarketCurveType.mrMonopoly,
      lengthAdjustment: lengthAdjustment,
      horizontalShift: horizontalShift,
      verticalShift: verticalShift,
      angle: angle,
      curveStyle: curveStyle,
      color: color,
      lrasX: lrasX,
      keynesianAS: keynesianAS,
    );
    return;
  }

  Offset baseStart;
  Offset baseEnd;
  List<CustomBezier>? beziers;

  bool isVertical =
      type == MarketCurveType.lras ||
      type == MarketCurveType.lras1 ||
      type == MarketCurveType.lras2 ||
      type == MarketCurveType.moneySupply ||
      type == MarketCurveType.lrpc ||
      type == MarketCurveType.lrpc1 ||
      type == MarketCurveType.lrpc2 ||
      type == MarketCurveType.perfectlyInelasticSupply;

  // 1. DEFINE BASE GEOMETRY
  switch (type) {
    // --- MICROECONOMICS J-CURVES & U-CURVES ---
    case MarketCurveType.mc:
      baseStart = const Offset(0.03, 0.80);
      baseEnd = const Offset(0.68, 0.10);
      beziers = [
        CustomBezier(control: const Offset(0.12, 1.26), endPoint: baseEnd),
      ];
      break;

    case MarketCurveType.ac:
      baseStart = const Offset(0.05, 0.20);
      baseEnd = const Offset(0.90, 0.20);
      beziers = [
        CustomBezier(control: const Offset(0.40, 0.885), endPoint: baseEnd),
      ];
      break;

    case MarketCurveType.avc:
      baseStart = const Offset(0.05, 0.55);
      baseEnd = const Offset(0.92, 0.15);
      beziers = [
        CustomBezier(control: const Offset(0.50, 1.0), endPoint: baseEnd),
      ];
      break;

    // --- MICROECONOMICS FIRM REVENUE ---
    case MarketCurveType.mr:
      baseStart = const Offset(0.05, 0.10);
      baseEnd = const Offset(0.50, 0.90);
      break;

    case MarketCurveType.dArMonopoly:
      baseStart = const Offset(0.05, 0.05);
      baseEnd = const Offset(0.85, 0.90);
      break;

    case MarketCurveType.mrMonopoly:
      baseStart = const Offset(0.05, 0.05);
      baseEnd = const Offset(0.50, 1.10);
      break;

    // --- DOWNWARD SLOPING (Linear - Full Length) ---
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
    case MarketCurveType.srpc:
    case MarketCurveType.srpc1:
    case MarketCurveType.srpc2:
      baseStart = const Offset(0.10, 0.10);
      baseEnd = const Offset(0.95, 0.95);
      beziers = [
        CustomBezier(
          control: const Offset(0.15, 0.90),
          endPoint: const Offset(0.95, 0.90),
        ),
      ];
      break;

    // --- UPWARD SLOPING (Supply-like - Full Length) ---
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
    case MarketCurveType.sPlusProvisionEqualsMSC:
    case MarketCurveType.sPlusProvision:
      baseStart = const Offset(0.10, 0.90);
      baseEnd = const Offset(0.90, 0.10);
      break;

    // --- UPWARD SLOPING (Shorter - SRAS & Loanable Funds Supply) ---
    case MarketCurveType.sras:
    case MarketCurveType.sras1:
    case MarketCurveType.sras2:
    case MarketCurveType.loanableFundsSupply: // 🌟 MOVED HERE
    case MarketCurveType.loanableFundsSupply1: // 🌟 MOVED HERE
    case MarketCurveType.loanableFundsSupply2: // 🌟 MOVED HERE
      baseStart = const Offset(0.20, 0.80);
      baseEnd = const Offset(0.80, 0.20);
      break;

    // --- DOWNWARD SLOPING (Shorter - AD & Loanable Funds Demand) ---
    case MarketCurveType.ad:
    case MarketCurveType.ad1:
    case MarketCurveType.ad2:
    case MarketCurveType.ad3:
    case MarketCurveType.loanableFundsDemand: // 🌟 MOVED HERE
    case MarketCurveType.loanableFundsDemand1: // 🌟 MOVED HERE
    case MarketCurveType.loanableFundsDemand2: // 🌟 MOVED HERE
      baseStart = const Offset(0.20, 0.20);
      baseEnd = const Offset(0.80, 0.80);
      break;

    // Steeper AD (~30 degrees more than standard 45 deg), slightly lower, and 20% longer
    case MarketCurveType.keynesianAD:
    case MarketCurveType.keynesianAD1:
    case MarketCurveType.keynesianAD2:
    case MarketCurveType.keynesianAD3:
      baseStart = const Offset(0.28, 0.19);
      baseEnd = const Offset(0.52, 0.91);
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
      baseStart = Offset(0.10, 0.70);
      baseEnd = Offset(keynesianAS, 0.10);
      beziers = [
        CustomBezier(endPoint: Offset(keynesianAS - 0.30, 0.70)),
        CustomBezier(
          control: Offset(keynesianAS, 0.70),
          endPoint: Offset(keynesianAS, 0.45),
        ),
        CustomBezier(endPoint: Offset(keynesianAS, 0.10)),
      ];
      break;

    case MarketCurveType.mcAtc:
    case MarketCurveType.dArMrMonopoly:
      baseStart = const Offset(0.0, 0.0);
      baseEnd = const Offset(0.0, 0.0);
      break;
  }

  // 2. APPLY TRANSFORMATIONS (Scaling & Shifting)
  Offset start = baseStart;
  Offset end = baseEnd;

  if (type != MarketCurveType.keynesianAS &&
      type != MarketCurveType.mcAtc &&
      type != MarketCurveType.dArMrMonopoly) {
    // --- A. LENGTH ADJUSTMENT (SCALING) ---
    if (lengthAdjustment != 0.0) {
      final mid = Offset(
        (baseStart.dx + baseEnd.dx) / 2,
        (baseStart.dy + baseEnd.dy) / 2,
      );
      final scale = 1.0 + lengthAdjustment;
      Offset scalePoint(Offset p) => Offset(
        mid.dx + (p.dx - mid.dx) * scale,
        mid.dy + (p.dy - mid.dy) * scale,
      );
      start = scalePoint(baseStart);
      end = scalePoint(baseEnd);
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
    start = Offset(0.0, baseStart.dy + verticalShift);
  } else {
    start = shift(start);
  }

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
      // Micro Labels
      case MarketCurveType.mc:
        finalLabel2 = "MC";
        break;
      case MarketCurveType.ac:
        finalLabel2 = "ATC";
        break;
      case MarketCurveType.avc:
        finalLabel2 = "AVC";
        break;
      case MarketCurveType.mr:
      case MarketCurveType.mrMonopoly:
        finalLabel2 = "MR";
        break;
      case MarketCurveType.dArMonopoly:
        finalLabel2 = "D=AR";
        break;

      // Existing Labels
      case MarketCurveType.demand:
        finalLabel2 = "D";
        break;
      case MarketCurveType.supply:
        finalLabel2 = "S";
        break;
      case MarketCurveType.ad:
      case MarketCurveType.keynesianAD:
        finalLabel2 = "AD";
        break;
      case MarketCurveType.ad1:
      case MarketCurveType.keynesianAD1:
        finalLabel2 = "AD1";
        break;
      case MarketCurveType.ad2:
      case MarketCurveType.keynesianAD2:
        finalLabel2 = "AD2";
        break;
      case MarketCurveType.ad3:
      case MarketCurveType.keynesianAD3:
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
        finalLabel2 = "Ms";
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
      case MarketCurveType.loanableFundsDemand:
        finalLabel2 = "Dlf";
        break;
      case MarketCurveType.loanableFundsDemand1:
        finalLabel2 = "Dlf1";
        break;
      case MarketCurveType.loanableFundsDemand2:
        finalLabel2 = "Dlf2";
        break;
      case MarketCurveType.loanableFundsSupply:
        finalLabel2 = "Slf";
        break;
      case MarketCurveType.loanableFundsSupply1:
        finalLabel2 = "Slf1";
        break;
      case MarketCurveType.loanableFundsSupply2:
        finalLabel2 = "Slf2";
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
        finalLabel2 = DiagramLabel.mPCMinusSubsidy.label;
        break;
      case MarketCurveType.perfectlyInelasticSupply:
        finalLabel2 = 'S';
        break;
      case MarketCurveType.sPlusProvision:
        finalLabel2 = 'S+Provision';
        break;
      case MarketCurveType.sPlusProvisionEqualsMSC:
        finalLabel2 = DiagramLabel.sPlusProvisionEqualsMSC.label;
        break;

      case MarketCurveType.mcAtc:
      case MarketCurveType.dArMrMonopoly:
        break; // Combo labels handled internally
    }
  }

  String? finalLabel1 = startLabel;

  // 4. DRAW (Only happens for non-combo base types)
  if (type != MarketCurveType.mcAtc && type != MarketCurveType.dArMrMonopoly) {
    if (beziers != null) {
      bool isSrpc =
          type == MarketCurveType.srpc ||
          type == MarketCurveType.srpc1 ||
          type == MarketCurveType.srpc2;

      paintDiagramLines(
        config,
        canvas,
        startPos: start,
        bezierPoints: beziers,
        label1: finalLabel1,
        label2: finalLabel2,
        label2Align: isSrpc ? LabelAlign.right : LabelAlign.centerTop,
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
        label1Align: isVertical
            ? LabelAlign.centerBottom
            : LabelAlign.centerTop,
        label2Align: isVertical ? LabelAlign.centerTop : LabelAlign.right,
        curveStyle: curveStyle,
        color: color,
      );
    }
  }
}
