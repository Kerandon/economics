import 'package:economics_app/app/configs/app_colors.dart';
import 'package:economics_app/app/configs/constants.dart';
import 'package:economics_app/app/custom_widgets/custom_small_divider.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/answer_stage.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../quiz_models/question_model.dart';
import 'answer_tile.dart';
import 'explanation_box.dart';

class QuestionTile extends ConsumerWidget {
  const QuestionTile({super.key, required this.index, required this.question});

  final int index;
  final QuestionModel question;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    final answers = question.answers;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [

          Padding(
            padding: EdgeInsets.all(size.height * kPageIndentVertical),
            child: Row(
              children: [
                SizedBox(
                  width: size.width * 0.05,
                  child: Text(
                    (index + 1).toString(),
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  // Wrap the Text widget with Expanded
                  child: Text(
                    question.question,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: Theme.of(context).colorScheme.primary,
          ),
          ...[
            ...answers
                .map((answer) => AnswerTile(
                      answerIndex: answers.indexOf(answer),
                      answer: answer,
                      question: question,
                    ))
                .toList()
          ],
          if (question.answerStage == AnswerStage.incorrect) ...[
            ExplanationBox(question: question)
          ],
          CustomSmallDivider(),
          SizedBox(
            height: size.height * kPageIndentVertical,
          ),
        ],
      ),
    );
  }
}
