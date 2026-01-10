import 'package:economics_app/diagrams/custom_paint/diagrams/competitive_market.dart';
import 'package:economics_app/diagrams/custom_paint/diagrams/elasticities.dart';
import 'package:economics_app/diagrams/custom_paint/diagrams/externalities.dart';
import 'package:economics_app/diagrams/custom_paint/diagrams/market_power.dart';
import 'package:economics_app/diagrams/custom_paint/diagrams/public_goods.dart';
import 'package:economics_app/diagrams/custom_paint/diagrams/taxes_and_subsidies.dart';
import '../custom_paint/diagrams/demand_diagram.dart';
import '../custom_paint/diagrams/price_controls.dart';
import '../custom_paint/diagrams/supply.dart';
import '../enums/diagram_enum.dart';
import '../models/diagram_widget.dart';
import '../models/diagram_painter_config.dart';

List<DiagramWidget> getDiagramWidgetList(DiagramPainterConfig c) {
  return [
    /// Demand
    DiagramWidget(DemandDiagram(c, DiagramEnum.microDemandApples)),
    DiagramWidget(DemandDiagram(c, DiagramEnum.microDemandExtension)),
    DiagramWidget(DemandDiagram(c, DiagramEnum.microDemandContraction)),
    DiagramWidget(
      DemandDiagram(c, DiagramEnum.microDemandQuantityChangeDueToSupply),
    ),
    DiagramWidget(DemandDiagram(c, DiagramEnum.microDemandIncrease)),
    DiagramWidget(DemandDiagram(c, DiagramEnum.microDemandDecrease)),

    /// Market Power
    DiagramWidget(
      MarketPower(c, DiagramEnum.microPerfectCompetitionMarketLongRun),
    ),
    DiagramWidget(
      MarketPower(c, DiagramEnum.microPerfectCompetitionFirmLongRun),
    ),
    DiagramWidget(
      MarketPower(c, DiagramEnum.microPerfectCompetitionMarketAbnormalProfit),
    ),
    DiagramWidget(
      MarketPower(
        c,
        DiagramEnum.microPerfectCompetitionFirmAbnormalProfitAdjustment,
      ),
    ),
    DiagramWidget(
      MarketPower(c, DiagramEnum.microPerfectCompetitionMarketLoss),
    ),
    DiagramWidget(MarketPower(c, DiagramEnum.microPerfectCompetitionFirmLoss)),
    DiagramWidget(
      MarketPower(c, DiagramEnum.microPerfectCompetitionShutdownPoint),
    ),
    DiagramWidget(
      MarketPower(
        c,
        DiagramEnum.microPerfectCompetitionNormalProfitRevenueCostsCalculation,
      ),
    ),
    DiagramWidget(
      MarketPower(
        c,
        DiagramEnum
            .microPerfectCompetitionAbnormalProfitRevenueCostsCalculation,
      ),
    ),
    DiagramWidget(
      MarketPower(
        c,
        DiagramEnum.microPerfectCompetitionShutdownLossCalculation,
      ),
    ),
    DiagramWidget(MarketPower(c, DiagramEnum.microMonopolyAbnormalProfit)),
    DiagramWidget(
      MarketPower(c, DiagramEnum.microMonopolyAbnormalProfitAndCosts),
    ),
    DiagramWidget(MarketPower(c, DiagramEnum.microMonopolyWelfare)),
    DiagramWidget(
      MarketPower(c, DiagramEnum.microMonopolyWelfareAllocativelyEfficient),
    ),
    DiagramWidget(MarketPower(c, DiagramEnum.microMonopolyNatural)),
    DiagramWidget(
      MarketPower(c, DiagramEnum.microMonopolyNaturalUnregulatedWelfare),
    ),
    DiagramWidget(
      MarketPower(c, DiagramEnum.microMonopolyNaturalPricingComparisons),
    ),
    DiagramWidget(
      MarketPower(c, DiagramEnum.microMonopolyNaturalAverageCostPricingWelfare),
    ),
    DiagramWidget(
      MarketPower(c, DiagramEnum.microMonopolyNaturalMarginalCostPricing),
    ),
    DiagramWidget(
      MarketPower(
        c,
        DiagramEnum.microMonopolyNaturalMarginalCostPricingWelfare,
      ),
    ),
    DiagramWidget(MarketPower(c, DiagramEnum.microOligopolyKinkedDemandCurve)),
    DiagramWidget(
      MarketPower(c, DiagramEnum.microMonopolisticCompetitionAbnormalProfit),
    ),
    DiagramWidget(MarketPower(c, DiagramEnum.microMonopolisticCompetitionLoss)),
    DiagramWidget(
      MarketPower(
        c,
        DiagramEnum.microMonopolisticCompetitionAbnormalProfitShift,
      ),
    ),
    DiagramWidget(
      MarketPower(c, DiagramEnum.microMonopolisticCompetitionLossShift),
    ),
    DiagramWidget(
      MarketPower(c, DiagramEnum.microMonopolisticCompetitionLongRun),
    ),
  ];
}

/// Make redundant
List<DiagramBundle> getBundleList(DiagramPainterConfig config) => [
  /// 1.1 PPC

  /// 2.1 Demand

  /// 2.2 Supply
  DiagramBundle(DiagramEnum.microSupplyExtension, [
    Supply(config, DiagramEnum.microSupplyExtension),
  ]),
  DiagramBundle(DiagramEnum.microSupplyContraction, [
    Supply(config, DiagramEnum.microSupplyContraction),
  ]),
  DiagramBundle(DiagramEnum.microSupplyIncrease, [
    Supply(config, DiagramEnum.microSupplyIncrease),
  ]),
  DiagramBundle(DiagramEnum.microSupplyDecrease, [
    Supply(config, DiagramEnum.microSupplyDecrease),
  ]),
  DiagramBundle(DiagramEnum.microMarginalProduct, [
    Supply(config, DiagramEnum.microMarginalProduct),
  ]),
  DiagramBundle(DiagramEnum.microTotalAndMarginalProduct, [
    Supply(config, DiagramEnum.microTotalAndMarginalProduct),
  ]),
  DiagramBundle(DiagramEnum.microMarginalCost, [
    Supply(config, DiagramEnum.microMarginalCost),
  ]),

  /// 2.3 Competitive Market Equilibrium
  DiagramBundle(DiagramEnum.microMarketEquilibrium, [
    CompetitiveMarket(config, DiagramEnum.microMarketEquilibrium),
  ]),
  DiagramBundle(DiagramEnum.microShortage, [
    CompetitiveMarket(config, DiagramEnum.microShortage),
  ]),
  DiagramBundle(DiagramEnum.microSurplus, [
    CompetitiveMarket(config, DiagramEnum.microSurplus),
  ]),
  DiagramBundle(DiagramEnum.microDemandIncreasePriceMechanism, [
    CompetitiveMarket(config, DiagramEnum.microDemandIncreasePriceMechanism),
  ]),
  DiagramBundle(DiagramEnum.microDemandDecreasePriceMechanism, [
    CompetitiveMarket(config, DiagramEnum.microDemandDecreasePriceMechanism),
  ]),
  DiagramBundle(DiagramEnum.microPriceRationing, [
    CompetitiveMarket(config, DiagramEnum.microPriceRationing),
  ]),
  DiagramBundle(DiagramEnum.microMarginalBenefit, [
    CompetitiveMarket(config, DiagramEnum.microMarginalBenefit),
  ]),
  DiagramBundle(DiagramEnum.microConsumerSurplus, [
    CompetitiveMarket(config, DiagramEnum.microConsumerSurplus),
  ]),
  DiagramBundle(DiagramEnum.microProducerSurplus, [
    CompetitiveMarket(config, DiagramEnum.microProducerSurplus),
  ]),
  DiagramBundle(DiagramEnum.microAllocativeEfficiency, [
    CompetitiveMarket(config, DiagramEnum.microAllocativeEfficiency),
  ]),
  DiagramBundle(DiagramEnum.microMarginalCostSteps, [
    CompetitiveMarket(config, DiagramEnum.microMarginalCostSteps),
  ]),

  /// 2.4 Critique of the maximizing behaviour of consumers and producers (HL only)
  /// 2.5 Elasticity of demand (includes HL only sub-topics)
  DiagramBundle(DiagramEnum.microDemandElastic, [
    Elasticities(config, DiagramEnum.microDemandElastic),
  ]),
  DiagramBundle(DiagramEnum.microDemandInelastic, [
    Elasticities(config, DiagramEnum.microDemandInelastic),
  ]),
  DiagramBundle(DiagramEnum.microDemandUnitElastic, [
    Elasticities(config, DiagramEnum.microDemandUnitElastic),
  ]),
  DiagramBundle(DiagramEnum.microDemandPerfectlyElastic, [
    Elasticities(config, DiagramEnum.microDemandPerfectlyElastic),
  ]),
  DiagramBundle(DiagramEnum.microDemandPerfectlyInelastic, [
    Elasticities(config, DiagramEnum.microDemandPerfectlyInelastic),
  ]),
  DiagramBundle(DiagramEnum.microDemandElasticRevenue, [
    Elasticities(config, DiagramEnum.microDemandElasticRevenue),
  ]),
  DiagramBundle(DiagramEnum.microDemandInelasticRevenue, [
    Elasticities(config, DiagramEnum.microDemandInelasticRevenue),
  ]),
  DiagramBundle(DiagramEnum.microDemandElasticityRevenueChange, [
    Elasticities(config, DiagramEnum.microDemandElasticityChange),
    Elasticities(config, DiagramEnum.microDemandElasticityRevenueChange),
  ]),
  DiagramBundle(DiagramEnum.microDemandEngelCurve, [
    Elasticities(config, DiagramEnum.microDemandEngelCurve),
  ]),

  /// 2.6 Elasticity of supply (includes HL only sub-topics)
  DiagramBundle(DiagramEnum.microSupplyElastic, [
    Elasticities(config, DiagramEnum.microSupplyElastic),
  ]),
  DiagramBundle(DiagramEnum.microSupplyInelastic, [
    Elasticities(config, DiagramEnum.microSupplyInelastic),
  ]),
  DiagramBundle(DiagramEnum.microSupplyUnitElastic, [
    Elasticities(config, DiagramEnum.microSupplyUnitElastic),
  ]),
  DiagramBundle(DiagramEnum.microSupplyPerfectlyInelastic, [
    Elasticities(config, DiagramEnum.microSupplyPerfectlyInelastic),
  ]),
  DiagramBundle(DiagramEnum.microSupplyPerfectlyElastic, [
    Elasticities(config, DiagramEnum.microSupplyPerfectlyElastic),
  ]),
  DiagramBundle(DiagramEnum.microSupplyPrimaryCommodities, [
    Elasticities(config, DiagramEnum.microSupplyPrimaryCommodities),
  ]),

  /// 2.7 Role of Government
  DiagramBundle(DiagramEnum.microPriceCeiling, [
    PriceControls(config, DiagramEnum.microPriceCeiling),
  ]),
  DiagramBundle(DiagramEnum.microNationalMinimumWage, [
    PriceControls(config, DiagramEnum.microNationalMinimumWage),
  ]),
  DiagramBundle(DiagramEnum.microNationalMinimumWageWelfare, [
    PriceControls(config, DiagramEnum.microNationalMinimumWageWelfare),
  ]),
  DiagramBundle(DiagramEnum.microNationalMinimumWageInelasticDemandAndSupply, [
    PriceControls(
      config,
      DiagramEnum.microNationalMinimumWageInelasticDemandAndSupply,
    ),
  ]),
  DiagramBundle(DiagramEnum.microAgriculturalPriceFloor, [
    PriceControls(config, DiagramEnum.microAgriculturalPriceFloor),
  ]),
  DiagramBundle(DiagramEnum.microIndirectTax, [
    TaxesAndSubsidies(config, DiagramEnum.microIndirectTax),
  ]),
  DiagramBundle(DiagramEnum.microIndirectTaxInelasticPED, [
    TaxesAndSubsidies(config, DiagramEnum.microIndirectTaxInelasticPED),
  ]),
  DiagramBundle(DiagramEnum.microIndirectTaxElasticPED, [
    TaxesAndSubsidies(config, DiagramEnum.microIndirectTaxElasticPED),
  ]),
  DiagramBundle(DiagramEnum.microSubsidy, [
    TaxesAndSubsidies(config, DiagramEnum.microSubsidy),
  ]),
  DiagramBundle(DiagramEnum.microSubsidyInelasticPED, [
    TaxesAndSubsidies(config, DiagramEnum.microSubsidyInelasticPED),
  ]),
  DiagramBundle(DiagramEnum.microSubsidyElasticPED, [
    TaxesAndSubsidies(config, DiagramEnum.microSubsidyElasticPED),
  ]),

  /// 2.8 Market failure—externalities and common pool or common access resources
  /// Negative Production Externality
  DiagramBundle(DiagramEnum.microNegativeProductionExternality, [
    Externalities(config, DiagramEnum.microNegativeProductionExternality),
  ]),
  DiagramBundle(DiagramEnum.microNegativeProductionExternalityWelfare, [
    Externalities(
      config,
      DiagramEnum.microNegativeProductionExternalityWelfare,
    ),
  ]),
  DiagramBundle(DiagramEnum.microNegativeProductionExternalityPigouvianTax, [
    Externalities(
      config,
      DiagramEnum.microNegativeProductionExternalityPigouvianTax,
    ),
  ]),
  DiagramBundle(DiagramEnum.microNegativeProductionExternalityRegulations, [
    Externalities(
      config,
      DiagramEnum.microNegativeProductionExternalityRegulations,
    ),
  ]),

  DiagramBundle(DiagramEnum.microCommonPoolResources, [
    Externalities(config, DiagramEnum.microCommonPoolResources),
  ]),
  DiagramBundle(DiagramEnum.microCarbonTax, [
    Externalities(config, DiagramEnum.microCarbonTax),
  ]),
  DiagramBundle(DiagramEnum.microTradablePollutionPermits, [
    Externalities(config, DiagramEnum.microTradablePollutionPermits),
  ]),

  /// Negative Consumption
  DiagramBundle(DiagramEnum.microNegativeConsumptionExternality, [
    Externalities(config, DiagramEnum.microNegativeConsumptionExternality),
  ]),
  DiagramBundle(DiagramEnum.microNegativeConsumptionExternalityWelfare, [
    Externalities(
      config,
      DiagramEnum.microNegativeConsumptionExternalityWelfare,
    ),
  ]),
  DiagramBundle(DiagramEnum.microNegativeConsumptionExternalityPigouvianTax, [
    Externalities(
      config,
      DiagramEnum.microNegativeConsumptionExternalityPigouvianTax,
    ),
  ]),
  DiagramBundle(
    DiagramEnum.microNegativeConsumptionExternalityPublicAwareness,
    [
      Externalities(
        config,
        DiagramEnum.microNegativeConsumptionExternalityPublicAwareness,
      ),
    ],
  ),

  /// Positive Production Externality
  DiagramBundle(DiagramEnum.microPositiveProductionExternality, [
    Externalities(config, DiagramEnum.microPositiveProductionExternality),
  ]),

  DiagramBundle(DiagramEnum.microPositiveProductionExternalityWelfare, [
    Externalities(
      config,
      DiagramEnum.microPositiveProductionExternalityWelfare,
    ),
  ]),

  DiagramBundle(DiagramEnum.microPositiveProductionExternalitySubsidy, [
    Externalities(
      config,
      DiagramEnum.microPositiveProductionExternalitySubsidy,
    ),
  ]),
  DiagramBundle(DiagramEnum.microPositiveProductionExternalityDirectProvision, [
    Externalities(
      config,
      DiagramEnum.microPositiveProductionExternalityDirectProvision,
    ),
  ]),

  /// Positive Consumption Externality
  DiagramBundle(DiagramEnum.microPositiveConsumptionExternality, [
    Externalities(config, DiagramEnum.microPositiveConsumptionExternality),
  ]),
  DiagramBundle(DiagramEnum.microPositiveConsumptionExternalityWelfare, [
    Externalities(
      config,
      DiagramEnum.microPositiveConsumptionExternalityWelfare,
    ),
  ]),
  DiagramBundle(DiagramEnum.microPositiveConsumptionExternalitySubsidy, [
    Externalities(
      config,
      DiagramEnum.microPositiveConsumptionExternalitySubsidy,
    ),
  ]),
  DiagramBundle(DiagramEnum.microPositiveConsumptionExternalityAdvertising, [
    Externalities(
      config,
      DiagramEnum.microPositiveConsumptionExternalityAdvertising,
    ),
  ]),
  DiagramBundle(
    DiagramEnum.microPositiveConsumptionExternalityDirectProvision,
    [
      Externalities(
        config,
        DiagramEnum.microPositiveConsumptionExternalityDirectProvision,
      ),
    ],
  ),

  /// 2.9 Market failure—public goods
  DiagramBundle(DiagramEnum.microPublicGoods, [
    PublicGoods(config, DiagramEnum.microPublicGoods),
  ]),

  /// 2.11 Market Power

  // /// 4.1 Benefits of International Trade
  // DiagramBundle(DiagramEnum.globalWorldPriceStandAlone, [
  //   InternationalTrade(config, DiagramEnum.globalWorldPriceStandAlone),
  // ]),
  // DiagramBundle(DiagramEnum.globalNetImporter, [
  //   InternationalTrade(config, DiagramEnum.globalWorldPrice),
  //   InternationalTrade(config, DiagramEnum.globalNetImporter),
  // ]),
  // DiagramBundle(DiagramEnum.globalNetExporter, [
  //   InternationalTrade(config, DiagramEnum.globalWorldPrice),
  //   InternationalTrade(config, DiagramEnum.globalNetExporter),
  // ]),
  //
  // /// Comparative Advantage
  // DiagramBundle(DiagramEnum.globalAbsoluteAdvantageDifferentGoods, [
  //   ComparativeAdvantage(
  //     config,
  //     DiagramEnum.globalAbsoluteAdvantageDifferentGoods,
  //   ),
  // ]),
  // DiagramBundle(DiagramEnum.globalAbsoluteAdvantageBothGoods, [
  //   ComparativeAdvantage(
  //     config,
  //     DiagramEnum.globalAbsoluteAdvantageBothGoods,
  //   ),
  // ]),
  // DiagramBundle(
  //   DiagramEnum.globalComparativeAdvantageTradeAndConsumption,
  //   [
  //     ComparativeAdvantage(
  //       config,
  //       DiagramEnum.globalComparativeAdvantageTradeAndConsumption,
  //     ),
  //   ],
  // ),
  // DiagramBundle(
  //   DiagramEnum.globalComparativeAdvantageTradeAndConsumptionMixed,
  //   [
  //     ComparativeAdvantage(
  //       config,
  //       DiagramEnum.globalComparativeAdvantageTradeAndConsumptionMixed,
  //     ),
  //   ],
  // ),
  //
  // /// 4.2 Types of Trade Protection
  // DiagramBundle(DiagramEnum.globalTariff, [
  //   Tariff(config, DiagramEnum.globalTariff),
  // ]),
  // DiagramBundle(DiagramEnum.globalTariffWelfare, [
  //   Tariff(config, DiagramEnum.globalTariffWelfare),
  // ]),
  // DiagramBundle(DiagramEnum.globalTariffConsumerSurplusChange, [
  //   Tariff(config, DiagramEnum.globalTariffConsumerSurplusChange),
  // ]),
  // DiagramBundle(DiagramEnum.globalTariffProducerSurplusChange, [
  //   Tariff(config, DiagramEnum.globalTariffProducerSurplusChange),
  // ]),
  // DiagramBundle(DiagramEnum.globalTariffGovernmentRevenue, [
  //   Tariff(config, DiagramEnum.globalTariffGovernmentRevenue),
  // ]),
  // DiagramBundle(DiagramEnum.globalTariffWelfareLoss, [
  //   Tariff(config, DiagramEnum.globalTariffWelfareLoss),
  // ]),
  //
  // /// Import Quota
  // DiagramBundle(DiagramEnum.globalImportQuota, [
  //   ImportQuota(config, DiagramEnum.globalImportQuota),
  // ]),
  // DiagramBundle(DiagramEnum.globalImportQuotaWelfare, [
  //   ImportQuota(config, DiagramEnum.globalImportQuotaWelfare),
  // ]),
  // DiagramBundle(DiagramEnum.globalImportQuotaConsumerSurplusChange, [
  //   ImportQuota(
  //     config,
  //     DiagramEnum.globalImportQuotaConsumerSurplusChange,
  //   ),
  // ]),
  // DiagramBundle(DiagramEnum.globalImportQuotaProducerSurplusChange, [
  //   ImportQuota(
  //     config,
  //     DiagramEnum.globalImportQuotaProducerSurplusChange,
  //   ),
  // ]),
  // DiagramBundle(DiagramEnum.globalImportQuotaWelfareLoss, [
  //   ImportQuota(config, DiagramEnum.globalImportQuotaWelfareLoss),
  // ]),
  // DiagramBundle(DiagramEnum.globalProductionSubsidy, [
  //   ProductionSubsidy(config, DiagramEnum.globalProductionSubsidy),
  // ]),
  // DiagramBundle(DiagramEnum.globalProductionSubsidyWelfare, [
  //   ProductionSubsidy(config, DiagramEnum.globalProductionSubsidyWelfare),
  // ]),
  // DiagramBundle(DiagramEnum.globalProductionSubsidyConsumerSurplus, [
  //   ProductionSubsidy(
  //     config,
  //     DiagramEnum.globalProductionSubsidyConsumerSurplus,
  //   ),
  // ]),
  // DiagramBundle(DiagramEnum.globalProductionSubsidyProducerSurplus, [
  //   ProductionSubsidy(
  //     config,
  //     DiagramEnum.globalProductionSubsidyProducerSurplus,
  //   ),
  // ]),
  // DiagramBundle(DiagramEnum.globalProductionSubsidyWelfareLoss, [
  //   ProductionSubsidy(
  //     config,
  //     DiagramEnum.globalProductionSubsidyWelfareLoss,
  //   ),
  // ]),
  // DiagramBundle(
  //   DiagramEnum.globalProductionSubsidyProducerSurplusChange,
  //   [
  //     ProductionSubsidy(
  //       config,
  //       DiagramEnum.globalProductionSubsidyProducerSurplusChange,
  //       legendDisplay: LegendDisplay.letters,
  //     ),
  //   ],
  // ),
];
