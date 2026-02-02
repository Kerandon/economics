import 'package:economics_app/diagrams/custom_paint/diagrams/ad_as_diagram.dart';
import 'package:economics_app/diagrams/custom_paint/diagrams/biz_cycle_diagram.dart';
import 'package:economics_app/diagrams/custom_paint/diagrams/circular_flow_diagram.dart';
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

List<DiagramWidget> getDiagramWidgetsListNEW(DiagramPainterConfig c) {
  return [
    /// Demand
    DiagramWidget([DemandDiagram(c, DiagramEnum.microDemand)]),
    DiagramWidget([DemandDiagram(c, DiagramEnum.microDemandExtension)]),
    DiagramWidget([DemandDiagram(c, DiagramEnum.microDemandContraction)]),
    DiagramWidget([
      DemandDiagram(c, DiagramEnum.microDemandQuantityChangeDueToSupply),
    ]),
    DiagramWidget([DemandDiagram(c, DiagramEnum.microDemandIncrease)]),
    DiagramWidget([DemandDiagram(c, DiagramEnum.microDemandDecrease)]),

    /// Supply
    DiagramWidget([Supply(c, DiagramEnum.microSupplyExtension)]),
    DiagramWidget([Supply(c, DiagramEnum.microSupplyContraction)]),
    DiagramWidget([Supply(c, DiagramEnum.microSupplyIncrease)]),
    DiagramWidget([Supply(c, DiagramEnum.microSupplyDecrease)]),

    /// Equilibrium & Surplus
    DiagramWidget([CompetitiveMarket(c, DiagramEnum.microMarketEquilibrium)]),
    DiagramWidget([CompetitiveMarket(c, DiagramEnum.microShortage)]),
    DiagramWidget([CompetitiveMarket(c, DiagramEnum.microSurplus)]),
    DiagramWidget([
      CompetitiveMarket(c, DiagramEnum.microDemandIncreasePriceMechanism),
    ]),
    DiagramWidget([
      CompetitiveMarket(c, DiagramEnum.microDemandDecreasePriceMechanism),
    ]),
    DiagramWidget([
      CompetitiveMarket(c, DiagramEnum.microAllocativeEfficiency),
    ]),
    DiagramWidget([Supply(c, DiagramEnum.microMarginalProduct)]),
    DiagramWidget([Supply(c, DiagramEnum.microTotalAndMarginalProduct)]),
    DiagramWidget([Supply(c, DiagramEnum.microMarginalCost)]),

    /// Elasticity
    DiagramWidget([Elasticities(c, DiagramEnum.microDemandElastic)]),
    DiagramWidget([Elasticities(c, DiagramEnum.microDemandInelastic)]),
    DiagramWidget([Elasticities(c, DiagramEnum.microDemandPerfectlyElastic)]),
    DiagramWidget([Elasticities(c, DiagramEnum.microDemandPerfectlyInelastic)]),
    DiagramWidget([Elasticities(c, DiagramEnum.microDemandEngelCurve)]),
    DiagramWidget([Elasticities(c, DiagramEnum.microSupplyElastic)]),
    DiagramWidget([Elasticities(c, DiagramEnum.microSupplyInelastic)]),
    DiagramWidget([Elasticities(c, DiagramEnum.microSupplyPrimaryCommodities)]),

    /// Price Controls
    DiagramWidget([PriceControls(c, DiagramEnum.microPriceCeiling)]),
    DiagramWidget([PriceControls(c, DiagramEnum.microMinimumWage)]),
    DiagramWidget([PriceControls(c, DiagramEnum.microAgriculturalPriceFloor)]),

    /// Intervention
    DiagramWidget([TaxesSubsidies(c, DiagramEnum.microIndirectTax)]),
    DiagramWidget([
      TaxesSubsidies(c, DiagramEnum.microIndirectTaxInelasticPED),
    ]),
    DiagramWidget([TaxesSubsidies(c, DiagramEnum.microSubsidyElasticPED)]),
    DiagramWidget([TaxesSubsidies(c, DiagramEnum.microSubsidy)]),
    DiagramWidget([TaxesSubsidies(c, DiagramEnum.microSubsidyElasticPED)]),
    DiagramWidget([TaxesSubsidies(c, DiagramEnum.microSubsidyInelasticPED)]),

    /// Externalities
    DiagramWidget([
      Externalities(c, DiagramEnum.microNegativeProductionExternality),
    ]),
    DiagramWidget([
      Externalities(c, DiagramEnum.microNegativeConsumptionExternality),
    ]),
    DiagramWidget([
      Externalities(c, DiagramEnum.microPositiveProductionExternality),
    ]),
    DiagramWidget([
      Externalities(c, DiagramEnum.microPositiveConsumptionExternality),
    ]),
    DiagramWidget([Externalities(c, DiagramEnum.microCarbonTax)]),
    DiagramWidget([
      Externalities(c, DiagramEnum.microTradablePollutionPermits),
    ]),

    /// Public Goods
    DiagramWidget([PublicGoods(c, DiagramEnum.microPublicGoods)]),

    /// ============================================================
    /// PERFECT COMPETITION PAIRINGS (Displayed Together)
    /// ============================================================
    DiagramWidget([
      MarketPower(c, DiagramEnum.microPerfectCompetitionMarketLongRun),
      MarketPower(c, DiagramEnum.microPerfectCompetitionFirmLongRun),
    ]),
    DiagramWidget([
      MarketPower(c, DiagramEnum.microPerfectCompetitionMarketAbnormalProfit),
      MarketPower(
        c,
        DiagramEnum.microPerfectCompetitionFirmAbnormalProfitAdjustment,
      ),
    ]),
    DiagramWidget([
      MarketPower(c, DiagramEnum.microPerfectCompetitionMarketLoss),
      MarketPower(c, DiagramEnum.microPerfectCompetitionFirmLoss),
    ]),

    /// ============================================================
    /// MONOPOLY & OTHERS (Back to individual elements)
    /// ============================================================
    DiagramWidget([MarketPower(c, DiagramEnum.microMonopolyAbnormalProfit)]),
    DiagramWidget([MarketPower(c, DiagramEnum.microMonopolyWelfare)]),
    DiagramWidget([MarketPower(c, DiagramEnum.microMonopolyNatural)]),
    DiagramWidget([
      MarketPower(c, DiagramEnum.microMonopolyNaturalAverageCostPricingWelfare),
    ]),
    DiagramWidget([
      MarketPower(c, DiagramEnum.microMonopolyNaturalMarginalCostPricing),
    ]),
    DiagramWidget([
      MarketPower(
        c,
        DiagramEnum.microMonopolyNaturalMarginalCostPricingWelfare,
      ),
    ]),
    DiagramWidget([
      MarketPower(c, DiagramEnum.microOligopolyKinkedDemandCurve),
    ]),
    DiagramWidget([
      MarketPower(c, DiagramEnum.microMonopolisticCompetitionLongRun),
    ]),
    DiagramWidget([
      MarketPower(c, DiagramEnum.microMonopolisticCompetitionAbnormalProfit),
    ]),

    /// Circular Flow
    DiagramWidget([
      CircularFlowDiagram(c, DiagramEnum.macroCircularFlowClosed),
    ]),
    DiagramWidget([CircularFlowDiagram(c, DiagramEnum.macroCircularFlowOpen)]),

    ///Biz cycle
    DiagramWidget([BizDiagram(c, DiagramEnum.macroBusinessCycle)]),

    /// AD-AS
    DiagramWidget([
      ADASDiagram(c, DiagramEnum.macroADASClassicalFullEmployment),
    ]),
    DiagramWidget([
      ADASDiagram(c, DiagramEnum.macroADASClassicalDeflationaryGap),
    ]),
    DiagramWidget([
      ADASDiagram(c, DiagramEnum.macroADASClassicalInflationaryGap),
    ]),
    DiagramWidget([
      ADASDiagram(c, DiagramEnum.macroADASKeynesianFullEmployment),
    ]),
    DiagramWidget([
      ADASDiagram(c, DiagramEnum.macroADASKeynesianDeflationaryGap),
    ]),
    DiagramWidget([
      ADASDiagram(c, DiagramEnum.macroADASKeynesianInflationaryGap),
    ]),
    DiagramWidget([
      ADASDiagram(c, DiagramEnum.macroADASClassicalLongTermGrowth),
    ]),
    DiagramWidget([
      ADASDiagram(c, DiagramEnum.macroADASKeynesianLongTermGrowth),
    ]),
    DiagramWidget([ADASDiagram(c, DiagramEnum.macroADASCostPushInflation)]),
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
