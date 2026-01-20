// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

/// Curves
const kCurveWidth = 8.0;
const kCurveWidthSlim = 2.0;
const kArrowSize = 16.0;
const kExtendBy5 = 0.05;
const kExtendBy10 = 0.10;
const kExtendBy15 = 0.18;
const kExtendBy20 = 0.20;

/// Axis & Labels
const kTopAxisIndent = 0.75;
const kBottomAxisIndent = 1.25;
const kLabelPadding = 0.06;
const kAxisIndent = 0.20;
const kAxisWidth = 0.30;
const kDashedLineWidth = 5.0;
const kAdvantages = 'Advantages';
const kLimitations = 'Limitations';
const kSimilarities = 'Similarities';
const kDifferences = 'Differences';

/// Text
const kFontVerySmall = 16.0;
const kFontSmall = 18.0;
const kFontMedium = 26.0;
const kLabelTextStyle = TextStyle(
  fontStyle: FontStyle.italic,
  fontSize: kFontMedium,
);

/// Dot
const kDotRadius = 22.0;

enum CurveStyle { standard, dashed, dotted, bold }

enum MarketCurveType { demand, supply }

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
