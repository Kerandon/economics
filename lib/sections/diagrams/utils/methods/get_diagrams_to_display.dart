import 'package:economics_app/sections/diagrams/data/all_diagrams.dart';
import 'package:economics_app/sections/diagrams/models/diagram_model.dart';
import 'package:economics_app/sections/diagrams/utils/mixins.dart';
import 'package:flutter/material.dart';

List<CustomPainter> getDiagramsToDisplay(
    Size size, BuildContext context, List<DiagramModel> selectedDiagrams) {
  final allDiagrams = AllDiagrams(
    size: size,
    surfaceColor: Theme.of(context).colorScheme.surface,
    onSurfaceColor: Theme.of(context).colorScheme.onSurface,
    primaryColor: Theme.of(context).colorScheme.primary,
  ).getAllDiagrams();

  List<CustomPainter> selectedPainterDiagrams = [];
  for (var s in selectedDiagrams) {
    for (var e in allDiagrams) {
      final i = e as DiagramIdentifierMixin;

      if (i.model.type == s.type && i.model.subtype == s.subtype) {
        selectedPainterDiagrams.add(e);
      }
    }
  }
  return selectedPainterDiagrams;
}
