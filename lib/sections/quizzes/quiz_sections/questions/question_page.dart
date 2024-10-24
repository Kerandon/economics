import 'package:economics_app/app/custom_widgets/gap.dart';
import 'package:economics_app/app/home/home_page.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/answer_stage.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/question_type.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/questions/custom_slider.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/questions/question_navigation_buttons.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/questions/unit_banner_title.dart';
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
    const borderPadding = 0.01;
    final quizState = ref.watch(quizProvider);
    final quizNotifier = ref.read(quizProvider.notifier);
    final customButtonGap = size.height * 0.04;

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
                const SliverToBoxAdapter(
                    child: Column(
                  children: [
                    Gap(),
                    UnitBannerTitle(),
                    Gap(),
                    CustomSlider(),
                    Gap(),
                  ],
                ))
              ];
            },
            body: Container(
              color: Theme.of(context).colorScheme.surface,
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: size.width * borderPadding,
                        right: size.width * borderPadding,
                        bottom: size.height * borderPadding),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(kBackgroundOpacity),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(kRadiusBig),
                        ),
                      ),
                      child: PageView(
                        onPageChanged: (index) {
                          WidgetsBinding.instance.addPostFrameCallback((t) {
                            setState(() {});
                            quizNotifier.setCurrentQuestionIndex(index);
                          });
                        },
                        controller: _pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: quizState.selectedQuestions.map(
                          (question) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: size.width * kPageIndentHorizontal,
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ...[
                                      if (quizState.questionType ==
                                          QuestionType.multi) ...[
                                        const MultiChoiceTile(),
                                      ],
                                      if (quizState.questionType ==
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
                              ),
                            );
                          },
                        ).toList(),
                      ),
                    ),
                  ),
                ],
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
                AnswerStage.correct) ...[const ConfettiAnimation()],
      ],
    );
  }
}
