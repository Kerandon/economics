import 'package:economics_app/app/utils/helper_methods/number_methods.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/answer_stage.dart';
import 'package:economics_app/sections/quizzes/quiz_models/question_model.dart';
import 'package:economics_app/sections/quizzes/quiz_state/quiz_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../app/configs/app_colors.dart';
import '../../../app/configs/constants.dart';
import '../quiz_models/answer_model.dart';

class AnswerTile extends ConsumerWidget {
  const AnswerTile({
    super.key,
    required this.answer,
    required this.question,
    required this.answerIndex,
  });

  final AnswerModel answer;
  final QuestionModel question;
  final int answerIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery
        .of(context)
        .size;
    Color borderColor = Colors.transparent;
    final quizState = ref.watch(quizProvider);
    final quizNotifier = ref.read(quizProvider.notifier);
    IconData? icon;
    if (answer.answerStage == AnswerStage.selected) {
      borderColor = Colors.white;
    }
    if (answer.answerStage == AnswerStage.correct) {
      borderColor = AppColors.defaultAppColor;
      icon = Icons.check_circle_outline;
    }
    if (answer.answerStage == AnswerStage.incorrect) {
      borderColor = Colors.red;
      icon = Icons.clear_outlined;
    }


    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(kRadius),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(kRadius),
              border: Border.all(
                color: borderColor,
                width: size.height * kBorderWidth,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(size.height * 0.015),
              child: ListView(
                shrinkWrap: true,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: size.width * 0.05,
                        child: Text(
                          ((answerIndex + 1).toAlphabet()),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          answer.answer,
                          textAlign: TextAlign
                              .start, // Align the text to the start (left) side
                        ),
                      ),
                      Icon(icon)
                    ],
                  ),

                ],
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(kRadius),
              onTap: quizState.questionsAllAnswered ? null : () {
                quizNotifier.setQuestionAsSelected(question, answer);
              }
            ),
          ),
        ),
      ],
    );
  }
}
