import 'package:economics_app/sections/diagrams/custom_paint/diagrams/perfect_competition.dart';
import 'package:economics_app/sections/diagrams/custom_paint/diagrams/ppc_micro.dart';
import 'package:economics_app/sections/diagrams/models/diagram_model.dart';
import 'package:flutter/material.dart';
import '../custom_paint/diagrams/supply_and_demand.dart';
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
      DiagramBundle(
        unit: UnitType.micro,
        type: DiagramType.ppcMicro,
        basePainterDiagrams: [
          PPCMicro(
            config: config,
            model: DiagramModel(
                unit: UnitType.micro,
                type: DiagramType.ppcMicro,
                subtype: DiagramSubtype.opportunityCost),
          ),
        ],
      ),
      DiagramBundle(
        unit: UnitType.micro,
        type: DiagramType.perfectCompetition,
        label: 'Perfect Competition - Long-run Equilibrium',
        description:
            kPerfectCompetitionLongRunEquilibrium,
        basePainterDiagrams: [
          SupplyAndDemand(
            config: config,
            model: DiagramModel(
              unit: UnitType.micro,
              type: DiagramType.supplyDemand,
              subtype: DiagramSubtype.perfectCompetitionNormalProfit,
            ),
          ),
          PerfectCompetition(
            config: config,
            model: DiagramModel(
              unit: UnitType.micro,
              type: DiagramType.perfectCompetition,
              subtype: DiagramSubtype.perfectCompetitionNormalProfit,
            ),
          ),
        ],
      ),
      DiagramBundle(
        unit: UnitType.micro,
        type: DiagramType.perfectCompetition,
        label: 'Perfect Competition - Abnormal Profits',
        description: kPerfectCompetitionAbnormalProfitProcessDescription,
        basePainterDiagrams: [
          SupplyAndDemand(
            config: config,
            model: DiagramModel(
              unit: UnitType.micro,
              type: DiagramType.supplyDemand,
              subtype: DiagramSubtype.perfectCompetitionAbnormalProfit,
            ),
          ),
          PerfectCompetition(
            config: config,
            model: DiagramModel(
              unit: UnitType.micro,
              type: DiagramType.perfectCompetition,
              subtype: DiagramSubtype.perfectCompetitionAbnormalProfit,
            ),
          ),
        ],
      ),
      DiagramBundle(
        unit: UnitType.micro,
        type: DiagramType.perfectCompetition,
        label: 'Perfect Competition - Economic Losses',
        description: kPerfectCompetitionLossesDescription,
        basePainterDiagrams: [
          SupplyAndDemand(
            config: config,
            model: DiagramModel(
              unit: UnitType.micro,
              type: DiagramType.supplyDemand,
              subtype: DiagramSubtype.perfectCompetitionLoss,
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
        ],
      ),
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
