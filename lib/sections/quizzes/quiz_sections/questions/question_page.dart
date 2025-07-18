
import 'package:economics_app/app/configs/constants.dart';
import 'package:economics_app/app/state/app_state.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/answer_stage.dart';
import 'package:economics_app/sections/quizzes/custom_widgets/custom_slider.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/question_type.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/questions/flip_card_tile.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/questions/multi_choice_tile.dart';
import 'package:economics_app/sections/quizzes/custom_widgets/question_navigation_buttons.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/questions/quiz_models/question_model.dart';
import 'package:economics_app/sections/quizzes/quiz_state/quiz_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../app/animation/confetti_animation.dart';
import '../../../../app/audio_manager/audio_manager.dart';
import '../../../../main.dart';
import '../../custom_widgets/gif_popup.dart';
import '../../custom_widgets/score_bar.dart';

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
    final size = MediaQuery.of(context).size;
    final horizontalPadding = size.width * kPageIndentHorizontal;
    final quizState = ref.watch(quizProvider);
    final quizNotifier = ref.read(quizProvider.notifier);
    final appNotifier = ref.read(appProvider.notifier);
    QuestionModel? c;
    if (quizState.selectedQuestions.isNotEmpty) {
      c = quizState.selectedQuestions[quizState.currentQuestionIndex];
    }
    final customButtonGap = size.height * 0.04;

    if (quizState.quizIsCompleted) {
      if (!_completeAudioHasPlayed) {
        _completeAudioHasPlayed = true;
        final audioManager = getIt<AudioManager>();
        if (audioManager.soundTrackPlayer.playing) {
          audioManager.stopSoundTrack();
        }
        audioManager.playSound('correct/correct_2');
      }
    }

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_outlined,
              ),
              onPressed: () {
                quizNotifier.setResetQuestions();
                Navigator.of(context).pop();
              },
            ),
            title: Row(
              children: [
                // Align the text to the left
                SizedBox(
                  height: size.height * 0.06,
                  child: Row(
                    children: [
                      Text(
                        'Economics App',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: IconButton(
                    onPressed: () {
                      appNotifier.setFontSize();
                    },
                    icon: Icon(
                      Icons.format_size_outlined,
                    ),
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    child: CustomSlider(),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (c?.questionTypes?[0] == QuestionType.multi) ...[
                      ScoreBar()
                    ],
                    if (c?.questionTypes?[0] == QuestionType.flip) ...[
                      Text(
                          'Flagged questions ${quizState.selectedQuestions.where((q) => q.answerStage == AnswerStage.incorrect).length}')
                    ],
                  ],
                ),
                SizedBox(
                  width: size.width * kPageIndentHorizontal,
                ),
              ],
            ),
          ),
          body: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[];
            },
            body: Stack(
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
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: size.height * 0.02,
                            left: horizontalPadding,
                            right: horizontalPadding,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ...[
                                if (question.questionTypes?[0] ==
                                    QuestionType.multi) ...[
                                  MultiChoiceTile(question),
                                ],
                                if (question.questionTypes?[0] !=
                                    QuestionType.multi) ...[
                                  FlipCardTile(question),
                                ],
                                SizedBox(
                                  height: customButtonGap,
                                ),
                              ],
                              SizedBox(
                                height: size.height * 0.05,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ],
            ),
          ),
        ),

        GifPopup(),
        Align(
          alignment: Alignment.bottomCenter,
          child: QuestionNavigationButtons(
            pageController: _pageController,
          ),
        ),
        if (c?.answerStage == AnswerStage.correct) ...[
          const ConfettiAnimation(),
        ],
      ],
    );
  }
}


