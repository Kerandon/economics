import 'package:economics_app/models/question_model.dart';
import 'package:economics_app/state/quiz_state.dart';
import 'package:economics_app/utils/constants.dart';
import 'package:economics_app/utils/enums/answer_stage.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'models/answer_model.dart';

class AnswerTile extends ConsumerWidget {
  const AnswerTile(
    this.index,
    this.question,
    this.answer, {
    super.key,
  });

  final String index;
  final QuestionModel question;
  final AnswerModel answer;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Color tileColor = Colors.grey;
    final state = ref.watch(quizProvider);
    final notifier = ref.read(quizProvider.notifier);
      QuestionModel q = state.currentQuestions.firstWhere((q) => q.question == question.question);

        AnswerModel a = q.answers.firstWhere((a) => a.answer == answer.answer);

        if (a.answerStage == AnswerStage.notAnswered) {
          tileColor = Colors.grey;
        }
        if (a.answerStage == AnswerStage.selected) {
          tileColor = Colors.lightBlue;
        }



    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kRadius)),
        tileColor: tileColor,
        leading: Text(index),
        onTap: () {
          notifier.setQuestionAsSelected(question, answer);
        },
        title: Text(answer.answer), // Assuming the key is the answer text
      ),
    );
  }
}
