import 'package:economics_app/app/animation/flip_animation.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/question_type.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/completion/completion_page.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/questions/quiz_models/question_model.dart';
import 'package:economics_app/sections/quizzes/quiz_state/edit_question_state.dart';
import 'package:economics_app/sections/quizzes/quiz_state/quiz_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../app/configs/constants.dart';
import '../../../../app/custom_widgets/custom_change_button.dart';
import '../../quiz_enums/answer_stage.dart';

class QuestionNavigationButtons extends ConsumerWidget {
  const QuestionNavigationButtons({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final checkAnswersAtEndState =
        ref.watch(editQuestionProvider.select((s) => (s.checkAnswersAtEnd)));
    final editState = ref.watch(editQuestionProvider);
    final quizState = ref.watch(quizProvider);
    final quizNotifier = ref.read(quizProvider.notifier);
    final questionIndex = quizState.currentQuestionIndex;
    QuestionModel question = const QuestionModel();
    if (quizState.selectedQuestions.isNotEmpty) {
      question = quizState.selectedQuestions[questionIndex];
    }

    bool onLastQuestion =
        questionIndex == quizState.selectedQuestions.length - 1;
    bool questionIsAnswered = question.answerStage == AnswerStage.correct ||
        question.answerStage == AnswerStage.incorrect;
    bool disableCenterButton = false;
    bool showCenterButton = false;
    String centerButtonText = kCheck;

    checkIfQuizIsCompleted(quizState, quizNotifier);

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
    if (checkAnswersAtEndState &&
        question.answerStage == AnswerStage.notSelected) {
      disableButtonRight = true;
    }

    /// Check answers at the end
    if (checkAnswersAtEndState) {
      if (onLastQuestion && question.answerStage != AnswerStage.notSelected ||
          quizState.quizIsCompleted) {
        centerButtonText = kResults;
        showCenterButton = true;
      }
    } else {
      /// Check answers one-by-one
      showCenterButton = true;
      if (question.answerStage == AnswerStage.notSelected) {
        disableCenterButton = true;
      }

      if (question.answerStage == AnswerStage.notSelected ||
          question.answerStage == AnswerStage.selected) {
        disableButtonRight = true;
      }

      if (quizState.quizIsCompleted) {
        centerButtonText = kResults;
      } else {
        if (question.answerStage == AnswerStage.notSelected ||
            questionIsAnswered) {
          disableCenterButton = true;
        }
      }
    }

    /// Flip Card Logic
    if (editState.questionType == QuestionType.flip) {
      showCenterButton = false;
    }
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (quizState.quizIsCompleted) ...[
            FloatingActionButton.extended(
              onPressed: () {
                buildShowCompletionDialog(context);
              },
              label: Text('Review'),
            ),
          ],
          SizedBox(
            height: size.height * 0.02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomPageChangeButton(
                onPressed: () {
                  pageController.animateToPage(
                      quizState.currentQuestionIndex - 1,
                      duration:
                          const Duration(milliseconds: kPageChangeAnimation),
                      curve: Curves.easeInOutCirc);
                },
                iconData: Icons.arrow_back_outlined,
                disable: disableButtonLeft,
              ),
              if (editState.questionType == QuestionType.flip &&
                  quizState.currentCardSide == CardSide.back) ...[
                FloatingActionButton.extended(
                  heroTag: '1',
                  backgroundColor: question.answerStage == AnswerStage.correct
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
                FloatingActionButton.extended(
                  heroTag: '2',
                  backgroundColor: question.answerStage == AnswerStage.incorrect
                      ? Colors.red
                      : theme.colorScheme.scrim,
                  onPressed: () {
                    quizNotifier.updateQuestion(
                        question.copyWith(answerStage: AnswerStage.incorrect));
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
              if (showCenterButton) ...[
                FloatingActionButton.extended(
                  backgroundColor: disableCenterButton
                      ? theme.colorScheme.scrim
                      : theme.primaryColor,
                  heroTag: '3',
                  label: editState.questionType == QuestionType.multi
                      ? Text(
                          centerButtonText,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: disableCenterButton
                                ? theme.colorScheme.surfaceDim
                                : theme
                                    .floatingActionButtonTheme.foregroundColor,
                          ),
                        )
                      : const Icon(Icons.flip_outlined),
                  onPressed: disableCenterButton
                      ? null
                      : () {
                          if (editState.questionType == QuestionType.multi) {
                            if (checkAnswersAtEndState) {
                              if (onLastQuestion &&
                                  question.answerStage ==
                                      AnswerStage.selected) {
                                quizNotifier.checkAllAnswers();
                                buildShowCompletionDialog(context);
                              }
                              if (quizState.quizIsCompleted) {
                                buildShowCompletionDialog(context);
                              }
                            } else {
                              if (onLastQuestion && questionIsAnswered ||
                                  quizState.quizIsCompleted) {
                                buildShowCompletionDialog(context);
                              } else {
                                quizNotifier.checkAnswer(
                                    context: context, question: question);
                              }
                            }
                          }
                          if (editState.questionType == QuestionType.flip) {
                            if (!quizState.cardHasFlipped) {
                              quizNotifier.flipCardForward(true);
                            }
                            if (quizState.cardHasFlipped) {
                              quizNotifier.flipCardForward(false);
                            }
                          }
                        },
                ),
              ],
              CustomPageChangeButton(
                onPressed: () {
                  pageController.animateToPage(
                    quizState.currentQuestionIndex + 1,
                    duration: const Duration(milliseconds: kAnimationDuration

                        ///kPageChangeAnimation
                        ),
                    curve: Curves.easeInOutCirc,
                  );
                },
                iconData: Icons.arrow_forward_outlined,
                disable: disableButtonRight,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void checkIfQuizIsCompleted(QuizState quizState, QuizNotifier quizNotifier) {
    WidgetsBinding.instance.addPostFrameCallback((t) {
      final isCompleted = quizState.selectedQuestions.every((e) =>
          e.answerStage == AnswerStage.correct ||
          e.answerStage == AnswerStage.incorrect);
      quizNotifier.setQuizIsCompleted(isCompleted);
    });
  }

  Future<dynamic> buildShowCompletionDialog(BuildContext context) {
    return showDialog(
        context: context, builder: (context) => const CompletionPage());
  }
}
