import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:economics_app/sections/quizzes/custom_widgets/custom_dropdown_tile.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/question_type.dart';
import 'package:economics_app/sections/settings/manage_questions/custom_dropdown_heading.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../quizzes/quiz_state/edit_question_state.dart';

class QuestionTypeButtons extends ConsumerWidget {
  const QuestionTypeButtons({super.key, this.oneChoiceOnly = false});

  final bool oneChoiceOnly;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editState = ref.watch(editQuestionProvider);
    final editNotifier = ref.read(editQuestionProvider.notifier);
    final c = editState.currentQuestion;

    if (oneChoiceOnly) {
      final currentTypes = c.questionTypes ?? [];

      if (currentTypes.isEmpty) {
        final defaultType = QuestionType.values.first;
        Future.microtask(() {
          editNotifier.updateCurrentQuestion(
            c.copyWith(questionTypes: [defaultType]),
          );
        });
      } else if (currentTypes.length > 1) {
        final first = currentTypes.first;
        Future.microtask(() {
          editNotifier.updateCurrentQuestion(
            c.copyWith(questionTypes: [first]),
          );
        });
      }
    }

    final selectionText = (c.questionTypes?.isNotEmpty ?? false)
        ? c.questionTypes!.map((e) => e.toText()).join(', ')
        : 'Select question types';

    return DropdownButtonHideUnderline(
      child: DropdownButton2<QuestionType>(
        customButton: CustomDropdownHeading(selectionText),
        onChanged: (_) {},
        items: [
          ...QuestionType.values.map((e) => DropdownMenuItem(
                value: e,
                child: QuestionTypeCustomContents(
                  e,
                  oneChoiceOnly: oneChoiceOnly,
                ),
              ))
        ],
      ),
    );
  }
}

class QuestionTypeCustomContents extends ConsumerWidget {
  const QuestionTypeCustomContents(
    this.questionType, {
    super.key,
    required this.oneChoiceOnly,
  });

  final QuestionType questionType;
  final bool oneChoiceOnly;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editState = ref.watch(editQuestionProvider);
    final editNotifier = ref.read(editQuestionProvider.notifier);
    final c = editState.currentQuestion;
    final isSelected = c.questionTypes?.contains(questionType) ?? false;

    return InkWell(
      onTap: () {
        List<QuestionType> questionTypes = c.questionTypes?.toList() ?? [];

        if (oneChoiceOnly) {
          if (!isSelected) {
            questionTypes = [questionType]; // Replace selection
            editNotifier.updateCurrentQuestion(
              c.copyWith(questionTypes: questionTypes),
            );
          }
          Navigator.maybePop(context);
        } else {
          if (isSelected) {
            questionTypes.remove(questionType); // Allow unchecking
          } else {
            questionTypes.add(questionType);
          }

          editNotifier.updateCurrentQuestion(
            c.copyWith(questionTypes: questionTypes),
          );
        }
      },
      child: CustomDropdownTile(
        text: questionType.toText(),
        isSelected: isSelected,
      ),
    );
  }
}
