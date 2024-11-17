import 'package:auto_size_text/auto_size_text.dart';
import 'package:economics_app/app/home/home_page.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/answer_stage.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/question_type.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/questions/custom_slider.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/questions/question_navigation_buttons.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/questions/quiz_models/question_model.dart';
import 'package:economics_app/sections/quizzes/quiz_state/edit_question_state.dart';
import 'package:economics_app/sections/quizzes/quiz_state/quiz_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../app/animation/confetti_animation.dart';
import '../../../../app/audio_manager/audio_manager.dart';
import '../../../../app/configs/constants.dart';
import '../../../../main.dart';
import 'flip_card/flip_card_tile.dart';
import 'multi_choice/multi_choice_tile.dart';

class QuestionPage extends ConsumerStatefulWidget {
  const QuestionPage({super.key});

  @override
  ConsumerState<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends ConsumerState<QuestionPage> {

  bool _completeAudioHasPlayed = false;

  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    final unitSubunitQuestionTypeProvider = ref.read(
      editQuestionProvider.select(
            (s) => (s.unit, s.subunit, s.questionType),
      ),
    );
    final selectedQuestionsCurrentQuestionIndexQuizIsCompletedState = ref.watch(quizProvider
        .select((s) =>
    (s.selectedQuestions, s.currentQuestionIndex, s.quizIsCompleted, ),),);
    QuestionModel? currentQuestion;
    if (selectedQuestionsCurrentQuestionIndexQuizIsCompletedState.$1.isNotEmpty) {
      currentQuestion = selectedQuestionsCurrentQuestionIndexQuizIsCompletedState
          .$1[selectedQuestionsCurrentQuestionIndexQuizIsCompletedState.$2];
    }
    final quizNotifier = ref.read(quizProvider.notifier);
    final customButtonGap = size.height * 0.04;

    if (selectedQuestionsCurrentQuestionIndexQuizIsCompletedState.$3) {
      print('QUIZ COMPLETED');
      if (!_completeAudioHasPlayed) {
        _completeAudioHasPlayed = true;
        final audioManager = getIt<AudioManager>();
        if (audioManager.soundTrackPlayer.playing) {
          audioManager.stopSoundTrack();
        }
        audioManager.playSound('other/complete');
      }
    }


    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: FittedBox(
              fit: BoxFit.scaleDown,
              child: AutoSizeText(
                '${unitSubunitQuestionTypeProvider.$1
                    .name} - ${unitSubunitQuestionTypeProvider.$2.name}',
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
                color: Theme
                    .of(context)
                    .colorScheme
                    .surface,
                child: Stack(
                  children: [
                    PageView(
                      onPageChanged: (index) {
                        quizNotifier.setCurrentQuestionIndex(index);
                      },
                      controller: _pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      children:
                      selectedQuestionsCurrentQuestionIndexQuizIsCompletedState.$1.map(
                            (question) {
                          return SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ...[
                                  if (unitSubunitQuestionTypeProvider.$3 ==
                                      QuestionType.multi) ...[
                                    const MultiChoiceTile(),
                                  ],
                                  if (unitSubunitQuestionTypeProvider.$3 ==
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
        if (selectedQuestionsCurrentQuestionIndexQuizIsCompletedState.$1.isNotEmpty &&
            currentQuestion?.answerStage == AnswerStage.correct) ...[
          const ConfettiAnimation(),
        ],
        if (selectedQuestionsCurrentQuestionIndexQuizIsCompletedState.$1.isNotEmpty) ...[
          ConfettiAnimation(
            animate: currentQuestion?.answerStage == AnswerStage.correct,
          ),
        ],
      ],
    );
  }
}
