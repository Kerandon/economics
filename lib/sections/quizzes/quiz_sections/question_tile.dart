import 'package:economics_app/app/configs/constants.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/answer_stage.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/explanation_box.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../quiz_models/question_model.dart';
import 'answer_tile.dart';

class QuestionTile extends ConsumerWidget {
  const QuestionTile({
    super.key,
    this.index,
    required this.question,
  });

  final int? index;
  final QuestionModel question;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    final answers = question.answers;
    return IgnorePointer(
      ignoring: question.answerStage == AnswerStage.correct ||
          question.answerStage == AnswerStage.incorrect,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                Padding(
                  padding: EdgeInsets.all(size.height * kPageIndentVertical),
                  child: Row(
                    children: [
                      if (index != null) ...[
                        SizedBox(
                          width: size.width * 0.05,
                          child: Text(
                            (index! + 1).toString(),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                      Expanded(
                        child: Column(
                          children: [
                            if (question.item != null)
                              Padding(
                                padding:
                                    EdgeInsets.only(bottom: size.height * 0.01),
                                child: question.item!,
                              ),
                            Text(
                              question.question ?? "",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    ...[
                      ...answers!.map(
                        (answer) => AnswerTile(
                          answerIndex: answers.indexOf(answer),
                          answer: answer,
                          question: question,
                        ),
                      )
                    ],
                    if (question.answerStage == AnswerStage.incorrect &&
                        question.explanation != null)
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
          ),
        ],
      ),
    );
  }
}
