import 'package:economics_app/app/syllabus_data/courses_data.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/question_type.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/questions/quiz_models/question_model.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/questions/quiz_models/user_prefs.dart';
import 'package:economics_app/sections/quizzes/quiz_state/edit_question_state.dart';
import 'package:economics_app/sections/quizzes/quiz_state/start_quiz_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../app/enums/syllabus_enum.dart';
import '../tab_main.dart';
import 'methods/get_questions_data.dart';

class QuizInitPage extends ConsumerStatefulWidget {
  const QuizInitPage({super.key});

  @override
  ConsumerState<QuizInitPage> createState() => _QuizInitPageState();
}

class _QuizInitPageState extends ConsumerState<QuizInitPage> {
  late final Future<List<QuestionModel>> _questionFuture;
  bool _initHasRun = false;

  @override
  void initState() {
    _questionFuture = getQuestionsData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final editNotifier = ref.read(editQuestionProvider.notifier);
    final startNotifier = ref.read(startQuizProvider.notifier);

    return Scaffold(
      body: FutureBuilder<dynamic>(
          future: _questionFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (!_initHasRun) {
                _initHasRun = true;
                final questionData = snapshot.data;

                List<QuestionModel> questions = [];
                questions = questionData.toList();
                WidgetsBinding.instance.addPostFrameCallback((t) {
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
