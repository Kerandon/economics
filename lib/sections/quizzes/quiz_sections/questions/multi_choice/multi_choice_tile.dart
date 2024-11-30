import 'package:economics_app/app/configs/constants.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/answer_stage.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/questions/quiz_models/question_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../completion/explanation_box.dart';
import 'answer_tile.dart';

class MultiChoiceTile extends ConsumerWidget {
  const MultiChoiceTile(
    this.question, {
    super.key,
  });

  final QuestionModel question;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final answers = question.answers!.toList();

    return IgnorePointer(
      ignoring: question.answerStage == AnswerStage.correct ||
          question.answerStage == AnswerStage.incorrect,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * kPageIndentHorizontal),
        child: Stack(
          children: [
            ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(size.width * 0.01),
                      child: Text(
                        question.question ?? "",
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    ...answers.map(
                      (answer) => AnswerTile(
                        answerIndex: answers.indexOf(answer),
                        answer: answer,
                        question: question,
                      ),
                    ),
                    if (question.answerStage == AnswerStage.incorrect &&
                        question.explanation != null &&
                        question.explanation!.isNotEmpty)
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: size.height * 0.01),
                        child:
                            ExplanationBox(explanation: question.explanation!),
                      )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
