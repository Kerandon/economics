import 'package:economics_app/app/configs/constants.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/answer_stage.dart';
import 'package:economics_app/sections/quizzes/quiz_state/quiz_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../completion/explanation_box.dart';
import 'answer_tile.dart';

class MultiChoiceTile extends ConsumerWidget {
  const MultiChoiceTile({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final quizState = ref.watch(quizProvider);
    final index = quizState.currentQuestionIndex;
    final question = quizState.selectedQuestions[index];
    final answers = question.answers!.toList();
    return IgnorePointer(
      ignoring: question.answerStage == AnswerStage.correct ||
          question.answerStage == AnswerStage.incorrect,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                Padding(
                  padding: EdgeInsets.all(size.height * kPageIndentVertical),
                  child: Row(
                    children: [
                      SizedBox(
                        width: size.width * 0.02,
                      ),
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
                                  .titleLarge
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
                      ...answers.map(
                        (answer) => AnswerTile(
                          answerIndex: answers.indexOf(answer),
                          answer: answer,
                          question: question,
                        ),
                      )
                    ],
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
