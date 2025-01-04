import 'package:economics_app/sections/diagrams/custom_paint/diagrams/updated_diagrams/perfect_competition.dart';
import 'package:economics_app/sections/diagrams/models/diagram_model.dart';
import 'package:flutter/material.dart';

import '../custom_paint/diagrams/updated_diagrams/negative_production_externalities.dart';
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
      PerfectCompetition(
        config: config,
        model: DiagramModel(
          unit: UnitType.micro,
          type: DiagramType.perfectCompetition,
          subtype: DiagramSubtype.longRunEquilibrium,
        ),
      ),
    ];
  }
}
