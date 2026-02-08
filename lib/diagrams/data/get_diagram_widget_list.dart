import 'package:economics_app/diagrams/custom_paint/diagrams/ad_as_diagram.dart';
import 'package:economics_app/diagrams/custom_paint/diagrams/biz_cycle_diagram.dart';
import 'package:economics_app/diagrams/custom_paint/diagrams/circular_flow_diagram.dart';
import 'package:economics_app/diagrams/custom_paint/diagrams/comparative_advantage.dart';
import 'package:economics_app/diagrams/custom_paint/diagrams/competitive_market.dart';
import 'package:economics_app/diagrams/custom_paint/diagrams/exchange_rate_diagram.dart';
import 'package:economics_app/diagrams/custom_paint/diagrams/lorenz_curve_diagram.dart';
import 'package:economics_app/diagrams/custom_paint/diagrams/market_power.dart';
import 'package:economics_app/diagrams/custom_paint/diagrams/money_market_diagram.dart';
import 'package:economics_app/diagrams/custom_paint/diagrams/poverty_cycle_diagram.dart';
import 'package:economics_app/diagrams/custom_paint/diagrams/ppc_diagram.dart';
import 'package:economics_app/diagrams/custom_paint/diagrams/price_controls.dart';
import '../custom_paint/diagrams/demand_diagram.dart';
import '../custom_paint/diagrams/elasticities.dart';
import '../custom_paint/diagrams/externalities.dart';
import '../custom_paint/diagrams/global_trade_diagram.dart';
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
      ADASDiagram(c, DiagramEnum.macroADASClassicalDeflationaryGapAdjustment),
    ]),
    DiagramWidget([
      ADASDiagram(c, DiagramEnum.macroADASClassicalInflationaryGapAdjustment),
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

    ///Inequality and Poverty
    DiagramWidget([
      LorenzCurveDiagram(c, DiagramEnum.macroLorenzCurveCalculation),
    ]),
    DiagramWidget([
      LorenzCurveDiagram(c, DiagramEnum.macroLorenzCurveImprovedEquality),
    ]),

    /// Money market
    DiagramWidget([MoneyMarketDiagram(c, DiagramEnum.macroMoneyMarket)]),
    DiagramWidget([
      MoneyMarketDiagram(
        c,
        DiagramEnum.macroMoneyMarketExpansionaryMonetaryPolicy,
      ),
      ADASDiagram(c, DiagramEnum.macroADASKeynesianExpansionaryPolicy),
    ]),
    DiagramWidget([
      MoneyMarketDiagram(
        c,
        DiagramEnum.macroMoneyMarketContractionaryMonetaryPolicy,
      ),
      ADASDiagram(c, DiagramEnum.macroADASKeynesianContractionaryPolicy),
    ]),
    DiagramWidget([ADASDiagram(c, DiagramEnum.macroADASKeynesianMultiplier)]),

    /// --- MONEY MARKET ---
    DiagramWidget([MoneyMarketDiagram(c, DiagramEnum.macroMoneyMarket)]),
    DiagramWidget([
      MoneyMarketDiagram(
        c,
        DiagramEnum.macroMoneyMarketExpansionaryMonetaryPolicy,
      ),
      ADASDiagram(c, DiagramEnum.macroADASKeynesianExpansionaryPolicy),
    ]),
    DiagramWidget([
      MoneyMarketDiagram(
        c,
        DiagramEnum.macroMoneyMarketContractionaryMonetaryPolicy,
      ),
      ADASDiagram(c, DiagramEnum.macroADASKeynesianContractionaryPolicy),
    ]),
    DiagramWidget([ADASDiagram(c, DiagramEnum.macroADASKeynesianMultiplier)]),

    /// --- GLOBAL TRADE ---

    /// Free Trade
    DiagramWidget([
      GlobalTradeDiagram(c, DiagramEnum.globalWorldPriceHigher),
      GlobalTradeDiagram(c, DiagramEnum.globalDomesticExporter),
    ]),
    DiagramWidget([
      GlobalTradeDiagram(c, DiagramEnum.globalWorldPriceLower),
      GlobalTradeDiagram(c, DiagramEnum.globalDomesticImporter),
    ]),
    DiagramWidget([
      ComparativeAdvantageDiagram(
        c,
        DiagramEnum.globalAbsoluteAdvantageDifferentGoods,
      ),
    ]),
    DiagramWidget([
      ComparativeAdvantageDiagram(c, DiagramEnum.globalComparativeAdvantage),
    ]),
    DiagramWidget([
      ComparativeAdvantageDiagram(c, DiagramEnum.globalNoComparativeAdvantage),
    ]),

    /// Trade Protectionism
    DiagramWidget([GlobalTradeDiagram(c, DiagramEnum.globalTariff)]),
    DiagramWidget([GlobalTradeDiagram(c, DiagramEnum.globalImportQuota)]),
    DiagramWidget([GlobalTradeDiagram(c, DiagramEnum.globalProductionSubsidy)]),
    DiagramWidget([GlobalTradeDiagram(c, DiagramEnum.globalExportSubsidy)]),

    /// Exchange Rates & BOP
    DiagramWidget([
      ExchangeRateDiagram(c, DiagramEnum.globalForeignExchangeRate),
    ]),
    DiagramWidget([
      ExchangeRateDiagram(c, DiagramEnum.globalUSDAppreciates),
      ExchangeRateDiagram(c, DiagramEnum.globalEuroDepreciates),
    ]),
    DiagramWidget([
      ExchangeRateDiagram(c, DiagramEnum.globalFloatingRateDemandIncrease),
    ]),
    DiagramWidget([
      ExchangeRateDiagram(c, DiagramEnum.globalFloatingRateDemandDecrease),
    ]),
    DiagramWidget([
      ExchangeRateDiagram(c, DiagramEnum.globalFloatingRateSupplyIncrease),
    ]),
    DiagramWidget([
      ExchangeRateDiagram(c, DiagramEnum.globalFloatingRateSupplyDecrease),
    ]),
    DiagramWidget([
      ExchangeRateDiagram(c, DiagramEnum.globalManagedRateRateDemandIncrease),
    ]),
    DiagramWidget([
      ExchangeRateDiagram(c, DiagramEnum.globalFixedRateDemandIncrease),
    ]),
    DiagramWidget([
      ExchangeRateDiagram(c, DiagramEnum.globalFixedRateDemandDecrease),
    ]),
    DiagramWidget([ExchangeRateDiagram(c, DiagramEnum.globalJCurveDeficit)]),
    DiagramWidget([ExchangeRateDiagram(c, DiagramEnum.globalJCurveSurplus)]),

    /// Economic Development
    DiagramWidget([PPCDiagram(c, DiagramEnum.globalPPCReallocation)]),
    DiagramWidget([PovertyCycleDiagram(c, DiagramEnum.globalPovertyCycle)]),
  ];
}
