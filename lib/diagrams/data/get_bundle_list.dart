import 'package:economics_app/diagrams/custom_paint/diagrams/comparative_advantage.dart';
import 'package:economics_app/diagrams/custom_paint/diagrams/elasticities.dart';
import 'package:economics_app/diagrams/custom_paint/diagrams/externalities.dart';
import 'package:economics_app/diagrams/custom_paint/diagrams/import_quota.dart';
import 'package:economics_app/diagrams/custom_paint/diagrams/international_trade.dart';
import 'package:economics_app/diagrams/custom_paint/diagrams/production_subsidy.dart';
import 'package:economics_app/diagrams/custom_paint/diagrams/tariff.dart';
import 'package:economics_app/diagrams/custom_paint/diagrams/taxes_and_subsidies.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/legend/legend_display.dart';

import '../custom_paint/diagrams/demand.dart';
import '../custom_paint/diagrams/price_controls.dart';
import '../custom_paint/diagrams/supply.dart';
import '../enums/diagram_bundle_enum.dart';
import '../models/diagram_bundle.dart';
import '../models/diagram_painter_config.dart';

List<DiagramBundle> getBundleList(DiagramPainterConfig config) => [
  /// 1.1 PPC

  /// 2.1 Demand
  DiagramBundle(DiagramBundleEnum.microDemandExtension, [
    Demand(config, DiagramBundleEnum.microDemandExtension),
  ]),
  DiagramBundle(DiagramBundleEnum.microDemandContraction, [
    Demand(config, DiagramBundleEnum.microDemandContraction),
  ]),
  DiagramBundle(DiagramBundleEnum.microDemandIncrease, [
    Demand(config, DiagramBundleEnum.microDemandIncrease),
  ]),
  DiagramBundle(DiagramBundleEnum.microDemandDecrease, [
    Demand(config, DiagramBundleEnum.microDemandDecrease),
  ]),

  /// 2.2 Supply
  DiagramBundle(DiagramBundleEnum.microSupplyExtension, [
    Supply(config, DiagramBundleEnum.microSupplyExtension),
  ]),
  DiagramBundle(DiagramBundleEnum.microSupplyContraction, [
    Supply(config, DiagramBundleEnum.microSupplyContraction),
  ]),
  DiagramBundle(DiagramBundleEnum.microSupplyIncrease, [
    Supply(config, DiagramBundleEnum.microSupplyIncrease),
  ]),
  DiagramBundle(DiagramBundleEnum.microSupplyDecrease, [
    Supply(config, DiagramBundleEnum.microSupplyDecrease),
  ]),
  DiagramBundle(DiagramBundleEnum.microMarginalProduct, [
    Supply(config, DiagramBundleEnum.microMarginalProduct),
  ]),
  DiagramBundle(DiagramBundleEnum.microTotalAndMarginalProduct, [
    Supply(config, DiagramBundleEnum.microTotalAndMarginalProduct),
  ]),
  DiagramBundle(DiagramBundleEnum.microMarginalCost, [
    Supply(config, DiagramBundleEnum.microMarginalCost),
  ]),

  /// 2.3 Competitive Market Equilibrium
  /// 2.4 Critique of the maximizing behaviour of consumers and producers (HL only)
  /// 2.5 Elasticity of demand (includes HL only sub-topics)
  DiagramBundle(DiagramBundleEnum.microDemandElastic, [
    Elasticities(config, DiagramBundleEnum.microDemandElastic),
  ]),
  DiagramBundle(DiagramBundleEnum.microDemandInelastic, [
    Elasticities(config, DiagramBundleEnum.microDemandInelastic),
  ]),
  DiagramBundle(DiagramBundleEnum.microDemandUnitElastic, [
    Elasticities(config, DiagramBundleEnum.microDemandUnitElastic),
  ]),
  DiagramBundle(DiagramBundleEnum.microDemandPerfectlyElastic, [
    Elasticities(config, DiagramBundleEnum.microDemandPerfectlyElastic),
  ]),
  DiagramBundle(DiagramBundleEnum.microDemandPerfectlyInelastic, [
    Elasticities(config, DiagramBundleEnum.microDemandPerfectlyInelastic),
  ]),
  DiagramBundle(
    title: 'PED and Firm Revenue',
    DiagramBundleEnum.microDemandElasticRevenue,
    [
      Elasticities(config, DiagramBundleEnum.microDemandElasticRevenue),
      Elasticities(config, DiagramBundleEnum.microDemandInelasticRevenue),
    ],
  ),
  DiagramBundle(DiagramBundleEnum.microDemandElasticityRevenueChange, [
    Elasticities(config, DiagramBundleEnum.microDemandElasticityChange),
    Elasticities(config, DiagramBundleEnum.microDemandElasticityRevenueChange),
  ]),
  DiagramBundle(DiagramBundleEnum.microDemandEngelCurve, [
    Elasticities(config, DiagramBundleEnum.microDemandEngelCurve),
  ]),

  /// 2.6 Elasticity of supply (includes HL only sub-topics)
  DiagramBundle(DiagramBundleEnum.microSupplyElastic, [
    Elasticities(config, DiagramBundleEnum.microSupplyElastic),
  ]),
  DiagramBundle(DiagramBundleEnum.microSupplyInelastic, [
    Elasticities(config, DiagramBundleEnum.microSupplyInelastic),
  ]),
  DiagramBundle(DiagramBundleEnum.microSupplyUnitElastic, [
    Elasticities(config, DiagramBundleEnum.microSupplyUnitElastic),
  ]),
  DiagramBundle(DiagramBundleEnum.microSupplyPerfectlyInelastic, [
    Elasticities(config, DiagramBundleEnum.microSupplyPerfectlyInelastic),
  ]),
  DiagramBundle(DiagramBundleEnum.microSupplyPerfectlyElastic, [
    Elasticities(config, DiagramBundleEnum.microSupplyPerfectlyElastic),
  ]),
  DiagramBundle(DiagramBundleEnum.microSupplyPrimaryCommodities, [
    Elasticities(config, DiagramBundleEnum.microSupplyPrimaryCommodities),
  ]),

  /// 2.7 Role of Government
  DiagramBundle(DiagramBundleEnum.microPriceCeiling, [
    PriceControls(config, DiagramBundleEnum.microPriceCeiling),
  ]),
  DiagramBundle(DiagramBundleEnum.microNationalMinimumWage, [
    PriceControls(config, DiagramBundleEnum.microNationalMinimumWage),
  ]),
  DiagramBundle(DiagramBundleEnum.microNationalMinimumWageWelfare, [
    PriceControls(config, DiagramBundleEnum.microNationalMinimumWageWelfare),
  ]),
  DiagramBundle(DiagramBundleEnum.microNationalMinimumWageInelasticDemandAndSupply, [
    PriceControls(config, DiagramBundleEnum.microNationalMinimumWageInelasticDemandAndSupply),
  ]),
  DiagramBundle(DiagramBundleEnum.microAgriculturalPriceFloor, [
    PriceControls(config, DiagramBundleEnum.microAgriculturalPriceFloor),
  ]),
  DiagramBundle(DiagramBundleEnum.microIndirectTax, [
    TaxesAndSubsidies(config, DiagramBundleEnum.microIndirectTax),
  ]),
  DiagramBundle(DiagramBundleEnum.microIndirectTaxInelasticPED, [
    TaxesAndSubsidies(config, DiagramBundleEnum.microIndirectTaxInelasticPED),
  ]),
  DiagramBundle(DiagramBundleEnum.microIndirectTaxElasticPED, [
    TaxesAndSubsidies(config, DiagramBundleEnum.microIndirectTaxElasticPED),
  ]),
  DiagramBundle(DiagramBundleEnum.microSubsidy, [
    TaxesAndSubsidies(config, DiagramBundleEnum.microSubsidy),
  ]),
  DiagramBundle(DiagramBundleEnum.microSubsidyInelasticPED, [
    TaxesAndSubsidies(config, DiagramBundleEnum.microSubsidyInelasticPED),
  ]),
  DiagramBundle(DiagramBundleEnum.microSubsidyElasticPED, [
    TaxesAndSubsidies(config, DiagramBundleEnum.microSubsidyElasticPED),
  ]),

  /// 2.8 Market failure—externalities and common pool or common access resources
  DiagramBundle(DiagramBundleEnum.microNegativeProductionExternalityWelfare, [
    Externalities(config, DiagramBundleEnum.microNegativeProductionExternalityWelfare),
  ]),
  DiagramBundle(DiagramBundleEnum.microNegativeConsumptionExternalityWelfare, [
    Externalities(config, DiagramBundleEnum.microNegativeConsumptionExternalityWelfare),
  ]),
  DiagramBundle(DiagramBundleEnum.microPositiveConsumptionExternalityWelfare, [
    Externalities(config, DiagramBundleEnum.microPositiveConsumptionExternalityWelfare),
  ]),
  DiagramBundle(DiagramBundleEnum.microPositiveProductionExternalityWelfare, [
    Externalities(config, DiagramBundleEnum.microPositiveProductionExternalityWelfare),
  ]),

  DiagramBundle(DiagramBundleEnum.microNegativeProductionExternalityPigouvianTax, [
    Externalities(config, DiagramBundleEnum.microNegativeProductionExternalityPigouvianTax),
  ]),
  DiagramBundle(DiagramBundleEnum.microNegativeProductionExternalityRegulations, [
    Externalities(config, DiagramBundleEnum.microNegativeProductionExternalityRegulations),
  ]),
  DiagramBundle(DiagramBundleEnum.microNegativeConsumptionExternalityPigouvianTax, [
    Externalities(config, DiagramBundleEnum.microNegativeConsumptionExternalityPigouvianTax),
  ]),
  DiagramBundle(DiagramBundleEnum.microNegativeConsumptionExternalityPublicAwareness, [
    Externalities(config, DiagramBundleEnum.microNegativeConsumptionExternalityPublicAwareness),
  ]),
  DiagramBundle(DiagramBundleEnum.microCommonPoolResourcesExternality, [
    Externalities(config, DiagramBundleEnum.microCommonPoolResourcesExternality),
  ]),
  DiagramBundle(DiagramBundleEnum.positiveConsumptionExternalitySubsidy, [
    Externalities(config, DiagramBundleEnum.positiveConsumptionExternalitySubsidy),
  ]),
  DiagramBundle(DiagramBundleEnum.positiveConsumptionExternalityAdvertising, [
    Externalities(config, DiagramBundleEnum.positiveConsumptionExternalityAdvertising),
  ]),
  DiagramBundle(DiagramBundleEnum.positiveConsumptionExternalityDirectProvision, [
    Externalities(config, DiagramBundleEnum.positiveConsumptionExternalityDirectProvision),
  ]),
  DiagramBundle(DiagramBundleEnum.positiveProductionExternalitySubsidy, [
    Externalities(config, DiagramBundleEnum.positiveProductionExternalitySubsidy),
  ]),
  DiagramBundle(DiagramBundleEnum.positiveProductionExternalityDirectProvision, [
    Externalities(config, DiagramBundleEnum.positiveProductionExternalityDirectProvision),
  ]),

  /// 4.1 Benefits of International Trade
  DiagramBundle(DiagramBundleEnum.globalWorldPriceStandAlone, [
    InternationalTrade(config, DiagramBundleEnum.globalWorldPriceStandAlone),
  ]),
  DiagramBundle(DiagramBundleEnum.globalNetImporter, [
    InternationalTrade(config, DiagramBundleEnum.globalWorldPrice),
    InternationalTrade(config, DiagramBundleEnum.globalNetImporter),
  ]),
  DiagramBundle(DiagramBundleEnum.globalNetExporter, [
    InternationalTrade(config, DiagramBundleEnum.globalWorldPrice),
    InternationalTrade(config, DiagramBundleEnum.globalNetExporter),
  ]),

  /// Comparative Advantage
  DiagramBundle(DiagramBundleEnum.globalAbsoluteAdvantageDifferentGoods, [
    ComparativeAdvantage(
      config,
      DiagramBundleEnum.globalAbsoluteAdvantageDifferentGoods,
    ),
  ]),
  DiagramBundle(DiagramBundleEnum.globalAbsoluteAdvantageBothGoods, [
    ComparativeAdvantage(
      config,
      DiagramBundleEnum.globalAbsoluteAdvantageBothGoods,
    ),
  ]),
  DiagramBundle(
    DiagramBundleEnum.globalComparativeAdvantageTradeAndConsumption,
    [
      ComparativeAdvantage(
        config,
        DiagramBundleEnum.globalComparativeAdvantageTradeAndConsumption,
      ),
    ],
  ),
  DiagramBundle(
    DiagramBundleEnum.globalComparativeAdvantageTradeAndConsumptionMixed,
    [
      ComparativeAdvantage(
        config,
        DiagramBundleEnum.globalComparativeAdvantageTradeAndConsumptionMixed,
      ),
    ],
  ),

  /// 4.2 Types of Trade Protection
  DiagramBundle(DiagramBundleEnum.globalTariff, [
    Tariff(config, DiagramBundleEnum.globalTariff),
  ]),
  DiagramBundle(DiagramBundleEnum.globalTariffWelfare, [
    Tariff(config, DiagramBundleEnum.globalTariffWelfare),
  ]),
  DiagramBundle(DiagramBundleEnum.globalTariffConsumerSurplusChange, [
    Tariff(config, DiagramBundleEnum.globalTariffConsumerSurplusChange),
  ]),
  DiagramBundle(DiagramBundleEnum.globalTariffProducerSurplusChange, [
    Tariff(config, DiagramBundleEnum.globalTariffProducerSurplusChange),
  ]),
  DiagramBundle(DiagramBundleEnum.globalTariffGovernmentRevenue, [
    Tariff(config, DiagramBundleEnum.globalTariffGovernmentRevenue),
  ]),
  DiagramBundle(DiagramBundleEnum.globalTariffWelfareLoss, [
    Tariff(config, DiagramBundleEnum.globalTariffWelfareLoss),
  ]),

  /// Import Quota
  DiagramBundle(DiagramBundleEnum.globalImportQuota, [
    ImportQuota(config, DiagramBundleEnum.globalImportQuota),
  ]),
  DiagramBundle(DiagramBundleEnum.globalImportQuotaWelfare, [
    ImportQuota(config, DiagramBundleEnum.globalImportQuotaWelfare),
  ]),
  DiagramBundle(DiagramBundleEnum.globalImportQuotaConsumerSurplusChange, [
    ImportQuota(
      config,
      DiagramBundleEnum.globalImportQuotaConsumerSurplusChange,
    ),
  ]),
  DiagramBundle(DiagramBundleEnum.globalImportQuotaProducerSurplusChange, [
    ImportQuota(
      config,
      DiagramBundleEnum.globalImportQuotaProducerSurplusChange,
    ),
  ]),
  DiagramBundle(DiagramBundleEnum.globalImportQuotaWelfareLoss, [
    ImportQuota(config, DiagramBundleEnum.globalImportQuotaWelfareLoss),
  ]),
  DiagramBundle(DiagramBundleEnum.globalProductionSubsidy, [
    ProductionSubsidy(config, DiagramBundleEnum.globalProductionSubsidy),
  ]),
  DiagramBundle(DiagramBundleEnum.globalProductionSubsidyWelfare, [
    ProductionSubsidy(config, DiagramBundleEnum.globalProductionSubsidyWelfare),
  ]),
  DiagramBundle(DiagramBundleEnum.globalProductionSubsidyConsumerSurplus, [
    ProductionSubsidy(
      config,
      DiagramBundleEnum.globalProductionSubsidyConsumerSurplus,
    ),
  ]),
  DiagramBundle(DiagramBundleEnum.globalProductionSubsidyProducerSurplus, [
    ProductionSubsidy(
      config,
      DiagramBundleEnum.globalProductionSubsidyProducerSurplus,
    ),
  ]),
  DiagramBundle(DiagramBundleEnum.globalProductionSubsidyWelfareLoss, [
    ProductionSubsidy(
      config,
      DiagramBundleEnum.globalProductionSubsidyWelfareLoss,
    ),
  ]),
  DiagramBundle(
    DiagramBundleEnum.globalProductionSubsidyProducerSurplusChange,
    [
      ProductionSubsidy(
        config,
        DiagramBundleEnum.globalProductionSubsidyProducerSurplusChange,
        legendDisplay: LegendDisplay.letters,
      ),
    ],
  ),
];
