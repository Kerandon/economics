import 'package:economics_app/app/state/app_state.dart';
import 'package:economics_app/sections/notes/sections/notes_contents.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../app/custom_widgets/custom_chip_button.dart';

import '../data/article_data.dart';
import '../models/unit_model.dart';

class NotesTabPage extends ConsumerWidget {
  const NotesTabPage({
    super.key,
    required this.sectionNotes,
    required this.controllers,
  });

  final Map<UnitModel, List<UnitModel>> sectionNotes;
  final List<ExpandableController> controllers;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final appState = ref.watch(appProvider);
    final appNotifier = ref.read(appProvider.notifier);
    return SingleChildScrollView(
      child: Column(
        children: [
          ...List.generate(
            sectionNotes.length, // Number of entries in the map
            (index) {
              return ExpandableNotifier(
                controller: controllers[index],
                child: ExpandablePanel(
                  header: ListTile(
                    leading: Text(sectionNotes.entries
                        .elementAt(index)
                        .key
                        .id
                        .toString()),
                    title: Text(sectionNotes.entries.elementAt(index).key.unit),
                  ),
                  collapsed: const SizedBox.shrink(),
                  expanded: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...sectionNotes.entries.elementAt(index).value.map(
                        (e) {
                          // print('e ${e.id}');
                          bool hasContent = false;
                          for (var i in articleData) {
                            if (e.id == i.key) {
                              hasContent = true;
                            }
                          }

                          return CustomChipButton(
                            removeShadingOfText: true,
                            text: e.unit,
                            isSelected: appState.selectedUnit == e,
                            onPressed: !hasContent
                                ? null
                                : () {
                                    appNotifier.setSelectedUnit(e);
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const NotesContents()));
                                  },
                            leading: Row(
                              children: [
                                if (!hasContent)
                                  const Icon(Icons.construction_outlined),
                                if (!hasContent && e.hlOnly)
                                  SizedBox(
                                    width: size.width * 0.02,
                                  ),
                                if (e.hlOnly) const Text('HL only'),
                              ],
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
