import 'package:economics_app/app/custom_widgets/custom_big_button.dart';
import 'package:economics_app/app/home/home_page.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/answer_stage.dart';
import 'package:economics_app/sections/quizzes/quiz_models/question_model.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/custom_slider.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/question_tile.dart';
import 'package:economics_app/sections/quizzes/quiz_state/quiz_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../app/configs/constants.dart';
import '../../../app/custom_widgets/custom_change_button.dart';
import 'completion_page.dart';

class QuestionPage extends ConsumerStatefulWidget {
  const QuestionPage({super.key});

  @override
  ConsumerState<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends ConsumerState<QuestionPage> {
  final _pageController = PageController();

  bool _hasShownCompletedDialog = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final quizState = ref.watch(quizProvider);
    final quizNotifier = ref.read(quizProvider.notifier);
    final customButtonGap = size.height * 0.04;
    QuestionModelMulti? currentQuestion;
    int questionIndex = 0;
    if (quizState.selectedQuestions.isNotEmpty) {
      currentQuestion =
          quizState.selectedQuestions[quizState.currentQuestionIndex];
    }

    final allQuestionsAnswered = quizState.selectedQuestions.every((element) =>
        element.answerStage == AnswerStage.correct ||
        element.answerStage == AnswerStage.incorrect);

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
    if (!quizState.showAnswersAsIGo &&
        currentQuestion?.answerStage == AnswerStage.notSelected) {
      disableButtonRight = true;
    }

    /// Check answers one by one
    if (quizState.showAnswersAsIGo) {
      if (currentQuestion?.answerStage == AnswerStage.notSelected ||
          currentQuestion?.answerStage == AnswerStage.selected) {
        disableButtonRight = true;
      }
    }
    String checkButtonText = "Check all answers";

    bool showCheckAnswersButton = false;
    if (!quizState.showAnswersAsIGo) {
      if (quizState.selectedQuestions
          .every((question) => question.answerStage == AnswerStage.selected)) {
        showCheckAnswersButton = true;
      }
    } else {
      if (quizState.selectedQuestions
          .any((element) => element.answerStage == AnswerStage.selected)) {
        showCheckAnswersButton = true;
        checkButtonText = "Check answer";
      }
    }
    if (quizState.selectedQuestions.every((element) =>
            element.answerStage == AnswerStage.correct ||
            element.answerStage == AnswerStage.incorrect) &&
        !_hasShownCompletedDialog &&
        quizState.selectedQuestions.isNotEmpty) {
      _hasShownCompletedDialog = true;
      _showCompletionBox(context: context, quizState: quizState);
    }

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_outlined,
                color: Colors.white,
              ),
              onPressed: () {
                quizNotifier.setResetQuestions();
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const HomePage();
                }));
              },
            ),
          ),
          body: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverToBoxAdapter(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Expanded(child: SizedBox.shrink()),
                    const Expanded(
                        flex: 6, child: ListTile(title: CustomSlider())),
                    Expanded(
                        child: Text(
                            '${quizState.currentQuestionIndex + 1}/${quizState.selectedSections.length}'))
                  ],
                ))
              ];
            },
            body: Container(
              color: Theme.of(context).colorScheme.surface,
              child: Padding(
                padding: EdgeInsets.only(top: size.height * 0.001),
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(kBackgroundOpacity),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(kRadiusBig),
                          topRight: Radius.circular(kRadiusBig),
                        ),
                      ),
                      child: PageView(
                        onPageChanged: (index) {
                          setState(() {});
                          quizNotifier.setCurrentQuestionIndex(index);
                        },
                        controller: _pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: quizState.selectedQuestions.map(
                          (question) {
                            questionIndex++;
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: size.width * kPageIndentHorizontal,
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ...[
                                      QuestionTile(
                                        question: quizState.selectedQuestions[
                                            questionIndex - 1],
                                      ),
                                      SizedBox(
                                        height: customButtonGap,
                                      ),
                                      if (question.answerStage !=
                                              AnswerStage.correct &&
                                          question.answerStage !=
                                              AnswerStage.incorrect)
                                        showCheckAnswersButton
                                            ? CustomBigButton(
                                                text: checkButtonText,
                                                onPressed:
                                                    question.answerStage ==
                                                            AnswerStage.selected
                                                        ? () {
                                                            if (!quizState
                                                                .showAnswersAsIGo) {
                                                              quizNotifier
                                                                  .checkAllAnswers();
                                                            } else {
                                                              quizNotifier
                                                                  .checkAnswer(
                                                                      question);
                                                            }
                                                          }
                                                        : null,
                                              )
                                            : const SizedBox.shrink(),
                                    ],
                                    allQuestionsAnswered
                                        ? CustomBigButton(
                                            text: 'Quiz results',
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      const CompletionPage());
                                            })
                                        : const SizedBox(),
                                    SizedBox(
                                      height: size.height * 0.15,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ).toList(),
                      ),
                    ),
                  ],
                ),
              ),
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
                  width: size.width * 0.65,
                ),
                CustomPageChangeButton(
                  onPressed: () {
                    _pageController.animateToPage(
                      quizState.currentQuestionIndex + 1,
                      duration:
                          const Duration(milliseconds: kPageChangeAnimation),
                      curve: Curves.easeInOutCirc,
                    );
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

void _showCompletionBox(
    {required BuildContext context, required QuizState quizState}) {
  Future.delayed(const Duration(milliseconds: 1200), () async {
    if (context.mounted) {
      if (quizState.selectedQuestions.isNotEmpty) {
        await showDialog(
            context: context, builder: (context) => const CompletionPage());
      }
    }
  });
}
