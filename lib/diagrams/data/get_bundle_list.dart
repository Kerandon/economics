
import '../custom_paint/diagrams/demand.dart';
import '../custom_paint/diagrams/ppc_micro.dart';
import '../custom_paint/diagrams/supply.dart';
import '../enums/diagram_bundle_enum.dart';
import '../enums/diagram_subtype.dart';
import '../models/diagram_bundle.dart';
import '../models/diagram_model.dart';
import '../models/diagram_painter_config.dart';

List<DiagramBundle> getBundleList(DiagramPainterConfig config) {
  return [
    /// PPC
    DiagramBundle(
      diagramBundleEnum: DiagramBundleEnum.microPPCIncreaseOppCost,
      basePainterDiagrams: [
        PPCMicro(
          config: config,
          model: DiagramModel(
            subtype: DiagramSubtype.increasingOpportunityCost,
          ),
        ),
        PPCMicro(
          config: config,
          model: DiagramModel(
            subtype: DiagramSubtype.constantOpportunityCost,
          ),
        ),
      ],
    ),
    DiagramBundle(
      diagramBundleEnum: DiagramBundleEnum.microPPCConstantOppCost,
      basePainterDiagrams: [
        PPCMicro(
          config: config,
          model: DiagramModel(
            subtype: DiagramSubtype.constantOpportunityCost,
          ),
        ),
      ],
    ),
    DiagramBundle(
      basePainterDiagrams: [
        PPCMicro(
          config: config,
          model: DiagramModel(
            subtype: DiagramSubtype.productionPoints,
          ),
        ),
      ],
    ),
    DiagramBundle(
      basePainterDiagrams: [
        PPCMicro(
          config: config,
          model: DiagramModel(
            subtype: DiagramSubtype.actualGrowth,
          ),
        ),
      ],
    ),
    DiagramBundle(
      basePainterDiagrams: [
        PPCMicro(
          config: config,
          model: DiagramModel(
            subtype: DiagramSubtype.increaseInProductionPotential,
          ),
        ),
      ],
    ),
    DiagramBundle(
      basePainterDiagrams: [
        PPCMicro(
          config: config,
          model: DiagramModel(
            subtype: DiagramSubtype.decreaseInProductionPotential,
          ),
        ),
      ],
    ),

    /// Demand
    DiagramBundle(
      diagramBundleEnum: DiagramBundleEnum.microDemand,
      basePainterDiagrams: [
        Demand(
          config: config,
          model: DiagramModel(),
        ),
      ],
    ),
    DiagramBundle(
      diagramBundleEnum: DiagramBundleEnum.microDemandDeterminants,
      basePainterDiagrams: [
        Demand(
          config: config,
          model: DiagramModel(
            subtype: DiagramSubtype.determinants,
          ),
        ),
      ],
    ),

    /// Supply
    DiagramBundle(
      diagramBundleEnum: DiagramBundleEnum.microSupply,
      basePainterDiagrams: [
        Supply(
          config: config,
          model: DiagramModel(),
        ),
      ],
    ),
    DiagramBundle(
      diagramBundleEnum: DiagramBundleEnum.microSupplyDeterminants,
      basePainterDiagrams: [
        Supply(
          config: config,
          model: DiagramModel(
            subtype: DiagramSubtype.determinants,
          ),
        ),
      ],
    ),
    // DiagramBundle(
    //   unit: UnitType.micro,
    //   type: DiagramType.priceMechanism,
    //   description: kSupplyAndDemandEquilibriumDescription,
    //   basePainterDiagrams: [
    //     PriceMechanism(
    //       config: config,
    //       model: DiagramModel(
    //         type: DiagramType.priceMechanism,
    //         subtype: DiagramSubtype.equilibrium,
    //
    //       ),
    //     ),
    //   ],
    // ),
    // DiagramBundle(
    //   unit: UnitType.micro,
    //   type: DiagramType.priceMechanism,
    //   description: kSupplyAndDemandIncreaseInDemandDescription,
    //   basePainterDiagrams: [
    //     PriceMechanism(
    //       config: config,
    //       model: DiagramModel(
    //         type: DiagramType.priceMechanism,
    //         subtype: DiagramSubtype.increaseInDemand,
    //       ),
    //     ),
    //   ],
    // ),
    // DiagramBundle(
    //   unit: UnitType.micro,
    //   type: DiagramType.priceMechanism,
    //   description: kSupplyAndDemandDecreaseInDemandDescription,
    //   basePainterDiagrams: [
    //     PriceMechanism(
    //       config: config,
    //       model: DiagramModel(
    //         type: DiagramType.priceMechanism,
    //         subtype: DiagramSubtype.decreaseInDemand,
    //       ),
    //     ),
    //   ],
    // ),
    // DiagramBundle(
    //   unit: UnitType.micro,
    //   type: DiagramType.priceMechanism,
    //   description: kSupplyAndDemandIncreaseInSupplyDescription,
    //   basePainterDiagrams: [
    //     PriceMechanism(
    //       config: config,
    //       model: DiagramModel(
    //         type: DiagramType.priceMechanism,
    //         subtype: DiagramSubtype.increaseInSupply,
    //       ),
    //     ),
    //   ],
    // ),
    // DiagramBundle(
    //   unit: UnitType.micro,
    //   type: DiagramType.priceMechanism,
    //   description: kSupplyAndDemandDecreaseInSupplyDescription,
    //   basePainterDiagrams: [
    //     PriceMechanism(
    //       config: config,
    //       model: DiagramModel(
    //         type: DiagramType.priceMechanism,
    //         subtype: DiagramSubtype.decreaseInSupply,
    //       ),
    //     ),
    //   ],
    // ),
    // DiagramBundle(
    //   unit: UnitType.micro,
    //   type: DiagramType.priceMechanism,
    //   description: kSupplyAndDemandShortageDescription,
    //   basePainterDiagrams: [
    //     PriceMechanism(
    //       config: config,
    //       model: DiagramModel(
    //         type: DiagramType.priceMechanism,
    //         subtype: DiagramSubtype.shortage,
    //       ),
    //     ),
    //   ],
    // ),
    // DiagramBundle(
    //   unit: UnitType.micro,
    //   type: DiagramType.priceMechanism,
    //   description: kSupplyAndDemandSurplusDescription,
    //   basePainterDiagrams: [
    //     PriceMechanism(
    //       config: config,
    //       model: DiagramModel(
    //         type: DiagramType.priceMechanism,
    //         subtype: DiagramSubtype.surplus,
    //       ),
    //     ),
    //   ],
    // ),
    //
    // /// Taxes and Subsidies
    // DiagramBundle(
    //   basePainterDiagrams: [
    //     TaxesAndSubsidies(
    //       config,
    //       DiagramModel(
    //         type: DiagramType.taxesAndSubsidies,
    //         subtype: DiagramSubtype.perUnitSalesTax,
    //       ),
    //     ),
    //   ],
    // ),
    // DiagramBundle(
    //   basePainterDiagrams: [
    //     TaxesAndSubsidies(
    //       config,
    //       DiagramModel(
    //         type: DiagramType.taxesAndSubsidies,
    //         subtype: DiagramSubtype.adValoremSalesTax,
    //       ),
    //     ),
    //   ],
    // ),
    // DiagramBundle(
    //   basePainterDiagrams: [
    //     TaxesAndSubsidies(
    //       config,
    //       DiagramModel(
    //         type: DiagramType.taxesAndSubsidies,
    //         subtype: DiagramSubtype.salesTaxSocialWelfare,
    //       ),
    //     ),
    //   ],
    // ),
    // DiagramBundle(
    //   basePainterDiagrams: [
    //     TaxesAndSubsidies(
    //       config,
    //       DiagramModel(
    //         type: DiagramType.taxesAndSubsidies,
    //         subtype: DiagramSubtype.subsidy,
    //       ),
    //     ),
    //   ],
    // ),
    // DiagramBundle(
    //   basePainterDiagrams: [
    //     TaxesAndSubsidies(
    //       config,
    //       DiagramModel(
    //         type: DiagramType.taxesAndSubsidies,
    //         subtype: DiagramSubtype.subsidySocialWelfare,
    //       ),
    //     ),
    //   ],
    // ),
    // DiagramBundle(
    //   basePainterDiagrams: [
    //     PriceControls(
    //       config,
    //       DiagramModel(
    //
    //         type: DiagramType.priceControls,
    //         subtype: DiagramSubtype.priceFloorNationalMinimumWage,
    //
    //       ),
    //     ),
    //   ],
    // ),
    //
    // DiagramBundle(
    //   basePainterDiagrams: [
    //     PriceControls(
    //       config,
    //       DiagramModel(
    //         type: DiagramType.priceControls,
    //         subtype: DiagramSubtype.priceFloorAgriculturalPurchases,
    //       ),
    //     ),
    //   ],
    // ),
    // DiagramBundle(
    //   basePainterDiagrams: [
    //     PriceControls(
    //       config,
    //       DiagramModel(
    //         type: DiagramType.priceControls,
    //         subtype: DiagramSubtype.priceCeiling,
    //       ),
    //     ),
    //   ],
    // ),
    //
    // /// Externalities
    // DiagramBundle(
    //   basePainterDiagrams: [
    //     Externalities(
    //       config: config,
    //       model: DiagramModel(
    //         type: DiagramType.externalities,
    //         subtype: DiagramSubtype.negativeProduction,
    //       ),
    //     ),
    //   ],
    // ),
    // DiagramBundle(
    //   basePainterDiagrams: [
    //     Externalities(
    //       config: config,
    //       model: DiagramModel(
    //         type: DiagramType.externalities,
    //         subtype: DiagramSubtype.negativeConsumption,
    //       ),
    //     ),
    //   ],
    // ),
    // DiagramBundle(
    //   basePainterDiagrams: [
    //     Externalities(
    //       config: config,
    //       model: DiagramModel(
    //         type: DiagramType.externalities,
    //         subtype: DiagramSubtype.positiveProduction,
    //       ),
    //     ),
    //   ],
    // ),
    // DiagramBundle(
    //   basePainterDiagrams: [
    //     Externalities(
    //       config: config,
    //       model: DiagramModel(
    //         type: DiagramType.externalities,
    //         subtype: DiagramSubtype.positiveConsumption,
    //
    //       ),
    //     ),
    //   ],
    // ),
    //
    // /// Market Power
    // DiagramBundle(
    //   unit: UnitType.micro,
    //   type: DiagramType.perfectCompetition,
    //   label: 'Long-Run Equilibrium',
    //   description: kPerfectCompetitionLongRunEquilibrium,
    //   basePainterDiagrams: [
    //     PriceMechanism(
    //       config: config,
    //       model: DiagramModel(
    //         type: DiagramType.priceMechanism,
    //         subtype: DiagramSubtype.longRunEquilibrium,
    //       ),
    //     ),
    //     PerfectCompetition(
    //       config: config,
    //       model: DiagramModel(
    //
    //         type: DiagramType.perfectCompetition,
    //         subtype: DiagramSubtype.longRunEquilibrium,
    //       ),
    //     ),
    //   ],
    // ),
    // DiagramBundle(
    //   unit: UnitType.micro,
    //   type: DiagramType.perfectCompetition,
    //   label: 'Abnormal Profits',
    //   description: kPerfectCompetitionAbnormalProfitProcessDescription,
    //   basePainterDiagrams: [
    //     PriceMechanism(
    //       config: config,
    //       model: DiagramModel(
    //
    //         type: DiagramType.priceMechanism,
    //         subtype: DiagramSubtype.abnormalProfit,
    //       ),
    //     ),
    //     PerfectCompetition(
    //       config: config,
    //       model: DiagramModel(
    //
    //         type: DiagramType.perfectCompetition,
    //         subtype: DiagramSubtype.abnormalProfit,
    //       ),
    //     ),
    //   ],
    // ),
    // DiagramBundle(
    //   unit: UnitType.micro,
    //   type: DiagramType.perfectCompetition,
    //   label: 'Losses',
    //   description: kPerfectCompetitionLossesDescription,
    //   basePainterDiagrams: [
    //     PriceMechanism(
    //       config: config,
    //       model: DiagramModel(
    //         type: DiagramType.priceMechanism,
    //         subtype: DiagramSubtype.loss,
    //       ),
    //     ),
    //     PerfectCompetition(
    //       config: config,
    //       model: DiagramModel(
    //
    //         type: DiagramType.perfectCompetition,
    //         subtype: DiagramSubtype.loss,
    //       ),
    //     ),
    //   ],
    // ),
    // DiagramBundle(
    //   unit: UnitType.micro,
    //   type: DiagramType.perfectCompetition,
    //   label: 'Social Welfare',
    //   description: kPerfectCompetitionSocialWelfareDescription,
    //   basePainterDiagrams: [
    //     PriceMechanism(
    //       config: config,
    //       model: DiagramModel(
    //
    //         type: DiagramType.priceMechanism,
    //         subtype: DiagramSubtype.socialWelfare,
    //       ),
    //     ),
    //     PerfectCompetition(
    //       config: config,
    //       model: DiagramModel(
    //
    //         type: DiagramType.perfectCompetition,
    //         subtype: DiagramSubtype.socialWelfare,
    //       ),
    //     ),
    //   ],
    // ),
    // DiagramBundle(
    //   basePainterDiagrams: [
    //     Monopoly(
    //       config: config,
    //       model: DiagramModel(
    //         type: DiagramType.monopoly,
    //         subtype: DiagramSubtype.abnormalProfit,
    //       ),
    //     ),
    //   ],
    // ),
    // DiagramBundle(
    //   basePainterDiagrams: [
    //     Monopoly(
    //       config: config,
    //       model: DiagramModel(
    //         type: DiagramType.monopoly,
    //         subtype: DiagramSubtype.loss,
    //       ),
    //     ),
    //   ],
    // ),
    // DiagramBundle(
    //   basePainterDiagrams: [
    //     Monopoly(
    //       config: config,
    //       model: DiagramModel(
    //         type: DiagramType.monopoly,
    //         subtype: DiagramSubtype.naturalMonopoly,
    //
    //       ),
    //     ),
    //   ],
    // ),
    // DiagramBundle(
    //   basePainterDiagrams: [
    //     Monopoly(
    //       config: config,
    //       model: DiagramModel(
    //         type: DiagramType.monopoly,
    //         subtype: DiagramSubtype.socialWelfare,
    //
    //       ),
    //     ),
    //   ],
    // ),
    // DiagramBundle(
    //   basePainterDiagrams: [
    //     MonopolisticCompetition(
    //       config: config,
    //       model: DiagramModel(
    //         type: DiagramType.monopolisticCompetition,
    //         subtype: DiagramSubtype.longRunEquilibrium,
    //       ),
    //     ),
    //   ],
    // ),
    // DiagramBundle(
    //   basePainterDiagrams: [
    //     MonopolisticCompetition(
    //       config: config,
    //       model: DiagramModel(
    //         type: DiagramType.monopolisticCompetition,
    //         subtype: DiagramSubtype.socialWelfare,
    //       ),
    //     ),
    //   ],
    // ),
    // DiagramBundle(
    //   basePainterDiagrams: [
    //     MonopolisticCompetition(
    //       config: config,
    //       model: DiagramModel(
    //         type: DiagramType.monopolisticCompetition,
    //         subtype: DiagramSubtype.abnormalProfit,
    //       ),
    //     ),
    //   ],
    // ),
    // DiagramBundle(
    //   basePainterDiagrams: [
    //     MonopolisticCompetition(
    //       config: config,
    //       model: DiagramModel(
    //         type: DiagramType.monopolisticCompetition,
    //         subtype: DiagramSubtype.loss,
    //       ),
    //     ),
    //   ],
    // ),
    // DiagramBundle(
    //   basePainterDiagrams: [
    //     Oligopoly(
    //       config: config,
    //       model: DiagramModel(
    //         type: DiagramType.oligopoly,
    //         subtype: DiagramSubtype.abnormalProfit,
    //       ),
    //     ),
    //   ],
    // ),
    //
    // /// Circular Flow Of Income Model
    // DiagramBundle(
    //   basePainterDiagrams: [
    //     CircularFlowOfIncome(
    //       config: config,
    //       model: DiagramModel(
    //         type: DiagramType.circularFlowOfIncome,
    //         subtype: DiagramSubtype.closedModel,
    //       ),
    //     ),
    //   ],
    // ),
    // DiagramBundle(
    //   basePainterDiagrams: [
    //     CircularFlowOfIncome(
    //       config: config,
    //       model: DiagramModel(
    //         type: DiagramType.circularFlowOfIncome,
    //         subtype: DiagramSubtype.openModel,
    //       ),
    //     ),
    //   ],
    // ),
    //
    // /// Aggregate Demand
    // DiagramBundle(basePainterDiagrams: [
    //   AggregateDemand(
    //     config: config,
    //     model: DiagramModel(
    //       type: DiagramType.aggregateDemand,
    //     ),
    //   ),
    // ]),
    // DiagramBundle(
    //   basePainterDiagrams: [
    //     AggregateDemand(
    //       config: config,
    //       model: DiagramModel(
    //         type: DiagramType.aggregateDemand,
    //         subtype: DiagramSubtype.determinants,
    //       ),
    //     ),
    //   ],
    // ),
    //
    // /// Classical ADAS
    // DiagramBundle(
    //   basePainterDiagrams: [
    //     ClassicalADAS(
    //       config: config,
    //       model: DiagramModel(
    //
    //         type: DiagramType.classicalADAS,
    //         subtype: DiagramSubtype.fullEmploymentClassical,
    //       ),
    //     ),
    //   ],
    // ),
    //
    // /// Keynesian ADAS
    // DiagramBundle(
    //   basePainterDiagrams: [
    //     KeynesianADAS(
    //       config: config,
    //       model: DiagramModel(
    //
    //         type: DiagramType.keynesianADAS,
    //         subtype: DiagramSubtype.fullEmploymentKeynesian,
    //       ),
    //     ),
    //   ],
    // ),
    //
    // /// Phillips Curve
    // DiagramBundle(
    //   basePainterDiagrams: [
    //     PhillipsCurve(
    //       config: config,
    //       model: DiagramModel(
    //
    //         type: DiagramType.phillipsCurve,
    //         subtype: DiagramSubtype.shortRun,
    //       ),
    //     ),
    //   ],
    // ),
    //
    // /// Money Market
    // DiagramBundle(
    //   basePainterDiagrams: [
    //     MoneyMarket(
    //       config: config,
    //       model: DiagramModel(
    //         type: DiagramType.moneyMarket,
    //
    //       ),
    //     ),
    //   ],
    // ),
    //
    // /// Demand-Side Policies
    // DiagramBundle(
    //   label: 'Demand-Side: Expansionary Monetary Policy',
    //   type: DiagramType.demandSidePolicies,
    //   description: kDemandSideExpansionaryMonetaryPolicyDescription,
    //   basePainterDiagrams: [
    //     MoneyMarket(
    //       config: config,
    //       model: DiagramModel(
    //         type: DiagramType.moneyMarket,
    //       ),
    //     ),
    //     ClassicalADAS(
    //       config: config,
    //       model: DiagramModel(type: DiagramType.classicalADAS),
    //     ),
    //   ],
    // ),
    // DiagramBundle(
    //   label: 'Demand-Side: Contractionary Monetary Policy',
    //   type: DiagramType.demandSidePolicies,
    //   description: kDemandSideContractionaryMonetaryPolicyDescription,
    //   basePainterDiagrams: [
    //     MoneyMarket(
    //       config: config,
    //       model: DiagramModel(
    //         type: DiagramType.moneyMarket,
    //       ),
    //     ),
    //     ClassicalADAS(
    //       config: config,
    //       model: DiagramModel(
    //         type: DiagramType.classicalADAS,
    //       ),
    //     ),
    //   ],
    // ),
    // DiagramBundle(
    //     label: 'Keynesian Multiplier (HL)',
    //     type: DiagramType.keynesianMultiplier,
    //     basePainterDiagrams: [
    //       KeynesianADAS(
    //         config: config,
    //         model: DiagramModel(
    //           subtype: DiagramSubtype.macro,
    //         ),
    //       ),
    //     ]),
    //
    // /// Supply-Side Policies
    // DiagramBundle(
    //   label: 'Long Term Growth',
    //   type: DiagramType.supplySidePolicies,
    //   description: kSupplySidePoliciesLongTermGrowthDescription,
    //   basePainterDiagrams: [
    //     ClassicalADAS(
    //       config: config,
    //       model: DiagramModel(
    //         type: DiagramType.classicalADAS,
    //         subtype: DiagramSubtype.increaseInSupply,
    //       ),
    //     ),
    //   ],
    // ),
    //
    // /// World Trade
    // DiagramBundle(
    //   label: 'International Trade - Exporter',
    //   description: kInternationalTradeExporterDescription,
    //   basePainterDiagrams: [
    //     InternationalTrade(
    //       config: config,
    //       model: DiagramModel(
    //         type: DiagramType.internationalTrade,
    //         subtype: DiagramSubtype.worldPrice,
    //       ),
    //     ),
    //     InternationalTrade(
    //         config: config,
    //         model: DiagramModel(
    //           type: DiagramType.internationalTrade,
    //           subtype: DiagramSubtype.exporter,
    //         )),
    //   ],
    // ),
    //
    // DiagramBundle(
    //   label: 'International Trade - Importer',
    //   basePainterDiagrams: [
    //     InternationalTrade(
    //         config: config,
    //         model: DiagramModel(
    //           type: DiagramType.internationalTrade,
    //           subtype: DiagramSubtype.worldPrice,
    //         )),
    //     InternationalTrade(
    //         config: config,
    //         model: DiagramModel(
    //           type: DiagramType.internationalTrade,
    //           subtype: DiagramSubtype.importer,
    //         ))
    //   ],
    // ),
    //
    // /// Comparative Advantage
    // DiagramBundle(
    //   basePainterDiagrams: [
    //     ComparativeAdvantage(
    //       config: config,
    //       model: DiagramModel(
    //         type: DiagramType.comparativeAdvantage,
    //         subtype: DiagramSubtype.absoluteAdvantage,
    //
    //       ),
    //     ),
    //   ],
    // ),
    // DiagramBundle(
    //   basePainterDiagrams: [
    //     ComparativeAdvantage(
    //       config: config,
    //       model: DiagramModel(
    //         type: DiagramType.comparativeAdvantage,
    //         subtype: DiagramSubtype.comparativeAdvantage,
    //
    //       ),
    //     ),
    //   ],
    // ),
    // DiagramBundle(
    //   basePainterDiagrams: [
    //     ComparativeAdvantage(
    //       config: config,
    //       model: DiagramModel(
    //         type: DiagramType.comparativeAdvantage,
    //         subtype: DiagramSubtype.noGainsFromTrade,
    //
    //       ),
    //     ),
    //   ],
    // ),
    //
    // /// Tariffs
    // DiagramBundle(
    //   basePainterDiagrams: [
    //     Tariff(
    //         config: config,
    //         model: DiagramModel(
    //
    //           type: DiagramType.tariff,
    //           subtype: DiagramSubtype.standard,
    //
    //         ))
    //   ],
    // ),
    // DiagramBundle(
    //   basePainterDiagrams: [
    //     Tariff(
    //         config: config,
    //         model: DiagramModel(
    //
    //           type: DiagramType.tariff,
    //           subtype: DiagramSubtype.socialWelfare,
    //
    //         ))
    //   ],
    // ),
    //
    // /// Import Quota
    // DiagramBundle(
    //   basePainterDiagrams: [
    //     ImportQuota(
    //         config: config,
    //         model: DiagramModel(
    //
    //           type: DiagramType.importQuota,
    //           subtype: DiagramSubtype.standard,
    //
    //         ))
    //   ],
    // ),
    // DiagramBundle(
    //   basePainterDiagrams: [
    //     ImportQuota(
    //         config: config,
    //         model: DiagramModel(
    //
    //           type: DiagramType.importQuota,
    //           subtype: DiagramSubtype.socialWelfare,
    //
    //         ))
    //   ],
    // ),
    //
    // /// Production Subsidy
    // DiagramBundle(
    //   basePainterDiagrams: [
    //     ProductionSubsidy(
    //         config: config,
    //         model: DiagramModel(
    //
    //           type: DiagramType.productionSubsidy,
    //           subtype: DiagramSubtype.standard,
    //
    //         ))
    //   ],
    // ),
    //
    // DiagramBundle(
    //   basePainterDiagrams: [
    //     ProductionSubsidy(
    //       config: config,
    //       model: DiagramModel(
    //
    //         type: DiagramType.productionSubsidy,
    //         subtype: DiagramSubtype.socialWelfare,
    //
    //       ),
    //     ),
    //   ],
    // ),
    //
    // /// Export Subsidy
    // DiagramBundle(
    //   basePainterDiagrams: [
    //     ExportSubsidy(
    //         config: config,
    //         model: DiagramModel(
    //
    //           type: DiagramType.exportSubsidy,
    //           subtype: DiagramSubtype.standard,
    //
    //         ))
    //   ],
    // ),
    // DiagramBundle(
    //   basePainterDiagrams: [
    //     ExportSubsidy(
    //       config: config,
    //       model: DiagramModel(
    //
    //         type: DiagramType.exportSubsidy,
    //         subtype: DiagramSubtype.socialWelfare,
    //
    //       ),
    //     ),
    //   ],
    // ),
    // DiagramBundle(
    //   basePainterDiagrams: [
    //     FloatingExchangeRate(
    //       config: config,
    //       model: DiagramModel(
    //         type: DiagramType.floatingExchangeRate,
    //         subtype: DiagramSubtype.equilibrium,
    //
    //       ),
    //     ),
    //   ],
    // ),
    // DiagramBundle(
    //   basePainterDiagrams: [
    //     FloatingExchangeRate(
    //       config: config,
    //       model: DiagramModel(
    //         type: DiagramType.floatingExchangeRate,
    //         subtype: DiagramSubtype.appreciationIncreaseInDemand,
    //
    //       ),
    //     ),
    //   ],
    // ),
    // DiagramBundle(
    //   basePainterDiagrams: [
    //     FloatingExchangeRate(
    //       config: config,
    //       model: DiagramModel(
    //         type: DiagramType.floatingExchangeRate,
    //         subtype: DiagramSubtype.appreciationDecreaseInSupply,
    //
    //       ),
    //     ),
    //   ],
    // ),
    // DiagramBundle(
    //   basePainterDiagrams: [
    //     FloatingExchangeRate(
    //       config: config,
    //       model: DiagramModel(
    //         type: DiagramType.floatingExchangeRate,
    //         subtype: DiagramSubtype.depreciationDecreaseInDemand,
    //       ),
    //     ),
    //   ],
    // ),
    // DiagramBundle(
    //   basePainterDiagrams: [
    //     FloatingExchangeRate(
    //       config: config,
    //       model: DiagramModel(
    //         type: DiagramType.floatingExchangeRate,
    //         subtype: DiagramSubtype.depreciationIncreaseInSupply,
    //       ),
    //     ),
    //   ],
    // ),
    // DiagramBundle(
    //   description: 'Managed Exchange Rate',
    //   basePainterDiagrams: [
    //     ManagedExchangeRate(
    //       config: config,
    //       model: DiagramModel(
    //         type: DiagramType.managedExchangeRate,
    //         subtype: DiagramSubtype.appreciationIncreaseInDemand,
    //       ),
    //     ),
    //   ],
    // ),
    // DiagramBundle(
    //   label: 'Fixed Rate - Central Bank Sells Domestic Currency',
    //   description: kFixedRateCentralBankSellsDomesticCurrency,
    //   basePainterDiagrams: [
    //     FixedExchangeRate(
    //       config: config,
    //       model: DiagramModel(
    //         type: DiagramType.fixedExchangeRate,
    //         subtype: DiagramSubtype.fixedRateIncreaseInDemand,
    //       ),
    //     ),
    //     FixedExchangeRate(
    //       config: config,
    //       model: DiagramModel(
    //         type: DiagramType.fixedExchangeRate,
    //         subtype: DiagramSubtype.fixedRateSellCurrency,
    //       ),
    //     ),
    //   ],
    // ),
    // DiagramBundle(
    //   label: 'Fixed Rate - Central Bank Raises Interest Rates',
    //   description: kFixedRateRaisesInterestRatesDescription,
    //   basePainterDiagrams: [
    //     FixedExchangeRate(
    //       config: config,
    //       model: DiagramModel(
    //         type: DiagramType.fixedExchangeRate,
    //         subtype: DiagramSubtype.fixedRateDecreaseInDemand,
    //       ),
    //     ),
    //     FixedExchangeRate(
    //       config: config,
    //       model: DiagramModel(
    //         type: DiagramType.fixedExchangeRate,
    //         subtype: DiagramSubtype.fixedRateRaiseInterestRates,
    //       ),
    //     ),
    //   ],
    // ),
    // DiagramBundle(
    //     description: kJCurveTradeDeficitDescription,
    //     basePainterDiagrams: [
    //       JCurve(
    //           config: config,
    //           model: DiagramModel(
    //             type: DiagramType.jCurve,
    //             subtype: DiagramSubtype.correctDeficit,
    //           ))
    //     ]),
    // DiagramBundle(
    //     description: kJCurveTradeSurplusDescription,
    //     basePainterDiagrams: [
    //       JCurve(
    //           config: config,
    //           model: DiagramModel(
    //             type: DiagramType.jCurve,
    //             subtype: DiagramSubtype.correctSurplus,
    //           ))
    //     ]),
    // DiagramBundle(label: 'Poverty Trap', basePainterDiagrams: [
    //   PovertyTrap(
    //       config: config,
    //       model: DiagramModel(
    //         type: DiagramType.povertyTrap,
    //         subtype: DiagramSubtype.standard,
    //       ))
    // ])
  ];
}
