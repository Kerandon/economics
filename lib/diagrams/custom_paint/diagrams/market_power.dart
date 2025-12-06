import 'dart:ui';

import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/label_align.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/paint_axis.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/diagram_lines/paint_diagram_lines.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_custom_bezier.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_diagram_dash_lines.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_dot.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_title.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/shortcut_methods/paint_marginal_cost.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/shortcut_methods/paint_market_curve.dart';
import 'package:economics_app/diagrams/enums/diagram_bundle_enum.dart';
import 'package:economics_app/diagrams/enums/diagram_labels.dart';
import 'package:economics_app/diagrams/enums/diagram_type.dart';
import 'package:economics_app/diagrams/models/custom_bezier.dart';

import '../../models/base_painter_painter.dart';
import '../../models/diagram_painter_config.dart';

class MarketPower extends BaseDiagramPainter3 {
  MarketPower(super.config, super.diagram);

  @override
  void paint(Canvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);

    switch (diagram) {
      case DiagramEnum.microPerfectCompetitionLongRunIndustry:
        return _perfectCompIndustry(c, canvas, size, diagram);
      case DiagramEnum.microPerfectCompetitionLongRunFirm:
        return _perfectCompFirm(c, canvas, size, diagram);
      default:
    }
  }
}

void _perfectCompIndustry(
  DiagramPainterConfig c,
  Canvas canvas,
  Size size,
  DiagramEnum bundle,
) {
  paintTitle(c, canvas, DiagramLabel.industry.label);
  paintAxis(
    c,
    canvas,
    yAxisLabel: DiagramLabel.priceCostsRevenue.label,
    xAxisLabel: DiagramLabel.industryQuantity.label,
  );

  paintMarketCurve(c, canvas, type: MarketCurveType.demand);
  paintMarketCurve(c, canvas, type: MarketCurveType.supply);
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.50,
    xAxisEndPos: 1.1,
    yLabel: DiagramLabel.pm.label,
    hideXLine: true,
  );
  paintDot(c, canvas, pos: Offset(0.50, 0.50));
}

void _perfectCompFirm(
  DiagramPainterConfig c,
  Canvas canvas,
  Size size,
  DiagramEnum bundle,
) {
  paintTitle(c, canvas, DiagramLabel.firm.label);
  paintAxis(
    c,
    canvas,
    yAxisLabel: DiagramLabel.priceCostsRevenue.label,
    xAxisLabel: DiagramLabel.quantityFirm.label,
  );

  paintDiagramLines(
    c,
    canvas,
    startPos: Offset(0, 0.50),
    polylineOffsets: [Offset(0.90, 0.50)],
    label2: DiagramLabel.dEqualsARMR.label,
    label2Align: LabelAlign.centerRight,
  );
  paintMarginalCost(c, canvas);
  paintDiagramLines(
    c,
    canvas,
    startPos: Offset(0.05, 0.10),
    bezierPoints: [
      CustomBezier(control: Offset(0.45, 0.90), endPoint: Offset(0.90, 0.10)),
    ],
    label2: DiagramLabel.atc.label,
    label2Align: LabelAlign.centerTop,
  );
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.50,
    xAxisEndPos: 0.48,
    hideYLine: true,
    yLabel: DiagramLabel.pE.label,
    xLabel: DiagramLabel.qE.label,
    showDotAtIntersection: true,
  );
}
