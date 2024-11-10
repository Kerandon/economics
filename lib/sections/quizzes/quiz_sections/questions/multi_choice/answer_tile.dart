import 'package:economics_app/app/animation/pop_out_animation.dart';
import 'package:economics_app/app/animation/rotate_around_animation.dart';
import 'package:economics_app/app/animation/shake_animation.dart';
import 'package:economics_app/app/utils/helper_methods/number_methods.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/answer_stage.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/questions/quiz_models/answer_model.dart';
import 'package:economics_app/sections/quizzes/quiz_state/quiz_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../app/audio_manager.dart';
import '../../../../../app/configs/constants.dart';
import '../quiz_models/question_model.dart';

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
  bool _hasAnimatedWhenCorrect = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Color backgroundColor =
        Theme.of(context).colorScheme.onSurface.withOpacity(kBackgroundOpacity);

    final quizNotifier = ref.read(quizProvider.notifier);
    IconData? icon;
    bool isSelected = widget.answer.answerStage == AnswerStage.selected;
    Color answerTextColor = Theme.of(context).colorScheme.onSurface;
    Color indexColor = Theme.of(context).colorScheme.primary;
    if (widget.answer.answerStage == AnswerStage.selected) {
      backgroundColor = Colors.indigo;
    }
    if (widget.answer.answerStage == AnswerStage.correct) {
      backgroundColor = Theme.of(context).colorScheme.primary;
      icon = Icons.check_circle_outline;
      if (!_hasAnimatedWhenCorrect) {
        _animate = true;
        _hasAnimatedWhenCorrect = true;
      }
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

    if (isSelected ||
        widget.answer.answerStage == AnswerStage.correct ||
        widget.answer.answerStage == AnswerStage.incorrect) {
      indexColor = Colors.transparent;
      answerTextColor = Colors.white;
    }

    return RotateAroundAnimation(
      beginValue: widget.answerIndex % 2 == 0 ? 0.50 : -0.50,
      duration: 600,
      child: ShakeAnimation(
        animate: _animate,
        onComplete: () {
          setState(() {
            _animate = false;
          });
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: size.height * kFormSpacing),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(kRadius),
                child: Container(
                  decoration: BoxDecoration(
                    color: backgroundColor,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(size.height * 0.005),
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        ListTile(
                          dense: true,
                          leading: CircleAvatar(
                            backgroundColor: indexColor,
                            // Set the background color to orange
                            radius: 20,
                            // Adjust the radius as needed
                            child: Text(
                              (widget.answerIndex + 1).toAlphabet(),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                          ),
                          title: Text(
                            widget.answer.answer,
                            textAlign: TextAlign.start,
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall
                                ?.copyWith(
                                    color:
                                        answerTextColor), // Align the text to the start (left) side
                          ),
                          trailing: PopOutAnimation(
                            duration: 300,
                            addPop: true,
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
                        AudioManager.playAudio('assets/audio/other/select.mp3');
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
