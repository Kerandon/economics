import 'package:economics_app/sections/diagrams/custom_paint/diagrams/circular_flow_of_income.dart';
import 'package:economics_app/sections/diagrams/custom_paint/diagrams/classical_adas.dart';
import 'package:economics_app/sections/diagrams/custom_paint/diagrams/floating_exchange_rate.dart';
import 'package:economics_app/sections/diagrams/custom_paint/diagrams/international_trade.dart';
import 'package:economics_app/sections/diagrams/custom_paint/diagrams/j_curve.dart';
import 'package:economics_app/sections/diagrams/custom_paint/diagrams/keynesian_adas.dart';
import 'package:economics_app/sections/diagrams/custom_paint/diagrams/monopoly.dart';
import 'package:economics_app/sections/diagrams/custom_paint/diagrams/perfect_competition.dart';
import 'package:economics_app/sections/diagrams/custom_paint/diagrams/phillips_curve.dart';
import 'package:economics_app/sections/diagrams/custom_paint/diagrams/poverty_trap.dart';
import 'package:economics_app/sections/diagrams/custom_paint/diagrams/ppc_micro.dart';
import 'package:economics_app/sections/diagrams/custom_paint/diagrams/production_subsidy.dart';
import 'package:economics_app/sections/diagrams/custom_paint/diagrams/tariff.dart';
import 'package:economics_app/sections/diagrams/models/diagram_model.dart';
import 'package:flutter/material.dart';
import '../custom_paint/diagrams/business_cycle.dart';
import '../custom_paint/diagrams/comparative_advantage.dart';
import '../custom_paint/diagrams/export_subsidy.dart';
import '../custom_paint/diagrams/externalities.dart';
import '../custom_paint/diagrams/fixed_exchange_rate.dart';
import '../custom_paint/diagrams/import_quota.dart';
import '../custom_paint/diagrams/supply_and_demand.dart';
import '../enums/diagram_subtype.dart';
import '../enums/diagram_type.dart';
import '../enums/unit_type.dart';
import '../models/base_painter_painter.dart';
import '../models/diagram_painter_config.dart';

class AllDiagrams {
  final Size size;
  final ColorScheme colorScheme;

  AllDiagrams({
    required this.size,
    required this.colorScheme,
  });

  List<BaseDiagramPainter> getAllPainterDiagrams() {
    // Create the shared config instance
    final config = DiagramPainterConfig(
      painterSize: size,
      appSize: Size(size.width, size.height),
      colorScheme: colorScheme,
    );
    return [
      PPCMicro(
        config: config,
        model: DiagramModel(
          unit: UnitType.micro,
          type: DiagramType.ppcMicro,
          subtype: DiagramSubtype.opportunityCost,
          description: 'A movement from X to Y on the PPC shows 50 tablets must be given up to gain 30 smart phones. Therefore one smartphone has an opportunity cost of 1.67 tablets (50/30)'
        ),
      ),
      PPCMicro(
        config: config,
        model: DiagramModel(
            unit: UnitType.micro,
            type: DiagramType.ppcMicro,
            subtype: DiagramSubtype.increasingOpportunityCost,
            description: 'As production shifts from point X to point Y, the economy gains 30 smartphones but sacrifices 50 tablets. However, moving further from point Y to point Z, another 50 tablets must be given up for a gain of only 10 smartphones. This illustrates that as more smartphones are produced, increasingly more tablets must be given up for each additional unit.'
        ),
      ),
      PPCMicro(
        config: config,
        model: DiagramModel(
            unit: UnitType.micro,
            type: DiagramType.ppcMicro,
            subtype: DiagramSubtype.constantOpportunityCost,
            description: 'A linear PPC shows constant opportunity costs. A movement from X to Y will gain 30 smartphones at a cost of 50 tablets. A movement from Y to Z will also result in a gain of 30 smartphones at a cost of 50 smartphones. The opportunity cost of 3/5 of a smartphone for every new tablet is constant along the PPC.'
        ),
      ),
      PPCMicro(
        config: config,
        model: DiagramModel(
            unit: UnitType.micro,
            type: DiagramType.ppcMicro,
            subtype: DiagramSubtype.outputPoints,
            description: 'Output at point Y shows unemployment or inefficient use of resources. Point X, Y & Z all represent full employment of resources with maximum efficiency. Point W represents unattainable output given the economy\'s current resources.'
        ),
      ),
      PPCMicro(
        config: config,
        model: DiagramModel(
            unit: UnitType.micro,
            type: DiagramType.ppcMicro,
            subtype: DiagramSubtype.increaseInPotentialOutput,
            description: 'An increase in the PPC reflects an increase in potential output (production possibilities) of an economy. This is caused by an increase in the quantity and quality of resources in an economy, such as improved education or advancements in technology.'
        ),
      ),
      PPCMicro(
        config: config,
        model: DiagramModel(
            unit: UnitType.micro,
            type: DiagramType.ppcMicro,
            subtype: DiagramSubtype.decreaseInPotentialOutput,
            description: 'A decrease in the PPC reflects a decrease in potential output. This is usually a more rare occurrence, but could be caused by a falling population or the result of a significant natural disaster.'
        ),
      ),
      PPCMicro(
        config: config,
        model: DiagramModel(
            unit: UnitType.micro,
            type: DiagramType.ppcMicro,
            subtype: DiagramSubtype.growth,
            description: 'A movement from W to X represents actual growth (short-term growth) caused by 1. increased employment of resources, or 2. increased efficiency in the use of resources. Point Y to Z is an outward shift of the PPC curve and represents an increase in potential (long-term) output.'
        ),
      ),
      SupplyAndDemand(
        config: config,
        model: DiagramModel(
          unit: UnitType.micro,
          type: DiagramType.supplyDemand,
          subtype: DiagramSubtype.equilibrium,
          description: 'The market is in equilibrium when the quantity demanded is equal to the quantity supplied at the market price.'
        ),
      ),
      SupplyAndDemand(
        config: config,
        model: DiagramModel(
          unit: UnitType.micro,
          type: DiagramType.supplyDemand,
          subtype: DiagramSubtype.increaseInDemand,
          description: "An increase in demand shifts the demand curve to the right, resulting in a higher market price and increased quantity supplied as the market adjusts to the new equilibrium."

        ),
      ),
      SupplyAndDemand(
        config: config,
        model: DiagramModel(
          unit: UnitType.micro,
          type: DiagramType.supplyDemand,
          subtype: DiagramSubtype.decreaseInDemand,
          description: "A decrease in demand shifts the demand curve to the left, causing the market price to fall and the quantity supplied to decrease as the market adjusts to the new equilibrium."
        ),
      ),
      SupplyAndDemand(
        config: config,
        model: DiagramModel(
          unit: UnitType.micro,
          type: DiagramType.supplyDemand,
          subtype: DiagramSubtype.increaseInSupply,
          description: "An increase in supply shifts the supply curve to the right, leading to a lower market price and increased quantity demanded as the market reaches the new equilibrium."

        ),
      ),
      SupplyAndDemand(
        config: config,
        model: DiagramModel(
          unit: UnitType.micro,
          type: DiagramType.supplyDemand,
          subtype: DiagramSubtype.decreaseInSupply,
          description: "A decrease in supply shifts the supply curve to the left, causing the market price to rise and the quantity demanded to decrease as the market adjusts to the new equilibrium."

        ),
      ),
      SupplyAndDemand(
        config: config,
        model: DiagramModel(
          unit: UnitType.micro,
          type: DiagramType.supplyDemand,
          subtype: DiagramSubtype.shortage,
          description: "A shortage occurs when the quantity demanded exceeds the quantity supplied at a given price, causing upward pressure on prices as the market moves towards equilibrium."


        ),
      ),
      SupplyAndDemand(
        config: config,
        model: DiagramModel(
          unit: UnitType.micro,
          type: DiagramType.supplyDemand,
          subtype: DiagramSubtype.surplus,
          description: "A surplus occurs when the quantity supplied exceeds the quantity demanded at a given price, leading to downward pressure on prices as the market adjusts to reach equilibrium."

        ),
      ),
      Externalities(
        config: config,
        model: DiagramModel(
          unit: UnitType.micro,
          type: DiagramType.externalities,
          subtype: DiagramSubtype.negativeProduction,
        ),
      ),
      Externalities(
        config: config,
        model: DiagramModel(
          unit: UnitType.micro,
          type: DiagramType.externalities,
          subtype: DiagramSubtype.negativeConsumption,
        ),
      ),
      Externalities(
        config: config,
        model: DiagramModel(
          unit: UnitType.micro,
          type: DiagramType.externalities,
          subtype: DiagramSubtype.positiveProduction,
        ),
      ),
      Externalities(
        config: config,
        model: DiagramModel(
          unit: UnitType.micro,
          type: DiagramType.externalities,
          subtype: DiagramSubtype.positiveConsumption,
        ),
      ),
      PerfectCompetition(
        config: config,
        model: DiagramModel(
          unit: UnitType.micro,
          type: DiagramType.perfectCompetition,
          subtype: DiagramSubtype.perfectCompetitionNormalProfit,
          description: "The firm always produces at the profit maximizing quantity where MC=MR. In the long run, this is also where: AR=AC (normal profit), P=MC (allocatively efficient), and MC=AC (productively efficient)."
        ),
      ),
      PerfectCompetition(
        config: config,
        model: DiagramModel(
            unit: UnitType.micro,
            type: DiagramType.perfectCompetition,
            subtype: DiagramSubtype.perfectCompetitionAbnormalProfit,
            description: "(AR > AC) X Q -> Abnormal profit is only possible in the short-run. Due to no barriers of entry, more firms will enter the market, increasing the supply of firms, pushing down the market price until all abnormal profits are eliminated"
        ),
      ),
      PerfectCompetition(
        config: config,
        model: DiagramModel(
            unit: UnitType.micro,
            type: DiagramType.perfectCompetition,
            subtype: DiagramSubtype.perfectCompetitionLoss,
        ),
      ),
      Monopoly(
        config: config,
        model: DiagramModel(
          unit: UnitType.micro,
          type: DiagramType.monopoly,
          subtype: DiagramSubtype.monopolyAbnormalProfit,
        ),
      ),
      Monopoly(
        config: config,
        model: DiagramModel(
          unit: UnitType.micro,
          type: DiagramType.monopoly,
          subtype: DiagramSubtype.monopolyNormalProfit,
        ),
      ),
      Monopoly(
        config: config,
        model: DiagramModel(
          unit: UnitType.micro,
          type: DiagramType.monopoly,
          subtype: DiagramSubtype.monopolyLoss,
        ),
      ),
      CircularFlowOfIncome(
        config: config,
        model: DiagramModel(
          unit: UnitType.micro,
          type: DiagramType.circularFlowOfIncome,
          subtype: DiagramSubtype.closed,
        ),
      ),
      BusinessCycle(
        config: config,
        model: DiagramModel(
          unit: UnitType.macro,
          type: DiagramType.businessCycle,
          subtype: DiagramSubtype.standard,
        ),
      ),
      PPCMicro(
        config: config,
        model: DiagramModel(
            unit: UnitType.macro,
            type: DiagramType.ppcMacro,
            subtype: DiagramSubtype.macro,
            description:
                'If a country decides to allocate more of its scare resources towards the production of consumer goods. This would result in a movement from X to Y on the PPC.'),
      ),
      KeynesianADAS(
        config: config,
        model: DiagramModel(
          unit: UnitType.macro,
          type: DiagramType.keynesianADAS,
          subtype: DiagramSubtype.fullEmployment,
        ),
      ),
      ClassicalADAS(
        config: config,
        model: DiagramModel(
          unit: UnitType.macro,
          type: DiagramType.classicalADAS,
          subtype: DiagramSubtype.fullEmployment,
        ),
      ),
      PhillipsCurve(
        config: config,
        model: DiagramModel(
          unit: UnitType.macro,
          type: DiagramType.phillipsCurve,
          subtype: DiagramSubtype.shortRun,
        ),
      ),
      InternationalTrade(
        config: config,
        model: DiagramModel(
          unit: UnitType.global,
          type: DiagramType.internationalTrade,
          subtype: DiagramSubtype.exporter,
        ),
      ),
      InternationalTrade(
        config: config,
        model: DiagramModel(
          unit: UnitType.global,
          type: DiagramType.internationalTrade,
          subtype: DiagramSubtype.importer,
        ),
      ),
      ComparativeAdvantage(
        config: config,
        model: DiagramModel(
          unit: UnitType.global,
          type: DiagramType.comparativeAdvantage,
          subtype: DiagramSubtype.standard,
        ),
      ),
      Tariffs(
        config: config,
        model: DiagramModel(
          unit: UnitType.global,
          type: DiagramType.tariffs,
          subtype: DiagramSubtype.shortRun,
        ),
      ),
      ImportQuota(
        config: config,
        model: DiagramModel(
          unit: UnitType.global,
          type: DiagramType.importQuota,
          subtype: DiagramSubtype.standard,
        ),
      ),
      ProductionSubsidy(
        config: config,
        model: DiagramModel(
          unit: UnitType.global,
          type: DiagramType.productionSubsidy,
          subtype: DiagramSubtype.standard,
        ),
      ),
      ExportSubsidy(
        config: config,
        model: DiagramModel(
          unit: UnitType.global,
          type: DiagramType.exportSubsidy,
          subtype: DiagramSubtype.standard,
        ),
      ),
      FloatingExchangeRate(
        config: config,
        model: DiagramModel(
          unit: UnitType.global,
          type: DiagramType.floatingExchangeRate,
          subtype: DiagramSubtype.standard,
        ),
      ),
      FixedExchangeRate(
        config: config,
        model: DiagramModel(
          unit: UnitType.global,
          type: DiagramType.fixedExchangeRate,
          subtype: DiagramSubtype.standard,
        ),
      ),
      JCurve(
        config: config,
        model: DiagramModel(
          unit: UnitType.global,
          type: DiagramType.jCurve,
          subtype: DiagramSubtype.standard,
        ),
      ),
      PovertyTrap(
        config: config,
        model: DiagramModel(
          unit: UnitType.global,
          type: DiagramType.povertyTrap,
          subtype: DiagramSubtype.standard,
        ),
      )
    ];
  }
}







