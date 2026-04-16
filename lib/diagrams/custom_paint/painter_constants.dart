// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

/// Curves
const kCurveWidth = 6.0;
const kCurveWidthSlim = 4.0;
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
const kFontTiny = 20.0;
const kFontVerySmall = 22.0;
const kFontSmall = 24.0;
const kFontMedium = 30.0;
const kFontSizeBig = 40.0;
const kFontSizeAverageRatioSmall = 30.0;
const kFontSizeAverageRatioStandard = 70.0;
const kLabelTextStyle = TextStyle(
  fontStyle: FontStyle.italic,
  fontSize: kFontMedium,
);

/// Dot
const kDotRadius = 6.0;

enum CurveStyle { standard, dashed, dotted, bold }

enum MarketCurveType {
  demand,
  supply,
  perfectlyInelasticSupply,
  ad,
  sras,
  lras,
  keynesianAS,
  moneySupply,
  lrpc,
  srpc,
  moneyDemand,
  demandDomestic,
  supplyDomestic,
  demandWorld,
  supplyWorld,
  demandUSD,
  supplyUSD,
  ad1,
  ad2,
  ad3,
  lras1,
  lras2,
  sras1,
  sras2,
  lrpc1,
  lrpc2,
  srpc1,
  srpc2,
  dl,
  dl1,
  dl2,
  sl,
  sl1,
  sl2,
  d1,
  d2,
  s1,
  s2,
  sTax,
  sSubsidy,
  sSub,
  dEqualsMPBMSB,
  dEqualsMPB,
  sEqualsMPC,
  sEqualsMPCMSC,
  mpc,
  msc,
  msb,
  mpcTax,
  sPlusProvision,
  mscEqualsMpcTax1,
  mscEqualsMpcTax2,
  mpcSub,
  sPlusProvisionEqualsMSC,

  /// Market power
  // --- MICROECONOMICS CURVES ---
  mc,
  ac, // or atc
  avc,
  mr,

  dArMonopoly, // Replaces dSteep
  mrMonopoly,  // Replaces mrSteep

  // --- COMBO CURVES ---
  mcAtc,
  dArMrMonopoly, // Draws Monopoly Demand & MR together
}

enum LabelAlign {
  topLeft,
  centerTop, // <-- Added back
  topRight,
  left,
  center,
  right,
  bottomLeft,
  centerBottom, // <-- Added back
  bottomRight,
}

enum CustomAxis { x, y }

enum LineEndStyle { none, arrow, arrowBothEnds, arrowRightAngles, circlesOnEnd }

enum GridLineStyle {
  none, // No gridlines or ticks
  full, // Full lines across
  dashes, // Full dashed lines
  indents, // Little tick marks on the axes only
}
