import 'package:economics_app/app/configs/constants.dart';
import 'package:economics_app/app/custom_widgets/custom_chip_button.dart';
import 'package:economics_app/app/state/audio_state.dart';
import 'package:economics_app/sections/quizzes/quiz_state/edit_question_state.dart';
import 'package:economics_app/sections/quizzes/quiz_state/quiz_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../app/audio_manager/audio_manager.dart';
import '../../main.dart';
import 'methods/start_quiz.dart';

class QuestionHomePage extends ConsumerStatefulWidget {
  const QuestionHomePage({super.key});

  @override
  ConsumerState<QuestionHomePage> createState() => _QuestionHomePageState();
}

class _QuestionHomePageState extends ConsumerState<QuestionHomePage> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    getIt<AudioManager>().stopSoundTrack();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final editState = ref.watch(editQuestionProvider);
    final quizNotifier = ref.read(quizProvider.notifier);
    final audioState = ref.watch(audioProvider);

    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: size.width * kPageIndentHorizontal),
      child: SingleChildScrollView(
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * kPageIndentHorizontal,
                  vertical: size.height * kPageIndentVertical,
                ),
                child: Column(
                  children: [
                    Container(
                      height: size.height * 0.40, // Set your desired height
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(16.0), // Rounded corners
                        image: const DecorationImage(
                          image: AssetImage(
                              'assets/images/study.jpg'), // Asset image path
                          fit: BoxFit
                              .cover, // Adjust the image to fit the container
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              CustomChipButton(
                isDisabled: editState.filteredQuestions.isEmpty,
                text: 'Start Quiz',
                onPressed: () {
                  final audio = getIt<AudioManager>();
                  if (audioState.soundtrackIsOn) {
                    audio.playSoundTrack('soundtrack_1');
                  }
                  audio.playSound('other/start');

                  startQuiz(
                    context: context,
                    filteredQuestions: editState.filteredQuestions,
                    limit: editState.maxNumberOfQuestions,
                    quizNotifier: quizNotifier,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
