import 'package:economics_app/app/animation/pop_out_animation.dart';
import 'package:economics_app/app/animation/shake_animation.dart';
import 'package:economics_app/app/utils/helper_methods/number_methods.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/answer_stage.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/questions/quiz_models/answer_model.dart';
import 'package:economics_app/sections/quizzes/quiz_state/quiz_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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
    ///Define variables
    final size = MediaQuery.of(context).size;


    final quizNotifier = ref.read(quizProvider.notifier);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final answerStage = widget.answer.answerStage;

    Color backgroundColor = colorScheme.surface;

    IconData? icon;
    bool isSelected = answerStage == AnswerStage.selected;
    Color answerTextColor = colorScheme.onSurface;
    Color indexColor = colorScheme.primary;

    if (answerStage == AnswerStage.selected) {
      backgroundColor = Colors.indigo;
    }
    if (answerStage == AnswerStage.correct) {
      backgroundColor = colorScheme.primary;
      answerTextColor = Colors.white;
      indexColor = Colors.white;
      icon = Icons.check_circle_outline;
      if (!_hasAnimatedWhenCorrect) {
        _animate = true;
        _hasAnimatedWhenCorrect = true;
      }
    }
    if (answerStage == AnswerStage.incorrect) {
      backgroundColor = Colors.red;
      answerTextColor = Colors.white;
      indexColor = Colors.white;
      icon = Icons.clear_outlined;
    }
    if (widget.answer.isCorrect && answerStage == AnswerStage.incorrect) {
      backgroundColor = colorScheme.primary;
      icon = Icons.check_circle_outline;
    }

    if (isSelected ||
        answerStage == AnswerStage.correct ||
        answerStage == AnswerStage.incorrect) {
      answerTextColor = Colors.white;
    }

    return ShakeAnimation(
      animate: _animate,
      onComplete: () {
        setState(() {
          _animate = false;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).colorScheme.shadow,
                blurRadius: 3,
                offset: Offset(2, 2)),
          ],
          borderRadius: BorderRadius.circular(kRadius),
          color: backgroundColor,
        ),
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
                    child: ListTile(
                      titleAlignment: ListTileTitleAlignment.center,
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      leading: Text(
                        (widget.answerIndex + 1).toAlphabet(),
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: indexColor,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.answer.answer,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.displaySmall?.copyWith(
                              color: answerTextColor,
                            ),
                          ),
                        ],
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
                  ),
                ),
              ),
              Positioned.fill(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(kRadius),
                    onTap: () {
                      // getIt<AudioManager>().playSound('other/select');
                      quizNotifier.setQuestionAsSelected(
                          widget.question, widget.answer);
                      setState(
                        () {
                          _animate = true;
                        },
                      );

                      quizNotifier.checkAnswer(
                          context: context, question: widget.question);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
