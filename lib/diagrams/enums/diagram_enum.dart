import 'package:economics_app/diagrams/enums/unit_type.dart';

enum DiagramEnum {
  microPPCConstantOppCost,
  microPPCIncreaseOppCost,
  microDemand,
  microDemandExtension,
  microDemandContraction,
  microDemandQuantityChangeDueToSupply,
  microDemandIncrease,
  microDemandDecrease,
  microSupplyExtension,
  microSupplyContraction,
  microSupplyIncrease,
  microSupplyDecrease,
  microMarginalProduct,
  microTotalAndMarginalProduct,
  microMarginalCost,
  microMarginalCostSteps,
  microMarginalCostSupplyCurve,
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
  microMinimumWage,
  microMinimumWageWelfare,
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
  microPublicGoods,
  microPerfectCompetitionFirmLongRun,
  microPerfectCompetitionMarketLongRun,
  microPerfectCompetitionFirmAbnormalProfitAdjustment,
  microPerfectCompetitionMarketAbnormalProfit,
  microPerfectCompetitionFirmLoss,
  microPerfectCompetitionMarketLoss,
  microPerfectCompetitionShutdownPoint,
  microPerfectCompetitionNormalProfitRevenueCostsCalculation,
  microPerfectCompetitionAbnormalProfitRevenueCostsCalculation,
  microPerfectCompetitionShutdownLossCalculation,
  microMonopolyAbnormalProfit,
  microMonopolyAbnormalProfitAndCosts,
  microMonopolyWelfare,
  microMonopolyWelfareAllocativelyEfficient,
  microMonopolyNatural,
  microMonopolyNaturalUnregulatedWelfare,
  microMonopolyNaturalPricingComparisons,
  microMonopolyNaturalAverageCostPricingWelfare,
  microMonopolyNaturalMarginalCostPricing,
  microMonopolyNaturalMarginalCostPricingWelfare,
  microOligopolyKinkedDemandCurve,
  microMonopolisticCompetitionAbnormalProfit,
  microMonopolisticCompetitionAbnormalProfitShift,
  microMonopolisticCompetitionLoss,
  microMonopolisticCompetitionLossShift,
  microMonopolisticCompetitionLongRun,

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

extension DiagramBundleEnumExtension on DiagramEnum {
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

extension DiagramBundleEnumUnit on DiagramEnum {
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
    DiagramEnum.microDemand => Subunit.demand,
    DiagramEnum.microPPCConstantOppCost => Subunit.whatIsEconomics,
    DiagramEnum.microPPCIncreaseOppCost => Subunit.whatIsEconomics,

    DiagramEnum.microDemandExtension => Subunit.demand,
    DiagramEnum.microDemandContraction => Subunit.demand,
    DiagramEnum.microDemandIncrease => Subunit.demand,
    DiagramEnum.microDemandDecrease => Subunit.demand,
    DiagramEnum.microDemandQuantityChangeDueToSupply => Subunit.demand,

    DiagramEnum.microSupplyExtension => Subunit.supply,
    DiagramEnum.microSupplyContraction => Subunit.supply,
    DiagramEnum.microSupplyIncrease => Subunit.supply,
    DiagramEnum.microSupplyDecrease => Subunit.supply,
    DiagramEnum.microMarginalProduct => Subunit.supply,
    DiagramEnum.microTotalAndMarginalProduct => Subunit.supply,
    DiagramEnum.microMarginalCost => Subunit.supply,

    DiagramEnum.microMarketEquilibrium => Subunit.competitiveMarket,
    DiagramEnum.microShortage => Subunit.competitiveMarket,
    DiagramEnum.microSurplus => Subunit.competitiveMarket,
    DiagramEnum.microDemandIncreasePriceMechanism => Subunit.competitiveMarket,
    DiagramEnum.microDemandDecreasePriceMechanism => Subunit.competitiveMarket,
    DiagramEnum.microMarginalCostSupplyCurve => Subunit.competitiveMarket,
    DiagramEnum.microAllocativeEfficiency => Subunit.competitiveMarket,
    DiagramEnum.microPriceRationing => Subunit.competitiveMarket,
    DiagramEnum.microConsumerSurplus => Subunit.competitiveMarket,
    DiagramEnum.microProducerSurplus => Subunit.competitiveMarket,
    DiagramEnum.microMarginalBenefit => Subunit.competitiveMarket,
    DiagramEnum.microMarginalCostSteps => Subunit.competitiveMarket,
    DiagramEnum.microDemandElastic => Subunit.elasticityDemand,
    DiagramEnum.microDemandInelastic => Subunit.elasticityDemand,
    DiagramEnum.microDemandUnitElastic => Subunit.elasticityDemand,
    DiagramEnum.microDemandPerfectlyElastic => Subunit.elasticityDemand,
    DiagramEnum.microDemandPerfectlyInelastic => Subunit.elasticityDemand,
    DiagramEnum.microDemandEngelCurve => Subunit.elasticityDemand,
    DiagramEnum.microDemandInelasticRevenue => Subunit.elasticityDemand,
    DiagramEnum.microDemandElasticRevenue => Subunit.elasticityDemand,
    DiagramEnum.microSupplyElastic => Subunit.elasticitySupply,
    DiagramEnum.microSupplyInelastic => Subunit.elasticitySupply,
    DiagramEnum.microSupplyUnitElastic => Subunit.elasticitySupply,
    DiagramEnum.microSupplyPerfectlyElastic => Subunit.elasticitySupply,
    DiagramEnum.microSupplyPerfectlyInelastic => Subunit.elasticitySupply,
    DiagramEnum.microDemandElasticityRevenueChange => Subunit.elasticityDemand,
    DiagramEnum.microDemandElasticityChange => Subunit.elasticityDemand,
    DiagramEnum.microSupplyPrimaryCommodities => Subunit.elasticitySupply,
    DiagramEnum.microPriceCeiling => Subunit.roleOfGovernment,
    DiagramEnum.microPriceFloor => Subunit.roleOfGovernment,
    DiagramEnum.microMinimumWage => Subunit.roleOfGovernment,
    DiagramEnum.microMinimumWageWelfare => Subunit.roleOfGovernment,
    DiagramEnum.microNationalMinimumWageInelasticDemandAndSupply =>
      Subunit.roleOfGovernment,
    DiagramEnum.microAgriculturalPriceFloor => Subunit.roleOfGovernment,
    DiagramEnum.microIndirectTax => Subunit.roleOfGovernment,
    DiagramEnum.microSubsidy => Subunit.roleOfGovernment,
    DiagramEnum.microIndirectTaxInelasticPED => Subunit.roleOfGovernment,
    DiagramEnum.microIndirectTaxElasticPED => Subunit.roleOfGovernment,
    DiagramEnum.microSubsidyInelasticPED => Subunit.roleOfGovernment,
    DiagramEnum.microSubsidyElasticPED => Subunit.roleOfGovernment,

    DiagramEnum.microNegativeProductionExternalityWelfare =>
      Subunit.marketFailureExternalities,
    DiagramEnum.microNegativeConsumptionExternalityWelfare =>
      Subunit.marketFailureExternalities,
    DiagramEnum.microPositiveProductionExternalityWelfare =>
      Subunit.marketFailureExternalities,
    DiagramEnum.microPositiveConsumptionExternalityWelfare =>
      Subunit.marketFailureExternalities,
    DiagramEnum.microNegativeConsumptionExternalityGovernmentRegulations =>
      Subunit.marketFailureExternalities,
    DiagramEnum.microNegativeProductionExternalityPigouvianTax =>
      Subunit.marketFailureExternalities,
    DiagramEnum.microNegativeProductionExternalityRegulations =>
      Subunit.marketFailureExternalities,
    DiagramEnum.microNegativeProductionExternality =>
      Subunit.marketFailureExternalities,

    DiagramEnum.microCarbonTax => Subunit.marketFailureExternalities,

    DiagramEnum.microTradablePollutionPermits =>
      Subunit.marketFailureExternalities,

    DiagramEnum.microNegativeConsumptionExternality =>
      Subunit.marketFailureExternalities,

    DiagramEnum.microPositiveProductionExternality =>
      Subunit.marketFailureExternalities,

    DiagramEnum.microPositiveConsumptionExternality =>
      Subunit.marketFailureExternalities,
    DiagramEnum.microNegativeConsumptionExternalityPigouvianTax =>
      Subunit.marketFailureExternalities,
    DiagramEnum.microNegativeConsumptionExternalityPublicAwareness =>
      Subunit.marketFailureExternalities,
    DiagramEnum.microCommonPoolResources => Subunit.marketFailureExternalities,
    DiagramEnum.microPositiveConsumptionExternalitySubsidy =>
      Subunit.marketFailureExternalities,
    DiagramEnum.microPositiveConsumptionExternalityAdvertising =>
      Subunit.marketFailureExternalities,

    DiagramEnum.microPositiveConsumptionExternalityDirectProvision =>
      Subunit.marketFailureExternalities,
    DiagramEnum.microPositiveProductionExternalitySubsidy =>
      Subunit.marketFailureExternalities,
    DiagramEnum.microPositiveProductionExternalityDirectProvision =>
      Subunit.marketFailureExternalities,
    DiagramEnum.microPublicGoods => Subunit.marketFailurePublicGoods,

    DiagramEnum.microPerfectCompetitionFirmLongRun =>
      Subunit.marketFailurePower,

    DiagramEnum.microPerfectCompetitionMarketLongRun =>
      Subunit.marketFailurePower,

    DiagramEnum.microPerfectCompetitionFirmAbnormalProfitAdjustment =>
      Subunit.marketFailurePower,

    DiagramEnum.microPerfectCompetitionMarketAbnormalProfit =>
      Subunit.marketFailurePower,

    DiagramEnum.microPerfectCompetitionFirmLoss => Subunit.marketFailurePower,

    DiagramEnum.microPerfectCompetitionMarketLoss => Subunit.marketFailurePower,
    DiagramEnum.microPerfectCompetitionShutdownPoint =>
      Subunit.marketFailurePower,
    DiagramEnum.microPerfectCompetitionNormalProfitRevenueCostsCalculation =>
      Subunit.marketFailurePower,
    DiagramEnum.microPerfectCompetitionShutdownLossCalculation =>
      Subunit.marketFailurePower,
    DiagramEnum.microMonopolyAbnormalProfit => Subunit.marketFailurePower,
    DiagramEnum.microMonopolyWelfareAllocativelyEfficient =>
      Subunit.marketFailurePower,
    DiagramEnum.microMonopolyNatural => Subunit.marketFailurePower,
    DiagramEnum.microPerfectCompetitionAbnormalProfitRevenueCostsCalculation =>
      Subunit.marketFailurePower,
    DiagramEnum.microMonopolyNaturalPricingComparisons =>
      Subunit.marketFailurePower,
    DiagramEnum.microMonopolyNaturalUnregulatedWelfare =>
      Subunit.marketFailurePower,
    DiagramEnum.microMonopolyNaturalMarginalCostPricing =>
      Subunit.marketFailurePower,
    DiagramEnum.microMonopolyNaturalAverageCostPricingWelfare =>
      Subunit.marketFailurePower,
    DiagramEnum.microMonopolyNaturalMarginalCostPricingWelfare =>
      Subunit.marketFailurePower,
    DiagramEnum.microMonopolyWelfare => Subunit.marketFailurePower,
    DiagramEnum.microMonopolyAbnormalProfitAndCosts =>
      Subunit.marketFailurePower,
    DiagramEnum.microOligopolyKinkedDemandCurve => Subunit.marketFailurePower,
    DiagramEnum.microMonopolisticCompetitionAbnormalProfit =>
      Subunit.marketFailurePower,
    DiagramEnum.microMonopolisticCompetitionLoss => Subunit.marketFailurePower,
    DiagramEnum.microMonopolisticCompetitionLongRun =>
      Subunit.marketFailurePower,
    DiagramEnum.microMonopolisticCompetitionAbnormalProfitShift =>
      Subunit.marketFailurePower,
    DiagramEnum.microMonopolisticCompetitionLossShift =>
      Subunit.marketFailurePower,
    DiagramEnum.globalWorldPrice => Subunit.benefitsTrade,
    DiagramEnum.globalWorldPriceStandAlone => Subunit.benefitsTrade,
    DiagramEnum.globalNetExporter => Subunit.benefitsTrade,
    DiagramEnum.globalNetImporter => Subunit.benefitsTrade,
    DiagramEnum.globalAbsoluteAdvantageDifferentGoods => Subunit.benefitsTrade,
    DiagramEnum.globalAbsoluteAdvantageBothGoods => Subunit.benefitsTrade,
    DiagramEnum.globalComparativeAdvantage => Subunit.benefitsTrade,
    DiagramEnum.globalComparativeAdvantageTradeAndConsumption =>
      Subunit.benefitsTrade,
    DiagramEnum.globalComparativeAdvantageTradeAndConsumptionMixed =>
      Subunit.benefitsTrade,
    DiagramEnum.globalTariff => Subunit.typesTradeProtection,
    DiagramEnum.globalTariffWelfare => Subunit.typesTradeProtection,
    DiagramEnum.globalTariffConsumerSurplus => Subunit.typesTradeProtection,
    DiagramEnum.globalTariffConsumerSurplusChange =>
      Subunit.typesTradeProtection,
    DiagramEnum.globalTariffProducerSurplus => Subunit.typesTradeProtection,
    DiagramEnum.globalTariffProducerSurplusChange =>
      Subunit.typesTradeProtection,
    DiagramEnum.globalTariffWelfareLoss => Subunit.typesTradeProtection,
    DiagramEnum.globalTariffGovernmentRevenue => Subunit.typesTradeProtection,
    DiagramEnum.globalImportQuota => Subunit.typesTradeProtection,
    DiagramEnum.globalImportQuotaWelfare => Subunit.typesTradeProtection,
    DiagramEnum.globalImportQuotaConsumerSurplus =>
      Subunit.typesTradeProtection,
    DiagramEnum.globalImportQuotaConsumerSurplusChange =>
      Subunit.typesTradeProtection,
    DiagramEnum.globalImportQuotaProducerSurplus =>
      Subunit.typesTradeProtection,
    DiagramEnum.globalImportQuotaProducerSurplusChange =>
      Subunit.typesTradeProtection,
    DiagramEnum.globalImportQuotaWelfareLoss => Subunit.typesTradeProtection,
    DiagramEnum.globalProductionSubsidy => Subunit.typesTradeProtection,
    DiagramEnum.globalProductionSubsidyConsumerSurplus =>
      Subunit.typesTradeProtection,
    DiagramEnum.globalProductionSubsidyProducerSurplus =>
      Subunit.typesTradeProtection,
    DiagramEnum.globalProductionSubsidyProducerSurplusChange =>
      Subunit.typesTradeProtection,
    DiagramEnum.globalProductionSubsidyWelfareLoss =>
      Subunit.typesTradeProtection,
    DiagramEnum.globalProductionSubsidyWelfare => Subunit.typesTradeProtection,
  };
}
