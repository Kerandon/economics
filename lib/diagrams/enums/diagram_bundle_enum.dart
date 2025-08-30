import '../custom_paint/painter_methods/legend/legend_display.dart';

enum DiagramBundleEnum {
  microPPCConstantOppCost,
  microPPCIncreaseOppCost,
  microDemandPriceChange,
  microDemandIndividual1,
  microDemandIndividual2,
  microDemandMarket,
  microDemandIndividualVsMarket,
  microDemandDeterminants,
  microSupplyPriceChanges,
  microSupplyDeterminants,
  globalWorldPrice,
  globalWorldPriceStandAlone,
  globalNetExporter,
  globalNetImporter,
  globalAbsoluteAdvantageDifferentGoods,
  globalAbsoluteAdvantageBothGoods,
  globalComparativeAdvantage,
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
