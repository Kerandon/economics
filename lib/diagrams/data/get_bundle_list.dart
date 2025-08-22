import 'package:economics_app/diagrams/custom_paint/diagrams/import_quota.dart';
import 'package:economics_app/diagrams/custom_paint/diagrams/international_trade.dart';
import 'package:economics_app/diagrams/custom_paint/diagrams/production_subsidy.dart';
import 'package:economics_app/diagrams/custom_paint/diagrams/tariff.dart';

import '../custom_paint/diagrams/demand.dart';
import '../custom_paint/diagrams/supply.dart';
import '../enums/diagram_bundle_enum.dart';
import '../models/diagram_bundle.dart';
import '../models/diagram_painter_config.dart';

List<DiagramBundle> getBundleList(DiagramPainterConfig config) => [
  /// 1.1 PPC
  DiagramBundle(
    diagramBundleEnum: DiagramBundleEnum.microSupplyDeterminants,
    basePainterDiagrams: [
      Supply2(config, DiagramBundleEnum.microSupplyPriceChanges),
      Supply2(config, DiagramBundleEnum.microSupplyDeterminants),
    ],
  ),

  /// 2.1 Demand
  DiagramBundle(
    diagramBundleEnum: DiagramBundleEnum.microDemandPriceChange,
    basePainterDiagrams: [
      Demand(config, DiagramBundleEnum.microDemandPriceChange),
    ],
  ),

  /// 4.1 Benefits of International Trade
  DiagramBundle(
    diagramBundleEnum: DiagramBundleEnum.globalWorldPriceStandAlone,
    basePainterDiagrams: [
      InternationalTrade(config, DiagramBundleEnum.globalWorldPriceStandAlone),
    ],
  ),
  DiagramBundle(
    diagramBundleEnum: DiagramBundleEnum.globalNetImporter,
    basePainterDiagrams: [
      InternationalTrade(config, DiagramBundleEnum.globalWorldPrice),
      InternationalTrade(config, DiagramBundleEnum.globalNetImporter),
    ],
  ),
  DiagramBundle(
    diagramBundleEnum: DiagramBundleEnum.globalNetExporter,
    basePainterDiagrams: [
      InternationalTrade(config, DiagramBundleEnum.globalWorldPrice),
      InternationalTrade(config, DiagramBundleEnum.globalNetExporter),
    ],
  ),

  /// 4.2 Types of Trade Protection
  DiagramBundle(
    diagramBundleEnum: DiagramBundleEnum.globalTariff,
    basePainterDiagrams: [Tariff(config, DiagramBundleEnum.globalTariff)],
  ),
  DiagramBundle(
    diagramBundleEnum: DiagramBundleEnum.globalTariffWelfare,
    basePainterDiagrams: [
      Tariff(config, DiagramBundleEnum.globalTariffWelfare),
    ],
  ),
  DiagramBundle(
    diagramBundleEnum: DiagramBundleEnum.globalTariffConsumerSurplusChange,
    basePainterDiagrams: [
      Tariff(config, DiagramBundleEnum.globalTariffConsumerSurplusChange),
    ],
  ),
  DiagramBundle(
    diagramBundleEnum: DiagramBundleEnum.globalTariffProducerSurplusChange,
    basePainterDiagrams: [
      Tariff(config, DiagramBundleEnum.globalTariffProducerSurplusChange),
    ],
  ),
  DiagramBundle(
    diagramBundleEnum: DiagramBundleEnum.globalTariffGovernmentRevenue,
    basePainterDiagrams: [
      Tariff(config, DiagramBundleEnum.globalTariffGovernmentRevenue),
    ],
  ),
  DiagramBundle(
    diagramBundleEnum: DiagramBundleEnum.globalTariffWelfareLoss,
    basePainterDiagrams: [
      Tariff(config, DiagramBundleEnum.globalTariffWelfareLoss),
    ],
  ),

  /// Import Quota
  DiagramBundle(
    diagramBundleEnum: DiagramBundleEnum.globalImportQuota,
    basePainterDiagrams: [
      ImportQuota(config, DiagramBundleEnum.globalImportQuota),
    ],
  ),
  DiagramBundle(
    diagramBundleEnum: DiagramBundleEnum.globalImportQuotaWelfare,
    basePainterDiagrams: [
      ImportQuota(config, DiagramBundleEnum.globalImportQuotaWelfare),
    ],
  ),
  DiagramBundle(
    diagramBundleEnum: DiagramBundleEnum.globalImportQuotaConsumerSurplusChange,
    basePainterDiagrams: [
      ImportQuota(config, DiagramBundleEnum.globalImportQuotaConsumerSurplusChange),
    ],
  ),
  DiagramBundle(
    diagramBundleEnum: DiagramBundleEnum.globalImportQuotaProducerSurplusChange,
    basePainterDiagrams: [
      ImportQuota(config, DiagramBundleEnum.globalImportQuotaProducerSurplusChange),
    ],
  ),
  DiagramBundle(
    diagramBundleEnum: DiagramBundleEnum.globalImportQuotaWelfareLoss,
    basePainterDiagrams: [
      ImportQuota(config, DiagramBundleEnum.globalImportQuotaWelfareLoss),
    ],
  ),
  DiagramBundle(
    diagramBundleEnum: DiagramBundleEnum.globalProductionSubsidy,
    basePainterDiagrams: [
      ProductionSubsidy(config, DiagramBundleEnum.globalProductionSubsidy,),
    ],
  ),
  DiagramBundle(
    diagramBundleEnum: DiagramBundleEnum.globalProductionSubsidyWelfare,
    basePainterDiagrams: [
      ProductionSubsidy(config, DiagramBundleEnum.globalProductionSubsidyWelfare,),
    ],
  ),
  DiagramBundle(
    diagramBundleEnum: DiagramBundleEnum.globalProductionSubsidyConsumerSurplus,
    basePainterDiagrams: [
      ProductionSubsidy(config, DiagramBundleEnum.globalProductionSubsidyConsumerSurplus,),
    ],
  ),
  DiagramBundle(
    diagramBundleEnum: DiagramBundleEnum.globalProductionSubsidyProducerSurplus,
    basePainterDiagrams: [
      ProductionSubsidy(config, DiagramBundleEnum.globalProductionSubsidyProducerSurplus,),
    ],
  ),
  DiagramBundle(
    diagramBundleEnum: DiagramBundleEnum.globalProductionSubsidyWelfareLoss,
    basePainterDiagrams: [
      ProductionSubsidy(config,  DiagramBundleEnum.globalProductionSubsidyWelfareLoss,),
    ],
  ),
];
