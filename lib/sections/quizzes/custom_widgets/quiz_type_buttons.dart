
import 'package:economics_app/sections/quizzes/quiz_state/edit_question_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../app/configs/constants.dart';
import '../../../../app/custom_widgets/custom_chip_button.dart';

import '../quiz_enums/question_type.dart';

class QuizTypeButtons extends ConsumerWidget {
  const QuizTypeButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final editState = ref.watch(editQuestionProvider);
    final editNotifier = ref.read(editQuestionProvider.notifier);
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: size.width * kWrapSpacing,
      children: QuestionType.values.map((e) => CustomChipButton(
          text: e.name,
          isSelected: e == editState.questionType,
          onPressed: (){
            editNotifier.setQuestionType(e);
          })).toList()
    );
  }
}
