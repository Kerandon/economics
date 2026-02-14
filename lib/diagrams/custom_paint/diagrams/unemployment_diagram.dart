import 'dart:math';
import 'package:economics_app/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/paint_axis.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/diagram_lines/paint_diagram_lines.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_diagram_dash_lines.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_line_segment_MAKEREDUNDANT.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_title.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/shortcut_methods/paint_description.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/shortcut_methods/paint_market_curve.dart';
import 'package:economics_app/diagrams/enums/diagram_enum.dart';
import 'package:economics_app/diagrams/enums/diagram_labels.dart';
import 'package:flutter/material.dart';

import '../../models/base_painter_painter.dart';
import '../../models/diagram_painter_config.dart';
import '../i_diagram_canvas.dart';
class UnemploymentDiagram extends BaseDiagramPainter {
  UnemploymentDiagram(super.config, super.diagram);

  @override
  void drawDiagram(IDiagramCanvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);

    switch (diagram) {
      case DiagramEnum.macroUnemploymentStructural:
        _paintUnemploymentStructural(c, canvas);
      case DiagramEnum.macroUnemploymentLaborMarketRigidities:
        _paintUnemploymentLaborMarketRigidities(c, canvas);
      case DiagramEnum.macroUnemploymentNationalMinimumWage:
        _paintNMW(c, canvas);
      case DiagramEnum.macroNaturalRateOfUnemployment:
        _paintNaturalRateOfUnemployment(c, canvas);
      case DiagramEnum.macroUnemploymentEfficiencyWages:
        _paintEfficiencyWages(c, canvas);
      default:
    }
  }

  // Helper to standardise curve length adjustments
  static const double _kCurveShort = -0.25;
  static const double _kCurveMed = -0.15;

  void _paintUnemploymentStructural(
      DiagramPainterConfig c, IDiagramCanvas canvas) {
    paintAxis(c, canvas, axisType: AxisType.laborMarket);

    // Initial Equilibrium
    paintDiagramDashedLines(
      c, canvas,
      yAxisStartPos: 0.425,
      xAxisEndPos: 0.58,
      yLabel: DiagramLabel.w1.label,
      xLabel: DiagramLabel.q1.label,
    );

    // New Equilibrium (Demand Shift)
    paintDiagramDashedLines(
      c, canvas,
      yAxisStartPos: 0.575, // Note: Visually check if this should be lower for a demand drop
      xAxisEndPos: 0.425,
      yLabel: DiagramLabel.w2.label, // changed from w1 to w2 (logic fix)
      xLabel: DiagramLabel.q2.label,
    );

    paintMarketCurve(
      c, canvas,
      type: MarketCurveType.sl,
      lengthAdjustment: _kCurveShort,
    );

    // Initial Demand
    paintMarketCurve(
      c, canvas,
      type: MarketCurveType.dl1,
      lengthAdjustment: _kCurveShort,
      horizontalShift: 0.15,
    );

    // Shifted Demand
    paintMarketCurve(
      c, canvas,
      type: MarketCurveType.dl2,
      lengthAdjustment: _kCurveShort,
      horizontalShift: -0.05,
      verticalShift: 0.10,
    );

    paintLineSegment(
      c, canvas,
      origin: const Offset(0.72, 0.70),
      angle: pi,
      length: 0.15,
    );

    paintDescription(
      c, canvas,
      'Structural Unemployment: Caused by a mismatch of skills (occupational immobility) or location (geographical immobility). Often driven by technological change (capital-labor substitution) or globalization shifting demand away from specific domestic industries.',
    );
  }

  void _paintUnemploymentLaborMarketRigidities(DiagramPainterConfig c, IDiagramCanvas canvas) {
    paintTitle(c, canvas, 'Retail Industry');
    paintAxis(c, canvas, axisType: AxisType.supplyDemand);

    paintDiagramDashedLines(
      c, canvas,
      yAxisStartPos: 0.55, xAxisEndPos: 0.55,
      yLabel: DiagramLabel.p1.label, xLabel: DiagramLabel.q1.label,
    );

    paintDiagramDashedLines(
      c, canvas,
      yAxisStartPos: 0.425, xAxisEndPos: 0.425,
      yLabel: DiagramLabel.p2.label, xLabel: DiagramLabel.q2.label,
    );

    paintMarketCurve(
      c, canvas,
      type: MarketCurveType.s1,
      horizontalShift: 0.05,
      verticalShift: 0.05,
      lengthAdjustment: _kCurveMed,
    );

    paintMarketCurve(
      c, canvas,
      type: MarketCurveType.s2,
      horizontalShift: -0.05,
      verticalShift: -0.10,
      lengthAdjustment: _kCurveMed,
    );

    paintMarketCurve(
      c, canvas,
      type: MarketCurveType.dl,
      lengthAdjustment: _kCurveMed,
    );

    paintDescription(
      c, canvas,
      'Labor Market Rigidities: Heavy regulation or strong trade union power increases production costs. This shifts Supply left (S1->S2), raising prices and lowering output. The drop in output leads to lower "derived demand" for labor.',
    );

    paintLineSegment(c, canvas, origin: const Offset(0.68, 0.30), angle: pi);
  }

  void _paintNMW(DiagramPainterConfig c, IDiagramCanvas canvas) {
    paintTitle(c, canvas, 'Fast-Food Industry');
    paintAxis(c, canvas, axisType: AxisType.laborMarket);

    // Equilibrium
    paintDiagramDashedLines(
      c, canvas,
      yAxisStartPos: 0.505, xAxisEndPos: 0.505,
      yLabel: DiagramLabel.wE.label, xLabel: DiagramLabel.qE.label,
    );

    // Minimum Wage Floor
    paintDiagramDashedLines(
      c, canvas,
      yAxisStartPos: 0.30, xAxisEndPos: 0.70,
      yLabel: DiagramLabel.wMin.label, xLabel: DiagramLabel.qS.label,
      additionalXPositions: [0.30],
      additionalXLabels: [DiagramLabel.qD.label],
    );

    paintMarketCurve(c, canvas, type: MarketCurveType.dl);
    paintMarketCurve(c, canvas, type: MarketCurveType.sl);

    paintDiagramLines(
      c, canvas,
      startPos: const Offset(0, 0.30),
      polylineOffsets: [const Offset(0.90, 0.30)],
      color: Colors.red,
    );

    paintLineSegment(
      c, canvas,
      origin: const Offset(0.50, 0.25),
      endStyle: LineEndStyle.circlesOnEnd,
      length: 0.40,
      label: DiagramLabel.surplusLabor.label,
    );

    paintDescription(
      c, canvas,
      'Real Wage Unemployment: A price floor (Min Wage) above equilibrium (We) creates a disequilibrium. Supply of labor extends to Qs, but Demand contracts to Qd. The gap (Qs - Qd) represents classical unemployment.',
    );
  }

  void _paintNaturalRateOfUnemployment(DiagramPainterConfig c, IDiagramCanvas canvas) {
    paintAxis(c, canvas, axisType: AxisType.laborMarket);

    paintDiagramDashedLines(
      c, canvas,
      yAxisStartPos: 0.43, xAxisEndPos: 0.625,
      yLabel: DiagramLabel.wE.label, xLabel: DiagramLabel.q1.label,
      additionalXPositions: [0.435],
      additionalXLabels: [DiagramLabel.qE.label],
    );

    paintMarketCurve(c, canvas, type: MarketCurveType.dl);

    // Supply Curves
    paintDiagramLines(
      c, canvas,
      startPos: const Offset(0.60, 0.10),
      polylineOffsets: [const Offset(0.20, 0.90)],
      label1: DiagramLabel.lFEffective.label,
    );

    paintDiagramLines(
      c, canvas,
      startPos: const Offset(0.70, 0.10),
      polylineOffsets: [const Offset(0.50, 0.90)],
      label1: DiagramLabel.lF.label,
    );

    paintLineSegment(
      c, canvas,
      origin: const Offset(0.53, 0.43),
      endStyle: LineEndStyle.circlesOnEnd,
      length: 0.17,
      color: Colors.red,
      label: 'NRU',
    );

    paintDescription(
      c, canvas,
      'Natural Rate (NRU): The difference between the Total Labor Force (LF) and the Effective Labor Force (LF-eff) at equilibrium. These workers are voluntarily unemployed (not willing to take jobs at We) due to Frictional (search) or Structural (mismatch) factors.',
    );
  }

  void _paintEfficiencyWages(DiagramPainterConfig c, IDiagramCanvas canvas) {
    paintAxis(c, canvas, axisType: AxisType.laborMarket);

    // Efficiency Wage Line
    paintDiagramDashedLines(
      c, canvas,
      yAxisStartPos: 0.30, xAxisEndPos: 0.70,
      yLabel: DiagramLabel.wEff.label, xLabel: DiagramLabel.qS.label,
      additionalXPositions: [0.30],
      additionalXLabels: [DiagramLabel.qD.label],
    );

    paintDiagramLines(
      c, canvas,
      startPos: const Offset(0, 0.30),
      polylineOffsets: [const Offset(0.90, 0.30)],
      color: Colors.blue,
      curveStyle: CurveStyle.dashed,
    );

    // Equilibrium Reference
    paintDiagramDashedLines(
      c, canvas,
      yAxisStartPos: 0.50, xAxisEndPos: 0.50,
      yLabel: DiagramLabel.wE.label, xLabel: DiagramLabel.qE.label,
    );

    paintMarketCurve(c, canvas, type: MarketCurveType.dl);
    paintMarketCurve(c, canvas, type: MarketCurveType.sl);

    paintDescription(
      c, canvas,
      'Efficiency Wages: Firms voluntarily pay above-market wages (Weff > We) to boost morale, reduce turnover, and attract talent. While efficient for the firm, it acts as a price floor, causing aggregate labor surplus (unemployment).',
    );
  }
}