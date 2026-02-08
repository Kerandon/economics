import 'dart:ui';

import 'package:economics_app/diagrams/custom_paint/i_diagram_canvas.dart';
import 'package:economics_app/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/paint_axis.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_diagram_dash_lines.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_line_segment_MAKEREDUNDANT.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_title.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/shortcut_methods/paint_description.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/shortcut_methods/paint_market_curve.dart';
import 'package:economics_app/diagrams/enums/diagram_enum.dart';
import 'package:economics_app/diagrams/enums/diagram_labels.dart';

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
  paintDiagramDashedLines(c, canvas, yAxisStartPos: 0.50,
      yLabel: DiagramLabel.eRE.label,
      xAxisEndPos: 0.50, hideXLine: true,);
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
  paintMarketCurve(c, canvas,
      type: MarketCurveType.supply,
      lengthAdjustment: -0.10
  );

  // 3. Shifting Curves (Demand Increases)
  // D1: Original (Lower/Left)
  paintMarketCurve(c, canvas,
    type: MarketCurveType.demand,
    verticalShift: 0.10,
    horizontalShift: -0.10,
    lengthAdjustment: -0.20,
    label: DiagramLabel.d1.label,
  );

  // D2: New (Higher/Right)
  paintMarketCurve(c, canvas,
      type: MarketCurveType.demand,
      horizontalShift: 0.10,
      lengthAdjustment: -0.20,
      label: DiagramLabel.d2.label
  );

  // 4. Equilibrium Lines
  // New Equilibrium (Higher Price)
  paintDiagramDashedLines(c, canvas,
    yAxisStartPos: 0.45,
    yLabel: '1.15',
    xAxisEndPos: 0.55,
    hideXLine: true,
  );

  // Old Equilibrium (Lower Price)
  paintDiagramDashedLines(c, canvas,
    yAxisStartPos: 0.60,
    yLabel: '0.90',
    xAxisEndPos: 0.40,
    hideXLine: true,
  );

  // 5. Directional Arrow (Indicating Demand Shift Right)
  // Originating near D1, pointing towards D2
  paintLineSegment(c, canvas,
    origin: Offset(0.65, 0.70),
    length: 0.12,
    // You might want to rotate this if your API supports it,
    // otherwise this is a flat line indicating "Right Shift"
  );

  // 6. Description
  paintDescription(c, canvas,
      'Relatively high U.S. interest rates attract inward portfolio investment from Europe. This drives up demand for the USD, raising its price from €0.90 to €1.15.'
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
  paintMarketCurve(c, canvas,
      type: MarketCurveType.demand,
      lengthAdjustment: -0.10
  );

  // 3. Shifting Curves (Supply Increases)
  // S1: Original (Higher Price/Left)
  paintMarketCurve(c, canvas,
    type: MarketCurveType.supply,
    lengthAdjustment: -0.10,
    label: DiagramLabel.s1.label,
    horizontalShift: -0.05,
    verticalShift: -0.05,
  );

  // S2: New (Lower Price/Right)
  paintMarketCurve(c, canvas,
    type: MarketCurveType.supply,
    lengthAdjustment: -0.15,
    label: DiagramLabel.s2.label,
    horizontalShift: 0.10,
    verticalShift: 0.10,
  );

  // 4. Equilibrium Lines
  // Old Equilibrium (High Price: 1 / 0.90 = 1.11)
  paintDiagramDashedLines(c, canvas,
    yAxisStartPos: 0.45,
    yLabel: '1.11',
    xAxisEndPos: 0.45,
    hideXLine: true,
  );

  // New Equilibrium (Low Price: 1 / 1.15 = 0.87)
  paintDiagramDashedLines(c, canvas,
    yAxisStartPos: 0.60,
    yLabel: '0.87',
    xAxisEndPos: 0.60,
    hideXLine: true,
  );

  // 5. Directional Arrow (Indicating Supply Shift Right)
  // Originating near S1, pointing towards S2
  paintLineSegment(c, canvas,
      origin: Offset(0.68, 0.35),
      length: 0.12
  );

  // 6. Description
  // Updated text to match the specific labels 1.11 and 0.87
  paintDescription(c, canvas,
      'USD appreciation mirrors Euro depreciation. Investors increase the supply of Euros to buy USD, driving the price down. The rate is the reciprocal: falling from \$1.11 (1/0.90) to \$0.87 (1/1.15).'
  );
}