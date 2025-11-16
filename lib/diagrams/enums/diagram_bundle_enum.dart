import 'package:economics_app/diagrams/enums/unit_type.dart';

import '../custom_paint/painter_methods/legend/legend_display.dart';

enum DiagramBundleEnum {
  microPPCConstantOppCost,
  microPPCIncreaseOppCost,
  microDemandExtension,
  microDemandContraction,
  microDemandIncrease,
  microDemandDecrease,
  microSupplyExtension,
  microSupplyContraction,
  microSupplyIncrease,
  microSupplyDecrease,
  microMarginalProduct,
  microTotalAndMarginalProduct,
  microMarginalCost,
  microMarketEquilibrium,
  microShortage,
  microSurplus,
  microDemandIncreasePriceMechanism,
  microDemandDecreasePriceMechanism,
  microPriceRationing,
  microConsumerSurplus,
  microProducerSurplus,
  microAllocativeEfficiency,
  microMarginalBenefit,
  microDemandElastic,
  microDemandInelastic,
  microDemandUnitElastic,
  microDemandPerfectlyElastic,
  microDemandPerfectlyInelastic,
  microDemandInelasticRevenue,
  microDemandElasticRevenue,
  microDemandElasticityChange,
  microDemandElasticityRevenueChange,
  microDemandEngelCurve,
  microSupplyElastic,
  microSupplyInelastic,
  microSupplyUnitElastic,
  microSupplyPerfectlyElastic,
  microSupplyPerfectlyInelastic,
  microSupplyPrimaryCommodities,
  microPriceCeiling,
  microPriceFloor,
  microNationalMinimumWage,
  microNationalMinimumWageWelfare,
  microNationalMinimumWageInelasticDemandAndSupply,
  microAgriculturalPriceFloor,
  microIndirectTax,
  microIndirectTaxInelasticPED,
  microIndirectTaxElasticPED,
  microSubsidy,
  microSubsidyInelasticPED,
  microSubsidyElasticPED,
  microNegativeProductionExternality,
  microNegativeProductionExternalityWelfare,
  microNegativeProductionExternalityPigouvianTax,
  microNegativeProductionExternalityRegulations,
  microCarbonTax,
  microTradablePollutionPermits,
  microCommonPoolResources,
  microNegativeConsumptionExternality,
  microNegativeConsumptionExternalityWelfare,
  microNegativeConsumptionExternalityPigouvianTax,
  microNegativeConsumptionExternalityPublicAwareness,
  microNegativeConsumptionExternalityGovernmentRegulations,
  microPositiveProductionExternality,
  microPositiveProductionExternalityWelfare,
  microPositiveConsumptionExternality,
  microPositiveConsumptionExternalityWelfare,
  microPositiveConsumptionExternalitySubsidy,
  microPositiveConsumptionExternalityAdvertising,
  microPositiveConsumptionExternalityDirectProvision,
  microPositiveProductionExternalitySubsidy,
  microPositiveProductionExternalityDirectProvision,
  globalWorldPrice,
  globalWorldPriceStandAlone,
  globalNetExporter,
  globalNetImporter,
  globalAbsoluteAdvantageDifferentGoods,
  globalAbsoluteAdvantageBothGoods,
  globalComparativeAdvantage,
  globalComparativeAdvantageTradeAndConsumption,
  globalComparativeAdvantageTradeAndConsumptionMixed,
  globalTariff,
  globalTariffWelfare,
  globalTariffConsumerSurplus,
  globalTariffConsumerSurplusChange,
  globalTariffProducerSurplus,
  globalTariffProducerSurplusChange,
  globalTariffWelfareLoss,
  globalTariffGovernmentRevenue,
  globalImportQuota,
  globalImportQuotaWelfare,
  globalImportQuotaConsumerSurplus,
  globalImportQuotaConsumerSurplusChange,
  globalImportQuotaProducerSurplus,
  globalImportQuotaProducerSurplusChange,
  globalImportQuotaWelfareLoss,
  globalProductionSubsidy,
  globalProductionSubsidyConsumerSurplus,
  globalProductionSubsidyProducerSurplus,
  globalProductionSubsidyProducerSurplusChange,
  globalProductionSubsidyWelfareLoss,
  globalProductionSubsidyWelfare,
}

extension DiagramBundleEnumExtension on DiagramBundleEnum {
  /// Converts enum like 'microPPCConstantOppCost' to 'PPC Constant Opp Cost'
  String get toText {
    final nameStr = toString().split('.').last;

    // Insert space before uppercase letters that are preceded by lowercase or numbers
    final withSpaces = nameStr.replaceAllMapped(
      RegExp(r'(?<=[a-z0-9])([A-Z])'),
      (match) => ' ${match.group(0)}',
    );

    // Capitalize first letter of each word
    final capitalized = withSpaces
        .split(' ')
        .map((word) {
          if (word.isEmpty) return word;
          return word[0].toUpperCase() + word.substring(1);
        })
        .join(' ');

    // Remove the first word
    final words = capitalized.split(' ');
    if (words.length <= 1) return ''; // return empty if only one word
    return words.skip(1).join(' ');
  }
}

extension DiagramBundleEnumDisplay on DiagramBundleEnum {
  LegendDisplay get defaultLegendDisplay {
    switch (this) {
      case DiagramBundleEnum.globalProductionSubsidyWelfare:
      case DiagramBundleEnum.globalProductionSubsidyConsumerSurplus:
      case DiagramBundleEnum.globalProductionSubsidyProducerSurplusChange:
        return LegendDisplay.shading;

      case DiagramBundleEnum.globalProductionSubsidyWelfareLoss:
        return LegendDisplay.letters;

      // Add more mappings for other diagram types if needed
      default:
        return LegendDisplay.shading; // fallback
    }
  }
}

extension DiagramBundleEnumUnit on DiagramBundleEnum {
  /// Returns the main unit: Intro, Micro, Macro, or Global
  UnitType get unit {
    final name = toString().split('.').last;

    if (name.startsWith('micro')) {
      return UnitType.micro;
    } else if (name.startsWith('macro')) {
      return UnitType.macro;
    } else if (name.startsWith('global')) {
      return UnitType.global;
    } else {
      return UnitType.intro; // fallback
    }
  }

  Subunit get subunit => switch (this) {
    DiagramBundleEnum.microPPCConstantOppCost => Subunit.whatIsEconomics,
    DiagramBundleEnum.microPPCIncreaseOppCost => Subunit.whatIsEconomics,

    DiagramBundleEnum.microDemandExtension => Subunit.demand,
    DiagramBundleEnum.microDemandContraction => Subunit.demand,
    DiagramBundleEnum.microDemandIncrease => Subunit.demand,
    DiagramBundleEnum.microDemandDecrease => Subunit.demand,

    DiagramBundleEnum.microSupplyExtension => Subunit.supply,
    DiagramBundleEnum.microSupplyContraction => Subunit.supply,
    DiagramBundleEnum.microSupplyIncrease => Subunit.supply,
    DiagramBundleEnum.microSupplyDecrease => Subunit.supply,
    DiagramBundleEnum.microMarginalProduct => Subunit.supply,
    DiagramBundleEnum.microTotalAndMarginalProduct => Subunit.supply,
    DiagramBundleEnum.microMarginalCost => Subunit.supply,

    DiagramBundleEnum.microMarketEquilibrium => Subunit.competitiveMarket,
    DiagramBundleEnum.microShortage => Subunit.competitiveMarket,
    DiagramBundleEnum.microSurplus => Subunit.competitiveMarket,
    DiagramBundleEnum.microDemandIncreasePriceMechanism =>
      Subunit.competitiveMarket,
    DiagramBundleEnum.microDemandDecreasePriceMechanism =>
      Subunit.competitiveMarket,
    DiagramBundleEnum.microAllocativeEfficiency => Subunit.competitiveMarket,
    DiagramBundleEnum.microPriceRationing => Subunit.competitiveMarket,
    DiagramBundleEnum.microConsumerSurplus => Subunit.competitiveMarket,
    DiagramBundleEnum.microProducerSurplus => Subunit.competitiveMarket,
    DiagramBundleEnum.microMarginalBenefit => Subunit.competitiveMarket,
    DiagramBundleEnum.microDemandElastic => Subunit.elasticityDemand,
    DiagramBundleEnum.microDemandInelastic => Subunit.elasticityDemand,
    DiagramBundleEnum.microDemandUnitElastic => Subunit.elasticityDemand,
    DiagramBundleEnum.microDemandPerfectlyElastic => Subunit.elasticityDemand,
    DiagramBundleEnum.microDemandPerfectlyInelastic => Subunit.elasticityDemand,
    DiagramBundleEnum.microDemandEngelCurve => Subunit.elasticityDemand,
    DiagramBundleEnum.microDemandInelasticRevenue => Subunit.elasticityDemand,
    DiagramBundleEnum.microDemandElasticRevenue => Subunit.elasticityDemand,
    DiagramBundleEnum.microSupplyElastic => Subunit.elasticitySupply,
    DiagramBundleEnum.microSupplyInelastic => Subunit.elasticitySupply,
    DiagramBundleEnum.microSupplyUnitElastic => Subunit.elasticitySupply,
    DiagramBundleEnum.microSupplyPerfectlyElastic => Subunit.elasticitySupply,
    DiagramBundleEnum.microSupplyPerfectlyInelastic => Subunit.elasticitySupply,
    DiagramBundleEnum.microDemandElasticityRevenueChange =>
      Subunit.elasticityDemand,
    DiagramBundleEnum.microDemandElasticityChange => Subunit.elasticityDemand,
    DiagramBundleEnum.microSupplyPrimaryCommodities => Subunit.elasticitySupply,
    DiagramBundleEnum.microPriceCeiling => Subunit.roleOfGovernment,
    DiagramBundleEnum.microPriceFloor => Subunit.roleOfGovernment,
    DiagramBundleEnum.microNationalMinimumWage => Subunit.roleOfGovernment,
    DiagramBundleEnum.microNationalMinimumWageWelfare =>
      Subunit.roleOfGovernment,
    DiagramBundleEnum.microNationalMinimumWageInelasticDemandAndSupply =>
      Subunit.roleOfGovernment,
    DiagramBundleEnum.microAgriculturalPriceFloor => Subunit.roleOfGovernment,
    DiagramBundleEnum.microIndirectTax => Subunit.roleOfGovernment,
    DiagramBundleEnum.microSubsidy => Subunit.roleOfGovernment,
    DiagramBundleEnum.microIndirectTaxInelasticPED => Subunit.roleOfGovernment,
    DiagramBundleEnum.microIndirectTaxElasticPED => Subunit.roleOfGovernment,
    DiagramBundleEnum.microSubsidyInelasticPED => Subunit.roleOfGovernment,
    DiagramBundleEnum.microSubsidyElasticPED => Subunit.roleOfGovernment,

    DiagramBundleEnum.microNegativeProductionExternalityWelfare =>
      Subunit.marketFailureExternalities,
    DiagramBundleEnum.microNegativeConsumptionExternalityWelfare =>
      Subunit.marketFailureExternalities,
    DiagramBundleEnum.microPositiveProductionExternalityWelfare =>
      Subunit.marketFailureExternalities,
    DiagramBundleEnum.microPositiveConsumptionExternalityWelfare =>
      Subunit.marketFailureExternalities,
    DiagramBundleEnum
        .microNegativeConsumptionExternalityGovernmentRegulations =>
      Subunit.marketFailureExternalities,
    DiagramBundleEnum.microNegativeProductionExternalityPigouvianTax =>
      Subunit.marketFailureExternalities,
    DiagramBundleEnum.microNegativeProductionExternalityRegulations =>
      Subunit.marketFailureExternalities,
    DiagramBundleEnum.microNegativeProductionExternality =>
      Subunit.marketFailureExternalities,

    DiagramBundleEnum.microCarbonTax => Subunit.marketFailureExternalities,

    DiagramBundleEnum.microTradablePollutionPermits =>
      Subunit.marketFailureExternalities,

    DiagramBundleEnum.microNegativeConsumptionExternality =>
      Subunit.marketFailureExternalities,

    DiagramBundleEnum.microPositiveProductionExternality =>
      Subunit.marketFailureExternalities,

    DiagramBundleEnum.microPositiveConsumptionExternality =>
      Subunit.marketFailureExternalities,
    DiagramBundleEnum.microNegativeConsumptionExternalityPigouvianTax =>
      Subunit.marketFailureExternalities,
    DiagramBundleEnum.microNegativeConsumptionExternalityPublicAwareness =>
      Subunit.marketFailureExternalities,
    DiagramBundleEnum.microCommonPoolResources =>
      Subunit.marketFailureExternalities,
    DiagramBundleEnum.microPositiveConsumptionExternalitySubsidy =>
      Subunit.marketFailureExternalities,
    DiagramBundleEnum.microPositiveConsumptionExternalityAdvertising =>
      Subunit.marketFailureExternalities,

    DiagramBundleEnum.microPositiveConsumptionExternalityDirectProvision =>
      Subunit.marketFailureExternalities,
    DiagramBundleEnum.microPositiveProductionExternalitySubsidy =>
      Subunit.marketFailureExternalities,
    DiagramBundleEnum.microPositiveProductionExternalityDirectProvision =>
      Subunit.marketFailureExternalities,

    DiagramBundleEnum.globalWorldPrice => Subunit.benefitsTrade,
    DiagramBundleEnum.globalWorldPriceStandAlone => Subunit.benefitsTrade,
    DiagramBundleEnum.globalNetExporter => Subunit.benefitsTrade,
    DiagramBundleEnum.globalNetImporter => Subunit.benefitsTrade,
    DiagramBundleEnum.globalAbsoluteAdvantageDifferentGoods =>
      Subunit.benefitsTrade,
    DiagramBundleEnum.globalAbsoluteAdvantageBothGoods => Subunit.benefitsTrade,
    DiagramBundleEnum.globalComparativeAdvantage => Subunit.benefitsTrade,
    DiagramBundleEnum.globalComparativeAdvantageTradeAndConsumption =>
      Subunit.benefitsTrade,
    DiagramBundleEnum.globalComparativeAdvantageTradeAndConsumptionMixed =>
      Subunit.benefitsTrade,
    DiagramBundleEnum.globalTariff => Subunit.typesTradeProtection,
    DiagramBundleEnum.globalTariffWelfare => Subunit.typesTradeProtection,
    DiagramBundleEnum.globalTariffConsumerSurplus =>
      Subunit.typesTradeProtection,
    DiagramBundleEnum.globalTariffConsumerSurplusChange =>
      Subunit.typesTradeProtection,
    DiagramBundleEnum.globalTariffProducerSurplus =>
      Subunit.typesTradeProtection,
    DiagramBundleEnum.globalTariffProducerSurplusChange =>
      Subunit.typesTradeProtection,
    DiagramBundleEnum.globalTariffWelfareLoss => Subunit.typesTradeProtection,
    DiagramBundleEnum.globalTariffGovernmentRevenue =>
      Subunit.typesTradeProtection,
    DiagramBundleEnum.globalImportQuota => Subunit.typesTradeProtection,
    DiagramBundleEnum.globalImportQuotaWelfare => Subunit.typesTradeProtection,
    DiagramBundleEnum.globalImportQuotaConsumerSurplus =>
      Subunit.typesTradeProtection,
    DiagramBundleEnum.globalImportQuotaConsumerSurplusChange =>
      Subunit.typesTradeProtection,
    DiagramBundleEnum.globalImportQuotaProducerSurplus =>
      Subunit.typesTradeProtection,
    DiagramBundleEnum.globalImportQuotaProducerSurplusChange =>
      Subunit.typesTradeProtection,
    DiagramBundleEnum.globalImportQuotaWelfareLoss =>
      Subunit.typesTradeProtection,
    DiagramBundleEnum.globalProductionSubsidy => Subunit.typesTradeProtection,
    DiagramBundleEnum.globalProductionSubsidyConsumerSurplus =>
      Subunit.typesTradeProtection,
    DiagramBundleEnum.globalProductionSubsidyProducerSurplus =>
      Subunit.typesTradeProtection,
    DiagramBundleEnum.globalProductionSubsidyProducerSurplusChange =>
      Subunit.typesTradeProtection,
    DiagramBundleEnum.globalProductionSubsidyWelfareLoss =>
      Subunit.typesTradeProtection,
    DiagramBundleEnum.globalProductionSubsidyWelfare =>
      Subunit.typesTradeProtection,

  };
}
