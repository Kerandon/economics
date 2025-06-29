import 'package:economics_app/app/syllabus_data/courses_data.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/question_type.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/questions/quiz_models/gif_collection.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/questions/quiz_models/question_model.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/questions/quiz_models/user_prefs.dart';
import 'package:economics_app/sections/quizzes/quiz_state/edit_question_state.dart';
import 'package:economics_app/sections/quizzes/quiz_state/quiz_state.dart';
import 'package:economics_app/sections/quizzes/quiz_state/start_quiz_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../app/enums/syllabus_enum.dart';
import 'tab_main.dart';
import '../quizzes/methods/get_gifs.dart';
import '../quizzes/methods/get_questions_data.dart';

class QuizInitPage extends ConsumerStatefulWidget {
  const QuizInitPage({super.key});

  @override
  ConsumerState<QuizInitPage> createState() => _QuizInitPageState();
}

class _QuizInitPageState extends ConsumerState<QuizInitPage> {
  late final Future<List<QuestionModel>> _questionFuture;
  late final Future<GifCollection> _gifsFuture;
  bool _initHasRun = false;

  @override
  void initState() {
    _questionFuture = getQuestionsData();
    _gifsFuture = getGifs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final editNotifier = ref.read(editQuestionProvider.notifier);
    final startNotifier = ref.read(startQuizProvider.notifier);
    final quizNotifier = ref.read(quizProvider.notifier);

    return Scaffold(
      body: FutureBuilder<dynamic>(
          future: Future.wait([_questionFuture,_gifsFuture]),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (!_initHasRun) {
                _initHasRun = true;
                final questionData = snapshot.data[0];
                final gifData = snapshot.data[1];

                List<QuestionModel> questions = [];
                questions = questionData.toList();
                WidgetsBinding.instance.addPostFrameCallback((t) {
                  quizNotifier.setGifsCollection(gifData);
                  if (questions.isNotEmpty) {
                    editNotifier.setAllQuestions(questions);
                  }

                  List<UserPref> prefs = [
                    UserPref(
                      question: QuestionModel(
                        syllabuses: [allSyllabuses.firstWhere((e) => e.syllabus == Syllabus.ib)],
                        questionTypes: [QuestionType.multi],
                      ),
                    ),
                    UserPref(
                      question: QuestionModel(
                        syllabuses: [allSyllabuses.firstWhere((e) => e.syllabus == Syllabus.ib)],
                        questionTypes: [QuestionType.flip],
                      ),
                    ),
                    UserPref(
                      question: QuestionModel(
                        syllabuses: [allSyllabuses.firstWhere((e) => e.syllabus == Syllabus.igcse)],
                        questionTypes: [QuestionType.multi],
                      ),
                    ),
                    UserPref(
                      question: QuestionModel(
                        syllabuses: [allSyllabuses.firstWhere((e) => e.syllabus == Syllabus.igcse)],
                        questionTypes: [QuestionType.flip],
                      ),
                    ),
                  ];

                  WidgetsBinding.instance.addPostFrameCallback((t) {
                    startNotifier.setAllUserPrefs(prefs);
                  });

                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const TabBarMain(),
                    ),
                  );
                });
              }
            }
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.red,
            ));
          }),
    );
  }
}
