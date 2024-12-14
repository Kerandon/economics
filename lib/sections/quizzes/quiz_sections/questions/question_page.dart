import 'package:auto_size_text/auto_size_text.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/answer_stage.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/question_type.dart';
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
                      return const TabBarMain();
                    },
                  ),
                );
                WidgetsBinding.instance.addPostFrameCallback((t) {});
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
                                  MultiChoiceTile(question),
                                ],
                                if (editState.questionType ==
                                    QuestionType.flip) ...[
                                  FlipCardTile(question),
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
