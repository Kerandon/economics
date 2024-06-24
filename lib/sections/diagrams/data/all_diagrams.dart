import 'package:economics_app/sections/diagrams/custom_paint/diagrams/global_export_subsidies.dart';
import 'package:economics_app/sections/diagrams/custom_paint/diagrams/global_forex.dart';
import 'package:economics_app/sections/diagrams/custom_paint/diagrams/global_j_curve.dart';
import 'package:economics_app/sections/diagrams/custom_paint/diagrams/global_production_subsidies.dart';
import 'package:economics_app/sections/diagrams/custom_paint/diagrams/global_quotas.dart';
import 'package:economics_app/sections/diagrams/custom_paint/diagrams/global_tariffs.dart';
import 'package:economics_app/sections/diagrams/diagram_enums/diagram_type.dart';
import 'package:flutter/material.dart';

List<CustomPainter> allDiagrams = [
  GlobalTariffs(),
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
  GlobalJCurve(type: DiagramType.global_JCurve_Inverse),
];
