import 'package:economics_app/sections/quizzes/quiz_enums/answer_stage.dart';
import 'package:economics_app/sections/quizzes/quiz_models/answer_model.dart';
import 'package:economics_app/sections/quizzes/quiz_models/question_model.dart';
import 'package:economics_app/sections/quizzes/quiz_state/quiz_state.dart';
import 'package:economics_app/sections/quizzes/quiz_widgets/question_tile.dart';
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final quizState = ref.watch(quizProvider);
    final quizNotifier = ref.read(quizProvider.notifier);
    QuestionModel currentQuestion =
        quizState.selectedQuestions[quizState.currentQuestionIndex];
    int questionIndex = 0;

    bool disableButtonLeft = false;
    if (quizState.currentQuestionIndex == 0) {
      disableButtonLeft = true;
    }
    bool disableButtonRight = false;
    if (quizState.currentQuestionIndex ==
            quizState.selectedQuestions.length - 1 ||
        currentQuestion.answerStage == AnswerStage.notSelected ||
        currentQuestion.answerStage == AnswerStage.selected) {
      disableButtonRight = true;
    }

    return Scaffold(
      appBar: AppBar(),
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
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
                      'Question ${quizState.currentQuestionIndex + 1} / ${quizState.numberOfQuestionsSelected}',
                )
              ],
            ),
          ];
        },
        body: PageView(
          onPageChanged: (index) {
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
                      question: quizState.selectedQuestions[questionIndex - 1],
                  removeEndDivider: true,
                  ),
                  if (question.answerStage != AnswerStage.correct &&
                      question.answerStage != AnswerStage.incorrect)
                    Align(
                      alignment: const Alignment(0, 0.60),
                      child:

                      SizedBox(
                        width: size.width * 0.80,
                        child: OutlinedButton(
                          onPressed: question.answerStage == AnswerStage.selected
                              ? () {
                                  List<AnswerModel> answers =
                                      question.answers.toList();
                                  for (int i = 0; i < answers.length; i++) {
                                    if (answers[i].answerStage ==
                                        AnswerStage.selected) {
                                      if (answers[i].isCorrect) {
                                        answers[i] = answers[i].copyWith(
                                            answerStage: AnswerStage.correct);
                                      } else {
                                        answers[i] = answers[i].copyWith(
                                            answerStage: AnswerStage.incorrect);
                                      }
                                    } else {
                                      if (answers[i].isCorrect) {
                                        answers[i] = answers[i].copyWith(
                                            answerStage: AnswerStage.incorrect);
                                      }
                                    }
                                  }
                                  question = question.copyWith(answers: answers);
                                  if (question.answers.any((answer) =>
                                      answer.answerStage ==
                                      AnswerStage.incorrect)) {
                                    question = question.copyWith(
                                        answerStage: AnswerStage.incorrect);
                                  } else {
                                    question = question.copyWith(
                                        answerStage: AnswerStage.correct);
                                  }

                                  quizNotifier.updateQuestionState(question);
                                }
                              : null,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
                            child: const Text('Check'),
                          ),
                        ),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
