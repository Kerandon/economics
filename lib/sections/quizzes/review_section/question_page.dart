import 'package:economics_app/app/animation/confetti_animation.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/answer_stage.dart';
import 'package:economics_app/sections/quizzes/quiz_models/question_model.dart';
import 'package:economics_app/sections/quizzes/quiz_state/quiz_state.dart';
import 'package:economics_app/sections/quizzes/quiz_widgets/question_tile.dart';
import 'package:economics_app/sections/quizzes/review_section/completion_page.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../app/configs/app_colors.dart';
import '../../../app/configs/constants.dart';
import '../../../app/custom_widgets/custom_change_button.dart';
import '../../../app/custom_widgets/nested_scroll_custom/custon_button_overlay_appbar.dart';

class QuestionPage extends ConsumerStatefulWidget {
  const QuestionPage({super.key});

  @override
  ConsumerState<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends ConsumerState<QuestionPage> {
  final _pageController = PageController();

  bool _animateConfetti = false;
  bool _hasShownCompletedDialog = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    final quizState = ref.watch(quizProvider);
    final quizNotifier = ref.read(quizProvider.notifier);
    QuestionModel? currentQuestion;
    int questionIndex = 0;
    if (quizState.selectedQuestions.isNotEmpty) {
      currentQuestion =
      quizState.selectedQuestions[quizState.currentQuestionIndex];
    }

    if (quizState.selectedQuestions.every((question) =>
    question.answerStage == AnswerStage.correct ||
        question.answerStage == AnswerStage.incorrect)) {
      if (!_hasShownCompletedDialog) {
        _hasShownCompletedDialog = true;
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          showDialog(
              context: context, builder: (context) => const CompletionPage());
        });
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
    if (quizState.checkAnswersAtEnd &&
        currentQuestion?.answerStage == AnswerStage.notSelected) {
      disableButtonRight = true;
    }

    /// Check answers one by one
    if (!quizState.checkAnswersAtEnd) {
      if (currentQuestion?.answerStage == AnswerStage.notSelected ||
          currentQuestion?.answerStage == AnswerStage.selected) {
        disableButtonRight = true;
      }
    }
    String checkButtonText = "Check all answers";

    bool showCheckAnswersButton = false;
    if (quizState.checkAnswersAtEnd) {
      if (quizState.selectedQuestions
          .every((question) => question.answerStage == AnswerStage.selected)) {
        showCheckAnswersButton = true;
      }
    } else {
      showCheckAnswersButton = true;
      checkButtonText = "Check answer";
    }

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(),
          body: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  backgroundColor: AppColors.defaultAppColorDarker,
                  automaticallyImplyLeading: false,
                  pinned: false,
                  floating: true,
                  forceElevated: innerBoxIsScrolled,
                  actions: [
                    CustomButtonOverlayAppBar(
                      title:
                      'Question ${quizState.currentQuestionIndex +
                          1} / ${quizState.numberOfQuestionsSelected}',
                    )
                  ],
                ),
              ];
            },
            body: PageView(
              onPageChanged: (index) {
                _animateConfetti = false;
                setState(() {});
                quizNotifier.setCurrentQuestionIndex(index);
              },
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: quizState.selectedQuestions.map(
                    (question) {
                  questionIndex++;
                  return Stack(
                    children: [
                      QuestionTile(
                        question:
                        quizState.selectedQuestions[questionIndex - 1],
                        removeEndDivider: true,
                      ),
                      OutlinedButton(onPressed: () {
                     showDialog(context: context, builder: (context) =>
                         CompletionPage());
                      }, child: Text('show')),
                      if (question.answerStage != AnswerStage.correct &&
                          question.answerStage != AnswerStage.incorrect)
                        Align(
                          alignment: const Alignment(0, 0.60),
                          child: SizedBox(
                            width: size.width * 0.80,
                            child: showCheckAnswersButton
                                ? OutlinedButton(
                              onPressed: question.answerStage ==
                                  AnswerStage.selected
                                  ? () {
                                if (quizState.checkAnswersAtEnd) {
                                  quizNotifier.checkAllAnswers();
                                } else {
                                  quizNotifier
                                      .checkAnswer(question);
                                }
                              }
                                  : null,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: size.height * 0.02),
                                child: Text(checkButtonText),
                              ),
                            )
                                : const SizedBox.shrink(),
                          ),
                        )
                    ],
                  );
                },
              ).toList(),
            ),
          ),
          floatingActionButton: SizedBox(
            width: size.width * 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomPageChangeButton(
                  onPressed: () {
                    _pageController.animateToPage(
                        quizState.currentQuestionIndex - 1,
                        duration:
                        const Duration(milliseconds: kPageChangeAnimation),
                        curve: Curves.easeInOutCirc);
                  },
                  iconData: Icons.arrow_back_outlined,
                  disable: disableButtonLeft,
                ),
                SizedBox(
                  width: size.width * 0.25,
                ),
                CustomPageChangeButton(
                  onPressed: () {
                    _pageController.animateToPage(
                        quizState.currentQuestionIndex + 1,
                        duration:
                        const Duration(milliseconds: kPageChangeAnimation),
                        curve: Curves.easeInOutCirc);
                  },
                  iconData: Icons.arrow_forward_outlined,
                  disable: disableButtonRight,
                ),
              ],
            ),
          ),
          floatingActionButtonLocation:
          FloatingActionButtonLocation.centerFloat,
        ),

      ],
    );
  }
}
