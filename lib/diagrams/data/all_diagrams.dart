import 'package:flutter/material.dart';
import '../enums/diagram_bundle_enum.dart';
import '../models/diagram_bundle.dart';
import '../models/diagram_model.dart';
import '../models/diagram_painter_config.dart';
import '../mixins/mixins.dart';
import 'get_bundle_list.dart';

class AllDiagrams {
  final Size size;
  final ColorScheme colorScheme;

  AllDiagrams({required this.size, required this.colorScheme});

  DiagramBundle? getDiagramBundle(DiagramBundleEnum diagramBundleEnum) {
    final bundles = getDiagramBundles(diagramBundleEnums: [diagramBundleEnum]);
    return bundles.isNotEmpty ? bundles.first : null;
  }

  List<DiagramBundle> getDiagramBundles({
    List<DiagramBundleEnum>? diagramBundleEnums, // optional filtering
    bool getAll = false, // new param, default false
  }) {
    final config = DiagramPainterConfig(
      painterSize: size,
      appSize: Size(size.width, size.height),
      colorScheme: colorScheme,
    );

    // Create bundles
    final allBundles = getBundleList(config).toList();

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
      allBundles[i] = allBundles[i].copyWith(diagramModels: tempModels);
    }

    if (getAll) {
      // Return all bundles
      return List.of(allBundles);
    } else if (diagramBundleEnums?.isNotEmpty ?? false) {
      // Filter by provided enums
      return allBundles
          .where(
            (bundle) => diagramBundleEnums!.contains(bundle.diagramBundleEnum),
          )
          .toList();
    } else {
      // Default: no bundles returned
      return [];
    }
  }
}
