import 'package:economics_app/diagrams/custom_paint/diagrams/ad_as_diagram.dart';
import 'package:economics_app/diagrams/custom_paint/diagrams/competitive_market.dart';
import 'package:economics_app/diagrams/custom_paint/diagrams/market_power.dart';
import 'package:economics_app/diagrams/custom_paint/diagrams/price_controls.dart';
import '../custom_paint/diagrams/demand_diagram.dart';
import '../custom_paint/diagrams/elasticities.dart';
import '../custom_paint/diagrams/externalities.dart';
import '../custom_paint/diagrams/public_goods.dart';
import '../custom_paint/diagrams/supply.dart';
import '../custom_paint/diagrams/taxes_subsidies.dart';
import '../enums/diagram_enum.dart';
import '../models/base_painter_painter.dart';
import '../models/diagram_widget.dart';
import '../models/diagram_painter_config.dart';

List<DiagramWidgetNEW> getDiagramWidgetsListNEW(DiagramPainterConfig c) {
  return [
    /// Demand
    DiagramWidgetNEW([DemandDiagram(c, DiagramEnum.microDemand)]),
    DiagramWidgetNEW([DemandDiagram(c, DiagramEnum.microDemandExtension)]),
    DiagramWidgetNEW([DemandDiagram(c, DiagramEnum.microDemandContraction)]),
    DiagramWidgetNEW([
      DemandDiagram(c, DiagramEnum.microDemandQuantityChangeDueToSupply),
    ]),
    DiagramWidgetNEW([DemandDiagram(c, DiagramEnum.microDemandIncrease)]),
    DiagramWidgetNEW([DemandDiagram(c, DiagramEnum.microDemandDecrease)]),

    /// Supply
    DiagramWidgetNEW([Supply(c, DiagramEnum.microSupplyExtension)]),
    DiagramWidgetNEW([Supply(c, DiagramEnum.microSupplyContraction)]),
    DiagramWidgetNEW([Supply(c, DiagramEnum.microSupplyIncrease)]),
    DiagramWidgetNEW([Supply(c, DiagramEnum.microSupplyDecrease)]),

    /// Equilibrium & Surplus
    DiagramWidgetNEW([
      CompetitiveMarket(c, DiagramEnum.microMarketEquilibrium),
    ]),
    DiagramWidgetNEW([CompetitiveMarket(c, DiagramEnum.microShortage)]),
    DiagramWidgetNEW([CompetitiveMarket(c, DiagramEnum.microSurplus)]),
    DiagramWidgetNEW([
      CompetitiveMarket(c, DiagramEnum.microDemandIncreasePriceMechanism),
    ]),
    DiagramWidgetNEW([
      CompetitiveMarket(c, DiagramEnum.microDemandDecreasePriceMechanism),
    ]),
    DiagramWidgetNEW([
      CompetitiveMarket(c, DiagramEnum.microAllocativeEfficiency),
    ]),
    DiagramWidgetNEW([Supply(c, DiagramEnum.microMarginalProduct)]),
    DiagramWidgetNEW([Supply(c, DiagramEnum.microTotalAndMarginalProduct)]),
    DiagramWidgetNEW([Supply(c, DiagramEnum.microMarginalCost)]),

    /// Elasticity
    DiagramWidgetNEW([Elasticities(c, DiagramEnum.microDemandElastic)]),
    DiagramWidgetNEW([Elasticities(c, DiagramEnum.microDemandInelastic)]),
    DiagramWidgetNEW([
      Elasticities(c, DiagramEnum.microDemandPerfectlyElastic),
    ]),
    DiagramWidgetNEW([
      Elasticities(c, DiagramEnum.microDemandPerfectlyInelastic),
    ]),
    DiagramWidgetNEW([Elasticities(c, DiagramEnum.microDemandEngelCurve)]),
    DiagramWidgetNEW([Elasticities(c, DiagramEnum.microSupplyElastic)]),
    DiagramWidgetNEW([Elasticities(c, DiagramEnum.microSupplyInelastic)]),
    DiagramWidgetNEW([
      Elasticities(c, DiagramEnum.microSupplyPrimaryCommodities),
    ]),

    /// Price Controls
    DiagramWidgetNEW([PriceControls(c, DiagramEnum.microPriceCeiling)]),
    DiagramWidgetNEW([PriceControls(c, DiagramEnum.microMinimumWage)]),
    DiagramWidgetNEW([
      PriceControls(c, DiagramEnum.microAgriculturalPriceFloor),
    ]),

    /// Intervention
    DiagramWidgetNEW([TaxesSubsidies(c, DiagramEnum.microIndirectTax)]),
    DiagramWidgetNEW([
      TaxesSubsidies(c, DiagramEnum.microIndirectTaxInelasticPED),
    ]),
    DiagramWidgetNEW([TaxesSubsidies(c, DiagramEnum.microSubsidyElasticPED)]),
    DiagramWidgetNEW([TaxesSubsidies(c, DiagramEnum.microSubsidy)]),
    DiagramWidgetNEW([TaxesSubsidies(c, DiagramEnum.microSubsidyElasticPED)]),
    DiagramWidgetNEW([TaxesSubsidies(c, DiagramEnum.microSubsidyInelasticPED)]),

    /// Externalities
    DiagramWidgetNEW([
      Externalities(c, DiagramEnum.microNegativeProductionExternality),
    ]),
    DiagramWidgetNEW([
      Externalities(c, DiagramEnum.microNegativeConsumptionExternality),
    ]),
    DiagramWidgetNEW([
      Externalities(c, DiagramEnum.microPositiveProductionExternality),
    ]),
    DiagramWidgetNEW([
      Externalities(c, DiagramEnum.microPositiveConsumptionExternality),
    ]),
    DiagramWidgetNEW([Externalities(c, DiagramEnum.microCarbonTax)]),
    DiagramWidgetNEW([
      Externalities(c, DiagramEnum.microTradablePollutionPermits),
    ]),

    /// Public Goods
    DiagramWidgetNEW([PublicGoods(c, DiagramEnum.microPublicGoods)]),

    /// ============================================================
    /// PERFECT COMPETITION PAIRINGS (Displayed Together)
    /// ============================================================
    DiagramWidgetNEW([
      MarketPower(c, DiagramEnum.microPerfectCompetitionMarketLongRun),
      MarketPower(c, DiagramEnum.microPerfectCompetitionFirmLongRun),
    ]),
    DiagramWidgetNEW([
      MarketPower(c, DiagramEnum.microPerfectCompetitionMarketAbnormalProfit),
      MarketPower(
        c,
        DiagramEnum.microPerfectCompetitionFirmAbnormalProfitAdjustment,
      ),
    ]),
    DiagramWidgetNEW([
      MarketPower(c, DiagramEnum.microPerfectCompetitionMarketLoss),
      MarketPower(c, DiagramEnum.microPerfectCompetitionFirmLoss),
    ]),

    /// ============================================================
    /// MONOPOLY & OTHERS (Back to individual elements)
    /// ============================================================
    DiagramWidgetNEW([MarketPower(c, DiagramEnum.microMonopolyAbnormalProfit)]),
    DiagramWidgetNEW([MarketPower(c, DiagramEnum.microMonopolyWelfare)]),
    DiagramWidgetNEW([MarketPower(c, DiagramEnum.microMonopolyNatural)]),
    DiagramWidgetNEW([
      MarketPower(c, DiagramEnum.microMonopolyNaturalAverageCostPricingWelfare),
    ]),
    DiagramWidgetNEW([
      MarketPower(c, DiagramEnum.microMonopolyNaturalMarginalCostPricing),
    ]),
    DiagramWidgetNEW([
      MarketPower(
        c,
        DiagramEnum.microMonopolyNaturalMarginalCostPricingWelfare,
      ),
    ]),
    DiagramWidgetNEW([
      MarketPower(c, DiagramEnum.microOligopolyKinkedDemandCurve),
    ]),
    DiagramWidgetNEW([
      MarketPower(c, DiagramEnum.microMonopolisticCompetitionLongRun),
    ]),
    DiagramWidgetNEW([
      MarketPower(c, DiagramEnum.microMonopolisticCompetitionAbnormalProfit),
    ]),

    /// AD-AS
    DiagramWidgetNEW([
      ADASDiagram(c, DiagramEnum.macroADASClassicalFullEmployment),
    ]),
    DiagramWidgetNEW([
      ADASDiagram(c, DiagramEnum.macroADASClassicalDeflationaryGap),
    ]),
    DiagramWidgetNEW([
      ADASDiagram(c, DiagramEnum.macroADASClassicalInflationaryGap),
    ]),
    DiagramWidgetNEW([
      ADASDiagram(c, DiagramEnum.macroADASKeynesianFullEmployment),
    ]),
    DiagramWidgetNEW([
      ADASDiagram(c, DiagramEnum.macroADASKeynesianDeflationaryGap),
    ]),
    DiagramWidgetNEW([
      ADASDiagram(c, DiagramEnum.macroADASKeynesianFullEmployment),
    ]),
    DiagramWidgetNEW([
      ADASDiagram(c, DiagramEnum.macroADASKeynesianInflationaryGap),
    ]),
  ];
}

//
// List<DiagramWidget> getDiagramWidgetList(DiagramPainterConfig c) {
//   return [
//     /// Demand
//     DiagramWidgetNEW(DemandDiagram(c, DiagramEnum.microDemand)),
//     DiagramWidget(DemandDiagram(c, DiagramEnum.microDemandExtension)),
//     DiagramWidget(DemandDiagram(c, DiagramEnum.microDemandContraction)),
//     DiagramWidget(
//       DemandDiagram(c, DiagramEnum.microDemandQuantityChangeDueToSupply),
//     ),
//     DiagramWidget(DemandDiagram(c, DiagramEnum.microDemandIncrease)),
//     DiagramWidget(DemandDiagram(c, DiagramEnum.microDemandDecrease)),
//
//     /// Market Power
//     DiagramWidget(
//       MarketPower(c, DiagramEnum.microPerfectCompetitionMarketLongRun),
//     ),
//     DiagramWidget(
//       MarketPower(c, DiagramEnum.microPerfectCompetitionFirmLongRun),
//     ),
//     DiagramWidget(
//       MarketPower(c, DiagramEnum.microPerfectCompetitionMarketAbnormalProfit),
//     ),
//     DiagramWidget(
//       MarketPower(
//         c,
//         DiagramEnum.microPerfectCompetitionFirmAbnormalProfitAdjustment,
//       ),
//     ),
//     DiagramWidget(
//       MarketPower(c, DiagramEnum.microPerfectCompetitionMarketLoss),
//     ),
//     DiagramWidget(MarketPower(c, DiagramEnum.microPerfectCompetitionFirmLoss)),
//     DiagramWidget(
//       MarketPower(c, DiagramEnum.microPerfectCompetitionShutdownPoint),
//     ),
//     DiagramWidget(
//       MarketPower(
//         c,
//         DiagramEnum.microPerfectCompetitionNormalProfitRevenueCostsCalculation,
//       ),
//     ),
//     DiagramWidget(
//       MarketPower(
//         c,
//         DiagramEnum
//             .microPerfectCompetitionAbnormalProfitRevenueCostsCalculation,
//       ),
//     ),
//     DiagramWidget(
//       MarketPower(
//         c,
//         DiagramEnum.microPerfectCompetitionShutdownLossCalculation,
//       ),
//     ),
//     DiagramWidget(MarketPower(c, DiagramEnum.microMonopolyAbnormalProfit)),
//     DiagramWidget(
//       MarketPower(c, DiagramEnum.microMonopolyAbnormalProfitAndCosts),
//     ),
//     DiagramWidget(MarketPower(c, DiagramEnum.microMonopolyWelfare)),
//     DiagramWidget(
//       MarketPower(c, DiagramEnum.microMonopolyWelfareAllocativelyEfficient),
//     ),
//     DiagramWidget(MarketPower(c, DiagramEnum.microMonopolyNatural)),
//     DiagramWidget(
//       MarketPower(c, DiagramEnum.microMonopolyNaturalUnregulatedWelfare),
//     ),
//     DiagramWidget(
//       MarketPower(c, DiagramEnum.microMonopolyNaturalPricingComparisons),
//     ),
//     DiagramWidget(
//       MarketPower(c, DiagramEnum.microMonopolyNaturalAverageCostPricingWelfare),
//     ),
//     DiagramWidget(
//       MarketPower(c, DiagramEnum.microMonopolyNaturalMarginalCostPricing),
//     ),
//     DiagramWidget(
//       MarketPower(
//         c,
//         DiagramEnum.microMonopolyNaturalMarginalCostPricingWelfare,
//       ),
//     ),
//     DiagramWidget(MarketPower(c, DiagramEnum.microOligopolyKinkedDemandCurve)),
//     DiagramWidget(
//       MarketPower(c, DiagramEnum.microMonopolisticCompetitionAbnormalProfit),
//     ),
//     DiagramWidget(MarketPower(c, DiagramEnum.microMonopolisticCompetitionLoss)),
//     DiagramWidget(
//       MarketPower(
//         c,
//         DiagramEnum.microMonopolisticCompetitionAbnormalProfitShift,
//       ),
//     ),
//     DiagramWidget(
//       MarketPower(c, DiagramEnum.microMonopolisticCompetitionLossShift),
//     ),
//     DiagramWidget(
//       MarketPower(c, DiagramEnum.microMonopolisticCompetitionLongRun),
//     ),
//   ];
// }
