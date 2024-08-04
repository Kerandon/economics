import 'package:economics_app/app/configs/constants.dart';
import 'package:economics_app/app/custom_widgets/custom_chip_button.dart';
import 'package:economics_app/app/custom_widgets/custom_page_heading.dart';
import 'package:economics_app/app/utils/helper_methods/string_extensions.dart';
import 'package:economics_app/sections/diagrams/custom_paint/diagrams/macro_business_cycle.dart';
import 'package:economics_app/sections/diagrams/custom_paint/diagrams/micro_monopolistic_competition.dart';
import 'package:economics_app/sections/diagrams/data/all_diagrams.dart';
import 'package:economics_app/sections/diagrams/state/all_diagrams_state.dart';
import 'package:economics_app/sections/diagrams/utils/extensions.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../app/custom_widgets/custom_divider.dart';
import '../../app/enums/sections.dart';
import '../../app/utils/helper_methods/get_section_icon.dart';
import 'custom_paint/custom_paint_diagrams.dart';
import 'custom_paint/diagrams/global_export_subsidies.dart';
import 'custom_paint/painter_constants.dart';
import 'enums/diagram_type.dart';

class AllDiagramsPage extends ConsumerStatefulWidget {
  const AllDiagramsPage({super.key});

  @override
  ConsumerState<AllDiagramsPage> createState() => _AllDiagramsPageState();
}

class _AllDiagramsPageState extends ConsumerState<AllDiagramsPage> {
  final List<ExpandableController> _expandableControllers = [];
  bool allTilesCollapsed = true;
  @override

  void initState() {

    for (int i = 0; i < 4; i++) {
      _expandableControllers.add(ExpandableController());
      _expandableControllers[i].addListener(() {
        if (_expandableControllers.any((c) => c.expanded)) {
          allTilesCollapsed = false;
        } else {
          allTilesCollapsed = true;
        }
      });
    }

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
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

    final sectionSelected = getSectionSelected(selectedDiagram);


    return NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            CustomPageHeading(
              expandableControllers: _expandableControllers,
              allTilesCollapsed: allTilesCollapsed,
              icon: Icon(
                Icons.ssid_chart,
              ),
              title: 'Diagrams',
            ),
          ];
        },
        body: ListView(
          children: [
            Column(
              children: [
                ExpandableNotifier(
                  controller: _expandableControllers[0],
                  child: ExpandablePanel(
                    header: ListTile(
                      leading: Icon(getSectionIcon(sectionSelected)),
                      title: Text('Section'),
                    ),
                    collapsed: const SizedBox.shrink(),
                    expanded: Column(
                      children: [
                        Wrap(
                          alignment: WrapAlignment.center,
                          spacing: kWrapSpacing * size.width,
                          children: Section.values.map(
                            (section) {
                              bool selected = false;
                              if (section.name.getFirstWord() ==
                                  diagramsState.diagram.name.getFirstWord()) {
                                selected = true;
                              }
                              return CustomChipButton(
                                icon: getSectionIcon(section),
                                text: section.name.capitalizeFirstLetter(),
                                isSelected: selected,
                                onPressed: () {
                                  switch (section) {
                                    case Section.intro:
                                      diagramsNotifier.setDiagramSelected(
                                          GlobalExportSubsidies());
                                    case Section.micro:
                                      diagramsNotifier.setDiagramSelected(
                                          MicroMonopolisticCompetition());
                                    case Section.macro:
                                      diagramsNotifier.setDiagramSelected(
                                          MacroBusinessCycle());
                                    case Section.global:
                                      diagramsNotifier.setDiagramSelected(
                                          GlobalExportSubsidies());
                                  }
                                },
                              );
                            },
                          ).toList(),
                        ),
                        const CustomDivider(),
                      ],
                    ),
                  ),
                ),
                ExpandableNotifier(
                  controller: _expandableControllers[1],
                  child: ExpandablePanel(
                    header: ListTile(
                      leading: Icon(Icons.add),
                      title: Text('Type'),
                    ),
                    collapsed: SizedBox.shrink(),
                    expanded: Wrap(
                        alignment: WrapAlignment.center,
                        spacing: kWrapSpacing * size.width,
                        children: selectedDiagrams.map((diagram) {
                          bool selected = false;

                          if (diagram.name
                                  .getWordsBetweenFirstAndSecondUnderscores() ==
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
                  ),
                ),
              ],
            ),
            ExpandableNotifier(
              controller: _expandableControllers[2],
              child: ExpandablePanel(
                  header: ListTile(
                    leading: Icon(Icons.ssid_chart_outlined),
                    title: Text('Diagram'),
                  ),
                  collapsed: SizedBox.shrink(),
                  expanded: Column(
                    children: [
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
                    ],
                  ),),
            ),
            ExpandableNotifier(
              controller: _expandableControllers[3],
              child: ExpandablePanel(
                header: ListTile(
                  leading: Icon(Icons.info_outline_rounded),
                  title: Text('Explanation'),
                ),
                collapsed: SizedBox.shrink(), expanded:
                  Padding(
                padding: const EdgeInsets.all(28.0),
                child: HtmlWidget(selectedDiagram.explanation()),
              ),

              ),
            )
          ],
        )

        // SingleChildScrollView(
        //   child: Column(
        //     children: [
        //       Wrap(
        //         alignment: WrapAlignment.center,
        //         spacing: kWrapSpacing * size.width,
        //         children: Section.values.map((section) {
        //           bool selected = false;
        //           if (section.name.getFirstWord() ==
        //               diagramsState.diagram.name.getFirstWord()) {
        //             selected = true;
        //           }
        //           return CustomChipButton(
        //               text: section.name.capitalizeFirstLetter(),
        //               isSelected: selected,
        //               onPressed: () {
        //                 switch (section) {
        //                   case Section.intro:
        //                     diagramsNotifier
        //                         .setDiagramSelected(GlobalExportSubsidies());
        //                   case Section.micro:
        //                     diagramsNotifier.setDiagramSelected(
        //                         MicroMonopolisticCompetition());
        //                   case Section.macro:
        //                     diagramsNotifier
        //                         .setDiagramSelected(MacroBusinessCycle());
        //                   case Section.global:
        //                     diagramsNotifier
        //                         .setDiagramSelected(GlobalExportSubsidies());
        //                 }
        //               });
        //         }).toList(),
        //       ),
        //       const CustomDivider(),
        //       Wrap(
        //           alignment: WrapAlignment.center,
        //           spacing: kWrapSpacing * size.width,
        //           children: selectedDiagrams.map((diagram) {
        //             bool selected = false;
        //
        //             if (diagram.name.getWordsBetweenFirstAndSecondUnderscores() ==
        //                 diagramsState.diagram.name
        //                     .getWordsBetweenFirstAndSecondUnderscores()) {
        //               selected = true;
        //             }
        //
        //             return CustomChipButton(
        //                 text: diagram.name
        //                     .getWordsBetweenFirstAndSecondUnderscores(),
        //                 isSelected: selected,
        //                 onPressed: () {
        //                   diagramsNotifier.setDiagramSelected(diagram);
        //                 });
        //           }).toList()),
        //       DiagramBox(customPainter: diagramsState.diagram),
        //       Wrap(
        //         alignment: WrapAlignment.center,
        //         spacing: kWrapSpacing * size.width,
        //         children: [
        //           ...subDiagrams.map((diagram) {
        //             bool selected = false;
        //
        //             if (diagram.name == diagramsState.diagram.name) {
        //               selected = true;
        //             }
        //
        //             return CustomChipButton(
        //                 text: diagram.name.getWordsAfterSecondUnderscore(),
        //                 isSelected: selected,
        //                 onPressed: () {
        //                   diagramsNotifier.setDiagramSelected(diagram);
        //                 });
        //           }),
        //         ],
        //       ),
        //       ...[
        //         Padding(
        //           padding: const EdgeInsets.all(28.0),
        //           child: HtmlWidget(selectedDiagram.explanation()),
        //         ),
        //       ]
        //     ],
        //   ),
        // ),
        );
  }

  Section getSectionSelected(DiagramType selectedDiagram) {
    print('selection diagram is ${selectedDiagram.name.getFirstWord()}');
    final sec = selectedDiagram.name.getFirstWord();
    Section sectionSelected = Section.values.where((s) => s.name == sec).first;
    print('section ${sectionSelected}');
    return sectionSelected;
  }
}
