import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../app/configs/constants.dart';
import '../../quizzes/quiz_state/edit_question_state.dart';

class NumberOfAnswersButton extends ConsumerStatefulWidget {
  const NumberOfAnswersButton({super.key});

  @override
  ConsumerState<NumberOfAnswersButton> createState() =>
      _NumberOfAnswersButtonsState();
}

class _NumberOfAnswersButtonsState
    extends ConsumerState<NumberOfAnswersButton> {

  @override
  Widget build(BuildContext context) {
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
          flex: 1,
          child: Wrap(
            alignment: WrapAlignment.start,
            spacing: size.width * kWrapSpacing,
            children: [
              ...List.generate(
                3,
                (index) {
                  final n = editState.numberOfMultiAnswers;
                  bool isSelected = false;
                  if (n == (index + 2)) {
                    isSelected = true;
                  }
                  final onSurfaceColor =
                      isSelected ? Colors.white : theme.colorScheme.onSurface;

                  return ChoiceChip(
                    onSelected: (_) {

                      editNotifier.setNumberOfMultiAnswers(editState.currentQuestion, index + 2);
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
//
// List<AnswerModel> adjustAnswersLength(QuestionModel question, int index) {
//   List<AnswerModel> answers = [];
//
// if(question.questionType == QuestionType.multi){
//   answers = question.answers?.toList() ?? [];
//   int requiredLength = index + 2; //
//   if (answers.length > requiredLength) {
//     // Trim excess answers if the list is too long
//     answers = answers.sublist(0, requiredLength);
//   } else {
//     // Add missing answers if the list is too short
//     while (answers.length < requiredLength) {
//       answers.add(AnswerModel(
//         "",
//       )); // Assuming AnswerModel has a default constructor
//     }
//   }
// }else{
//   answers = [AnswerModel("")];
// }
//
//
//
//
//   return answers;
// }
