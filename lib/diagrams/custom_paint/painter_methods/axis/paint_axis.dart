import 'dart:ui';

import 'package:economics_app/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/paint_axis_labels.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/paint_axis_lines.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/paint_j_curve_axis.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/paint_zero.dart';
import 'package:economics_app/diagrams/enums/diagram_labels.dart';
import '../../../models/diagram_painter_config.dart';
import '../../i_diagram_canvas.dart';
import 'axis_enum.dart';

enum AxisType {
  supplyDemand,
  laborMarket,
  priceRevenueCosts,
  macroADAS,
  jCurve,
  macroPPC,
  phillipsCurve, // Added new type
}

// THE HELPER: Extends functionality without changing the object structure
extension AxisTypeData on AxisType {
  String get yLabel {
    switch (this) {
      case AxisType.supplyDemand:
        return DiagramLabel.p.label;
      case AxisType.laborMarket:
        return DiagramLabel.wageRate.label;
      case AxisType.priceRevenueCosts:
        return DiagramLabel.priceRevenueCosts.label;
      case AxisType.macroADAS:
        return DiagramLabel.priceLevel.label;

      // Phillips Curve: Y-Axis is Inflation Rate
      case AxisType.phillipsCurve:
        return 'Inflation Rate';

      default:
        return 'P';
    }
  }

  String get xLabel {
    switch (this) {
      case AxisType.supplyDemand:
        return DiagramLabel.q.label;
      case AxisType.laborMarket:
        return DiagramLabel.quantityOfLabor.label;
      case AxisType.priceRevenueCosts:
        return DiagramLabel.quantity.label;
      case AxisType.macroADAS:
        return DiagramLabel.realGDP.label;

      // Phillips Curve: X-Axis is Unemployment Rate
      case AxisType.phillipsCurve:
        return 'Unemployment Rate';

      default:
        return 'Q';
    }
  }

  AxisStyle get style {
    switch (this) {
      case AxisType.jCurve:
        return AxisStyle.jCurve;
      // Phillips curve uses standard arrows, so it falls to default
      default:
        return AxisStyle.arrows;
    }
  }
}

void paintAxis(
  DiagramPainterConfig config,
  IDiagramCanvas canvas, {
  String yAxisLabel = 'P',
  String xAxisLabel = 'Q',
  AxisStyle axisStyle = AxisStyle.arrows,
  AxisType? axisType,
  double? xMaxValue,
  double? yMaxValue,
  int? xDivisions,
  int? yDivisions,
  bool drawGridlines = false,
  int decimalPlaces = 0,
  GridLineStyle gridLineStyle = GridLineStyle.full,
  double labelPad = kLabelPadding,
  double extraXLabelPadding = 0.0,
  double extraYLabelPadding = 0.0,
  bool showLabelBackground = true, // 👈 New Property
}) {
  String finalY = yAxisLabel;
  String finalX = xAxisLabel;
  AxisStyle finalStyle = axisStyle;

  if (axisType != null) {
    if (yAxisLabel == 'P') finalY = axisType.yLabel;
    if (xAxisLabel == 'Q') finalX = axisType.xLabel;
    if (axisStyle == AxisStyle.arrows) finalStyle = axisType.style;
  }

  if (finalStyle == AxisStyle.jCurve) {
    paintJCurveAxes(config, canvas, finalX, finalY);
    return;
  }

  final effectiveGridStyle = drawGridlines ? gridLineStyle : GridLineStyle.none;

  // Pass background property down to grid lines
  paintAxisLines(
    config,
    canvas,
    yMaxValue: yMaxValue,
    yDivisions: yDivisions,
    xMaxValue: xMaxValue,
    xDivisions: xDivisions,
    decimalPlaces: decimalPlaces,
    gridLineStyle: effectiveGridStyle,
    axisStyle: finalStyle,
    showLabelBackground: showLabelBackground,
  );

  const double baseBuffer = 0.02;

  paintAxisLabels(
    config,
    canvas,
    axis: CustomAxis.y,
    label: finalY,
    offsetAdjustment: Offset(-(baseBuffer + extraYLabelPadding), 0),
    showBackground: showLabelBackground, // Pass to helper
  );

  paintAxisLabels(
    config,
    canvas,
    axis: CustomAxis.x,
    label: finalX,
    offsetAdjustment: Offset(baseBuffer + extraXLabelPadding, 0),
    showBackground: showLabelBackground, // Pass to helper
  );

  if (finalStyle == AxisStyle.arrows) paintZero(config, canvas);
}
