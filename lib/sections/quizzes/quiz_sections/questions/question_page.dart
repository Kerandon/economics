import 'package:auto_size_text/auto_size_text.dart';
import 'package:economics_app/app/home/home_page.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/answer_stage.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/question_type.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/questions/custom_slider.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/questions/question_navigation_buttons.dart';
import 'package:economics_app/sections/quizzes/quiz_state/edit_question_state.dart';
import 'package:economics_app/sections/quizzes/quiz_state/quiz_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../app/animation/confetti_animation.dart';
import '../../../../app/configs/constants.dart';
import 'flip_card/flip_card_tile.dart';
import 'multi_choice/multi_choice_tile.dart';

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
    final editState = ref.read(editQuestionProvider);
    final quizState = ref.watch(quizProvider);
    final quizNotifier = ref.read(quizProvider.notifier);
    final customButtonGap = size.height * 0.04;

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: FittedBox(
              fit: BoxFit.scaleDown,
              child: AutoSizeText(
                '${editState.unit.name} - ${editState.subunit.name}',
                overflow: TextOverflow.fade,
                maxLines: 1,
              ),
            ),
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_outlined,
                color: Colors.white,
              ),
              onPressed: () {
                quizNotifier.setResetQuestions();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return const HomePage();
                    },
                  ),
                );
                WidgetsBinding.instance.addPostFrameCallback((t) {});
              },
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * kPageIndentHorizontal,
            ),
            child: NestedScrollView(
              floatHeaderSlivers: true,
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  const SliverToBoxAdapter(
                    child: Column(
                      children: [
                        CustomSlider(),
                      ],
                    ),
                  )
                ];
              },
              body: Container(
                color: Theme.of(context).colorScheme.surface,
                child: Stack(
                  children: [
                    PageView(
                      onPageChanged: (index) {
                        quizNotifier.setCurrentQuestionIndex(index);
                      },
                      controller: _pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: quizState.selectedQuestions.map(
                        (question) {
                          return SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ...[
                                  if (editState.questionType ==
                                      QuestionType.multi) ...[
                                    const MultiChoiceTile(),
                                  ],
                                  if (editState.questionType ==
                                      QuestionType.flip) ...[
                                    const FlipCardTile(),
                                  ],
                                  SizedBox(
                                    height: customButtonGap,
                                  ),
                                ],
                                SizedBox(
                                  height: size.height * 0.15,
                                ),
                              ],
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          floatingActionButton: QuestionNavigationButtons(
            pageController: _pageController,
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        ),
        if (quizState.selectedQuestions.isNotEmpty &&
            quizState.selectedQuestions[quizState.currentQuestionIndex]
                    .answerStage ==
                AnswerStage.correct) ...[
          const ConfettiAnimation(),
        ],
        if (quizState.selectedQuestions.isNotEmpty) ...[
          ConfettiAnimation(
            animate: quizState.selectedQuestions[quizState.currentQuestionIndex]
                    .answerStage ==
                AnswerStage.correct,
          ),
        ],
      ],
    );
  }
}
