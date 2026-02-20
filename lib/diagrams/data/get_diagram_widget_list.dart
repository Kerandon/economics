import 'package:economics_app/diagrams/custom_paint/diagrams/ad_as_diagram.dart';
import 'package:economics_app/diagrams/custom_paint/diagrams/biz_cycle_diagram.dart';
import 'package:economics_app/diagrams/custom_paint/diagrams/circular_flow_diagram.dart';
import 'package:economics_app/diagrams/custom_paint/diagrams/comparative_advantage.dart';
import 'package:economics_app/diagrams/custom_paint/diagrams/competitive_market.dart';
import 'package:economics_app/diagrams/custom_paint/diagrams/exchange_rate_diagram.dart';
import 'package:economics_app/diagrams/custom_paint/diagrams/j_curve_diagram.dart';
import 'package:economics_app/diagrams/custom_paint/diagrams/lorenz_curve_diagram.dart';
import 'package:economics_app/diagrams/custom_paint/diagrams/market_power.dart';
import 'package:economics_app/diagrams/custom_paint/diagrams/money_market_diagram.dart';
import 'package:economics_app/diagrams/custom_paint/diagrams/phillips_curve_diagram.dart';
import 'package:economics_app/diagrams/custom_paint/diagrams/poverty_cycle_diagram.dart';
import 'package:economics_app/diagrams/custom_paint/diagrams/ppc_diagram.dart';
import 'package:economics_app/diagrams/custom_paint/diagrams/price_controls.dart';
import 'package:economics_app/diagrams/custom_paint/diagrams/unemployment_diagram.dart';
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
    DiagramWidget([SupplyDiagram(c, DiagramEnum.microSupplyExtension)]),
    DiagramWidget([SupplyDiagram(c, DiagramEnum.microSupplyContraction)]),
    DiagramWidget([SupplyDiagram(c, DiagramEnum.microSupplyIncrease)]),
    DiagramWidget([SupplyDiagram(c, DiagramEnum.microSupplyDecrease)]),
    DiagramWidget([SupplyDiagram(c, DiagramEnum.microTotalAndMarginalProduct)]),
    DiagramWidget(
      title: 'Marginal Product and Marginal Cost',
      description:
          'Marginal cost (MC) is inversely related to marginal product (MP), given by MC = W / MP, where W is the wage rate. As diminishing marginal returns set in, MP declines, increasing the marginal cost of each additional unit of output.',
      [
        SupplyDiagram(c, DiagramEnum.microMarginalProduct),
        SupplyDiagram(c, DiagramEnum.microMarginalCost),
      ],
    ),

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

    /// Elasticity
    DiagramWidget([Elasticities(c, DiagramEnum.microDemandElastic)]),
    DiagramWidget([Elasticities(c, DiagramEnum.microDemandInelastic)]),
    DiagramWidget([Elasticities(c, DiagramEnum.microDemandPerfectlyElastic)]),
    DiagramWidget([Elasticities(c, DiagramEnum.microDemandPerfectlyInelastic)]),
    DiagramWidget([
      Elasticities(c, DiagramEnum.microDemandElasticityRevenueChange),
      Elasticities(c, DiagramEnum.microDemandElasticityChange),
    ]),
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
      TaxesSubsidies(c, DiagramEnum.microIndirectTaxInelasticDemand),
    ]),
    DiagramWidget([TaxesSubsidies(c, DiagramEnum.microSubsidyElasticDemand)]),
    DiagramWidget([TaxesSubsidies(c, DiagramEnum.microSubsidy)]),
    DiagramWidget([TaxesSubsidies(c, DiagramEnum.microSubsidyElasticDemand)]),
    DiagramWidget([TaxesSubsidies(c, DiagramEnum.microSubsidyInelasticDemand)]),

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
    DiagramWidget(
      title: 'Perfect Competition - Long Run Equilibrium',
      description:
          'In the long-run a firm in perfect competition can only make normal profit (TR - TC = 0).',
      [
        MarketPower(c, DiagramEnum.microPerfectCompetitionMarketLongRun),
        MarketPower(c, DiagramEnum.microPerfectCompetitionFirmLongRun),
      ],
    ),
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
    DiagramWidget([ADASDiagram(c, DiagramEnum.macroClassicalFullEmployment)]),
    DiagramWidget([ADASDiagram(c, DiagramEnum.macroClassicalDeflationaryGap)]),
    DiagramWidget([ADASDiagram(c, DiagramEnum.macroClassicalInflationaryGap)]),
    DiagramWidget([
      ADASDiagram(c, DiagramEnum.macroClassicalDeflationaryGapAdjustment),
    ]),
    DiagramWidget([
      ADASDiagram(c, DiagramEnum.macroClassicalInflationaryGapAdjustment),
    ]),
    DiagramWidget([
      ADASDiagram(c, DiagramEnum.macroADASKeynesianFullEmployment),
    ]),
    DiagramWidget([ADASDiagram(c, DiagramEnum.macroKeynesianDeflationaryGap)]),
    DiagramWidget([ADASDiagram(c, DiagramEnum.macroKeynesianInflationaryGap)]),

    /// Economic growth
    DiagramWidget([
      ADASDiagram(c, DiagramEnum.macroClassicalLongTermGrowth),
      ADASDiagram(c, DiagramEnum.macroKeynesianLongTermGrowth),
    ]),
    DiagramWidget([PPCDiagram(c, DiagramEnum.globalPPCEconomicGrowth)]),

    /// Inflation
    DiagramWidget([
      ADASDiagram(c, DiagramEnum.macroClassicalDemandPullInflation),
      ADASDiagram(c, DiagramEnum.macroKeynesianDemandPullInflation),
    ]),
    DiagramWidget([ADASDiagram(c, DiagramEnum.macroADASCostPushInflation)]),

    /// Unemployment
    DiagramWidget([
      UnemploymentDiagram(c, DiagramEnum.macroUnemploymentStructural),
    ]),
    DiagramWidget([
      UnemploymentDiagram(
        c,
        DiagramEnum.macroUnemploymentLaborMarketRigidities,
      ),
    ]),
    DiagramWidget([
      UnemploymentDiagram(c, DiagramEnum.macroUnemploymentNationalMinimumWage),
    ]),
    DiagramWidget([
      UnemploymentDiagram(c, DiagramEnum.macroUnemploymentEfficiencyWages),
    ]),

    DiagramWidget([
      UnemploymentDiagram(c, DiagramEnum.macroNaturalRateOfUnemployment),
    ]),

    /// Philips Curve
    DiagramWidget([PhillipsCurveDiagram(c, DiagramEnum.macroSRPCAndLRPC)]),
    DiagramWidget([
      PhillipsCurveDiagram(c, DiagramEnum.macroPhillipsCurveStagflation),
      ADASDiagram(c, DiagramEnum.macroADASCostPushInflation),
    ]),
    DiagramWidget([
      PhillipsCurveDiagram(c, DiagramEnum.macroSRPCInflationaryGapAdjustment),
      ADASDiagram(c, DiagramEnum.macroClassicalInflationaryGapAdjustment),
    ]),
    DiagramWidget([
      PhillipsCurveDiagram(c, DiagramEnum.macroSRPCDeflationaryGapAdjustment),
      ADASDiagram(c, DiagramEnum.macroClassicalDeflationaryGapAdjustment),
    ]),
    DiagramWidget([PhillipsCurveDiagram(c, DiagramEnum.macroLRPCFallInNRU)]),

    /// Inequality and Poverty
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
      ADASDiagram(c, DiagramEnum.macroKeynesianExpansionaryPolicy),
    ]),
    DiagramWidget([
      MoneyMarketDiagram(
        c,
        DiagramEnum.macroMoneyMarketContractionaryMonetaryPolicy,
      ),
      ADASDiagram(c, DiagramEnum.macroKeynesianContractionaryPolicy),
    ]),
    DiagramWidget([ADASDiagram(c, DiagramEnum.macroKeynesianMultiplier)]),

    /// --- MONEY MARKET ---
    DiagramWidget([MoneyMarketDiagram(c, DiagramEnum.macroMoneyMarket)]),
    DiagramWidget([
      MoneyMarketDiagram(
        c,
        DiagramEnum.macroMoneyMarketExpansionaryMonetaryPolicy,
      ),
      ADASDiagram(c, DiagramEnum.macroKeynesianExpansionaryPolicy),
    ]),
    DiagramWidget([
      MoneyMarketDiagram(
        c,
        DiagramEnum.macroMoneyMarketContractionaryMonetaryPolicy,
      ),
      ADASDiagram(c, DiagramEnum.macroKeynesianContractionaryPolicy),
    ]),
    DiagramWidget([ADASDiagram(c, DiagramEnum.macroKeynesianMultiplier)]),

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
      ExchangeRateDiagram(c, DiagramEnum.globalManagedExchangeRate),
    ]),

    DiagramWidget([
      ExchangeRateDiagram(
        c,
        DiagramEnum.globalFixedRateDemandDecreaseBuyCurrency,
      ),
    ]),
    DiagramWidget([
      ExchangeRateDiagram(
        c,
        DiagramEnum.globalFixedRateDemandIncreaseSellCurrency,
      ),
    ]),
    DiagramWidget([
      ExchangeRateDiagram(
        c,
        DiagramEnum.globalFixedRateDemandDecreaseReduceSupply,
      ),
    ]),
    DiagramWidget([JCurveDiagram(c, DiagramEnum.globalJCurveDeficit)]),
    DiagramWidget([JCurveDiagram(c, DiagramEnum.globalJCurveSurplus)]),

    /// Economic Development
    DiagramWidget([
      PPCDiagram(c, DiagramEnum.globalPPCUnsustainableUseOfNaturalResources),
    ]),
    DiagramWidget([PPCDiagram(c, DiagramEnum.globalPPCReallocation)]),

    DiagramWidget([PPCDiagram(c, DiagramEnum.globalPPCCapitalInvestment)]),
    DiagramWidget([PovertyCycleDiagram(c, DiagramEnum.globalPovertyCycle)]),
  ];
}
