import 'package:economics_app/models/question_model.dart';
import 'package:economics_app/state/quiz_state.dart';
import 'package:economics_app/configs/constants.dart';
import 'package:economics_app/utils/enums/answer_stage.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/answer_model.dart';

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
    final size = MediaQuery.of(context).size;
    final heightPadding = size.height * 0.003;
    final widthPadding = size.width * 0.03;
    Color borderColor = Colors.transparent;
    final state = ref.watch(quizProvider);
    final notifier = ref.read(quizProvider.notifier);
    QuestionModel q = state.currentQuestions
        .firstWhere((q) => q.question == question.question);

    AnswerModel a = q.answers.firstWhere((a) => a.answer == answer.answer);

    IconData? icon = Icons.question_mark_outlined;

    if (question.answerStage != AnswerStage.notAnswered &&
        question.answerStage != AnswerStage.selected) {
      icon = null;
    }

    if (a.answerStage == AnswerStage.notAnswered) {
      borderColor = Colors.black12;
    }
    if (a.answerStage == AnswerStage.selected) {
      borderColor = Colors.lightBlue;
    }
    if (question.answerStage == AnswerStage.correct && answer.isCorrect) {
      borderColor = Colors.green;
      icon = Icons.check_outlined;
    }
    if (question.answerStage == AnswerStage.incorrect) {
      if (answer.answerStage == AnswerStage.selected) {
        borderColor = Colors.red;
        icon = Icons.close_outlined;
      }
      if (answer.isCorrect) {
        borderColor = Colors.green;
        icon = Icons.check_outlined;
      }
    }

    return Padding(
      padding: EdgeInsets.fromLTRB(
          widthPadding, heightPadding, widthPadding, heightPadding),
      child: ListTile(
        shape: RoundedRectangleBorder(
            side: BorderSide(
              color: borderColor,
              width: size.height * kBorderWidth,
            ),
            borderRadius: BorderRadius.circular(kRadius)),
        tileColor: Colors.black.withOpacity(0.05),
        leading: Text(index),
        onTap: () {
          notifier.setQuestionAsSelected(question, answer);
        },
        title: Text(answer.answer),
        trailing: Icon(icon), // Assuming the key is the answer text
      ),
    );
  }
}
