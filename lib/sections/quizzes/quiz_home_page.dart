import 'package:economics_app/app/configs/constants.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/methods/get_questions_from_firebase.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/questions/question_page.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/questions/quiz_models/question_model.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/quiz_options/quiz_options.dart';
import 'package:economics_app/sections/quizzes/quiz_state/quiz_state.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../app/audio_manager.dart';
import '../../app/custom_widgets/custom_chip_button.dart';
import '../../app/custom_widgets/gap.dart';
import '../../app/enums/audio_clip.dart';
import 'quiz_enums/answer_stage.dart';

class QuizHomePage extends ConsumerStatefulWidget {
  const QuizHomePage({super.key});

  @override
  ConsumerState<QuizHomePage> createState() => _ReviewPageState();
}

class _ReviewPageState extends ConsumerState<QuizHomePage> {
  final ExpandableController _expandableController =
      ExpandableController(initialExpanded: false);

  bool _downloadedAllQuestionsOnInit = false;
  late final Future<List<QuestionModel>> _questionFuture;

  @override
  void initState() {
    _questionFuture = getQuestionsFromFirebase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    List<QuestionModel> allQuestions = [];
    final quizState = ref.watch(quizProvider);
    final quizNotifier = ref.read(quizProvider.notifier);

    if (quizState.selectedQuestions
        .every((question) => question.answerStage == AnswerStage.correct)) {
      if (quizState.selectedQuestions.every((question) =>
          question.answerStage == AnswerStage.correct ||
          question.answerStage == AnswerStage.incorrect)) {}
    }

    return Stack(
      children: [
        NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[];
          },
          body: FutureBuilder<List<QuestionModel>>(
              future: _questionFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    if (!_downloadedAllQuestionsOnInit) {
                      _downloadedAllQuestionsOnInit = true;
                      WidgetsBinding.instance.addPostFrameCallback((t) {
                        quizNotifier.setAllQuestions(snapshot.data!.toList());
                      });

                      for (var q in quizState.allQuestions) {
                        allQuestions.add(q);
                      }
                    }

                    List<QuestionModel> selectedQuestions = [];
                    for (var q in quizState.allQuestions) {
                      if (q.unit == quizState.unit &&
                          q.subunit == quizState.subunit) {
                        selectedQuestions.add(q);
                      }
                    }

                    ///todo remove below to test!!!!
                    if (selectedQuestions.length > 1) {
                      selectedQuestions = [
                        selectedQuestions.first,
                        selectedQuestions[1]
                      ];
                    }
                    return SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * kPageIndentHorizontal,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ExpandableNotifier(
                              controller: _expandableController,
                              child: ExpandablePanel(
                                theme: const ExpandableThemeData(
                                    tapBodyToCollapse: false),
                                header: ListTile(
                                  title: Row(
                                    children: [
                                      Icon(
                                        Icons.settings_outlined,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      const Text('Quiz options'),
                                    ],
                                  ),
                                ),
                                collapsed: const SizedBox.shrink(),
                                expanded: const QuizOptions(),
                              ),
                            ),
                            const Gap(),
                            CustomChipButton(
                                isDisabled: selectedQuestions.isEmpty,
                                text: 'Start Quiz',
                                onPressed: () {
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((t) {
                                    quizNotifier.setSelectedQuestions(
                                        selectedQuestions);
                                  });
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((t) {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const QuestionPage(),
                                      ),
                                    );
                                  });
                                  AudioManager.playAudio(AudioClip.start);
                                }),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: size.height * 0.05,
                                  bottom: size.height * 0.10),
                              child: Image.asset('assets/images/study.jpg'),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  if (snapshot.hasError) {
                    return const Center(
                        child: Text(
                      'An error occurred. \n\n'
                      'Please check your internet connection and try again. \n\n',
                      textAlign: TextAlign.center,
                    ));
                  }
                  if (snapshot.data == null || snapshot.data!.isEmpty) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 100,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        Text(
                          'No questions found!\n\nAdd a quiz question to begin (top-right plus icon)',
                          style: Theme.of(context).textTheme.titleMedium,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    );
                  }
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                return const CircularProgressIndicator();
              }),
        ),
      ],
    );
  }
}
