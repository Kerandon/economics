import 'dart:math';
import 'dart:ui';
import 'package:economics_app/diagrams/custom_paint/i_diagram_canvas.dart';
import 'package:economics_app/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/paint_axis.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/diagram_lines/paint_diagram_lines.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_diagram_dash_lines.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_line_segment.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_text.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_title.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/shortcut_methods/paint_description.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/shortcut_methods/paint_market_curve.dart';
import 'package:economics_app/diagrams/enums/diagram_enum.dart';
import 'package:economics_app/diagrams/enums/diagram_labels.dart';
import 'package:flutter/material.dart';
import '../../models/base_painter_painter.dart';
import '../../models/diagram_painter_config.dart';

class ExchangeRateDiagram extends BaseDiagramPainter {
  ExchangeRateDiagram(super.config, super.diagram);

  @override
  void drawDiagram(IDiagramCanvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);

    switch (diagram) {
      case DiagramEnum.globalForeignExchangeRate:
        _paintFloatingRate(c, canvas);
      case DiagramEnum.globalUSDAppreciates:
        _paintUSDAppreciates(c, canvas);
      case DiagramEnum.globalEuroDepreciates:
        _paintEuroDepreciates(c, canvas);
      case DiagramEnum.globalFloatingRateDemandIncrease:
      case DiagramEnum.globalFloatingRateDemandDecrease:
      case DiagramEnum.globalFloatingRateSupplyIncrease:
      case DiagramEnum.globalFloatingRateSupplyDecrease:
        _paintFloatingChange(c, canvas, diagram);
      case DiagramEnum.globalManagedExchangeRate:
        _paintManagedRate(c, canvas);
      case DiagramEnum.globalFixedRateDemandIncreaseSellCurrency:
      case DiagramEnum.globalFixedRateDemandDecreaseBuyCurrency:
      case DiagramEnum.globalFixedRateDemandDecreaseReduceSupply:
        _paintFixedRate(c, canvas, diagram);
      default:
    }
  }
}

_paintFloatingRate(DiagramPainterConfig c, IDiagramCanvas canvas) {
  paintAxis(
    c,
    canvas,
    yAxisLabel: DiagramLabel.euroPerDollar.label,
    xAxisLabel: DiagramLabel.quantityOfUSD.label,
  );
  paintTitle(c, canvas, 'Price of USD in Euros');
  paintMarketCurve(c, canvas, type: MarketCurveType.demand);
  paintMarketCurve(c, canvas, type: MarketCurveType.supply);
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.50,
    yLabel: DiagramLabel.eRE.label,
    xAxisEndPos: 0.50,
    hideXLine: true,
  );
}

void _paintUSDAppreciates(DiagramPainterConfig c, IDiagramCanvas canvas) {
  paintTitle(c, canvas, 'USD Appreciates Against the Euro');

  // 1. Axes
  paintAxis(
    c,
    canvas,
    yAxisLabel: DiagramLabel.euroPerDollar.label, // Price of USD
    xAxisLabel: DiagramLabel.quantityOfUSD.label,
  );

  // 2. Static Curve (Supply)
  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.supply,
    lengthAdjustment: -0.10,
  );

  // 3. Shifting Curves (Demand Increases)
  // D1: Original (Lower/Left)
  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.demand,
    verticalShift: 0.10,
    horizontalShift: -0.10,
    lengthAdjustment: -0.20,
    label: DiagramLabel.d1.label,
  );

  // D2: New (Higher/Right)
  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.demand,
    horizontalShift: 0.10,
    lengthAdjustment: -0.20,
    label: DiagramLabel.d2.label,
  );

  // 4. Equilibrium Lines
  // New Equilibrium (Higher Price)
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.45,
    yLabel: '1.15',
    xAxisEndPos: 0.55,
    hideXLine: true,
  );

  // Old Equilibrium (Lower Price)
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.60,
    yLabel: '0.90',
    xAxisEndPos: 0.40,
    hideXLine: true,
  );

  // 5. Directional Arrow (Indicating Demand Shift Right)
  // Originating near D1, pointing towards D2
  paintLineSegment(
    c,
    canvas,
    origin: Offset(0.65, 0.70),
    length: 0.12,
    // You might want to rotate this if your API supports it,
    // otherwise this is a flat line indicating "Right Shift"
  );

  // 6. Description
  paintDescription(
    c,
    canvas,
    'Relatively high U.S. interest rates attract inward portfolio investment from Europe. This drives up demand for the USD, raising its price from €0.90 to €1.15.',
  );
}

void _paintEuroDepreciates(DiagramPainterConfig c, IDiagramCanvas canvas) {
  paintTitle(c, canvas, 'Euro Depreciates Against the USD');

  // 1. Axes
  paintAxis(
    c,
    canvas,
    yAxisLabel: DiagramLabel.dollarPerEuro.label, // Price of Euro
    xAxisLabel: DiagramLabel.quantityOfEuro.label,
  );

  // 2. Static Curve (Demand)
  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.demand,
    lengthAdjustment: -0.10,
  );

  // 3. Shifting Curves (Supply Increases)
  // S1: Original (Higher Price/Left)
  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.supply,
    lengthAdjustment: -0.10,
    label: DiagramLabel.s1.label,
    horizontalShift: -0.05,
    verticalShift: -0.05,
  );

  // S2: New (Lower Price/Right)
  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.supply,
    lengthAdjustment: -0.15,
    label: DiagramLabel.s2.label,
    horizontalShift: 0.10,
    verticalShift: 0.10,
  );

  // 4. Equilibrium Lines
  // Old Equilibrium (High Price: 1 / 0.90 = 1.11)
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.45,
    yLabel: '1.11',
    xAxisEndPos: 0.45,
    hideXLine: true,
  );

  // New Equilibrium (Low Price: 1 / 1.15 = 0.87)
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.60,
    yLabel: '0.87',
    xAxisEndPos: 0.60,
    hideXLine: true,
  );

  // 5. Directional Arrow (Indicating Supply Shift Right)
  // Originating near S1, pointing towards S2
  paintLineSegment(c, canvas, origin: Offset(0.68, 0.35), length: 0.12);

  // 6. Description
  // Updated text to match the specific labels 1.11 and 0.87
  paintDescription(
    c,
    canvas,
    'USD appreciation mirrors Euro depreciation. Investors increase the supply of Euros to buy USD, driving the price down. The rate is the reciprocal: falling from \$1.11 (1/0.90) to \$0.87 (1/1.15).',
  );
}

void _paintFloatingChange(
  DiagramPainterConfig c,
  IDiagramCanvas canvas,
  DiagramEnum diagram,
) {
  final length = -0.15;

  // Default Labels
  String d1Label = DiagramLabel.d1.label;
  String d2Label = DiagramLabel.d2.label;
  String s1Label = DiagramLabel.s1.label;
  String s2Label = DiagramLabel.s2.label;

  // Logic Flags & Shift Defaults
  bool shiftDemand = false;
  bool shiftSupply = false;
  double dH = 0.0, dV = 0.0; // Demand horizontal/vertical shift
  double sH = 0.0, sV = 0.0; // Supply horizontal/vertical shift

  // Equilibrium positions (0.50 is the center start point)
  double e2Y = 0.50; // New Exchange Rate Y position
  double e2X = 0.50; // New Quantity X position

  String title = '';
  String desc = '';

  // Arrow origin for the shift indicator
  Offset arrowOrigin = Offset.zero;
  double arrowAngle = 0;

  switch (diagram) {
    case DiagramEnum.globalFloatingRateDemandIncrease:
      title = 'Appreciation - Increase in Demand';
      shiftDemand = true;
      s1Label = DiagramLabel.s.label;
      dH = 0.10;
      dV = -0.10;
      e2Y = 0.40; // Visually higher (Appreciation)
      e2X = 0.60;
      arrowOrigin = Offset(0.69, 0.60); // Points right
      desc =
          'Factors increasing demand: higher exports, remittances, inward FDI, higher interest rates attracting hot money.';
      break;

    case DiagramEnum.globalFloatingRateDemandDecrease:
      title = 'Depreciation - Decrease in Demand';
      shiftDemand = true;
      s1Label = DiagramLabel.s.label;
      dH = -0.10;
      dV = 0.10;
      e2Y = 0.60; // Visually lower (Depreciation)
      e2X = 0.40;
      arrowOrigin = Offset(0.60, 0.70);
      arrowAngle = pi; // Points left
      desc =
          'Factors decreasing demand: lower exports, less inward FDI, lower interest rates causing hot money outflow.';
      break;

    case DiagramEnum.globalFloatingRateSupplyIncrease:
      title = 'Depreciation - Increase in Supply';
      shiftSupply = true;
      d1Label = DiagramLabel.d.label;
      sH = 0.10;
      sV = 0.10;
      e2Y = 0.60; // Visually lower (Depreciation)
      e2X = 0.60;
      arrowOrigin = Offset(0.69, 0.40); // Points right
      desc =
          'Factors increasing supply: increased imports, outward FDI, central bank selling domestic currency.';
      break;

    case DiagramEnum.globalFloatingRateSupplyDecrease:
      title = 'Appreciation - Decrease in Supply';
      shiftSupply = true;
      d1Label = DiagramLabel.d.label;
      sH = -0.10;
      sV = -0.10;
      e2Y = 0.40; // Visually higher (Appreciation)
      e2X = 0.40;
      arrowOrigin = Offset(0.60, 0.30);
      arrowAngle = pi; // Points left
      desc =
          'Factors decreasing supply: decreased imports, less outward FDI, higher interest rates reducing capital flight.';
      break;

    default:
      break;
  }

  // 1. Paint Title
  paintTitle(c, canvas, title);

  // 2. Paint Axes
  paintAxis(
    c,
    canvas,
    yAxisLabel: DiagramLabel.euroPerDollar.label,
    xAxisLabel: DiagramLabel.quantityOfUSD.label,
  );

  // 3. Paint Demand Curves
  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.demand,
    label: d1Label,
    lengthAdjustment: length,
  );

  if (shiftDemand) {
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.demand,
      label: d2Label,
      horizontalShift: dH,
      verticalShift: dV,
      lengthAdjustment: length,
    );
  }

  // 4. Paint Supply Curves
  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.supply,
    label: s1Label,
    lengthAdjustment: length,
  );

  if (shiftSupply) {
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.supply,
      label: s2Label,
      horizontalShift: sH,
      verticalShift: sV,
      lengthAdjustment: length,
    );
  }

  // 5. Paint Old Equilibrium (eR1)
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.50,
    xAxisEndPos: 0.50,
    hideXLine: true,
    yLabel: DiagramLabel.eR1.label,
  );

  // 6. Paint New Equilibrium (eR2)
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: e2Y,
    xAxisEndPos: e2X,
    hideXLine: true,
    yLabel: DiagramLabel.eR2.label,
  );

  // 7. Paint Shift Indicator (Arrow)
  if (arrowOrigin != Offset.zero) {
    paintLineSegment(c, canvas, origin: arrowOrigin, angle: arrowAngle);
  }

  // 8. Paint Description
  paintDescription(c, canvas, desc);
}

void _paintManagedRate(DiagramPainterConfig c, IDiagramCanvas canvas) {
  paintTitle(
    c,
    canvas,
    'Foreign Exchange Market for the Vietnamese Dong (VND)',
  );

  final length = -0.20;

  paintDiagramLines(
    c,
    canvas,
    startPos: Offset(0, 0.38),
    polylineOffsets: [Offset(0.85, 0.38)],
    label2: DiagramLabel.upperBand.label,
    label2Align: LabelAlign.centerRight,
    color: Colors.red,
    curveStyle: CurveStyle.dashed,
  );

  // Lower Band (Floor) - Central Bank buys VND if price hits this
  paintDiagramLines(
    c,
    canvas,
    startPos: Offset(0, 0.62),
    polylineOffsets: [Offset(0.85, 0.62)],
    label2: DiagramLabel.lowerBand.label,
    label2Align: LabelAlign.centerRight,
    color: Colors.red,
    curveStyle: CurveStyle.dashed,
  );

  // 3. Axes
  paintAxis(
    c,
    canvas,
    yAxisLabel: DiagramLabel.uSDPerDong.label,
    xAxisLabel: DiagramLabel.quantityOfDong.label,
  );

  // 4. Market Curves
  // Base Demand (D1)
  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.demand,
    label: DiagramLabel.d1.label,
    lengthAdjustment: length,
  );

  // Low Demand (D2) - Shifts Left, pushing price down to Lower Band
  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.demand,
    label: DiagramLabel.d2.label,
    horizontalShift: -0.08,
    verticalShift: 0.05,
    // Adjust vertical to align intersection with band
    lengthAdjustment: length,
  );

  // High Demand (D3) - Shifts Right, pushing price up to Upper Band
  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.demand,
    label: DiagramLabel.d3.label,
    horizontalShift: 0.08,
    verticalShift: -0.05,
    // Adjust vertical to align intersection with band
    lengthAdjustment: length,
  );

  // Supply Curve
  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.supply,
    lengthAdjustment: length,
  );

  // 5. Equilibrium Points
  // Central Rate (eR1)
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.50,
    xAxisEndPos: 0.50,
    yLabel: DiagramLabel.eR1.label,
    hideXLine: true,
  );

  // Lower Limit Hit (eR2) - Caused by D2
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.565, // Matches Lower Band Y
    xAxisEndPos: 0.445, // Matches D2/Supply intersection X
    yLabel: DiagramLabel.eR2.label,
    hideXLine: true,
  );

  // Upper Limit Hit (eR3) - Caused by D3
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.435, // Matches Upper Band Y
    xAxisEndPos: 0.57, // Matches D3/Supply intersection X
    yLabel: DiagramLabel.eR3.label,
    hideXLine: true,
  );

  // 6. Description
  paintDescription(
    c,
    canvas,
    'The Central Bank allows the currency to float within and upper and lower band (limit). If the exchange rate hits these limits, the Central Bank intervenes by buying or selling currency to keep the rate within the target range.',
  );
}

void _paintFixedRate(
  DiagramPainterConfig c,
  IDiagramCanvas canvas,
  DiagramEnum diagram,
) {
  // 1. Title
  paintTitle(
    c,
    canvas,
    'Foreign Exchange Market for the Hong Kong Dollar (HKD)',
  );

  final length = -0.25;

  // 2. Default State (Demand Decrease / Surplus)
  // Standard: D1 is Right (High), D2 is Left (Low).
  // Fixed Rate (eRF) is usually the target, eR1 is the new low market rate.
  String d1Label = DiagramLabel.d1.label;
  String d2Label = DiagramLabel.d2.label;
  String s1Label = DiagramLabel.s.label;

  // Position of the dashed lines
  double lineHighY = 0.425;
  double lineLowY = 0.575;

  // By default, Fixed Rate is the high line (trying to maintain value),
  // and Market Rate drops to the low line (surplus pressure).
  String lineHighLabel = DiagramLabel.eRF.label;
  String lineLowLabel = DiagramLabel.eR1.label;

  String description = '';

  // 3. Scenario Logic
  switch (diagram) {
    case DiagramEnum.globalFixedRateDemandDecreaseBuyCurrency:
      description =
          '1. A fall in demand leads to downward pressure on currency value. 2. The central bank intervenes by increasing demand: using foreign reserves to buy surplus currency; and/or raise interest rates to increase inward hot money flows.';

      // Arrow 1: Demand Shifts Left
      paintLineSegment(
        c,
        canvas,
        origin: Offset(0.65, 0.65),
        length: 0.20,
        label: '1',
        angle: pi,
      );
      // Arrow 2: Intervention (Upward pressure/buying)
      paintLineSegment(
        c,
        canvas,
        origin: Offset(0.72, 0.75),
        length: 0.20,
        label: '2',
      );
      // Surplus Gap Marker (at the High Fixed Rate)
      paintLineSegment(
        c,
        canvas,
        origin: Offset(0.43, lineHighY), // Aligned with dashed line
        endStyle: LineEndStyle.circlesOnEnd,
        length: 0.30,
        color: Colors.red,
        label: DiagramLabel.surplus.label,
      );
      break;

    case DiagramEnum.globalFixedRateDemandIncreaseSellCurrency:
      description =
          '1. An increase in demand puts upward pressure on the currency value. 2. Central bank sells domestic currency (buying foreign currency) increasing supply.';

      // Logic Swap: Demand Increased.
      // The "Right" curve is now D2 (New), "Left" is D1 (Old).
      d1Label = DiagramLabel.d2.label;
      d2Label = DiagramLabel.d1.label;

      // The Fixed Rate is now the LOW line (Shortage pressure),
      // Market wants to go to the HIGH line.
      lineHighLabel = DiagramLabel.eR1.label;
      lineLowLabel = DiagramLabel.eRF.label;

      // Arrow 1: Demand Shifts Right
      paintLineSegment(
        c,
        canvas,
        origin: Offset(0.70, 0.70),
        length: 0.20,
        label: '1',
      );
      // Arrow 2: Intervention (Selling/Supply shift logic visual)
      paintLineSegment(
        c,
        canvas,
        origin: Offset(0.734, 0.75),
        length: 0.20,
        label: '2',
        angle: pi,
      );
      // Shortage Gap Marker (at the Low Fixed Rate)
      paintLineSegment(
        c,
        canvas,
        origin: Offset(0.58, lineLowY), // Aligned with dashed line
        endStyle: LineEndStyle.circlesOnEnd,
        length: 0.30,
        color: Colors.red,
        label: DiagramLabel.shortage.label,
      );
      break;

    case DiagramEnum.globalFixedRateDemandDecreaseReduceSupply:
      description =
          '1. A fall in demand leads to downward pressure on currency. 2. A central bank can reduce supply to maintain a fixed rate by imposing tariffs and capital controls (prevents capital flight).';

      // Specifically label the Base supply S1, as we add S2
      s1Label = DiagramLabel.s1.label;

      // Paint the extra "Policy" Supply Curve (S2)
      paintMarketCurve(
        c,
        canvas,
        type: MarketCurveType.supply,
        label: 'S2',
        lengthAdjustment: length,
        horizontalShift: -0.15,
        verticalShift: -0.15,
      );

      // Arrow 1: Demand Shifts Left
      paintLineSegment(
        c,
        canvas,
        origin: Offset(0.71, 0.70),
        length: 0.20,
        label: '1',
        angle: pi,
      );
      // Arrow 2: Supply Shifts Left (Policy Response)
      paintLineSegment(
        c,
        canvas,
        origin: Offset(0.62, 0.24),
        length: 0.20,
        label: '2',
        angle: pi,
      );
      // Surplus Gap Marker (at the High Fixed Rate)
      paintLineSegment(
        c,
        canvas,
        origin: Offset(0.43, lineHighY),
        endStyle: LineEndStyle.circlesOnEnd,
        length: 0.30,
        color: Colors.red,
        label: DiagramLabel.surplus.label,
      );
      break;

    default:
      break;
  }

  // 4. Paint Base Axes & Description
  paintAxis(
    c,
    canvas,
    yAxisLabel: DiagramLabel.uSDPerHKD.label,
    xAxisLabel: DiagramLabel.quantityOfHKD.label,
  );

  paintDescription(c, canvas, description);

  // 5. Paint Base Curves
  // Right Curve (D1 usually, or D2 in increase case)
  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.demand,
    label: d1Label,
    lengthAdjustment: length,
    horizontalShift: 0.10,
    verticalShift: -0.05,
  );

  // Left Curve (D2 usually, or D1 in increase case)
  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.demand,
    label: d2Label,
    horizontalShift: -0.10,
    verticalShift: 0.05,
    lengthAdjustment: length,
  );

  // Base Supply Curve
  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.supply,
    label: s1Label,
    lengthAdjustment: length,
  );

  // 6. Paint Dashed Rate Lines
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: lineHighY,
    xAxisEndPos: 0.575, // Keeps visual symmetry
    yLabel: lineHighLabel,
    hideXLine: true,
  );
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: lineLowY,
    xAxisEndPos: 0.425, // Keeps visual symmetry
    yLabel: lineLowLabel,
    hideXLine: true,
  );
}
