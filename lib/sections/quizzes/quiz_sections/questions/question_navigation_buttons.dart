import 'package:economics_app/app/custom_widgets/custom_chip_button.dart';
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
    final editState = ref.watch(editQuestionProvider);
    final quizState = ref.watch(quizProvider);
    final quizNotifier = ref.read(quizProvider.notifier);
    final questionIndex = quizState.currentQuestionIndex;
    QuestionModel question = const QuestionModel();
    if (quizState.selectedQuestions.isNotEmpty) {
      question = quizState.selectedQuestions[questionIndex];
    }
    String centerButtonText = "";
    bool quizIsCompleted = false, disableCenterButton = false;
    if (questionIndex == quizState.selectedQuestions.length - 1) {
      if (question.answerStage == AnswerStage.correct ||
          question.answerStage == AnswerStage.incorrect) {
        quizIsCompleted = true;
      }
    }

    if (!quizIsCompleted) {
      if (question.answerStage == AnswerStage.notSelected ||
          question.answerStage == AnswerStage.correct ||
          question.answerStage == AnswerStage.incorrect) {
        disableCenterButton = true;
      }
    }

    /// Directional buttons
    /// Left button
    bool disableButtonLeft = false;
    if (quizState.currentQuestionIndex == 0) {
      disableButtonLeft = true;
    }

    /// Right button
    bool disableButtonRight = false;
    if (quizState.currentQuestionIndex ==
        quizState.selectedQuestions.length - 1) {
      disableButtonRight = true;
    }
    if (editState.checkAnswersAtEnd &&
        question.answerStage == AnswerStage.notSelected) {
      disableButtonRight = true;
    }

    /// Check answers one by one
    if (!editState.checkAnswersAtEnd) {
      if (question.answerStage == AnswerStage.notSelected ||
          question.answerStage == AnswerStage.selected) {
        disableButtonRight = true;
      }
    }

    if (!editState.checkAnswersAtEnd) {
      if (quizIsCompleted) {
        centerButtonText = 'Show results';
      } else {
        centerButtonText = 'Check question';
      }
    }
    return SizedBox(
      width: size.width * 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomPageChangeButton(
            onPressed: () {
              pageController.animateToPage(quizState.currentQuestionIndex - 1,
                  duration: const Duration(milliseconds: kPageChangeAnimation),
                  curve: Curves.easeInOutCirc);
            },
            iconData: Icons.arrow_back_outlined,
            disable: disableButtonLeft,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.30),
            child: CustomChipButton(
              isDisabled: disableCenterButton,
              text: centerButtonText,
              onPressed: () {
                if (questionIndex == quizState.selectedQuestions.length - 1 &&
                    question.answerStage == AnswerStage.selected) {}
                if (quizIsCompleted) {
                  showDialog(
                      context: context,
                      builder: (context) => const CompletionPage());
                } else {
                  if (editState.checkAnswersAtEnd) {
                    quizNotifier.checkAllAnswers();
                  } else {
                    quizNotifier.checkAnswer(
                        context: context, question: question);
                  }
                }
              },
            ),
          ),
          CustomPageChangeButton(
            onPressed: () {
              pageController.animateToPage(
                quizState.currentQuestionIndex + 1,
                duration: const Duration(milliseconds: kPageChangeAnimation),
                curve: Curves.easeInOutCirc,
              );
            },
            iconData: Icons.arrow_forward_outlined,
            disable: disableButtonRight,
          ),
        ],
      ),
    );
  }
}

void _showCompletionBox(
    {required BuildContext context, required QuizState quizState}) {
  Future.delayed(const Duration(milliseconds: 800), () {
    if (context.mounted && ModalRoute.of(context)?.isCurrent != true) {
      if (quizState.selectedQuestions.isNotEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((t) async {
          await showDialog(
              context: context, builder: (context) => const CompletionPage());
        });
      }
    }
  });
}
