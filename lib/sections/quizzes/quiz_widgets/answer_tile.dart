import 'package:economics_app/app/animation/pop_out_animation.dart';
import 'package:economics_app/app/animation/rotate_around_animation.dart';
import 'package:economics_app/app/animation/shake_animation.dart';
import 'package:economics_app/app/animation/slide_in_animation.dart';
import 'package:economics_app/app/utils/helper_methods/number_methods.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/answer_stage.dart';
import 'package:economics_app/sections/quizzes/quiz_models/question_model.dart';
import 'package:economics_app/sections/quizzes/quiz_state/quiz_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../app/configs/constants.dart';
import '../../../app/enums/slide_direction.dart';
import '../quiz_models/answer_model.dart';

class AnswerTile extends ConsumerStatefulWidget {
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
  ConsumerState<AnswerTile> createState() => _AnswerTileState();
}

class _AnswerTileState extends ConsumerState<AnswerTile> {
  bool _animate = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Color backgroundColor = Theme.of(context).colorScheme.background;
    final quizNotifier = ref.read(quizProvider.notifier);
    IconData? icon;

    if (widget.answer.answerStage == AnswerStage.selected) {
      backgroundColor = Colors.indigo;
    }
    if (widget.answer.answerStage == AnswerStage.correct) {
      backgroundColor = Theme.of(context).colorScheme.primary;
      icon = Icons.check_circle_outline;
    }
    if (widget.answer.answerStage == AnswerStage.incorrect) {
      backgroundColor = Colors.red;
      icon = Icons.clear_outlined;
    }
    if (widget.answer.isCorrect &&
        widget.answer.answerStage == AnswerStage.incorrect) {
      backgroundColor = Theme.of(context).colorScheme.primary;
      icon = Icons.check_circle_outline;
    }

    return SlideAnimation(
      direction: widget.answerIndex % 2 == 0 ? SlideDirection.rightIn : SlideDirection.leftIn,
      animateOnStart: true,
      child: ShakeAnimation(
        animate: _animate,
        onComplete: () {
          setState(() {
            _animate = false;
          });
        },
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: size.height * kPageIndentVertical / 6),
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
                            ((widget.answerIndex + 1).toAlphabet()),
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          title: Text(
                            widget.answer.answer,
                            textAlign: TextAlign.start,
                            style:
                                Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: widget.answer.answerStage !=
                                              AnswerStage.selected
                                          ? Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .color
                                          : Colors.white,
                                    ), // Align the text to the start (left) side
                          ),
                          trailing: PopOutAnimation(
                            animate: icon != null,
                            child: Icon(
                              icon,
                              color: Colors.white,
                            ),
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
                      onTap: () {
                        quizNotifier.setQuestionAsSelected(
                            widget.question, widget.answer);

                        setState(() {
                          _animate = true;
                        });
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
