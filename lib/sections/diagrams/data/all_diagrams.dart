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
import 'package:economics_app/sections/diagrams/custom_paint/diagrams/ppc.dart';
import 'package:economics_app/sections/diagrams/custom_paint/diagrams/production_subsidy.dart';
import 'package:economics_app/sections/diagrams/custom_paint/diagrams/tariff.dart';
import 'package:economics_app/sections/diagrams/models/diagram_model.dart';
import 'package:flutter/material.dart';

import '../custom_paint/diagrams/business_cycle.dart';
import '../custom_paint/diagrams/comparative_advantage.dart';
import '../custom_paint/diagrams/export_subsidy.dart';
import '../custom_paint/diagrams/fixed_exchange_rate.dart';
import '../custom_paint/diagrams/import_quota.dart';
import '../custom_paint/diagrams/negative_production_externalities.dart';
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
      NegativeProductionExternalities(
        config: config,
        model: DiagramModel(
          unit: UnitType.micro,
          type: DiagramType.negativeProductionExternalities,
          subtype: DiagramSubtype.commonPoolResources,
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
      Monopoly(
        config: config,
        model: DiagramModel(
          unit: UnitType.micro,
          type: DiagramType.monopoly,
          subtype: DiagramSubtype.abnormalProfit,
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
      PPC(
        config: config,
        model: DiagramModel(
          unit: UnitType.macro,
          type: DiagramType.ppc,
          subtype: DiagramSubtype.macro,
        ),
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
          subtype: DiagramSubtype.importer,
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
