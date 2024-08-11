import 'package:economics_app/sections/diagrams/state/all_diagrams_state.dart';
import 'package:economics_app/sections/diagrams/utils/extensions.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../app/configs/constants.dart';
import '../../../app/custom_widgets/custom_chip_button.dart';
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

    for (var d in allDiagrams) {
      if (d.name == diagramState.selectedDiagrams[index].name) {
        selectedDiagramPainter = d;
      }
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: size.width * 0.04),
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
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: size.width * 0.01,
                          horizontal: size.width * kPageIndentHorizontal),
                      child: HtmlWidget(subDiagrams[index].explanation()),
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
