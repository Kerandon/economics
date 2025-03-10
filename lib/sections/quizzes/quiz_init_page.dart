import 'package:economics_app/sections/quizzes/quiz_sections/questions/quiz_models/question_model.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/questions/quiz_models/user_prefs.dart';
import 'package:economics_app/sections/quizzes/quiz_state/edit_question_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../app/enums/syllabus_enum.dart';
import '../../app/utils/models/syllabus_model.dart';
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

                  List<UserPref> prefs = [];

                  // addUserPrefs(prefs, courses, CourseEnum.ib);
                  // addUserPrefs(prefs, courses, CourseEnum.igcse);
                  // WidgetsBinding.instance.addPostFrameCallback((t) {
                  //   startNotifier.setAllUserPrefs(prefs);
                  // });

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

  Future<void> addUserPrefs(List<UserPref> prefs, List<SyllabusModel> syllabuses,
      Syllabus courseEnum) async {
   // final c = syllabuses.firstWhere((c) => c.syllabus == courseEnum);
    // for (var e in TopicTag.values) {
    //   prefs.add(
    //     UserPref(
    //       course: c,
    //       numberOfQuestions: 0,
    //       selectedUnits: [],
    //       showAnswersAtEnd: false,
    //     ),
    //   );
    // }
  }
}
