import 'package:economics_app/diagrams/custom_paint/diagrams/comparative_advantage.dart';
import 'package:economics_app/diagrams/custom_paint/diagrams/import_quota.dart';
import 'package:economics_app/diagrams/custom_paint/diagrams/international_trade.dart';
import 'package:economics_app/diagrams/custom_paint/diagrams/production_subsidy.dart';
import 'package:economics_app/diagrams/custom_paint/diagrams/tariff.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/legend/legend_display.dart';

import '../custom_paint/diagrams/demand.dart';
import '../custom_paint/diagrams/supply.dart';
import '../enums/diagram_bundle_enum.dart';
import '../models/diagram_bundle.dart';
import '../models/diagram_painter_config.dart';

List<DiagramBundle> getBundleList(DiagramPainterConfig config) => [
  /// 1.1 PPC
  DiagramBundle(DiagramBundleEnum.microSupplyDeterminants, [
    Supply2(config, DiagramBundleEnum.microSupplyPriceChanges),
    Supply2(config, DiagramBundleEnum.microSupplyDeterminants),
  ]),

  /// 2.1 Demand
  DiagramBundle(DiagramBundleEnum.microDemandPriceChange, [
    Demand(config, DiagramBundleEnum.microDemandPriceChange),
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
