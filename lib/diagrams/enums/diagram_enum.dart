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

  /// Macro**********

  /// National income & biz cycle
  macroCircularFlowClosed,
  macroCircularFlowOpen,
  macroBusinessCycle,

  /// AD-AS
  macroClassicalFullEmployment,
  macroClassicalDeflationaryGap,
  macroClassicalInflationaryGap,
  macroADASKeynesianFullEmployment,
  macroKeynesianDeflationaryGap,
  macroKeynesianInflationaryGap,
  macroKeynesianExpansionaryPolicy,
  macroKeynesianContractionaryPolicy,
  macroClassicalDeflationaryGapAdjustment,
  macroClassicalInflationaryGapAdjustment,

  /// Economic growth
  macroClassicalLongTermGrowth,
  macroKeynesianLongTermGrowth,

  /// Inflation
  macroClassicalDemandPullInflation,
  macroKeynesianDemandPullInflation,
  macroADASCostPushInflation,

  /// Unemployment
  macroUnemploymentStructural,
  macroUnemploymentLaborMarketRigidities,
  macroUnemploymentNationalMinimumWage,
  macroUnemploymentEfficiencyWages,
  macroNaturalRateOfUnemployment,

  /// Phillips Curve
  macroSRPCAndLRPC,
  macroPhillipsCurveStagflation,
  macroSRPCInflationaryGapAdjustment,
  macroSRPCDeflationaryGapAdjustment,
  macroLRPCFallInNRU,

  /// Poverty and Inequality
  macroLorenzCurveCalculation,
  macroLorenzCurveImprovedEquality,

  /// Demand and Supply-Side
  macroMoneyMarket,
  macroMoneyMarketExpansionaryMonetaryPolicy,
  macroMoneyMarketContractionaryMonetaryPolicy,
  macroKeynesianMultiplier,
  macroSupplSidePoliciesLowInflation,

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
  globalPPCCapitalInvestment,
  globalPPCEconomicGrowth,
  globalPPCUnsustainableUseOfNaturalResources,
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
    DiagramEnum.macroClassicalFullEmployment => Subunit.variationsActivityADAS,

    DiagramEnum.macroClassicalDeflationaryGap => Subunit.variationsActivityADAS,

    DiagramEnum.macroClassicalInflationaryGap => Subunit.variationsActivityADAS,

    DiagramEnum.macroADASKeynesianFullEmployment =>
      Subunit.variationsActivityADAS,

    DiagramEnum.macroKeynesianDeflationaryGap => Subunit.variationsActivityADAS,

    DiagramEnum.macroKeynesianInflationaryGap => Subunit.variationsActivityADAS,

    DiagramEnum.macroClassicalDeflationaryGapAdjustment =>
      Subunit.variationsActivityADAS,

    DiagramEnum.macroClassicalInflationaryGapAdjustment =>
      Subunit.variationsActivityADAS,

    /// Economic growth
    DiagramEnum.macroClassicalLongTermGrowth => Subunit.macroObjectives,
    DiagramEnum.macroKeynesianLongTermGrowth => Subunit.macroObjectives,

    /// Inflation
    DiagramEnum.macroADASCostPushInflation => Subunit.macroObjectives,
    DiagramEnum.macroClassicalDemandPullInflation => Subunit.macroObjectives,

    /// Unemployment
    DiagramEnum.macroUnemploymentStructural => Subunit.macroObjectives,
    DiagramEnum.macroUnemploymentLaborMarketRigidities =>
      Subunit.macroObjectives,
    DiagramEnum.macroUnemploymentNationalMinimumWage => Subunit.macroObjectives,
    DiagramEnum.macroUnemploymentEfficiencyWages => Subunit.macroObjectives,
    DiagramEnum.macroNaturalRateOfUnemployment => Subunit.macroObjectives,

    ///Philips Curve
    DiagramEnum.macroSRPCAndLRPC => Subunit.macroObjectives,
    DiagramEnum.macroPhillipsCurveStagflation => Subunit.macroObjectives,
    DiagramEnum.macroSRPCInflationaryGapAdjustment => Subunit.macroObjectives,
    DiagramEnum.macroSRPCDeflationaryGapAdjustment => Subunit.macroObjectives,
    DiagramEnum.macroLRPCFallInNRU => Subunit.macroObjectives,

    /// Poverty and Inequality
    DiagramEnum.macroLorenzCurveCalculation => Subunit.inequalityPoverty,
    DiagramEnum.macroLorenzCurveImprovedEquality => Subunit.inequalityPoverty,

    /// Demand-side & Supply-side
    DiagramEnum.macroKeynesianDemandPullInflation => Subunit.macroObjectives,
    DiagramEnum.macroKeynesianMultiplier => Subunit.demandManagementFiscal,
    DiagramEnum.macroMoneyMarket => Subunit.demandManagementMonetary,
    DiagramEnum.macroMoneyMarketExpansionaryMonetaryPolicy =>
      Subunit.demandManagementMonetary,
    DiagramEnum.macroMoneyMarketContractionaryMonetaryPolicy =>
      Subunit.demandManagementMonetary,
    DiagramEnum.macroKeynesianExpansionaryPolicy =>
      Subunit.demandManagementMonetary,
    DiagramEnum.macroKeynesianContractionaryPolicy =>
      Subunit.demandManagementMonetary,
    DiagramEnum.macroSupplSidePoliciesLowInflation =>
      Subunit.supplySidePolicies,

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
    DiagramEnum.globalPPCUnsustainableUseOfNaturalResources =>
      Subunit.barriersGrowth,
    DiagramEnum.globalPovertyCycle => Subunit.barriersGrowth,
    DiagramEnum.globalPPCReallocation => Subunit.sustainableDevelopment,
    DiagramEnum.globalPPCEconomicGrowth => Subunit.sustainableDevelopment,
    DiagramEnum.globalPPCCapitalInvestment => Subunit.sustainableDevelopment,
  };
}

extension DiagramDescriptionEnumExtension on DiagramEnum {
  /// Returns a short description for the diagram.
  String get description {
    return switch (this) {
      // -----------------------------------------------------------------------
      // MICROECONOMICS
      // -----------------------------------------------------------------------

      // Intro
      DiagramEnum.microPPCConstantOppCost =>
        "A straight-line PPC showing constant opportunity cost, implying resources are perfect substitutes.",
      DiagramEnum.microPPCIncreaseOppCost =>
        "A bowed-out PPC illustrating the law of increasing opportunity costs as resources are reallocated.",

      // Demand & Supply Basics
      DiagramEnum.microDemand =>
        "The law of demand: a downward-sloping curve showing the inverse relationship between price and quantity.",
      DiagramEnum.microDemandExtension =>
        "A movement along the demand curve downwards (extension) caused by a decrease in price.",
      DiagramEnum.microDemandContraction =>
        "A movement along the demand curve upwards (contraction) caused by an increase in price.",
      DiagramEnum.microDemandQuantityChangeDueToSupply =>
        "Shows how a shift in supply causes a movement along the demand curve to a new quantity.",
      DiagramEnum.microDemandIncrease =>
        "A rightward shift of the demand curve caused by non-price determinants.",
      DiagramEnum.microDemandDecrease =>
        "A leftward shift of the demand curve caused by non-price determinants.",
      DiagramEnum.microSupplyExtension =>
        "A movement along the supply curve upwards (extension) caused by an increase in price.",
      DiagramEnum.microSupplyContraction =>
        "A movement along the supply curve downwards (contraction) caused by a decrease in price.",
      DiagramEnum.microSupplyIncrease =>
        "A rightward shift of the supply curve caused by non-price determinants.",
      DiagramEnum.microSupplyDecrease =>
        "A leftward shift of the supply curve caused by non-price determinants.",
      DiagramEnum.microMarginalProduct =>
        "Illustrates diminishing returns where marginal product eventually falls as input increases.",
      DiagramEnum.microTotalAndMarginalProduct =>
        "The relationship between Total Product (TP) and Marginal Product (MP).",
      DiagramEnum.microMarginalCost =>
        "The Marginal Cost (MC) curve, which intersects Average Cost at its minimum point.",
      DiagramEnum.microMarginalCostSteps =>
        "Stepwise marginal cost indicating incremental cost increases for discrete units.",
      DiagramEnum.microMarginalCostSupplyCurve =>
        "Demonstrates how the firm's supply curve is derived from its Marginal Cost curve above AVC.",

      // Market Equilibrium
      DiagramEnum.microMarketEquilibrium =>
        "The point where quantity demanded equals quantity supplied (market clearing price).",
      DiagramEnum.microShortage =>
        "Excess demand occurs when the price is set below the equilibrium level.",
      DiagramEnum.microSurplus =>
        "Excess supply occurs when the price is set above the equilibrium level.",
      DiagramEnum.microDemandIncreasePriceMechanism =>
        "How the signaling and incentive functions of price restore equilibrium after demand increases.",
      DiagramEnum.microDemandDecreasePriceMechanism =>
        "How the signaling and incentive functions of price restore equilibrium after demand decreases.",
      DiagramEnum.microPriceRationing =>
        "The rationing function of price clearing a shortage by raising prices.",
      DiagramEnum.microConsumerSurplus =>
        "The difference between what consumers are willing to pay and the market price.",
      DiagramEnum.microProducerSurplus =>
        "The difference between the market price and the price producers are willing to sell for.",
      DiagramEnum.microAllocativeEfficiency =>
        "Occurs where Marginal Social Benefit equals Marginal Social Cost (MSB = MSC).",
      DiagramEnum.microMarginalBenefit =>
        "The additional satisfaction or utility gained from consuming one more unit.",

      // Elasticity
      DiagramEnum.microDemandElastic =>
        "Elastic Demand (PED > 1): Quantity changes by a greater percentage than price.",
      DiagramEnum.microDemandInelastic =>
        "Inelastic Demand (PED < 1): Quantity changes by a smaller percentage than price.",
      DiagramEnum.microDemandUnitElastic =>
        "Unit Elastic Demand (PED = 1): Percentage change in quantity equals percentage change in price.",
      DiagramEnum.microDemandPerfectlyElastic =>
        "Perfectly Elastic Demand (PED = ∞): Consumers will only buy at one specific price.",
      DiagramEnum.microDemandPerfectlyInelastic =>
        "Perfectly Inelastic Demand (PED = 0): Quantity demanded remains constant regardless of price.",
      DiagramEnum.microDemandInelasticRevenue =>
        "Increasing price on an inelastic good increases Total Revenue.",
      DiagramEnum.microDemandElasticRevenue =>
        "Decreasing price on an elastic good increases Total Revenue.",
      DiagramEnum.microDemandElasticityChange =>
        "Shows how PED varies along a linear demand curve (elastic at top, inelastic at bottom).",
      DiagramEnum.microDemandElasticityRevenueChange =>
        "The relationship between PED and the Total Revenue curve (max revenue at Unit Elasticity).",
      DiagramEnum.microDemandEngelCurve =>
        "Shows the relationship between income and quantity demanded for normal vs inferior goods.",
      DiagramEnum.microSupplyElastic =>
        "Elastic Supply (PES > 1): Producers are responsive to price changes.",
      DiagramEnum.microSupplyInelastic =>
        "Inelastic Supply (PES < 1): Producers are unresponsive to price changes.",
      DiagramEnum.microSupplyUnitElastic =>
        "Unit Elastic Supply (PES = 1): Supply curve passes through the origin.",
      DiagramEnum.microSupplyPerfectlyElastic =>
        "Perfectly Elastic Supply (PES = ∞): Horizontal supply curve.",
      DiagramEnum.microSupplyPerfectlyInelastic =>
        "Perfectly Inelastic Supply (PES = 0): Vertical supply curve (fixed quantity).",
      DiagramEnum.microSupplyPrimaryCommodities =>
        "Comparison of volatility between primary commodities (inelastic) and manufactured goods.",

      // Government Intervention
      DiagramEnum.microPriceCeiling =>
        "A maximum price set below equilibrium, leading to a shortage.",
      DiagramEnum.microPriceFloor =>
        "A minimum price set above equilibrium, leading to a surplus.",
      DiagramEnum.microMinimumWage =>
        "A price floor in the labor market creating unemployment (excess supply of labor).",
      DiagramEnum.microMinimumWageWelfare =>
        "Welfare analysis (deadweight loss) caused by a minimum wage.",
      DiagramEnum.microNationalMinimumWageInelasticDemandAndSupply =>
        "Shows reduced unemployment impact when labor demand/supply are inelastic.",
      DiagramEnum.microAgriculturalPriceFloor =>
        "Government purchasing the surplus to support agricultural prices.",
      DiagramEnum.microIndirectTax =>
        "A specific tax shifting supply vertically upwards by the amount of the tax.",
      DiagramEnum.microIndirectTaxInelasticPED =>
        "Tax incidence falls mostly on consumers when demand is inelastic.",
      DiagramEnum.microIndirectTaxElasticPED =>
        "Tax incidence falls mostly on producers when demand is elastic.",
      DiagramEnum.microSubsidy =>
        "A government payment shifting supply vertically downwards.",
      DiagramEnum.microSubsidyInelasticPED =>
        "Consumers benefit most from a subsidy when demand is inelastic.",
      DiagramEnum.microSubsidyElasticPED =>
        "Producers benefit most from a subsidy when demand is elastic.",

      // Market Failure: Externalities
      DiagramEnum.microNegativeProductionExternality =>
        "MSC > MPC. Over-production and welfare loss due to external costs.",
      DiagramEnum.microNegativeProductionExternalityWelfare =>
        "Deadweight loss area shown when the market ignores negative production externalities.",
      DiagramEnum.microNegativeProductionExternalityPigouvianTax =>
        "Using a tax to internalize the externality and shift MPC to MSC.",
      DiagramEnum.microNegativeProductionExternalityRegulations =>
        "Using quotas or regulation to reduce quantity to the social optimum.",
      DiagramEnum.microCarbonTax =>
        "A tax specifically targeting carbon emissions to correct market failure.",
      DiagramEnum.microTradablePollutionPermits =>
        "Cap and trade system limiting total pollution quantity.",
      DiagramEnum.microCommonPoolResources =>
        "Tragedy of the Commons: Overuse of rival but non-excludable resources.",
      DiagramEnum.microNegativeConsumptionExternality =>
        "MSB < MPB. Over-consumption of demerit goods (e.g., smoking).",
      DiagramEnum.microNegativeConsumptionExternalityWelfare =>
        "Deadweight loss area caused by over-consumption of demerit goods.",
      DiagramEnum.microNegativeConsumptionExternalityPigouvianTax =>
        "Taxing consumers (shifting MPB) or producers to reduce consumption.",
      DiagramEnum.microNegativeConsumptionExternalityPublicAwareness =>
        "Advertising shifts demand left to align MPB with MSB.",
      DiagramEnum.microNegativeConsumptionExternalityGovernmentRegulations =>
        "Bans or restrictions forcing consumption down to the social optimum.",
      DiagramEnum.microPositiveProductionExternality =>
        "MSC < MPC. Under-production of goods with external benefits (e.g., R&D).",
      DiagramEnum.microPositiveProductionExternalityWelfare =>
        "Potential welfare gain lost due to under-production.",
      DiagramEnum.microPositiveConsumptionExternality =>
        "MSB > MPB. Under-consumption of merit goods (e.g., vaccines).",
      DiagramEnum.microPositiveConsumptionExternalityWelfare =>
        "Potential welfare gain lost due to under-consumption.",
      DiagramEnum.microPositiveConsumptionExternalitySubsidy =>
        "Subsidizing consumption to shift MPB rightward or Supply rightward.",
      DiagramEnum.microPositiveConsumptionExternalityAdvertising =>
        "Increasing demand for merit goods through education/advertising.",
      DiagramEnum.microPositiveConsumptionExternalityDirectProvision =>
        "Government directly providing the good (Supply shifts to Qopt).",
      DiagramEnum.microPositiveProductionExternalitySubsidy =>
        "Subsidizing firms to reduce costs and increase production.",
      DiagramEnum.microPositiveProductionExternalityDirectProvision =>
        "Government taking over production to reach social optimum.",
      DiagramEnum.microPublicGoods =>
        "Illustrates the 'Missing Market' for non-excludable, non-rival goods.",

      // Theory of the Firm
      DiagramEnum.microPerfectCompetitionFirmLongRun =>
        "Productive and Allocative efficiency where P = MC = min ATC.",
      DiagramEnum.microPerfectCompetitionMarketLongRun =>
        "The industry supply and demand setting the price for price-taking firms.",
      DiagramEnum.microPerfectCompetitionFirmAbnormalProfitAdjustment =>
        "The transition from short-run profit to long-run normal profit.",
      DiagramEnum.microPerfectCompetitionMarketAbnormalProfit =>
        "Entry of new firms shifts market supply right, lowering price.",
      DiagramEnum.microPerfectCompetitionFirmLoss =>
        "Short-run loss where Price is below ATC but above AVC.",
      DiagramEnum.microPerfectCompetitionMarketLoss =>
        "Exit of firms shifts market supply left, raising price.",
      DiagramEnum.microPerfectCompetitionShutdownPoint =>
        "The firm shuts down when Price falls below Average Variable Cost (AVC).",
      DiagramEnum.microPerfectCompetitionNormalProfitRevenueCostsCalculation =>
        "Visualizing Total Revenue and Total Cost when Profit = 0.",
      DiagramEnum
          .microPerfectCompetitionAbnormalProfitRevenueCostsCalculation =>
        "Visualizing the area of Supernormal (Abnormal) Profit.",
      DiagramEnum.microPerfectCompetitionShutdownLossCalculation =>
        "Visualizing the loss area when a firm shuts down.",
      DiagramEnum.microMonopolyAbnormalProfit =>
        "Profit maximization at MR=MC where Price > ATC.",
      DiagramEnum.microMonopolyAbnormalProfitAndCosts =>
        "Detailed view of Revenue and Cost boxes for a Monopoly.",
      DiagramEnum.microMonopolyWelfare =>
        "Deadweight loss under Monopoly compared to Perfect Competition.",
      DiagramEnum.microMonopolyWelfareAllocativelyEfficient =>
        "Comparison of Price/Output against the Allocatively Efficient point.",
      DiagramEnum.microMonopolyNatural =>
        "LRAC falls continuously over the relevant range of output.",
      DiagramEnum.microMonopolyNaturalUnregulatedWelfare =>
        "High prices and restricted output in an unregulated natural monopoly.",
      DiagramEnum.microMonopolyNaturalPricingComparisons =>
        "Comparing Profit Max vs Average Cost vs Marginal Cost pricing.",
      DiagramEnum.microMonopolyNaturalAverageCostPricingWelfare =>
        "Regulation setting P=ATC (Normal Profit) to lower prices.",
      DiagramEnum.microMonopolyNaturalMarginalCostPricing =>
        "Regulation setting P=MC (Allocative Efficiency), causing a loss.",
      DiagramEnum.microMonopolyNaturalMarginalCostPricingWelfare =>
        "Welfare implications of subsidizing a Natural Monopoly to achieve P=MC.",
      DiagramEnum.microOligopolyKinkedDemandCurve =>
        "Price rigidity due to interdependent reactions to price changes.",
      DiagramEnum.microMonopolisticCompetitionAbnormalProfit =>
        "Short-run profit with a downward-sloping (elastic) demand curve.",
      DiagramEnum.microMonopolisticCompetitionAbnormalProfitShift =>
        "Entry of substitutes shifts demand left in the long run.",
      DiagramEnum.microMonopolisticCompetitionLoss =>
        "Short-run loss where P < ATC.",
      DiagramEnum.microMonopolisticCompetitionLossShift =>
        "Exit of firms shifts demand right in the long run.",
      DiagramEnum.microMonopolisticCompetitionLongRun =>
        "Long-run Tangency Equilibrium: P = ATC but P > MC.",

      // -----------------------------------------------------------------------
      // MACROECONOMICS
      // -----------------------------------------------------------------------

      // Activity & Biz Cycle
      DiagramEnum.macroCircularFlowClosed =>
        "Two-sector model showing flows of income and expenditure between Households and Firms.",
      DiagramEnum.macroCircularFlowOpen =>
        "Four-sector model including Government, Financial, and Foreign sectors.",
      DiagramEnum.macroBusinessCycle =>
        "Fluctuations in GDP over time: Boom, Recession, Trough, and Recovery.",

      // AD-AS
      DiagramEnum.macroClassicalFullEmployment =>
        "Long-run equilibrium where AD intersects SRAS and LRAS at Yfe.",
      DiagramEnum.macroClassicalDeflationaryGap =>
        "Equilibrium below full employment (Recessionary Gap).",
      DiagramEnum.macroClassicalInflationaryGap =>
        "Equilibrium above full employment (Overheating).",
      DiagramEnum.macroADASKeynesianFullEmployment =>
        "Equilibrium on the vertical section of the Keynesian AS curve.",
      DiagramEnum.macroKeynesianDeflationaryGap =>
        "Equilibrium on the horizontal or intermediate section of the AS curve.",
      DiagramEnum.macroKeynesianInflationaryGap =>
        "AD shifts purely inflationary on the vertical AS section.",
      DiagramEnum.macroKeynesianExpansionaryPolicy =>
        "AD shifting right to close a deflationary gap.",
      DiagramEnum.macroKeynesianContractionaryPolicy =>
        "AD shifting left to control inflation.",
      DiagramEnum.macroClassicalDeflationaryGapAdjustment =>
        "Self-correction mechanism: Wages fall, SRAS shifts right.",
      DiagramEnum.macroClassicalInflationaryGapAdjustment =>
        "Self-correction mechanism: Wages rise, SRAS shifts left.",

      // Growth
      DiagramEnum.macroClassicalLongTermGrowth =>
        "LRAS shifting right due to increased quantity/quality of factors.",
      DiagramEnum.macroKeynesianLongTermGrowth =>
        "Keynesian AS curve shifting right/down representing growth.",

      // Inflation
      DiagramEnum.macroClassicalDemandPullInflation =>
        "Price level rising due to continuous rightward shifts in AD.",
      DiagramEnum.macroKeynesianDemandPullInflation =>
        "Inflation caused by AD shifting right on the intermediate/vertical AS section.",
      DiagramEnum.macroADASCostPushInflation =>
        "Stagflation caused by a leftward shift of SRAS (supply shock).",

      // Unemployment
      DiagramEnum.macroUnemploymentStructural =>
        "Mismatch of skills or geography causing long-term unemployment.",
      DiagramEnum.macroUnemploymentLaborMarketRigidities =>
        "Factors preventing wages from clearing the labor market.",
      DiagramEnum.macroUnemploymentNationalMinimumWage =>
        "Real wage unemployment caused by a minimum wage above equilibrium.",
      DiagramEnum.macroUnemploymentEfficiencyWages =>
        "Wages kept above equilibrium to boost worker productivity.",
      DiagramEnum.macroNaturalRateOfUnemployment =>
        "The rate of unemployment when the labor market is in equilibrium (Structural + Frictional).",

      // Phillips Curve
      DiagramEnum.macroSRPCAndLRPC =>
        "Short-run trade-off vs Long-run vertical curve at the NRU.",
      DiagramEnum.macroPhillipsCurveStagflation =>
        "SRPC shifting right due to supply shocks or higher inflation expectations.",
      DiagramEnum.macroSRPCInflationaryGapAdjustment =>
        "Movement along SRPC to higher inflation/lower unemployment.",
      DiagramEnum.macroSRPCDeflationaryGapAdjustment =>
        "Movement along SRPC to lower inflation/higher unemployment.",
      DiagramEnum.macroLRPCFallInNRU =>
        "LRPC shifting left due to supply-side policies improving labor markets.",

      // Poverty
      DiagramEnum.macroLorenzCurveCalculation =>
        "Visualizing income inequality; the further from the diagonal, the more unequal.",
      DiagramEnum.macroLorenzCurveImprovedEquality =>
        "Lorenz curve shifting inward towards the line of perfect equality.",

      // Policies
      DiagramEnum.macroMoneyMarket =>
        "Supply and Demand for Money determining the interest rate.",
      DiagramEnum.macroMoneyMarketExpansionaryMonetaryPolicy =>
        "Money Supply shifts right, lowering interest rates.",
      DiagramEnum.macroMoneyMarketContractionaryMonetaryPolicy =>
        "Money Supply shifts left, raising interest rates.",
      DiagramEnum.macroKeynesianMultiplier =>
        "Shows how an initial injection leads to a larger final increase in GDP.",
      DiagramEnum.macroSupplSidePoliciesLowInflation =>
        "LRAS shifts right allowing growth without inflationary pressure.",

      // -----------------------------------------------------------------------
      // GLOBAL ECONOMICS
      // -----------------------------------------------------------------------

      // Trade
      DiagramEnum.globalWorldPriceHigher =>
        "Domestic price is below World Price -> Country exports.",
      DiagramEnum.globalWorldPriceLower =>
        "Domestic price is above World Price -> Country imports.",
      DiagramEnum.globalDomesticExporter =>
        "Welfare analysis of a country opening up to exports.",
      DiagramEnum.globalDomesticImporter =>
        "Welfare analysis of a country opening up to imports.",
      DiagramEnum.globalAbsoluteAdvantageDifferentGoods =>
        "Comparison of production possibilities where countries differ strictly in efficiency.",
      DiagramEnum.globalComparativeAdvantage =>
        "Gains from trade based on lower opportunity costs.",
      DiagramEnum.globalNoComparativeAdvantage =>
        "Parallel PPCs implying no opportunity cost differences (no gains from trade).",

      // Protectionism
      DiagramEnum.globalTariff =>
        "Import tax raising domestic price, reducing imports, and causing deadweight loss.",
      DiagramEnum.globalImportQuota =>
        "Quantity limit on imports raising price and creating quota rents.",
      DiagramEnum.globalProductionSubsidy =>
        "Subsidy to domestic firms to reduce imports without raising consumer prices.",
      DiagramEnum.globalExportSubsidy =>
        "Subsidy to exporters creating dumping and welfare loss.",

      // Exchange Rates
      DiagramEnum.globalForeignExchangeRate =>
        "Equilibrium exchange rate determined by Supply and Demand for currency.",
      DiagramEnum.globalEuroDepreciates =>
        "Fall in value of the Euro due to decreased demand or increased supply.",
      DiagramEnum.globalUSDAppreciates =>
        "Rise in value of the USD due to increased demand or decreased supply.",
      DiagramEnum.globalFloatingRateDemandIncrease =>
        "Currency appreciates as demand for exports or investment rises.",
      DiagramEnum.globalFloatingRateDemandDecrease =>
        "Currency depreciates as demand for exports falls.",
      DiagramEnum.globalFloatingRateSupplyIncrease =>
        "Currency depreciates as citizens buy more imports (selling currency).",
      DiagramEnum.globalFloatingRateSupplyDecrease =>
        "Currency appreciates as citizens buy fewer imports.",
      DiagramEnum.globalManagedExchangeRate =>
        "Central Bank intervention to keep the rate within a specific band.",
      DiagramEnum.globalFixedRateDemandDecreaseBuyCurrency =>
        "Central Bank uses reserves to buy currency and maintain the peg.",
      DiagramEnum.globalFixedRateDemandIncreaseSellCurrency =>
        "Central Bank sells currency to prevent appreciation above the peg.",
      DiagramEnum.globalFixedRateDemandDecreaseReduceSupply =>
        "Using contractionary monetary policy to shift supply and maintain the peg.",
      DiagramEnum.globalJCurveDeficit =>
        "Marshall-Lerner condition: Depreciation initially worsens trade balance before improving it.",
      DiagramEnum.globalJCurveSurplus =>
        "Inverse J-Curve effect on a trade surplus.",

      // Development
      DiagramEnum.globalPPCReallocation =>
        "Moving along the PPC to prioritize merit goods or capital.",
      DiagramEnum.globalPPCCapitalInvestment =>
        "Trade-off: Consuming less now to invest in capital for future growth.",
      DiagramEnum.globalPPCEconomicGrowth =>
        "Outward shift of the PPC representing development and capacity growth.",
      DiagramEnum.globalPPCUnsustainableUseOfNaturalResources =>
        "Inward shift of the PPC due to resource depletion.",
      DiagramEnum.globalPovertyCycle =>
        "Circular flow showing how low income leads to low savings and investment.",
    };
  }
}
