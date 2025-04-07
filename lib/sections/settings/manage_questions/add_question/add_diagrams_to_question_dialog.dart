
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:economics_app/app/utils/helper_methods/string_methods.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../diagrams/models/diagram_model.dart';
import '../../../quizzes/custom_widgets/custom_dropdown_tile.dart';
import '../../../quizzes/quiz_state/edit_question_state.dart';
import '../custom_dropdown_heading.dart';

class AddDiagramsToQuestionDialog extends ConsumerWidget {
  const AddDiagramsToQuestionDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;


    final allDiagrams = DiagramModel.getAllDiagrams(size, context);

    return AlertDialog(
      content: SizedBox(
        width: size.width * 0.60,
        child: DropdownButtonHideUnderline(
          child: DropdownButton2<DiagramModel>(
            customButton: CustomDropdownHeading('Select diagrams'),
            isExpanded: true,
            onChanged: (value) {},
            items: [
              ...allDiagrams.map(
                    (e) {
                  return DropdownMenuItem(
                    enabled: false,
                    value: e,
                    child: CustomDropdownContents(
                      diagram: e,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        OutlinedButton(
            onPressed: () {
              Navigator.maybePop(context);
            },
            child: Text('Close'))
      ],
    );
  }
}

class CustomDropdownContents extends ConsumerWidget {
  const CustomDropdownContents({
    required this.diagram,
    super.key,
  });

  final DiagramModel diagram;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editState = ref.watch(editQuestionProvider);
    final editNotifier = ref.read(editQuestionProvider.notifier);
    final c = editState.currentQuestion;

    final isSelected = c.diagrams?.toList().contains(diagram) ?? false;
    return InkWell(
      onTap: () {
        List<DiagramModel> diagrams = c.diagrams?.toList() ?? [];

        if (diagrams.contains(diagram)) {
          diagrams.remove(diagram);
        } else {
          diagrams.add(diagram);
        }

        ///Update the question state
        editNotifier.updateCurrentQuestion(
          c.copyWith(
            diagrams: diagrams.toList(),
          ),
        );
      },
      child: CustomDropdownTile(
        leading: (diagram.unit!.name.capitalizeFirst()).toString(),
        text:
        '${diagram.type!.name.capitalizeFirst()} - ${diagram.subtype!.name.capitalizeFirst()}',
        isSelected: isSelected,
      ),
    );
  }
}
