import 'package:auto_size_text/auto_size_text.dart';
import 'package:economics_app/app/animation/pop_out_animation.dart';
import 'package:economics_app/app/animation/shake_animation.dart';
import 'package:economics_app/app/utils/helper_methods/number_methods.dart';
import 'package:economics_app/sections/diagrams/diagram_widgets/custom_diagram_builder.dart';
import 'package:economics_app/sections/quizzes/methods/get_box_shadow.dart';
import 'package:economics_app/sections/quizzes/methods/get_current_pref.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/answer_stage.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/questions/quiz_models/answer_model.dart';
import 'package:economics_app/sections/quizzes/quiz_state/quiz_state.dart';
import 'package:economics_app/sections/quizzes/quiz_state/start_quiz_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../app/configs/constants.dart';
import 'quiz_models/question_model.dart';

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

    final quizNotifier = ref.read(quizProvider.notifier);
    final theme = Theme.of(context);
    final startState = ref.watch(startQuizProvider);
    final colorScheme = theme.colorScheme;
    final answerStage = widget.answer.answerStage;

    Color backgroundColor = colorScheme.surface;

    final showAnswersAtEnd =
        getCurrentPref(startState).showAnswersAtEnd ?? false;

    IconData? icon;
    bool isSelected = answerStage == AnswerStage.selected;
    Color answerTextColor = colorScheme.onSurface;
    Color indexColor = colorScheme.primary;

    if (answerStage == AnswerStage.selected) {
      backgroundColor = Colors.indigo;
      indexColor = Colors.white;
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
            buildBoxShadow(context),
          ],
          borderRadius: BorderRadius.circular(kRadius),
          border: Border.all(
            color: theme.colorScheme.scrim,
          ),
          color: backgroundColor,
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(kRadius),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                contentPadding: EdgeInsets.all(12),
                leading: Text(
                  (widget.answerIndex + 1).toAlphabet(),
                  style: theme.textTheme.titleLarge?.copyWith(
                      color: indexColor, fontWeight: FontWeight.bold),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: AutoSizeText(
                        widget.answer.answer,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.displaySmall?.copyWith(
                          color: answerTextColor,
                        ),
                      ),
                    ),
                    Expanded(
                        child: CustomDiagramBuilder(
                            dimensions: 0.10,
                            diagrams: widget.answer.diagrams?.toList())),
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

                    if (!showAnswersAtEnd) {
                      quizNotifier.checkAnswer(
                          context: context, question: widget.question);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
