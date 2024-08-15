import 'package:economics_app/sections/diagrams/custom_paint/diagrams/global_export_subsidies.dart';
import 'package:economics_app/sections/diagrams/custom_paint/diagrams/global_forex.dart';
import 'package:economics_app/sections/diagrams/custom_paint/diagrams/global_j_curve.dart';
import 'package:economics_app/sections/diagrams/custom_paint/diagrams/global_production_subsidies.dart';
import 'package:economics_app/sections/diagrams/custom_paint/diagrams/global_quotas.dart';
import 'package:economics_app/sections/diagrams/custom_paint/diagrams/global_tariffs.dart';
import 'package:economics_app/sections/diagrams/custom_paint/diagrams/macro_business_cycle.dart';
import 'package:economics_app/sections/diagrams/custom_paint/diagrams/micro_monopolistic_competition.dart';
import 'package:economics_app/sections/diagrams/custom_paint/diagrams/micro_perfect_competition_long_run.dart';
import 'package:flutter/material.dart';
import '../custom_paint/diagrams/macro_circular_flow.dart';
import '../enums/diagram_type.dart';

List<CustomPainter> allDiagrams = [
  MicroPerfectCompetition(
      type: DiagramType.micro_PerfectCompetition_LongRun_Default),
  MicroPerfectCompetition(
      type: DiagramType.micro_PerfectCompetition_AbnormalProfits),
  MicroPerfectCompetition(
      type: DiagramType.micro_PerfectCompetition_EconomicLosses),
  MicroMonopolisticCompetition(),
  MicroMonopolisticCompetition(
      type: DiagramType.micro_MonopolisticCompetition_WelfareLoss),
  MicroMonopolisticCompetition(
      type: DiagramType.micro_MonopolisticCompetition_AbnormalProfits),
  MicroMonopolisticCompetition(
      type: DiagramType.micro_MonopolisticCompetition_EconomicLosses),
  MicroMonopolisticCompetition(
      type: DiagramType.micro_MonopolisticCompetition_WelfareAnalysis),
  MacroBusinessCycle(),
  MacroCircularFlow(
      type: DiagramType.macro_CircularFlowOfIncome_Closed_Default),
  MacroCircularFlow(type: DiagramType.macro_CircularFlowOfIncome_Equivalence),
  MacroCircularFlow(type: DiagramType.macro_CircularFlowOfIncome_Open),
  GlobalTariffs(type: DiagramType.global_Tariffs_Standard_Default),
  GlobalTariffs(type: DiagramType.global_Tariffs_Calculation),
  GlobalTariffs(type: DiagramType.global_Tariffs_Labels),
  GlobalQuotas(),
  GlobalQuotas(type: DiagramType.global_Quotas_Labels),
  GlobalQuotas(type: DiagramType.global_Quotas_Calculation),
  GlobalProductionSubsidies(),
  GlobalProductionSubsidies(
      type: DiagramType.global_ProductionSubsidies_Calculation),
  GlobalExportSubsidies(),
  GlobalExportSubsidies(type: DiagramType.global_ExportSubsidies_Calculation),
  GlobalForex(),
  GlobalForex(type: DiagramType.global_Forex_DemandIncrease),
  GlobalForex(type: DiagramType.global_Forex_DemandDecrease),
  GlobalForex(type: DiagramType.global_Forex_SupplyIncrease),
  GlobalForex(type: DiagramType.global_Forex_SupplyDecrease),
  GlobalJCurve(),
  GlobalJCurve(type: DiagramType.global_JCurve_CorrectingTradeSurplus),
];
