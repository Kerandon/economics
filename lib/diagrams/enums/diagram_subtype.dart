
import 'package:economics_app/diagrams/enums/shade_type.dart';
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

extension DiagramSubtypeExtension on DiagramSubtype {
  String toText() {
    switch (this) {
      case DiagramSubtype.productionPoints:
        return 'Production Points';
      case DiagramSubtype.increasingOpportunityCost:
        return 'Increasing Opportunity Cost';
      case DiagramSubtype.constantOpportunityCost:
        return 'Constant Opportunity Cost';
      case DiagramSubtype.increaseInProductionPotential:
        return 'Increase in Potential Production';
      case DiagramSubtype.decreaseInProductionPotential:
        return 'Decrease in Potential Production';
      case DiagramSubtype.equilibrium:
        return 'Equilibrium';
      case DiagramSubtype.increaseInDemand:
        return 'Increase in Demand';
      case DiagramSubtype.decreaseInDemand:
        return 'Decrease in Demand';
      case DiagramSubtype.increaseInSupply:
        return 'Increase in Supply';
      case DiagramSubtype.decreaseInSupply:
        return 'Decrease in Supply';
      case DiagramSubtype.shortage:
        return 'Shortage';
      case DiagramSubtype.surplus:
        return 'Surplus';
      case DiagramSubtype.commonPoolResources:
        return 'Common Pool Resources';
      case DiagramSubtype.closedModel:
        return 'Closed-model';
      case DiagramSubtype.macro:
        return 'Macro';
      case DiagramSubtype.fullEmploymentClassical:
        return 'Full employment';
      case DiagramSubtype.shortRun:
        return 'Short-run';
      case DiagramSubtype.standard:
        return 'Standard';
      case DiagramSubtype.priceFloorNationalMinimumWage:
        return 'Price Floor - National Minimum Wage';
      case DiagramSubtype.priceFloorAgriculturalPurchases:
        return 'Price Floor - Agricultural Purchases';
      case DiagramSubtype.priceCeiling:
        return 'Price Ceiling';
      case DiagramSubtype.negativeProduction:
        return 'Negative production externality';
      case DiagramSubtype.negativeConsumption:
        return 'Negative consumption externality';
      case DiagramSubtype.positiveProduction:
        return 'Positive production externality';
      case DiagramSubtype.positiveConsumption:
        return 'Positive consumption externality';
      case DiagramSubtype.socialWelfare:
        return 'Social welfare';
      case DiagramSubtype.longRunEquilibrium:
        return 'Long-run equilibrium';
      case DiagramSubtype.abnormalProfit:
        return 'Abnormal Profit';
      case DiagramSubtype.loss:
        return 'Loss';
      case DiagramSubtype.naturalMonopoly:
        return 'Natural Monopoly';
      case DiagramSubtype.exporter:
        return 'Exporter';
      case DiagramSubtype.importer:
        return 'Importer';
      case DiagramSubtype.perUnitSalesTax:
        return 'Sales Tax (Fixed Per Unit)';
      case DiagramSubtype.subsidy:
        return 'Subsidy';
      case DiagramSubtype.adValoremSalesTax:
        return 'Sales Tax (Ad Valorem)';
      case DiagramSubtype.salesTaxSocialWelfare:
        return 'Sales Tax - Social Welfare';
      case DiagramSubtype.subsidySocialWelfare:
        return 'Subsidy - Social Welfare';
      case DiagramSubtype.worldPrice:
        return 'World Price';
      case DiagramSubtype.domesticMarket:
        return 'Domestic Market';
      case DiagramSubtype.noGainsFromTrade:
        return 'No Gains From Trade';
      case DiagramSubtype.absoluteAdvantage:
        return 'Absolute Advantage';
      case DiagramSubtype.comparativeAdvantage:
        return 'Comparative Advantage';
      case DiagramSubtype.appreciationIncreaseInDemand:
        return 'Appreciation - Increase in Demand';
      case DiagramSubtype.appreciationDecreaseInSupply:
        return 'Appreciation - Decrease in Supply';
      case DiagramSubtype.depreciationDecreaseInDemand:
        return 'Depreciation - Decrease in Demand';
      case DiagramSubtype.depreciationIncreaseInSupply:
        return 'Depreciation - Increase in Supply';
      case DiagramSubtype.fixedRateIncreaseInDemand:
        return 'Fixed Rate Example - Buying Domestic Currency';
      case DiagramSubtype.fixedRateDecreaseInDemand:
        return 'Fixed Rate Example - Decrease in Demand';
      case DiagramSubtype.fixedRateSellCurrency:
        return 'Fixed Rate Example - Sell Currency';
      case DiagramSubtype.fixedRateRaiseInterestRates:
        return 'Fixed Rate Example - Raise Interest Rates';
      case DiagramSubtype.correctDeficit:
        return 'Depreciation in a Deficit';
      case DiagramSubtype.correctSurplus:
        return 'Appreciation in a Surplus';
      case DiagramSubtype.sras:
        return 'SRAS';
      case DiagramSubtype.fullEmploymentKeynesian:
        return 'Full Employment (Keynesian)';
      case DiagramSubtype.inflationaryGapClassical:
        return 'Inflationary Gap (Classical)';
      case DiagramSubtype.inflationaryGapKeynesian:
        return 'Inflationary Gap (Keynesian)';
      case DiagramSubtype.deflationaryGapClassical:
        return 'Deflationary Gap (Classical)';
      case DiagramSubtype.deflationaryGapKeynesian:
        return 'Deflationary Gap (Keynesian)';
      case DiagramSubtype.openModel:
        return 'Open Model';
      case DiagramSubtype.shortRunMacroeconomicEquilibrium:
        return 'Short-Run Macroeconomic Equilibrium';
      case DiagramSubtype.keynesianAggregateSupply:
        return 'Keynesian Aggregate Supply';

      case DiagramSubtype.increase:
        return 'Increase';
      case DiagramSubtype.decrease:
        return 'Decrease';
      case DiagramSubtype.determinants:
        return 'Determinants';
      case DiagramSubtype.actualGrowth:
        return 'Actual Growth';
      case DiagramSubtype.determinantsOfDemand:
        return 'Determinants of Demand';
      case DiagramSubtype.determinantsOfSupply:
        return 'Determinants of Supply';
    }
  }
}

class KeyEntry {
  final ShadeType? shadeType;
  final Color? customColor;
  final String? _label;

  KeyEntry({
    this.shadeType,
    this.customColor,
    String? label,
  })  : _label = label,
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
    final hexColor = red.toRadixString(16).padLeft(2, '0') +
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
