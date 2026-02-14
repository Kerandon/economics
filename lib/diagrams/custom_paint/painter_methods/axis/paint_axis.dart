import 'dart:math';

import 'package:economics_app/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/paint_axis_labels.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/paint_axis_lines.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/paint_j_curve_axis.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/paint_zero.dart';
import 'package:economics_app/diagrams/enums/diagram_labels.dart';

import 'package:flutter/material.dart';
import '../../../models/diagram_painter_config.dart';
import '../../i_diagram_canvas.dart';
import '../paint_arrow_head.dart';
import '../paint_text.dart';
import 'axis_enum.dart';



enum AxisType {
  supplyDemand,
  laborMarket,
  priceRevenueCosts,
  macroADAS,
  jCurve,
  macroPPC,
}


// THE HELPER: Extends functionality without changing the object structure
extension AxisTypeData on AxisType {
  String get yLabel {
    switch (this) {
      case AxisType.supplyDemand: return DiagramLabel.p.label;
      case AxisType.laborMarket: return DiagramLabel.wageRate.label;
      case AxisType.priceRevenueCosts: return DiagramLabel.priceRevenueCosts.label;
      case AxisType.macroADAS: return DiagramLabel.priceLevel.label;
    // Default fallback for others
      default: return 'P';
    }
  }

  String get xLabel {
    switch (this) {
      case AxisType.supplyDemand: return DiagramLabel.q.label;
      case AxisType.laborMarket: return DiagramLabel.quantityOfLabor.label;
      case AxisType.priceRevenueCosts: return DiagramLabel.quantity.label;
      case AxisType.macroADAS: return DiagramLabel.realGDP.label;
    // Default fallback for others
      default: return 'Q';
    }
  }

  AxisStyle get style {
    switch (this) {
      case AxisType.jCurve: return AxisStyle.jCurve;
      default: return AxisStyle.arrows;
    }
  }
}void paintAxis(
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
      double labelPad = kLabelPadding,
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

  paintAxisLabels(config, canvas, axis: CustomAxis.y, label: finalY);
  paintAxisLabels(config, canvas, axis: CustomAxis.x, label: finalX);

  if (finalStyle == AxisStyle.arrows) {
    paintZero(config, canvas);
  }
}