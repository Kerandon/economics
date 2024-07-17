import 'package:economics_app/app/animation/pop_out_animation.dart';
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
    final size = MediaQuery.of(context).size;
    Color backgroundColor = Theme.of(context).colorScheme.background;
    final quizState = ref.watch(quizProvider);
    final quizNotifier = ref.read(quizProvider.notifier);
    IconData? icon;

    if (answer.answerStage == AnswerStage.selected) {
      backgroundColor = Colors.indigo;
    }
    if (answer.answerStage == AnswerStage.correct) {
      backgroundColor = Theme.of(context).colorScheme.primary;
      icon = Icons.check_circle_outline;
    }
    if (answer.answerStage == AnswerStage.incorrect) {
      backgroundColor = Colors.red;
      icon = Icons.clear_outlined;
    }
    if (answer.isCorrect && answer.answerStage == AnswerStage.incorrect) {
      backgroundColor = Theme.of(context).colorScheme.primary;
      icon = Icons.check_circle_outline;
    }

    return Padding(
      padding:
          EdgeInsets.symmetric(vertical: size.height * kPageIndentVertical / 6),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(kRadius),
            child: Container(
              decoration: BoxDecoration(
                color: backgroundColor,
              ),
              child: Padding(
                padding: EdgeInsets.all(size.height * 0.015),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    ListTile(
                      leading: Text(
                        ((answerIndex + 1).toAlphabet()),
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      title: Text(
                        answer.answer,
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: answer.answerStage != AnswerStage.selected
                                ? Theme.of(context).textTheme.bodyMedium!.color
                                : Colors
                                    .white,), // Align the text to the start (left) side
                      ),
                      trailing: SizedBox(
                        child: icon != null
                            ? PopOutAnimation(
                                child: Icon(
                                  icon,
                                  color: Colors.white,
                                ),
                              )
                            : null,
                      ),
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
                  onTap: quizState.questionsAllAnswered
                      ? null
                      : () {
                          quizNotifier.setQuestionAsSelected(question, answer);
                        }),
            ),
          ),
        ],
      ),
    );
  }
}
