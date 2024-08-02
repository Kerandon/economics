import 'package:economics_app/app/configs/constants.dart';
import 'package:economics_app/app/custom_widgets/custom_chip_button.dart';
import 'package:economics_app/app/custom_widgets/custom_page_heading.dart';
import 'package:economics_app/app/utils/helper_methods/string_extensions.dart';
import 'package:economics_app/sections/diagrams/custom_paint/diagrams/macro_business_cycle.dart';
import 'package:economics_app/sections/diagrams/custom_paint/diagrams/micro_monopolistic_competition.dart';
import 'package:economics_app/sections/diagrams/data/all_diagrams.dart';
import 'package:economics_app/sections/diagrams/state/all_diagrams_state.dart';
import 'package:economics_app/sections/diagrams/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../app/custom_widgets/custom_divider.dart';
import '../../app/enums/sections.dart';
import 'custom_paint/custom_paint_diagrams.dart';
import 'custom_paint/diagrams/global_export_subsidies.dart';
import 'custom_paint/painter_constants.dart';
import 'enums/diagram_type.dart';

class AllDiagramsPage extends ConsumerWidget {
  const AllDiagramsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final diagramsState = ref.watch(diagramsProvider);
    final diagramsNotifier = ref.read(diagramsProvider.notifier);

    List<CustomPainter> selectedDiagrams = [];
    List<CustomPainter> subDiagrams = [];

    for (var d in allDiagrams) {
      if (d.name.getFirstWord() == diagramsState.diagram.name.getFirstWord()) {
        if (d.name.getWordsAfterThirdUnderscore() == kDefault) {
          selectedDiagrams.add(d);
        }
      }
    }

    for (var d in allDiagrams) {
      if (d.name.getWordsBetweenFirstAndSecondUnderscores().contains(
          diagramsState.diagram.name
              .getWordsBetweenFirstAndSecondUnderscores())) {
        subDiagrams.add(d);
      }
    }

    final selectedDiagram = DiagramType.values
        .firstWhere((element) => element.name == diagramsState.diagram.name);

    return NestedScrollView(
      floatHeaderSlivers: true,
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          const CustomPageHeading(
            icon: Icon(Icons.ssid_chart,),
            title: 'Diagrams',
          ),
        ];
      },
      body: SingleChildScrollView(
        child: Column(
          children: [
            Wrap(
              alignment: WrapAlignment.center,
              spacing: kWrapSpacing * size.width,
              children: Section.values.map((section) {
                bool selected = false;
                if (section.name.getFirstWord() ==
                    diagramsState.diagram.name.getFirstWord()) {
                  selected = true;
                }
                return CustomChipButton(
                    text: section.name.capitalizeFirstLetter(),
                    isSelected: selected,
                    onPressed: () {
                      switch (section) {
                        case Section.intro:
                          diagramsNotifier
                              .setDiagramSelected(GlobalExportSubsidies());
                        case Section.micro:
                          diagramsNotifier.setDiagramSelected(
                              MicroMonopolisticCompetition());
                        case Section.macro:
                          diagramsNotifier
                              .setDiagramSelected(MacroBusinessCycle());
                        case Section.global:
                          diagramsNotifier
                              .setDiagramSelected(GlobalExportSubsidies());
                      }
                    });
              }).toList(),
            ),
            const CustomDivider(),
            Wrap(
                alignment: WrapAlignment.center,
                spacing: kWrapSpacing * size.width,
                children: selectedDiagrams.map((diagram) {
                  bool selected = false;

                  if (diagram.name.getWordsBetweenFirstAndSecondUnderscores() ==
                      diagramsState.diagram.name
                          .getWordsBetweenFirstAndSecondUnderscores()) {
                    selected = true;
                  }

                  return CustomChipButton(
                      text: diagram.name
                          .getWordsBetweenFirstAndSecondUnderscores(),
                      isSelected: selected,
                      onPressed: () {
                        diagramsNotifier.setDiagramSelected(diagram);
                      });
                }).toList()),
            DiagramBox(customPainter: diagramsState.diagram),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: kWrapSpacing * size.width,
              children: [
                ...subDiagrams.map((diagram) {
                  bool selected = false;

                  if (diagram.name == diagramsState.diagram.name) {
                    selected = true;
                  }

                  return CustomChipButton(
                      text: diagram.name.getWordsAfterSecondUnderscore(),
                      isSelected: selected,
                      onPressed: () {
                        diagramsNotifier.setDiagramSelected(diagram);
                      });
                }),
              ],
            ),
            ...[
              Padding(
                padding: const EdgeInsets.all(28.0),
                child: HtmlWidget(selectedDiagram.explanation()),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
