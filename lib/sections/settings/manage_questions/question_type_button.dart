import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/question_type.dart';
import 'package:economics_app/sections/settings/manage_questions/custom_dropdown_heading.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../quizzes/quiz_state/edit_question_state.dart';

class QuestionTypeButton extends ConsumerWidget {
  const QuestionTypeButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editState = ref.watch(editQuestionProvider);
    final editNotifier = ref.read(editQuestionProvider.notifier);
    final c = editState.currentQuestion;
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        customButton: CustomDropdownHeading(c.questionType?.toText() ?? 'Select question type'),
        onChanged: (value) {
          editNotifier.updateCurrentQuestion(
            c.copyWith(questionType: value),
          );
        },
        value: c.questionType,
        items: [
          ...QuestionType.values.map(
            (e) => DropdownMenuItem(
              value: e,
              child: Text(
                e.toText(),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
