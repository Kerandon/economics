import 'package:auto_size_text/auto_size_text.dart';
import 'package:economics_app/app/configs/constants.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/answer_stage.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/flip_card_tag.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/questions/custom_slider.dart';

import 'package:economics_app/sections/quizzes/quiz_sections/questions/flip_card/flip_card_tile.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/questions/multi_choice/multi_choice_tile.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/questions/question_navigation_buttons.dart';

import 'package:economics_app/sections/quizzes/quiz_sections/questions/quiz_models/question_model.dart';
import 'package:economics_app/sections/quizzes/quiz_state/edit_question_state.dart';
import 'package:economics_app/sections/quizzes/quiz_state/quiz_state.dart';
import 'package:economics_app/sections/tab_main.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../app/animation/confetti_animation.dart';
import '../../../../app/audio_manager/audio_manager.dart';

import '../../../../main.dart';

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
    final theme = Theme.of(context);

    final quizState = ref.watch(quizProvider);

    final editState = ref.watch(editQuestionProvider);

    QuestionModel? currentQuestion;
    if (quizState.selectedQuestions.isNotEmpty) {
      currentQuestion =
          quizState.selectedQuestions[quizState.currentQuestionIndex];
    }
    final quizNotifier = ref.read(quizProvider.notifier);
    final customButtonGap = size.height * 0.04;

    if (quizState.quizIsCompleted) {
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
          backgroundColor: Theme.of(context).colorScheme.surface,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_outlined,
                color: theme.colorScheme.onSurface,
              ),
              onPressed: () {
                quizNotifier.setResetQuestions();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return const TabBarMain();
                    },
                  ),
                );
                WidgetsBinding.instance.addPostFrameCallback((t) {});
              },
            ),
            title: Row(
              children: [
                // Align the text to the left
                Expanded(
                  flex: 12,
                  child: AutoSizeText(
                    '${editState.unit.name} - ${editState.subunit.name}',
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                    style: TextStyle(color: theme.colorScheme.primary),
                  ),
                ),
                // You can add other widgets like CustomSlider if needed, but now the text is left-aligned
                Expanded(
                  flex: 6,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    child: CustomSlider(),
                  ),
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
                          padding: EdgeInsets.symmetric(
                            horizontal: size.width * kPageIndentHorizontal,
                            vertical: size.height * kPageIndentVertical,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ...[
                                if (question.flipCardTag ==
                                    FlipCardTag.multipleChoiceQuestions) ...[
                                  MultiChoiceTile(question),
                                ],
                                if (question.flipCardTag !=
                                    FlipCardTag.multipleChoiceQuestions) ...[
                                  FlipCardTile(
                                    question,
                                    editMode: false,
                                  ),
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
          floatingActionButton: QuestionNavigationButtons(
            pageController: _pageController,
          ),
        ),
        if (quizState.selectedQuestions.isNotEmpty &&
            currentQuestion?.answerStage == AnswerStage.correct) ...[
          const ConfettiAnimation(),
        ],
        if (quizState.selectedQuestions.isNotEmpty) ...[
          ConfettiAnimation(
            animate: currentQuestion?.answerStage == AnswerStage.correct,
          ),
        ],
      ],
    );
  }
}
