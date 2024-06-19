import 'package:economics_app/sections/diagrams/custom_paint/diagrams/global_tariffs.dart';

import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../app/enums/sections.dart';

class DiagramsState {
  // final Section section;
  final CustomPainter diagram;

  DiagramsState(
      {
      // required this.section,
      required this.diagram});

  DiagramsState copyWith({Section? section, CustomPainter? diagram}) {
    return DiagramsState(
        // section: section ?? this.section,
        diagram: diagram ?? this.diagram);
  }
}

class DiagramsNotifier extends StateNotifier<DiagramsState> {
  DiagramsNotifier(super.state);

  // void setSectionSelected(Section section) {
  //   state = state.copyWith(section: section);
  // }

  void setDiagramSelected(CustomPainter diagram) {
    state = state.copyWith(diagram: diagram);
  }
}

final diagramsProvider = StateNotifierProvider<DiagramsNotifier, DiagramsState>(
  (ref) => DiagramsNotifier(
    DiagramsState(
      // section: Section.global,
      diagram: GlobalTariffs(),
    ),
  ),
);
