import 'package:economics_app/app/configs/constants.dart';
import 'package:economics_app/app/custom_widgets/custom_chip_button.dart';
import 'package:economics_app/app/state/audio_state.dart';
import 'package:economics_app/sections/quizzes/custom_widgets/filter_button.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/quiz_filter.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/questions/quiz_models/question_model.dart';
import 'package:economics_app/sections/quizzes/quiz_state/edit_question_state.dart';
import 'package:economics_app/sections/quizzes/quiz_state/quiz_state.dart';
import 'package:economics_app/sections/settings/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../app/audio_manager/audio_manager.dart';
import '../../main.dart';
import 'methods/start_quiz.dart';

class QuizHomePage extends ConsumerStatefulWidget {
  const QuizHomePage({super.key});

  @override
  ConsumerState<QuizHomePage> createState() => _QuizHomePageState();
}

class _QuizHomePageState extends ConsumerState<QuizHomePage> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    getIt<AudioManager>().stopSoundTrack();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final numberOfQuestionsFilteredQuestionsQuizFilterAllQuestionsCourse =
        ref.watch(
      editQuestionProvider.select(
        (state) => (
          state.numberOfQuestions,
          state.filteredQuestions,
          state.quizFilter,
          state.allQuestions,
          state.course,
        ),
      ),
    );
    final quizNotifier = ref.read(quizProvider.notifier);
    final audioState = ref.watch(audioProvider);

    List<QuestionModel> selectedQuestions = [];

    if (numberOfQuestionsFilteredQuestionsQuizFilterAllQuestionsCourse.$3 ==
        QuizFilter.all) {
      for (var q
          in numberOfQuestionsFilteredQuestionsQuizFilterAllQuestionsCourse
              .$4) {
        if (q.course ==
            numberOfQuestionsFilteredQuestionsQuizFilterAllQuestionsCourse.$5) {
          selectedQuestions.add(q);
        }
      }
    } else {
      selectedQuestions.addAll(
        numberOfQuestionsFilteredQuestionsQuizFilterAllQuestionsCourse.$2
            .toList(),
      );
    }

    return Scaffold(
      drawer: const SettingsPage(),
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text('Quiz'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * kPageIndentHorizontal),
        child: SingleChildScrollView(
          child: FormBuilder(
            key: _formKey,
            child: Column(
              children: [
                QuizFilterButton(),
                SizedBox(
                  height: size.height * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomChipButton(
                      isDisabled:
                          selectedQuestions.isEmpty,
                      text: 'Start Quiz',
                      onPressed: () {
                        final audio = getIt<AudioManager>();
                        if (audioState.soundtrackIsOn) {
                          audio.playSoundTrack('soundtrack_1');
                        }
                        audio.playSound('other/start');

                        startQuiz(
                          context: context,
                          filteredQuestions: selectedQuestions,
                          limit:
                              numberOfQuestionsFilteredQuestionsQuizFilterAllQuestionsCourse
                                  .$1,
                          quizNotifier: quizNotifier,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
