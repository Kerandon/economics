import 'package:economics_app/diagrams/custom_paint/shade/shade_type.dart';
import 'package:flutter/material.dart';

enum DiagramSubtype {
  productionPoints,
  increasingOpportunityCost,
  constantOpportunityCost,
  increaseInProductionPotential,
  decreaseInProductionPotential,
  actualGrowth,
  equilibrium,
  longRunEquilibrium,
  priceChange,
  individual1,
  individual2,
  market,
  determinantsOfDemand,
  determinantsOfSupply,
  increaseInDemand,
  decreaseInDemand,
  increaseInSupply,
  decreaseInSupply,
  shortage,
  surplus,
  perUnitSalesTax,
  adValoremSalesTax,
  salesTaxSocialWelfare,
  subsidy,
  subsidySocialWelfare,
  priceFloorNationalMinimumWage,
  priceFloorAgriculturalPurchases,
  priceCeiling,
  negativeProduction,
  negativeConsumption,
  positiveProduction,
  positiveConsumption,
  commonPoolResources,
  abnormalProfit,
  loss,
  socialWelfare,
  naturalMonopoly,
  closedModel,
  openModel,
  sras,
  determinants,
  increase,
  decrease,
  macro,
  shortRunMacroeconomicEquilibrium,
  keynesianAggregateSupply,
  fullEmploymentClassical,
  fullEmploymentKeynesian,
  inflationaryGapClassical,
  inflationaryGapKeynesian,
  deflationaryGapClassical,
  deflationaryGapKeynesian,
  shortRun,
  standard,
  worldPrice,
  domesticMarket,
  noGainsFromTrade,
  absoluteAdvantage,
  comparativeAdvantage,
  exporter,
  importer,
  appreciationIncreaseInDemand,
  appreciationDecreaseInSupply,
  depreciationDecreaseInDemand,
  depreciationIncreaseInSupply,
  fixedRateIncreaseInDemand,
  fixedRateSellCurrency,
  fixedRateDecreaseInDemand,
  fixedRateRaiseInterestRates,
  correctDeficit,
  correctSurplus,
}

class KeyEntry {
  final ShadeType? shadeType;
  final Color? customColor;
  final String? _label;

  KeyEntry({this.shadeType, this.customColor, String? label})
    : _label = label,
      assert(
        (shadeType != null) ^ (customColor != null),
        'Exactly one of shadeType or customColor must be provided.',
      );

  Color get color => customColor ?? shadeType!.setShadeColor();

  String get label {
    if (_label != null) {
      return _label;
    }
    if (shadeType != null) return shadeType!.defaultLabel;
    throw ArgumentError('Label must be provided if no shadeType is set.');
  }
}

String createColorKey(List<KeyEntry> entries) {
  final buffer = StringBuffer();
  buffer.writeln('<table>');

  for (var entry in entries) {
    final color = entry.color;
    // Convert from double (0.0-1.0) to int (0-255)
    final red = (color.r * 255).toInt();
    final green = (color.g * 255).toInt();
    final blue = (color.b * 255).toInt();

    // Compose hex color string (ARGB or RGBA — usually just RGB for CSS)
    final hexColor =
        red.toRadixString(16).padLeft(2, '0') +
        green.toRadixString(16).padLeft(2, '0') +
        blue.toRadixString(16).padLeft(2, '0');
    // For CSS background-color, alpha usually not included unless rgba()

    buffer.writeln('''
      <tr>
        <td style="width:12px;height:12px;background-color:#$hexColor;"></td>
        <td style="padding-left:6px;">${entry.label}</td>
      </tr>
    ''');
  }

  buffer.writeln('</table>');
  return buffer.toString();
}

extension ColorUtils on Color {
  int toInt() {
    final alpha = (a * 255).toInt();
    final red = (r * 255).toInt();
    final green = (g * 255).toInt();
    final blue = (b * 255).toInt();
    return (alpha << 24) | (red << 16) | (green << 8) | blue;
  }
}
