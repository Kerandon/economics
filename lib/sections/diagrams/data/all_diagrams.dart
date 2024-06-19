import 'package:economics_app/sections/diagrams/custom_paint/diagrams/global_export_subsidies.dart';
import 'package:economics_app/sections/diagrams/custom_paint/diagrams/global_production_subsidies.dart';
import 'package:economics_app/sections/diagrams/custom_paint/diagrams/global_tariffs.dart';
import 'package:economics_app/sections/diagrams/custom_paint/diagrams/macro_business_cycle.dart';
import 'package:economics_app/sections/diagrams/diagram_enums/diagram_type.dart';
import 'package:flutter/material.dart';
import '../custom_paint/diagrams/macro_circular_flow_open.dart';

List<CustomPainter> allDiagrams = [
  MacroCircularFlowOfIncomeOpen(),
  MacroCircularFlowOfIncomeOpen(
      type: DiagramType.macroCircularFlowOfIncomeClosed),
  MacroBusinessCycle(),
  GlobalTariffs(),
  GlobalTariffs(type: DiagramType.globalTariffsCalculation),
  GlobalTariffs(type: DiagramType.globalTariffsLabels),
  GlobalProductionSubsidies(),
  GlobalProductionSubsidies(
      type: DiagramType.globalProductionSubsidiesCalculation),
  GlobalExportSubsidies(),
  GlobalExportSubsidies(type: DiagramType.globalExportSubsidiesCalculation),
];
