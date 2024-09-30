import 'package:economics_app/app/configs/constants.dart';
import 'package:economics_app/app/custom_widgets/custom_big_button.dart';
import 'package:economics_app/app/custom_widgets/custom_page_heading.dart';

import 'package:economics_app/sections/quizzes/quiz_sections/add_question/add_question_page.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/methods/get_questions_from_firebase.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/question_page.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/quiz_options/quiz_options.dart';
import 'package:economics_app/sections/quizzes/quiz_state/quiz_state.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../app/custom_widgets/gap.dart';
import '../quiz_enums/answer_stage.dart';
import '../quiz_models/question_model.dart';

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

    final quizState = ref.watch(quizProvider);
    final quizNotifier = ref.read(quizProvider.notifier);

    if (quizState.selectedQuestions
        .every((question) => question.answerStage == AnswerStage.correct)) {
      if (quizState.selectedQuestions.every((question) =>
          question.answerStage == AnswerStage.correct ||
          question.answerStage == AnswerStage.incorrect)) {}
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
      child: Stack(
        children: [
          NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                CustomPageHeading(
                  icon: const Icon(
                    Icons.question_answer_outlined,
                    color: Colors.white,
                  ),
                  title: 'Quiz',
                  trailing: Padding(
                    padding: EdgeInsets.all(size.height * 0.005),
                    child: SizedBox(
                      height: size.height * 0.06,
                      width: size.height * 0.06,
                      child: FittedBox(
                        fit: BoxFit.contain,
                        // Ensures the icon scales down to fit inside
                        child: IconButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const AddQuestionPage(),
                              ),
                            );
                          },
                          icon: Icon(Icons.add_outlined,
                              color: Colors.white,
                              size:
                                  size.width * 0.20), // Icon size can be large
                        ),
                      ),
                    ),
                  ),
                ),
              ];
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
                              const Gap(),
                              ExpandableNotifier(
                                controller: _expandableController,
                                child: ExpandablePanel(
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
                              SizedBox(
                                height: size.height * 0.20,
                              ),
                              CustomBigButton(
                                  text: 'Start Quiz',
                                  onPressed: () {
                                    quizNotifier.setSelectedQuestions(
                                        quizState.allQuestions.toList());

                                    WidgetsBinding.instance
                                        .addPostFrameCallback((t) {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const QuestionPage()));
                                    });
                                  }),
                              SizedBox(
                                height: size.height * 0.20,
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
                      return Center(
                          child: Text(
                        'No questions found!\n\nUpload a quiz question to begin! (top-right plus icon)',
                        style: Theme.of(context).textTheme.displaySmall,
                        textAlign: TextAlign.center,
                      ));
                    }
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return const CircularProgressIndicator();
                }),
          ),
        ],
      ),
    );
  }
}
