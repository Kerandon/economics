import 'package:economics_app/sections/diagrams/state/all_diagrams_state.dart';
import 'package:economics_app/sections/diagrams/utils/extensions.dart';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../app/configs/constants.dart';
import '../../../app/custom_widgets/custom_chip_button.dart';
import '../../quizzes/quiz_sections/completion/explanation_box.dart';
import '../custom_paint/custom_paint_diagrams.dart';
import '../data/all_diagrams.dart';
import '../enums/diagram_type.dart';

class DiagramContents extends ConsumerWidget {
  const DiagramContents({
    super.key,
    required this.subDiagrams,
    required this.index,
    required this.controller,
  });

  final List<DiagramType> subDiagrams;
  final int index;
  final ExpandableController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final diagramState = ref.watch(diagramsProvider);
    final diagramNotifier = ref.read(diagramsProvider.notifier);

    CustomPainter? selectedDiagramPainter;

    AllDiagrams allDiagrams = AllDiagrams(
      size: size,
      surfaceColor: Colors.black,
      onSurfaceColor: Colors.orange,
      primaryColor: Colors.red,
    );
    for (var d in allDiagrams.getAllDiagrams()) {
      if (d.name == diagramState.selectedDiagrams[index].name) {
        selectedDiagramPainter = d;
      }
    }
    List<DiagramType> subDiagramTypes = [];
    for (var d in DiagramType.values) {
      if (d.name.getWordsBetweenFirstAndSecondUnderscores() ==
          diagramState.selectedDiagrams[index].name
              .getWordsBetweenFirstAndSecondUnderscores()) {
        subDiagramTypes.add(d);
      }
    }

    subDiagramTypes.sort((a, b) => a.name.compareTo(b.name));

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: size.height * 0.01),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...subDiagrams.map(
                    (d) => CustomChipButton(
                      text: d.name.getWordsBetweenFirstAndSecondUnderscores(),
                      isSelected: diagramState.selectedDiagrams[index] == d,
                      onPressed: () {
                        diagramNotifier.setDiagramSelected(d, index);
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          if (selectedDiagramPainter != null && subDiagrams.isNotEmpty) ...[
            ExpandableNotifier(
              child: ExpandablePanel(
                controller: controller,
                collapsed: const SizedBox.shrink(),
                expanded: Column(
                  children: [
                    DiagramBox(customPainter: selectedDiagramPainter),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...subDiagramTypes.map(
                            (d) => CustomChipButton(
                              text: d.name.getWordsAfterSecondUnderscore(),
                              isSelected:
                                  diagramState.selectedDiagrams[index].name ==
                                      d.name,
                              onPressed: () {
                                diagramNotifier.setDiagramSelected(d, index);
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: size.width * 0.03,
                          horizontal: size.width * kPageIndentHorizontal),
                      child: ExplanationBox(
                          explanation: diagramState.selectedDiagrams[index]
                              .explanation()),
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    )
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
