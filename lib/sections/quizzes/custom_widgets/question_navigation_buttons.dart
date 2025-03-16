import 'package:economics_app/app/animation/flip_animation.dart';
import 'package:economics_app/sections/quizzes/methods/get_current_pref.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/question_type.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/questions/quiz_models/question_model.dart';
import 'package:economics_app/sections/quizzes/quiz_state/quiz_state.dart';
import 'package:economics_app/sections/quizzes/quiz_state/start_quiz_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../app/configs/constants.dart';
import '../../../app/custom_widgets/custom_change_button.dart';
import '../methods/show_completion_box.dart';
import '../quiz_enums/answer_stage.dart';

class QuestionNavigationButtons extends ConsumerStatefulWidget {
  const QuestionNavigationButtons({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  ConsumerState<QuestionNavigationButtons> createState() =>
      _QuestionNavigationButtonsState();
}

class _QuestionNavigationButtonsState
    extends ConsumerState<QuestionNavigationButtons> {
  bool _haveRunCompletionDialog = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final buttonsWidthGap = size.width * 0.03;
    final quizState = ref.watch(quizProvider);
    final quizNotifier = ref.read(quizProvider.notifier);
    final startState = ref.watch(startQuizProvider);
    final questionIndex = quizState.currentQuestionIndex;
    final showAnswersAtEnd =
        getCurrentPref(startState).showAnswersAtEnd ?? false;
    if (quizState.quizIsCompleted && !_haveRunCompletionDialog) {
      _haveRunCompletionDialog = true;
      WidgetsBinding.instance.addPostFrameCallback((t) {
        showCompletionDialog(context);
      });
    }

    QuestionModel c = const QuestionModel();
    if (quizState.selectedQuestions.isNotEmpty) {
      c = quizState.selectedQuestions[questionIndex];
    }
    final multi = c.questionType == QuestionType.multi;
    final flip = c.questionType == QuestionType.flip;

    bool onLastQuestion =
        questionIndex == quizState.selectedQuestions.length - 1;
    bool showCheckAllQuestionsButton = false;

    if(multi && c.showAnswersAtEnd == true && quizState.selectedQuestions.every(
        (e) => showAnswersAtEnd && e.answerStage == AnswerStage.selected)){
      showCheckAllQuestionsButton = false;
    }

    /// Directional buttons
    /// Left button
    bool disableButtonLeft = false;
    if (quizState.currentQuestionIndex == 0) {
      disableButtonLeft = true;
    }

    /// Right button
    bool disableButtonRight = false;
    if (onLastQuestion) {
      disableButtonRight = true;
    }
    if (c.answerStage == AnswerStage.notSelected) {
      disableButtonRight = true;
    }

    print('answer stage ${c.answerStage}');

    return Container(
      width: size.width,
      height: size.height * 0.10,
      color: theme.colorScheme.surfaceTint,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * kPageIndentHorizontal),
        child: Row(
          children: [
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomPageChangeButton(
                    onPressed: () {
                      widget.pageController.animateToPage(
                        quizState.currentQuestionIndex - 1,
                        duration:
                            const Duration(milliseconds: kPageChangeAnimation),
                        curve: Curves.easeInOutCirc,
                      );
                    },
                    iconData: Icons.arrow_back_outlined,
                    disable: disableButtonLeft,
                  ),
                  SizedBox(width: buttonsWidthGap),
                  CustomPageChangeButton(
                    onPressed: () {
                      widget.pageController.animateToPage(
                        quizState.currentQuestionIndex + 1,
                        duration:
                            const Duration(milliseconds: kAnimationDuration),
                        curve: Curves.easeInOutCirc,
                      );
                    },
                    iconData: Icons.arrow_forward_outlined,
                    disable: disableButtonRight,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (showCheckAllQuestionsButton) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FloatingActionButton.extended(
                          onPressed: () {
                            quizNotifier.checkAllAnswers();
                          },
                          label: Text('CHECK'),
                        ),
                      ],
                    ),
                  ],
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (quizState.quizIsCompleted) ...[
                        FloatingActionButton.extended(
                          onPressed: () {
                            showCompletionDialog(context);
                          },
                          label: Text('RESULTS'),
                        ),
                      ],
                    ],
                  )
                ],
              ),
            ),
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (c.questionType != QuestionType.flip &&
                    quizState.currentCardSide == CardSide.back) ...[
                  Row(
                    children: [
                      FloatingActionButton.extended(
                        heroTag: '1',
                        backgroundColor:
                            c.answerStage == AnswerStage.correct
                                ? theme.primaryColor
                                : theme.colorScheme.scrim,
                        onPressed: () {
                          quizNotifier.updateQuestion(
                            c.copyWith(
                              answerStage: AnswerStage.correct,
                            ),
                          );
                        },
                        label: Icon(
                          Icons.check_outlined,
                          color: c.answerStage == AnswerStage.correct
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      SizedBox(width: buttonsWidthGap),
                      FloatingActionButton.extended(
                        heroTag: '2',
                        backgroundColor:
                            c.answerStage == AnswerStage.incorrect
                                ? Colors.red
                                : theme.colorScheme.scrim,
                        onPressed: () {
                          quizNotifier.updateQuestion(c.copyWith(
                              answerStage: AnswerStage.incorrect));
                        },
                        label: Icon(
                          Icons.close_outlined,
                          color: c.answerStage == AnswerStage.correct ||
                                  c.answerStage == AnswerStage.incorrect
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
                FloatingActionButton.extended(
                  heroTag: '3',
                  backgroundColor: c.answerStage == AnswerStage.incorrect ?
                  Colors.red :
                  theme.colorScheme.surface,
                  onPressed: c.answerStage == AnswerStage.notSelected? null : () {
                    if(c.answerStage == AnswerStage.incorrect){
                      quizNotifier.updateQuestion(c.copyWith(answerStage: AnswerStage.correct));
                    }else {
                      quizNotifier.updateQuestion(
                          c.copyWith(answerStage: AnswerStage.incorrect));
                    }
                  },
                  label: Icon(Icons.flag_outlined, color: theme.colorScheme.onSurface ,)
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
