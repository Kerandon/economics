import 'package:economics_app/sections/settings/manage_questions/add_question/diagram_builder_2.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../app/configs/constants.dart';
import '../../../../app/custom_widgets/custom_chip_button.dart';
import '../../../diagrams/models/diagram_model.dart';
import '../../../quizzes/quiz_enums/question_part_enum.dart';
import '../../../quizzes/quiz_sections/questions/quiz_models/answer_model.dart';
import '../../../quizzes/quiz_state/edit_question_state.dart';

class AddDiagramPage extends ConsumerWidget {
  const AddDiagramPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final editState = ref.watch(editQuestionProvider);
    final editNotifier = ref.read(editQuestionProvider.notifier);
    return AlertDialog(
      title: Text('Add diagram to ${editState.questionPart.name}'),
      content: SizedBox(
        width: size.width * 0.90,
        height: size.height * 0.90,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Wrap(
                alignment: WrapAlignment.start,
                spacing: size.width * kWrapSpacing,
                children: [
                  ...List.generate(
                    5,
                    (index) {
                      final answerIndex = editState.questionPart.toIndexEnum();
                      bool isSelected = false;
                      List<DiagramModel> currentDiagrams = [];
                      int currentDiagramsLength = 0;
                      if (editState.questionPart == QuestionPart.question) {
                        currentDiagrams =
                            editState.currentQuestion.diagrams?.toList() ?? [];
                      } else {
                        final answers = editState.currentQuestion.answers;
                        if (answers?.isNotEmpty ?? false) {
                          final diagrams = answers![answerIndex].diagrams;
                          if (diagrams?.isNotEmpty ?? false) {
                            currentDiagrams = diagrams!.toList();
                          }
                        }
                      }
                      currentDiagramsLength = currentDiagrams.length;

                      // Determine if the current index is selected
                      if (currentDiagramsLength == 0 && index == 0) {
                        isSelected =
                            true; // Select the first index if no diagrams exist
                      } else if (currentDiagramsLength == index) {
                        isSelected =
                            true; // Select the index that matches the current number of diagrams
                      }

                      return ChoiceChip(
                        onSelected: (_) {
                          final allDiagrams =
                              DiagramModel.getAllDiagrams(size, context)
                                  .toList();

                          if (index == 0) {
                            // If index is 0, clear the diagrams list
                            currentDiagrams.clear();
                          } else {
                            // Adjust the diagrams list based on the selected index
                            for (int i = 0; i < index; i++) {
                              if (i < currentDiagrams.length) {
                                // Keep existing diagrams up to the selected index
                                continue;
                              } else {
                                // Add default diagrams if the index exceeds the current list length
                                currentDiagrams.add(allDiagrams.first);
                              }
                            }

                            // Remove excess diagrams if the index is less than the current list length
                            if (index < currentDiagrams.length) {
                              currentDiagrams =
                                  currentDiagrams.sublist(0, index);
                            }
                          }

                          if (editState.questionPart == QuestionPart.question) {
                            editNotifier.updateCurrentQuestion(
                              editState.currentQuestion
                                  .copyWith(diagrams: currentDiagrams.toList()),
                            );
                          } else {
                            List<AnswerModel> answers = [];
                            answers =
                                editState.currentQuestion.answers!.toList();
                            answers[answerIndex] = answers[answerIndex].copyWith(
                                diagrams: currentDiagrams
                                    .toList()); // ✅ Correctly updating the list

                            editNotifier.updateCurrentQuestion(
                              editState.currentQuestion.copyWith(
                                answers: answers.toList(),
                              ),
                            );
                          }
                        },
                        checkmarkColor: Colors.white,
                        selectedColor: theme.colorScheme.primary,
                        label: Text((index).toString()),
                        selected: isSelected,
                      );
                    },
                  ),
                ],
              ),
              DiagramBuilder2(),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: size.height * kPageIndentVertical),
                child: CustomChipButton(
                    text: 'Done',
                    onPressed: () {
                      Navigator.of(context).maybePop();
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
