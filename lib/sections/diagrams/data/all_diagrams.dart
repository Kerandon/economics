import 'package:economics_app/sections/diagrams/custom_paint/diagrams/aggregate_demand.dart';
import 'package:economics_app/sections/diagrams/custom_paint/diagrams/circular_flow_of_income.dart';
import 'package:economics_app/sections/diagrams/custom_paint/diagrams/comparative_advantage.dart';
import 'package:economics_app/sections/diagrams/custom_paint/diagrams/demand.dart';
import 'package:economics_app/sections/diagrams/custom_paint/diagrams/externalities.dart';
import 'package:economics_app/sections/diagrams/custom_paint/diagrams/import_quota.dart';
import 'package:economics_app/sections/diagrams/custom_paint/diagrams/international_trade.dart';
import 'package:economics_app/sections/diagrams/custom_paint/diagrams/j_curve.dart';
import 'package:economics_app/sections/diagrams/custom_paint/diagrams/money_market.dart';
import 'package:economics_app/sections/diagrams/custom_paint/diagrams/monopolistic_competition.dart';
import 'package:economics_app/sections/diagrams/custom_paint/diagrams/monopoly.dart';
import 'package:economics_app/sections/diagrams/custom_paint/diagrams/perfect_competition.dart';
import 'package:economics_app/sections/diagrams/custom_paint/diagrams/phillips_curve.dart';
import 'package:economics_app/sections/diagrams/custom_paint/diagrams/poverty_trap.dart';
import 'package:economics_app/sections/diagrams/custom_paint/diagrams/ppc_micro.dart';
import 'package:economics_app/sections/diagrams/custom_paint/diagrams/production_subsidy.dart';
import 'package:economics_app/sections/diagrams/custom_paint/diagrams/taxes_and_subsidies.dart';
import 'package:economics_app/sections/diagrams/models/diagram_model.dart';
import 'package:flutter/material.dart';
import '../custom_paint/diagrams/classical_ad_as.dart';
import '../custom_paint/diagrams/export_subsidy.dart';
import '../custom_paint/diagrams/fixed_exchange_rate.dart';
import '../custom_paint/diagrams/floating_exchange_rate.dart';
import '../custom_paint/diagrams/keynesian_ad_as.dart';
import '../custom_paint/diagrams/managed_exchange_rate.dart';
import '../custom_paint/diagrams/oligopoly.dart';
import '../custom_paint/diagrams/price_controls.dart';
import '../custom_paint/diagrams/price_mechanism.dart';
import '../custom_paint/diagrams/tariff.dart';
import '../enums/diagram_subtype.dart';
import '../enums/diagram_type.dart';
import '../enums/unit_type.dart';
import '../models/diagram_bundle.dart';
import '../models/diagram_painter_config.dart';
import '../utils/mixins.dart';
import 'diagram_descriptions.dart';

class AllDiagrams {
  final Size size;
  final ColorScheme colorScheme;

  AllDiagrams({
    required this.size,
    required this.colorScheme,
  });

  List<DiagramBundle> getDiagramBundles({
    DiagramType? type, // optional filtering
  }) {
    final config = DiagramPainterConfig(
      painterSize: size,
      appSize: Size(size.width, size.height),
      colorScheme: colorScheme,
    );

    // Create bundles
    final List<DiagramBundle> allBundles = [
      /// PPC
      DiagramBundle(
        unit: UnitType.micro,
        type: DiagramType.ppcMicro,
        description: kPPCMicroIncreasingOppCostDescription,
        basePainterDiagrams: [
          PPCMicro(
            config: config,
            model: DiagramModel(
              unit: UnitType.micro,
              type: DiagramType.ppcMicro,
              subtype: DiagramSubtype.increasingOpportunityCost,
            ),
          ),
        ],
      ),
      DiagramBundle(
        unit: UnitType.micro,
        type: DiagramType.ppcMicro,
        description: kPPCMicroConstantOppCostDescription,
        basePainterDiagrams: [
          PPCMicro(
            config: config,
            model: DiagramModel(
              unit: UnitType.micro,
              type: DiagramType.ppcMicro,
              subtype: DiagramSubtype.constantOpportunityCost,
            ),
          ),
        ],
      ),
      DiagramBundle(
        unit: UnitType.micro,
        type: DiagramType.ppcMicro,
        description: kPPCMicroProductionPointsDescription,
        basePainterDiagrams: [
          PPCMicro(
            config: config,
            model: DiagramModel(
              unit: UnitType.micro,
              type: DiagramType.ppcMicro,
              subtype: DiagramSubtype.productionPoints,
            ),
          ),
        ],
      ),
      DiagramBundle(
        unit: UnitType.micro,
        type: DiagramType.ppcMicro,
        description: kPPCMicroActualGrowthDescription,
        basePainterDiagrams: [
          PPCMicro(
            config: config,
            model: DiagramModel(
              type: DiagramType.ppcMicro,
              subtype: DiagramSubtype.actualGrowth,
            ),
          ),
        ],
      ),
      DiagramBundle(
        unit: UnitType.micro,
        type: DiagramType.ppcMicro,
        description: kPPCMicroIncreaseInProductionPotentialDescription,
        basePainterDiagrams: [
          PPCMicro(
            config: config,
            model: DiagramModel(
              unit: UnitType.micro,
              type: DiagramType.ppcMicro,
              subtype: DiagramSubtype.increaseInProductionPotential,
            ),
          ),
        ],
      ),
      DiagramBundle(
        unit: UnitType.micro,
        type: DiagramType.ppcMicro,
        description: kPPCMicroDecreaseInProductionPotentialDescription,
        basePainterDiagrams: [
          PPCMicro(
            config: config,
            model: DiagramModel(
              unit: UnitType.micro,
              type: DiagramType.ppcMicro,
              subtype: DiagramSubtype.decreaseInProductionPotential,
            ),
          ),
        ],
      ),

      /// Demand
      DiagramBundle(
        unit: UnitType.micro,
        type: DiagramType.demand,
        description: kDemandDescription,
        basePainterDiagrams: [
          Demand(
            config: config,
            model: DiagramModel(
              type: DiagramType.demand,
            ),
          ),
        ],
      ),
      DiagramBundle(
        unit: UnitType.micro,
        type: DiagramType.demand,
        description: kDemandDeterminantsDescription,
        basePainterDiagrams: [
          Demand(
            config: config,
            model: DiagramModel(
              type: DiagramType.demand,
              subtype: DiagramSubtype.determinants,
            ),
          ),
        ],
      ),
      /// Supply
      DiagramBundle(
        unit: UnitType.micro,
        type: DiagramType.supply,
        description: kSupplyDescription,
        basePainterDiagrams: [
          Demand(
            config: config,
            model: DiagramModel(
              type: DiagramType.supply,
            ),
          ),
        ],
      ),
      DiagramBundle(
        unit: UnitType.micro,
        type: DiagramType.priceMechanism,
        description: kSupplyAndDemandEquilibriumDescription,
        basePainterDiagrams: [
          PriceMechanism(
            config: config,
            model: DiagramModel(
              type: DiagramType.priceMechanism,
              subtype: DiagramSubtype.equilibrium,
              description: '',
            ),
          ),
        ],
      ),
      DiagramBundle(
        unit: UnitType.micro,
        type: DiagramType.priceMechanism,
        description: kSupplyAndDemandIncreaseInDemandDescription,
        basePainterDiagrams: [
          PriceMechanism(
            config: config,
            model: DiagramModel(
              type: DiagramType.priceMechanism,
              subtype: DiagramSubtype.increaseInDemand,
              description: '',
            ),
          ),
        ],
      ),
      DiagramBundle(
        unit: UnitType.micro,
        type: DiagramType.priceMechanism,
        description: kSupplyAndDemandDecreaseInDemandDescription,
        basePainterDiagrams: [
          PriceMechanism(
            config: config,
            model: DiagramModel(
              unit: UnitType.micro,
              type: DiagramType.priceMechanism,
              subtype: DiagramSubtype.decreaseInDemand,
            ),
          ),
        ],
      ),
      DiagramBundle(
        unit: UnitType.micro,
        type: DiagramType.priceMechanism,
        description: kSupplyAndDemandIncreaseInSupplyDescription,
        basePainterDiagrams: [
          PriceMechanism(
            config: config,
            model: DiagramModel(
              type: DiagramType.priceMechanism,
              subtype: DiagramSubtype.increaseInSupply,
            ),
          ),
        ],
      ),
      DiagramBundle(
        unit: UnitType.micro,
        type: DiagramType.priceMechanism,
        description: kSupplyAndDemandDecreaseInSupplyDescription,
        basePainterDiagrams: [
          PriceMechanism(
            config: config,
            model: DiagramModel(
              type: DiagramType.priceMechanism,
              subtype: DiagramSubtype.decreaseInSupply,
            ),
          ),
        ],
      ),
      DiagramBundle(
        unit: UnitType.micro,
        type: DiagramType.priceMechanism,
        description: kSupplyAndDemandShortageDescription,
        basePainterDiagrams: [
          PriceMechanism(
            config: config,
            model: DiagramModel(
              type: DiagramType.priceMechanism,
              subtype: DiagramSubtype.shortage,
            ),
          ),
        ],
      ),
      DiagramBundle(
        unit: UnitType.micro,
        type: DiagramType.priceMechanism,
        description: kSupplyAndDemandSurplusDescription,
        basePainterDiagrams: [
          PriceMechanism(
            config: config,
            model: DiagramModel(
              type: DiagramType.priceMechanism,
              subtype: DiagramSubtype.surplus,
            ),
          ),
        ],
      ),

      /// Taxes and Subsidies
      DiagramBundle(
        basePainterDiagrams: [
          TaxesAndSubsidies(
            config,
            DiagramModel(
              unit: UnitType.micro,
              type: DiagramType.taxesAndSubsidies,
              subtype: DiagramSubtype.perUnitSalesTax,
              description: kFixedPerUnitSalesTax,
            ),
          ),
        ],
      ),
      DiagramBundle(
        basePainterDiagrams: [
          TaxesAndSubsidies(
            config,
            DiagramModel(
              unit: UnitType.micro,
              type: DiagramType.taxesAndSubsidies,
              subtype: DiagramSubtype.adValoremSalesTax,
              description: kAdValoremSalesTaxDescription,
            ),
          ),
        ],
      ),
      DiagramBundle(
        basePainterDiagrams: [
          TaxesAndSubsidies(
            config,
            DiagramModel(
              unit: UnitType.micro,
              type: DiagramType.taxesAndSubsidies,
              subtype: DiagramSubtype.salesTaxSocialWelfare,
              description: kSalesTaxSocialWelfareDescription,
            ),
          ),
        ],
      ),
      DiagramBundle(
        basePainterDiagrams: [
          TaxesAndSubsidies(
            config,
            DiagramModel(
              unit: UnitType.micro,
              type: DiagramType.taxesAndSubsidies,
              subtype: DiagramSubtype.subsidy,
              description: kSubsidyDescription,
            ),
          ),
        ],
      ),
      DiagramBundle(
        basePainterDiagrams: [
          TaxesAndSubsidies(
            config,
            DiagramModel(
              unit: UnitType.micro,
              type: DiagramType.taxesAndSubsidies,
              subtype: DiagramSubtype.subsidySocialWelfare,
              description: kSubsidySocialWelfareDescription,
            ),
          ),
        ],
      ),
      DiagramBundle(
        basePainterDiagrams: [
          PriceControls(
            config,
            DiagramModel(
              unit: UnitType.micro,
              type: DiagramType.priceControls,
              subtype: DiagramSubtype.priceFloorNationalMinimumWage,
              description: '',
            ),
          ),
        ],
      ),

      DiagramBundle(
        basePainterDiagrams: [
          PriceControls(
            config,
            DiagramModel(
              unit: UnitType.micro,
              type: DiagramType.priceControls,
              subtype: DiagramSubtype.priceFloorAgriculturalPurchases,
              description: '',
            ),
          ),
        ],
      ),
      DiagramBundle(
        basePainterDiagrams: [
          PriceControls(
            config,
            DiagramModel(
              unit: UnitType.micro,
              type: DiagramType.priceControls,
              subtype: DiagramSubtype.priceCeiling,
              description: '',
            ),
          ),
        ],
      ),

      /// Externalities
      DiagramBundle(
        basePainterDiagrams: [
          Externalities(
            config: config,
            model: DiagramModel(
              type: DiagramType.externalities,
              subtype: DiagramSubtype.negativeProduction,
              description: kNegativeProductionExternalityDescription,
            ),
          ),
        ],
      ),
      DiagramBundle(
        basePainterDiagrams: [
          Externalities(
            config: config,
            model: DiagramModel(
              type: DiagramType.externalities,
              subtype: DiagramSubtype.negativeConsumption,
              description: kNegativeConsumptionExternalityDescription,
            ),
          ),
        ],
      ),
      DiagramBundle(
        basePainterDiagrams: [
          Externalities(
            config: config,
            model: DiagramModel(
              type: DiagramType.externalities,
              subtype: DiagramSubtype.positiveProduction,
              description: kPositiveProductionExternalityDescription,
            ),
          ),
        ],
      ),
      DiagramBundle(
        basePainterDiagrams: [
          Externalities(
            config: config,
            model: DiagramModel(
              type: DiagramType.externalities,
              subtype: DiagramSubtype.positiveConsumption,
              description: kPositiveConsumptionExternalityDescription,
            ),
          ),
        ],
      ),

      /// Market Power
      DiagramBundle(
        unit: UnitType.micro,
        type: DiagramType.perfectCompetition,
        label: 'Long-Run Equilibrium',
        description: kPerfectCompetitionLongRunEquilibrium,
        basePainterDiagrams: [
          PriceMechanism(
            config: config,
            model: DiagramModel(
              unit: UnitType.micro,
              type: DiagramType.priceMechanism,
              subtype: DiagramSubtype.longRunEquilibrium,
            ),
          ),
          PerfectCompetition(
            config: config,
            model: DiagramModel(
              unit: UnitType.micro,
              type: DiagramType.perfectCompetition,
              subtype: DiagramSubtype.longRunEquilibrium,
            ),
          ),
        ],
      ),
      DiagramBundle(
        unit: UnitType.micro,
        type: DiagramType.perfectCompetition,
        label: 'Abnormal Profits',
        description: kPerfectCompetitionAbnormalProfitProcessDescription,
        basePainterDiagrams: [
          PriceMechanism(
            config: config,
            model: DiagramModel(
              unit: UnitType.micro,
              type: DiagramType.priceMechanism,
              subtype: DiagramSubtype.abnormalProfit,
            ),
          ),
          PerfectCompetition(
            config: config,
            model: DiagramModel(
              unit: UnitType.micro,
              type: DiagramType.perfectCompetition,
              subtype: DiagramSubtype.abnormalProfit,
            ),
          ),
        ],
      ),
      DiagramBundle(
        unit: UnitType.micro,
        type: DiagramType.perfectCompetition,
        label: 'Losses',
        description: kPerfectCompetitionLossesDescription,
        basePainterDiagrams: [
          PriceMechanism(
            config: config,
            model: DiagramModel(
              unit: UnitType.micro,
              type: DiagramType.priceMechanism,
              subtype: DiagramSubtype.loss,
            ),
          ),
          PerfectCompetition(
            config: config,
            model: DiagramModel(
              unit: UnitType.micro,
              type: DiagramType.perfectCompetition,
              subtype: DiagramSubtype.loss,
            ),
          ),
        ],
      ),
      DiagramBundle(
        unit: UnitType.micro,
        type: DiagramType.perfectCompetition,
        label: 'Social Welfare',
        description: kPerfectCompetitionSocialWelfareDescription,
        basePainterDiagrams: [
          PriceMechanism(
            config: config,
            model: DiagramModel(
              unit: UnitType.micro,
              type: DiagramType.priceMechanism,
              subtype: DiagramSubtype.socialWelfare,
            ),
          ),
          PerfectCompetition(
            config: config,
            model: DiagramModel(
              unit: UnitType.micro,
              type: DiagramType.perfectCompetition,
              subtype: DiagramSubtype.socialWelfare,
            ),
          ),
        ],
      ),
      DiagramBundle(
        basePainterDiagrams: [
          Monopoly(
            config: config,
            model: DiagramModel(
              type: DiagramType.monopoly,
              subtype: DiagramSubtype.abnormalProfit,
              description: kMonopolyAbnormalProfitsDescription,
            ),
          ),
        ],
      ),
      DiagramBundle(
        basePainterDiagrams: [
          Monopoly(
            config: config,
            model: DiagramModel(
              type: DiagramType.monopoly,
              subtype: DiagramSubtype.loss,
              description: 'A monopoly can be loss-making',
            ),
          ),
        ],
      ),
      DiagramBundle(
        basePainterDiagrams: [
          Monopoly(
            config: config,
            model: DiagramModel(
              type: DiagramType.monopoly,
              subtype: DiagramSubtype.naturalMonopoly,
              description: kMonopolyNaturalDescription,
            ),
          ),
        ],
      ),
      DiagramBundle(
        basePainterDiagrams: [
          Monopoly(
            config: config,
            model: DiagramModel(
              type: DiagramType.monopoly,
              subtype: DiagramSubtype.socialWelfare,
              description: kMonopolyWelfareLossDescription,
            ),
          ),
        ],
      ),
      DiagramBundle(
        basePainterDiagrams: [
          MonopolisticCompetition(
            config: config,
            model: DiagramModel(
              type: DiagramType.monopolisticCompetition,
              subtype: DiagramSubtype.longRunEquilibrium,
              description:
                  kMonopolisticCompetitionLongRunEquilibriumDescription,
            ),
          ),
        ],
      ),
      DiagramBundle(
        basePainterDiagrams: [
          MonopolisticCompetition(
            config: config,
            model: DiagramModel(
              type: DiagramType.monopolisticCompetition,
              subtype: DiagramSubtype.socialWelfare,
              description: kMonopolisticCompetitionWelfareDescription,
            ),
          ),
        ],
      ),
      DiagramBundle(
        basePainterDiagrams: [
          MonopolisticCompetition(
            config: config,
            model: DiagramModel(
              type: DiagramType.monopolisticCompetition,
              subtype: DiagramSubtype.abnormalProfit,
              description: kMonopolisticCompetitionAbnormalProfitDescription,
            ),
          ),
        ],
      ),
      DiagramBundle(
        basePainterDiagrams: [
          MonopolisticCompetition(
            config: config,
            model: DiagramModel(
              type: DiagramType.monopolisticCompetition,
              subtype: DiagramSubtype.loss,
              description: kMonopolisticCompetitionLossDescription,
            ),
          ),
        ],
      ),
      DiagramBundle(
        basePainterDiagrams: [
          Oligopoly(
            config: config,
            model: DiagramModel(
              type: DiagramType.oligopoly,
              subtype: DiagramSubtype.abnormalProfit,
              description: kOligopolyCartelDescription,
            ),
          ),
        ],
      ),

      /// Circular Flow Of Income Model
      DiagramBundle(
        basePainterDiagrams: [
          CircularFlowOfIncome(
            config: config,
            model: DiagramModel(
              type: DiagramType.circularFlowOfIncome,
              subtype: DiagramSubtype.closedModel,
              description: kCircularFlowOfIncomeModelClosedDescription,
            ),
          ),
        ],
      ),
      DiagramBundle(
        basePainterDiagrams: [
          CircularFlowOfIncome(
            config: config,
            model: DiagramModel(
              type: DiagramType.circularFlowOfIncome,
              subtype: DiagramSubtype.openModel,
              description: kCircularFlowOfIncomeModelOpenDescription,
            ),
          ),
        ],
      ),

      /// Aggregate Demand
      DiagramBundle(basePainterDiagrams: [
        AggregateDemand(
          config: config,
          model: DiagramModel(
            unit: UnitType.macro,
            type: DiagramType.aggregateDemand,
          ),
        ),
      ]),
      DiagramBundle(
        basePainterDiagrams: [
          AggregateDemand(
            config: config,
            model: DiagramModel(
              unit: UnitType.macro,
              type: DiagramType.aggregateDemand,
              subtype: DiagramSubtype.determinants,
              description: kAggregateDemandDeterminantsDescription,
            ),
          ),
        ],
      ),

      /// Classical ADAS
      DiagramBundle(
        basePainterDiagrams: [
          ClassicalADAS(
            config: config,
            model: DiagramModel(
              unit: UnitType.macro,
              type: DiagramType.classicalADAS,
              subtype: DiagramSubtype.fullEmploymentClassical,
            ),
          ),
        ],
      ),

      /// Keynesian ADAS
      DiagramBundle(
        basePainterDiagrams: [
          KeynesianADAS(
            config: config,
            model: DiagramModel(
              unit: UnitType.macro,
              type: DiagramType.keynesianADAS,
              subtype: DiagramSubtype.fullEmploymentKeynesian,
            ),
          ),
        ],
      ),

      /// Phillips Curve
      DiagramBundle(
        basePainterDiagrams: [
          PhillipsCurve(
            config: config,
            model: DiagramModel(
              unit: UnitType.macro,
              type: DiagramType.phillipsCurve,
              subtype: DiagramSubtype.shortRun,
            ),
          ),
        ],
      ),

      /// Money Market
      DiagramBundle(
        basePainterDiagrams: [
          MoneyMarket(
            config: config,
            model: DiagramModel(
              type: DiagramType.moneyMarket,
              description: kCircularFlowOfIncomeModelOpenDescription,
            ),
          ),
        ],
      ),

      /// Demand-Side Policies
      DiagramBundle(
        label: 'Demand-Side: Expansionary Monetary Policy',
        type: DiagramType.demandSidePolicies,
        description: kDemandSideExpansionaryMonetaryPolicyDescription,
        basePainterDiagrams: [
          MoneyMarket(
            config: config,
            model: DiagramModel(
              type: DiagramType.moneyMarket,
            ),
          ),
          ClassicalADAS(
            config: config,
            model: DiagramModel(type: DiagramType.classicalADAS),
          ),
        ],
      ),
      DiagramBundle(
        label: 'Demand-Side: Contractionary Monetary Policy',
        type: DiagramType.demandSidePolicies,
        description: kDemandSideContractionaryMonetaryPolicyDescription,
        basePainterDiagrams: [
          MoneyMarket(
            config: config,
            model: DiagramModel(
              type: DiagramType.moneyMarket,
            ),
          ),
          ClassicalADAS(
            config: config,
            model: DiagramModel(
              type: DiagramType.classicalADAS,
            ),
          ),
        ],
      ),
      DiagramBundle(
          label: 'Keynesian Multiplier (HL)',
          type: DiagramType.keynesianMultiplier,
          basePainterDiagrams: [
            KeynesianADAS(
              config: config,
              model: DiagramModel(
                unit: UnitType.macro,
                subtype: DiagramSubtype.macro,
              ),
            ),
          ]),

      /// Supply-Side Policies
      DiagramBundle(
        label: 'Long Term Growth',
        type: DiagramType.supplySidePolicies,
        description: kSupplySidePoliciesLongTermGrowthDescription,
        basePainterDiagrams: [
          ClassicalADAS(
            config: config,
            model: DiagramModel(
              unit: UnitType.macro,
              type: DiagramType.classicalADAS,
              subtype: DiagramSubtype.increaseInSupply,
            ),
          ),
        ],
      ),

      /// World Trade
      DiagramBundle(
        label: 'International Trade - Exporter',
        description: kInternationalTradeExporterDescription,
        basePainterDiagrams: [
          InternationalTrade(
            config: config,
            model: DiagramModel(
              unit: UnitType.global,
              type: DiagramType.internationalTrade,
              subtype: DiagramSubtype.worldPrice,
              description: kInternationalTradeExporterDescription,
            ),
          ),
          InternationalTrade(
              config: config,
              model: DiagramModel(
                unit: UnitType.global,
                type: DiagramType.internationalTrade,
                subtype: DiagramSubtype.exporter,
                description: kInternationalTradeExporterDescription,
              )),
        ],
      ),

      DiagramBundle(
        label: 'International Trade - Importer',
        basePainterDiagrams: [
          InternationalTrade(
              config: config,
              model: DiagramModel(
                unit: UnitType.global,
                type: DiagramType.internationalTrade,
                subtype: DiagramSubtype.worldPrice,
                description: kInternationalTradeExporterDescription,
              )),
          InternationalTrade(
              config: config,
              model: DiagramModel(
                unit: UnitType.global,
                type: DiagramType.internationalTrade,
                subtype: DiagramSubtype.importer,
                description: kInternationalTradeExporterDescription,
              ))
        ],
      ),

      /// Comparative Advantage
      DiagramBundle(
        basePainterDiagrams: [
          ComparativeAdvantage(
            config: config,
            model: DiagramModel(
              type: DiagramType.comparativeAdvantage,
              subtype: DiagramSubtype.absoluteAdvantage,
              description: '',
            ),
          ),
        ],
      ),
      DiagramBundle(
        basePainterDiagrams: [
          ComparativeAdvantage(
            config: config,
            model: DiagramModel(
              type: DiagramType.comparativeAdvantage,
              subtype: DiagramSubtype.comparativeAdvantage,
              description: '',
            ),
          ),
        ],
      ),
      DiagramBundle(
        basePainterDiagrams: [
          ComparativeAdvantage(
            config: config,
            model: DiagramModel(
              type: DiagramType.comparativeAdvantage,
              subtype: DiagramSubtype.noGainsFromTrade,
              description: '',
            ),
          ),
        ],
      ),

      /// Tariffs
      DiagramBundle(
        basePainterDiagrams: [
          Tariff(
              config: config,
              model: DiagramModel(
                unit: UnitType.global,
                type: DiagramType.tariff,
                subtype: DiagramSubtype.standard,
                description: kTariffDescription,
              ))
        ],
      ),
      DiagramBundle(
        basePainterDiagrams: [
          Tariff(
              config: config,
              model: DiagramModel(
                unit: UnitType.global,
                type: DiagramType.tariff,
                subtype: DiagramSubtype.socialWelfare,
                description: kTariffWelfareDescription,
              ))
        ],
      ),

      /// Import Quota
      DiagramBundle(
        basePainterDiagrams: [
          ImportQuota(
              config: config,
              model: DiagramModel(
                unit: UnitType.global,
                type: DiagramType.importQuota,
                subtype: DiagramSubtype.standard,
                description: kImportQuotaDescription,
              ))
        ],
      ),
      DiagramBundle(
        basePainterDiagrams: [
          ImportQuota(
              config: config,
              model: DiagramModel(
                unit: UnitType.global,
                type: DiagramType.importQuota,
                subtype: DiagramSubtype.socialWelfare,
                description: kImportQuotaWelfareDescription,
              ))
        ],
      ),

      /// Production Subsidy
      DiagramBundle(
        basePainterDiagrams: [
          ProductionSubsidy(
              config: config,
              model: DiagramModel(
                unit: UnitType.global,
                type: DiagramType.productionSubsidy,
                subtype: DiagramSubtype.standard,
                description: kProductionSubsidyDescription,
              ))
        ],
      ),

      DiagramBundle(
        basePainterDiagrams: [
          ProductionSubsidy(
            config: config,
            model: DiagramModel(
              unit: UnitType.global,
              type: DiagramType.productionSubsidy,
              subtype: DiagramSubtype.socialWelfare,
              description: kProductionSubsidyWelfareDescription,
            ),
          ),
        ],
      ),

      /// Export Subsidy
      DiagramBundle(
        basePainterDiagrams: [
          ExportSubsidy(
              config: config,
              model: DiagramModel(
                unit: UnitType.global,
                type: DiagramType.exportSubsidy,
                subtype: DiagramSubtype.standard,
                description: kExportSubsidyDescription,
              ))
        ],
      ),
      DiagramBundle(
        basePainterDiagrams: [
          ExportSubsidy(
            config: config,
            model: DiagramModel(
              unit: UnitType.global,
              type: DiagramType.exportSubsidy,
              subtype: DiagramSubtype.socialWelfare,
              description: kExportSubsidyWelfareDescription,
            ),
          ),
        ],
      ),
      DiagramBundle(
        basePainterDiagrams: [
          FloatingExchangeRate(
            config: config,
            model: DiagramModel(
              type: DiagramType.floatingExchangeRate,
              subtype: DiagramSubtype.equilibrium,
              description: kFloatingExchangeRateEquilibriumDescription,
            ),
          ),
        ],
      ),
      DiagramBundle(
        basePainterDiagrams: [
          FloatingExchangeRate(
            config: config,
            model: DiagramModel(
              type: DiagramType.floatingExchangeRate,
              subtype: DiagramSubtype.appreciationIncreaseInDemand,
              description: AppreciationIncreaseInDemandDescription,
            ),
          ),
        ],
      ),
      DiagramBundle(
        basePainterDiagrams: [
          FloatingExchangeRate(
            config: config,
            model: DiagramModel(
              type: DiagramType.floatingExchangeRate,
              subtype: DiagramSubtype.appreciationDecreaseInSupply,
              description: AppreciationDecreaseInSupplyDescription,
            ),
          ),
        ],
      ),
      DiagramBundle(
        basePainterDiagrams: [
          FloatingExchangeRate(
            config: config,
            model: DiagramModel(
              type: DiagramType.floatingExchangeRate,
              subtype: DiagramSubtype.depreciationDecreaseInDemand,
              description: DepreciationDecreaseInDemandDescription,
            ),
          ),
        ],
      ),
      DiagramBundle(
        basePainterDiagrams: [
          FloatingExchangeRate(
            config: config,
            model: DiagramModel(
              type: DiagramType.floatingExchangeRate,
              subtype: DiagramSubtype.depreciationIncreaseInSupply,
              description: kDepreciationIncreaseInSupplyDescription,
            ),
          ),
        ],
      ),
      DiagramBundle(
        description: 'Managed Exchange Rate',
        basePainterDiagrams: [
          ManagedExchangeRate(
            config: config,
            model: DiagramModel(
              type: DiagramType.managedExchangeRate,
              subtype: DiagramSubtype.appreciationIncreaseInDemand,
              description: kManagedExchangeRateDescription,
            ),
          ),
        ],
      ),
      DiagramBundle(
        label: 'Fixed Rate - Central Bank Sells Domestic Currency',
        description: kFixedRateCentralBankSellsDomesticCurrency,
        basePainterDiagrams: [
          FixedExchangeRate(
            config: config,
            model: DiagramModel(
              type: DiagramType.fixedExchangeRate,
              subtype: DiagramSubtype.fixedRateIncreaseInDemand,
            ),
          ),
          FixedExchangeRate(
            config: config,
            model: DiagramModel(
              type: DiagramType.fixedExchangeRate,
              subtype: DiagramSubtype.fixedRateSellCurrency,
            ),
          ),
        ],
      ),
      DiagramBundle(
        label: 'Fixed Rate - Central Bank Raises Interest Rates',
        description: kFixedRateRaisesInterestRatesDescription,
        basePainterDiagrams: [
          FixedExchangeRate(
            config: config,
            model: DiagramModel(
              type: DiagramType.fixedExchangeRate,
              subtype: DiagramSubtype.fixedRateDecreaseInDemand,
              description: '',
            ),
          ),
          FixedExchangeRate(
            config: config,
            model: DiagramModel(
              type: DiagramType.fixedExchangeRate,
              subtype: DiagramSubtype.fixedRateRaiseInterestRates,
              description: '',
            ),
          ),
        ],
      ),
      DiagramBundle(
          description: kJCurveTradeDeficitDescription,
          basePainterDiagrams: [
            JCurve(
                config: config,
                model: DiagramModel(
                  type: DiagramType.jCurve,
                  subtype: DiagramSubtype.correctDeficit,
                ))
          ]),
      DiagramBundle(
          description: kJCurveTradeSurplusDescription,
          basePainterDiagrams: [
            JCurve(
                config: config,
                model: DiagramModel(
                  type: DiagramType.jCurve,
                  subtype: DiagramSubtype.correctSurplus,
                ))
          ]),
      DiagramBundle(label: 'Poverty Trap', basePainterDiagrams: [
        PovertyTrap(
            config: config,
            model: DiagramModel(
              type: DiagramType.povertyTrap,
              subtype: DiagramSubtype.standard,
            ))
      ])
    ];

    for (int i = 0; i < allBundles.length; i++) {
      List<DiagramModel> tempModels = [];

      for (int j = 0; j < allBundles[i].basePainterDiagrams.length; j++) {
        final diagramIdentifier =
            allBundles[i].basePainterDiagrams[j] as DiagramIdentifierMixin;

        tempModels.add(
          diagramIdentifier.model.copyWith(
            painter: allBundles[i].basePainterDiagrams[j],
          ),
        );
      }

      // Store the result of copyWith back into allBundles if needed
      allBundles[i] = allBundles[i].copyWith(
        diagramModels: tempModels,
      );
    }

    // Optional filter
    if (type != null) {
      return allBundles.where((bundle) {
        return bundle.basePainterDiagrams.any((diagram) =>
            diagram.model.type == type &&
            diagram.model.subtype == diagram.model.subtype);
      }).toList();
    }
    return allBundles.toList();
  }
}
