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

  /// Macro
  macroCircularFlowClosed,
  macroCircularFlowOpen,
  macroBusinessCycle,
  macroADASClassicalFullEmployment,
  macroADASClassicalDeflationaryGap,
  macroADASClassicalInflationaryGap,
  macroADASKeynesianFullEmployment,
  macroADASKeynesianDeflationaryGap,
  macroADASKeynesianInflationaryGap,
  macroADASKeynesianExpansionaryPolicy,
  macroADASKeynesianContractionaryPolicy,
  macroADASClassicalDeflationaryGapAdjustment,
  macroADASClassicalInflationaryGapAdjustment,
  macroADASClassicalLongTermGrowth,
  macroADASKeynesianLongTermGrowth,
  macroADASClassicalDemandPullInflation,
  macroKeynesianDemandPullInflation,
  macroADASCostPushInflation,
  macroLorenzCurveCalculation,
  macroLorenzCurveImprovedEquality,
  macroMoneyMarket,
  macroMoneyMarketExpansionaryMonetaryPolicy,
  macroMoneyMarketContractionaryMonetaryPolicy,
  macroADASKeynesianMultiplier,

  ///Global*****************************************

  /// Free Trade
  globalWorldPriceHigher,
  globalWorldPriceLower,
  globalDomesticExporter,
  globalDomesticImporter,
  globalAbsoluteAdvantageDifferentGoods,
  globalComparativeAdvantage,
  globalNoComparativeAdvantage,

  /// Protectionism
  globalTariff,
  globalImportQuota,
  globalProductionSubsidy,
  globalExportSubsidy,

  /// Exchange Rates
  globalForeignExchangeRate,
  globalEuroDepreciates,
  globalUSDAppreciates,
  globalFloatingRateDemandIncrease,
  globalFloatingRateDemandDecrease,
  globalFloatingRateSupplyIncrease,
  globalFloatingRateSupplyDecrease,
  globalManagedExchangeRate,
  globalFixedRateDemandDecreaseBuyCurrency,
  globalFixedRateDemandIncreaseSellCurrency,
  globalFixedRateDemandDecreaseReduceSupply,
  globalJCurveDeficit,
  globalJCurveSurplus,

  /// Economic Development
  globalPPCReallocation,
  globalPovertyCycle,
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

    ///Macro
    DiagramEnum.macroCircularFlowClosed => Subunit.measuringEconomicActivity,

    DiagramEnum.macroCircularFlowOpen => Subunit.measuringEconomicActivity,
    DiagramEnum.macroBusinessCycle => Subunit.measuringEconomicActivity,
    DiagramEnum.macroADASClassicalFullEmployment =>
      Subunit.variationsActivityADAS,

    DiagramEnum.macroADASClassicalDeflationaryGap =>
      Subunit.variationsActivityADAS,

    DiagramEnum.macroADASClassicalInflationaryGap =>
      Subunit.variationsActivityADAS,

    DiagramEnum.macroADASKeynesianFullEmployment =>
      Subunit.variationsActivityADAS,

    DiagramEnum.macroADASKeynesianDeflationaryGap =>
      Subunit.variationsActivityADAS,

    DiagramEnum.macroADASKeynesianInflationaryGap =>
      Subunit.variationsActivityADAS,

    DiagramEnum.macroADASClassicalDeflationaryGapAdjustment =>
      Subunit.variationsActivityADAS,

    DiagramEnum.macroADASClassicalInflationaryGapAdjustment =>
      Subunit.variationsActivityADAS,

    /// Macro Objectives
    DiagramEnum.macroADASClassicalLongTermGrowth => Subunit.macroObjectives,

    DiagramEnum.macroADASKeynesianLongTermGrowth => Subunit.macroObjectives,

    DiagramEnum.macroADASCostPushInflation => Subunit.macroObjectives,
    DiagramEnum.macroADASClassicalDemandPullInflation =>
      Subunit.macroObjectives,

    /// Poverty and Inequality
    DiagramEnum.macroLorenzCurveCalculation => Subunit.inequalityPoverty,

    DiagramEnum.macroLorenzCurveImprovedEquality => Subunit.inequalityPoverty,

    /// Demand-side
    DiagramEnum.macroKeynesianDemandPullInflation => Subunit.macroObjectives,
    DiagramEnum.macroADASKeynesianMultiplier => Subunit.demandManagementFiscal,
    DiagramEnum.macroMoneyMarket => Subunit.demandManagementMonetary,
    DiagramEnum.macroMoneyMarketExpansionaryMonetaryPolicy =>
      Subunit.demandManagementMonetary,
    DiagramEnum.macroMoneyMarketContractionaryMonetaryPolicy =>
      Subunit.demandManagementMonetary,
    DiagramEnum.macroADASKeynesianExpansionaryPolicy =>
      Subunit.demandManagementMonetary,
    DiagramEnum.macroADASKeynesianContractionaryPolicy =>
      Subunit.demandManagementMonetary,

    /// Global***************

    /// Free Trade
    DiagramEnum.globalWorldPriceHigher => Subunit.benefitsTrade,
    DiagramEnum.globalWorldPriceLower => Subunit.benefitsTrade,
    DiagramEnum.globalDomesticExporter => Subunit.benefitsTrade,
    DiagramEnum.globalDomesticImporter => Subunit.benefitsTrade,
    DiagramEnum.globalAbsoluteAdvantageDifferentGoods => Subunit.benefitsTrade,
    DiagramEnum.globalComparativeAdvantage => Subunit.benefitsTrade,
    DiagramEnum.globalNoComparativeAdvantage => Subunit.benefitsTrade,

    /// Trade Protectionism
    DiagramEnum.globalTariff => Subunit.typesTradeProtection,
    DiagramEnum.globalImportQuota => Subunit.typesTradeProtection,
    DiagramEnum.globalProductionSubsidy => Subunit.typesTradeProtection,
    DiagramEnum.globalExportSubsidy => Subunit.typesTradeProtection,

    /// Exchange Rates & BOP
    DiagramEnum.globalForeignExchangeRate => Subunit.exchangeRates,
    DiagramEnum.globalEuroDepreciates => Subunit.exchangeRates,
    DiagramEnum.globalUSDAppreciates => Subunit.exchangeRates,
    DiagramEnum.globalFloatingRateDemandIncrease => Subunit.exchangeRates,
    DiagramEnum.globalFloatingRateDemandDecrease => Subunit.exchangeRates,
    DiagramEnum.globalFloatingRateSupplyIncrease => Subunit.exchangeRates,
    DiagramEnum.globalFloatingRateSupplyDecrease => Subunit.exchangeRates,
    DiagramEnum.globalManagedExchangeRate => Subunit.exchangeRates,
    DiagramEnum.globalFixedRateDemandDecreaseBuyCurrency =>
      Subunit.exchangeRates,
    DiagramEnum.globalFixedRateDemandIncreaseSellCurrency =>
      Subunit.exchangeRates,
    DiagramEnum.globalFixedRateDemandDecreaseReduceSupply =>
      Subunit.exchangeRates,
    DiagramEnum.globalJCurveDeficit => Subunit.balanceOfPayments,
    DiagramEnum.globalJCurveSurplus => Subunit.balanceOfPayments,

    /// Economic Development
    DiagramEnum.globalPPCReallocation => Subunit.barriersGrowth,
    DiagramEnum.globalPovertyCycle => Subunit.barriersGrowth,

    ///
  };
}
