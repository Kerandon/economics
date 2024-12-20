import 'package:economics_app/sections/diagrams/models/diagram_model.dart';
import 'package:flutter/material.dart';

import '../custom_paint/diagrams/updated_diagrams/circular_flow_of_income.dart';
import '../custom_paint/diagrams/updated_diagrams/perfect_competition.dart';

class AllDiagrams {
  final Size size;
  final Color surfaceColor;
  final Color onSurfaceColor;
  final Color primaryColor;

  AllDiagrams({
    required this.size,
    required this.surfaceColor,
    required this.onSurfaceColor,
    required this.primaryColor,
  });

  List<CustomPainter> getAllDiagrams() {
    return [
      PerfectCompetition(
        appSize: size,
        surfaceColor: surfaceColor,
        onSurfaceColor: onSurfaceColor,
        primaryColor: primaryColor,
        diagramModel: DiagramModel(
          unit: UnitType.micro,
          type: DiagramType.perfectCompetition,
          subtype: DiagramSubtype.longRunEquilibrium,
        ),
      ),
      CircularFlowOfIncome(
        appSize: size,
        surfaceColor: surfaceColor,
        onSurfaceColor: onSurfaceColor,
        primaryColor: primaryColor,
        diagramModel: DiagramModel(
          unit: UnitType.macro,
          type: DiagramType.circularFlowOfIncome,
          subtype: DiagramSubtype.closed,
        ),
      )
    ];
  }
}
