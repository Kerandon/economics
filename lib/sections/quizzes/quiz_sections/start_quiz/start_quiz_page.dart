import 'package:economics_app/app/custom_widgets/custom_chip_button.dart';
import 'package:economics_app/sections/quizzes/methods/get_pref.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/question_type.dart';

import 'package:economics_app/sections/quizzes/quiz_sections/questions/quiz_models/question_model.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/start_quiz/answers_at_end_button.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/start_quiz/start_number_of_questions_button.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/start_quiz/start_subunits_buttons.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/start_quiz/start_tags_button.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/start_quiz/start_units_button.dart';
import 'package:economics_app/sections/quizzes/quiz_state/quiz_state.dart';
import 'package:economics_app/sections/quizzes/quiz_state/start_quiz_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../app/audio_manager/audio_manager.dart';
import '../../../../main.dart';
import '../../../home_page/tab_main.dart';
import '../../quiz_enums/answer_stage.dart';
import '../questions/question_page.dart';
import '../questions/quiz_models/answer_model.dart';

class StartQuizPage extends ConsumerStatefulWidget {
  const StartQuizPage({super.key});

  @override
  ConsumerState<StartQuizPage> createState() => _StartPageState();
}

class _StartPageState extends ConsumerState<StartQuizPage> {
  bool _initHasRun = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final startState = ref.watch(startQuizProvider);
    final startNotifier = ref.read(startQuizProvider.notifier);
    final quizNotifier = ref.read(quizProvider.notifier);
    final pref = getPref(startState);

    if (!_initHasRun) {
      _initHasRun = true;
      WidgetsBinding.instance.addPostFrameCallback((t) {
        startNotifier.updateUserPref(pref);
      });
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => TabBarMain(),
              ),
            );
          },
          icon: Icon(
            Icons.arrow_back_outlined,
          ),
        ),
        title: SizedBox(
          height: size.height * 0.06,
          child: Row(
            children: [
              Text(
                'Economics App',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            collapsedHeight: kToolbarHeight * 1.5,
            expandedHeight: 0,
            flexibleSpace: FlexibleSpaceBar(
              title: Row(
                children: [
                  Expanded(
                    flex: 10,
                    child: StartUnitsButton(),
                  ),
                  Expanded(
                    flex: 10,
                    child: StartSubunitsButton(),
                  ),
                  Expanded(
                    flex: 10,
                    child: StartTagsButton(),
                  ),
                  Expanded(
                    flex: 10,
                    child: StartNumberOfQuestionsButton(),
                  ),
                  if (pref.question?.questionTypes?[0] ==
                      QuestionType.multi) ...[
                    Expanded(
                      flex: 10,
                      child: AnswersAtEndButton(),
                    ),
                  ],
                ],
              ),
            ),
            automaticallyImplyLeading: false,
            pinned:
                true, // Keeps the app bar fixed at the top// Height of the expanded app bar
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              width: size.width,
              height: size.height * 0.80,
              child: Padding(
                padding: const EdgeInsets.all(88.0),
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Selected ${pref.question?.numberOfQuestions.toString()} of ${pref.question?.filteredQuestions?.toList().length} total questions',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                        ),
                        CustomChipButton(
                          onTap: () {
                            List<QuestionModel> f =
                                pref.question!.filteredQuestions?.toList() ??
                                    [];
                            List<QuestionModel> updatedQuestions = f
                                .map((e) => e.copyWith(
                                      answers: e.answers
                                          ?.map((a) => a.copyWith(
                                              answerStage:
                                                  AnswerStage.notSelected))
                                          .toList(),
                                      answerStage: AnswerStage
                                          .notSelected, // If needed at the question level
                                    ))
                                .toList();
                            updatedQuestions = updatedQuestions.map((question) {
                              List<AnswerModel> shuffledAnswers = [
                                ...?question.answers
                              ]..shuffle(); // Create a new shuffled list
                              return question.copyWith(
                                  answers:
                                      shuffledAnswers); // Return a new instance of question
                            }).toList();

                            updatedQuestions
                                .shuffle(); // Shuffle the questions AFTER updating answers

                            updatedQuestions = updatedQuestions
                                .getRange(
                                    0, pref.question?.numberOfQuestions ?? 0)
                                .toList();
                            getIt<AudioManager>().playSoundTrack(
                                'soundtrack_1'); // Retrieve instance
                            quizNotifier
                              ..setResetQuestions()
                              ..setSelectedQuestions(updatedQuestions.toList());

                            WidgetsBinding.instance.addPostFrameCallback((t) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => QuestionPage(),
                                ),
                              );
                            });
                          },
                          label: 'Start',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
