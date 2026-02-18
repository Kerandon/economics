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
  // Arguments keep their default values to maintain backward compatibility
  String yAxisLabel = 'P',
  String xAxisLabel = 'Q',
  AxisStyle axisStyle = AxisStyle.arrows,
  AxisType? axisType, // The optional preset

  double? xMaxValue,
  double? yMaxValue,
  int? xDivisions,
  int? yDivisions,
  bool drawGridlines = false,
  int decimalPlaces = 0,
  GridLineStyle gridLineStyle = GridLineStyle.full,

  // Original labelPad (kept for compatibility, though previously unused in labels)
  double labelPad = kLabelPadding,

  // NEW: Explicit extra padding controls
  // Positive values move the labels further away from the graph
  double extraXLabelPadding = 0.0,
  double extraYLabelPadding = 0.0,
}) {
  // --- 1. RESOLVE CONFIGURATION ---
  // We determine the final labels and style here.

  String finalY = yAxisLabel;
  String finalX = xAxisLabel;
  AxisStyle finalStyle = axisStyle;

  if (axisType != null) {
    // Logic: Only apply the Enum preset if the user hasn't
    // explicitly passed a custom label (i.e., if it's still the default 'P'/'Q')
    if (yAxisLabel == 'P') finalY = axisType.yLabel;
    if (xAxisLabel == 'Q') finalX = axisType.xLabel;

    // For style, usually the Enum dictates the geometry (like J-Curve)
    // so we can trust the extension.
    if (axisStyle == AxisStyle.arrows) finalStyle = axisType.style;
  }

  // --- 2. J-CURVE SPECIAL HANDLING ---
  // J-Curves are geometrically different (centered axis), so we check the STYLE.
  if (finalStyle == AxisStyle.jCurve) {
    paintJCurveAxes(config, canvas, finalX, finalY);
    return; // Exit early
  }

  // --- 3. STANDARD AXIS PAINTING ---
  final effectiveGridStyle = drawGridlines ? gridLineStyle : GridLineStyle.none;

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
  );

  // --- 4. PAINT LABELS WITH EXTRA PADDING ---

  // A small default buffer to ensure they aren't touching the lines by default
  const double baseBuffer = 0.02;

  // Y-AXIS LOGIC:
  // "Extra Padding" for Y usually means moving it further LEFT (Negative X).
  // We sum the base buffer + user's extra padding.
  final double totalYShift = baseBuffer + extraYLabelPadding;

  paintAxisLabels(
    config,
    canvas,
    axis: CustomAxis.y,
    label: finalY,
    offsetAdjustment: Offset(-totalYShift, 0), // Move Left
  );

  // X-AXIS LOGIC:
  // "Extra Padding" for X usually means moving it further RIGHT (Positive X)
  // or slightly Down depending on preference. Here we move it Right to avoid overlaps.
  final double totalXShift = baseBuffer + extraXLabelPadding;

  paintAxisLabels(
    config,
    canvas,
    axis: CustomAxis.x,
    label: finalX,
    offsetAdjustment: Offset(totalXShift, 0), // Move Right
  );

  if (finalStyle == AxisStyle.arrows) {
    paintZero(config, canvas);
  }
}
