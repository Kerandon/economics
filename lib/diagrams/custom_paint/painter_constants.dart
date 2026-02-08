// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

/// Curves
const kCurveWidth = 3.0;
const kCurveWidthSlim = 2.0;
const kArrowSize = 16.0;
const kExtendBy5 = 0.05;
const kExtendBy10 = 0.10;
const kExtendBy15 = 0.18;
const kExtendBy20 = 0.20;

/// Axis & Labels
const kTopAxisIndent = 0.50;
const kBottomAxisIndent = 1.50;
const kLabelPadding = 0.06;
const kAxisIndent = 0.20;
const kAxisWidth = 0.30;
const kDashedLineWidth = 5.0;
const kAdvantages = 'Advantages';
const kLimitations = 'Limitations';
const kSimilarities = 'Similarities';
const kDifferences = 'Differences';

/// Text
const kFontTiny = 16.0;
const kFontVerySmall = 22.0;
const kFontSmall = 22.0;
const kFontMedium = 28.0;
const kFontSizeAverageRatioSmall = 30.0;
const kLabelTextStyle = TextStyle(
  fontStyle: FontStyle.italic,
  fontSize: kFontMedium,
);

/// Dot
const kDotRadius = 8.0;

enum CurveStyle { standard, dashed, dotted, bold }

enum MarketCurveType {
  demand,
  supply,
  ad,
  sras,
  lras,
  keynesianAS,
  moneySupply,
  lrpc,
  srpc,
  moneyDemand,

  // --- NEW TRADE TYPES ---
  demandDomestic, // Downward sloping (Dd)
  supplyDomestic, // Upward sloping (Sd)
  demandWorld, // Downward sloping (Dw) - Assuming 'worldDomestic' implies World Demand
  supplyWorld, // Upward sloping (Sw)

  // --- Currency ---
  demandUSD,
  supplyUSD,
}

enum LabelAlign { center, centerLeft, centerRight, centerTop, centerBottom }

enum CustomAxis { x, y }

enum LineEndStyle {
  /// No special termination, just the line itself.
  none,

  /// Standard single arrowhead at the 'endPos'.
  arrow,

  /// Arrowheads at both start and end (like a vector).
  arrowBothEnds,

  /// A perpendicular line segment at both ends, visually extending measurement bounds.
  arrowRightAngles,
}

enum GridLineStyle {
  none, // No gridlines or ticks
  full, // Full lines across
  dashes, // Full dashed lines
  indents, // Little tick marks on the axes only
}
