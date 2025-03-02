import 'package:economics_app/app/animation/flip_animation.dart';
import 'package:economics_app/sections/quizzes/methods/get_current_pref.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/questions/quiz_models/question_model.dart';
import 'package:economics_app/sections/quizzes/quiz_state/quiz_state.dart';
import 'package:economics_app/sections/quizzes/quiz_state/start_quiz_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../app/configs/constants.dart';
import '../../../app/custom_widgets/custom_change_button.dart';
import '../methods/show_completion_box.dart';
import '../quiz_enums/answer_stage.dart';
import '../quiz_enums/topic_tag.dart';

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

    QuestionModel question = const QuestionModel();
    if (quizState.selectedQuestions.isNotEmpty) {
      question = quizState.selectedQuestions[questionIndex];
    }

    bool onLastQuestion =
        questionIndex == quizState.selectedQuestions.length - 1;
    bool showCheckAllQuestionsButton = quizState.selectedQuestions.every(
        (e) => showAnswersAtEnd && e.answerStage == AnswerStage.selected);

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
    if (question.answerStage == AnswerStage.notSelected) {
      disableButtonRight = true;
    }

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
                if (question.topicTag != TopicTag.multipleChoiceQuestion &&
                    quizState.currentCardSide == CardSide.back) ...[
                  Row(
                    children: [
                      FloatingActionButton.extended(
                        heroTag: '1',
                        backgroundColor:
                            question.answerStage == AnswerStage.correct
                                ? theme.primaryColor
                                : theme.colorScheme.scrim,
                        onPressed: () {
                          quizNotifier.updateQuestion(
                            question.copyWith(
                              answerStage: AnswerStage.correct,
                            ),
                          );
                        },
                        label: Icon(
                          Icons.check_outlined,
                          color: question.answerStage == AnswerStage.correct
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      SizedBox(width: buttonsWidthGap),
                      FloatingActionButton.extended(
                        heroTag: '2',
                        backgroundColor:
                            question.answerStage == AnswerStage.incorrect
                                ? Colors.red
                                : theme.colorScheme.scrim,
                        onPressed: () {
                          quizNotifier.updateQuestion(question.copyWith(
                              answerStage: AnswerStage.incorrect));
                        },
                        label: Icon(
                          Icons.close_outlined,
                          color: question.answerStage == AnswerStage.correct ||
                                  question.answerStage == AnswerStage.incorrect
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            )),
          ],
        ),
      ),
    );
  }
}
