import 'package:economics_app/models/question_model.dart';
import 'package:economics_app/utils/enums/answer_stage.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../state/quiz_state.dart';
import '../../configs/constants.dart';
import 'answer_tile.dart';

class QuestionTile extends ConsumerWidget {
  const QuestionTile({super.key, required this.index, required this.question});

  final int index;
  final QuestionModel question;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final heightPadding = size.height * 0.003;
    final widthPadding = size.width * 0.05;
    final quizState = ref.watch(quizProvider);
    final quizNotifier = ref.read(quizProvider.notifier);
    IconData? icon;
    Color borderColor = Colors.transparent;
    bool isSelected = false;
    bool isAnswered = false;
    if (question.answerStage == AnswerStage.selected) {
      isSelected = true;
    }
    if (question.answerStage == AnswerStage.correct ||
        question.answerStage == AnswerStage.incorrect) {
      isAnswered = true;
    }

    if (question.answerStage == AnswerStage.correct) {
      icon = Icons.check_circle_outline;
      borderColor = Colors.green;
    }
    if (question.answerStage == AnswerStage.incorrect) {
      icon = Icons.close_outlined;
      borderColor = Colors.red;
    }
    int answerIndex = 0;
    return Padding(
      padding: EdgeInsets.all(size.height * 0.01),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kRadius),
          border: Border.all(
            color: borderColor,
            width: kBorderWidth * size.height,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ListTile(
              leading: Text(
                'Q${index.toString()}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              title: Text(
                question.question,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            ...question.answers.map((answer) {
              answerIndex++;
              String answerNumerator = getAnswerIndex(answerIndex);
              return AnswerTile(answerNumerator, question, answer);
            }),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  widthPadding, heightPadding, widthPadding, heightPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (!isAnswered) ...[
                    OutlinedButton(
                      style: ElevatedButton.styleFrom(elevation: 0),
                      onPressed: isSelected
                          ? () {
                              quizNotifier.checkQuestion(question);
                            }
                          : null,
                      child: const Text('Check'),
                    ),
                  ],
                  if (icon != null) ...[
                    Icon(
                      icon,
                      size: size.height * 0.05,
                      color: borderColor,
                    ),
                  ],
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

String getAnswerIndex(int index) {
  String letter = "";
  switch (index) {
    case 1:
      letter = 'a';
    case 2:
      letter = 'b';
    case 3:
      letter = 'c';
    case 4:
      letter = 'd';
  }
  return letter;
}
