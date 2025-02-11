import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../app/configs/constants.dart';
import '../../../quizzes/quiz_sections/questions/quiz_models/answer_model.dart';
import '../../../quizzes/quiz_state/edit_question_state.dart';

class NumberOfAnswersButtons extends ConsumerWidget {
  const NumberOfAnswersButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final editState = ref.watch(editQuestionProvider);
    final editNotifier = ref.read(editQuestionProvider.notifier);
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: AutoSizeText('Number of answers'),
        ),
        Expanded(
          flex: 5,
          child: Wrap(
            alignment: WrapAlignment.start,
            spacing: size.width * kWrapSpacing,
            children: [
              ...List.generate(
                3,
                (index) {
                  final number = editState.currentQuestion.answers?.length;
                  bool isSelected = false;
                  if (number == (index + 2)) {
                    isSelected = true;
                  }
                  final onSurfaceColor =
                      isSelected ? Colors.white : theme.colorScheme.onSurface;

                  return ChoiceChip(
                    onSelected: (_) {
                      List<AnswerModel> answers =
                          editState.currentQuestion.answers?.toList() ?? [];

                      int requiredLength =
                          index + 2; // Determines if we need 2, 3, or 4 answers

                      if (answers.length > requiredLength) {
                        // Trim excess answers if the list is too long
                        answers = answers.sublist(0, requiredLength);
                      } else {
                        // Add missing answers if the list is too short
                        while (answers.length < requiredLength) {
                          answers.add(AnswerModel(
                            "",
                          )); // Assuming AnswerModel has a default constructor
                        }
                      }

                      // Update the question with the new answers list
                      editNotifier.updateCurrentQuestion(
                        editState.currentQuestion.copyWith(answers: answers),
                      );
                    },
                    checkmarkColor: onSurfaceColor,
                    selectedColor: theme.colorScheme.primary,
                    label: Text(
                      (index + 2).toString(),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: onSurfaceColor,
                      ),
                    ),
                    selected: isSelected,
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
