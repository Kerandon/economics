import 'package:economics_app/app/configs/constants.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/topic_tag.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/questions/quiz_models/question_model.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/questions/quiz_models/user_prefs.dart';
import 'package:economics_app/sections/quizzes/quiz_state/edit_question_state.dart';
import 'package:economics_app/sections/quizzes/quiz_state/start_quiz_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../app/utils/mixins/course_mixin.dart';
import '../../app/utils/models/course.dart';
import '../../app/utils/models/unit.dart';
import '../settings/edit_courses/helper_methods/get_course_data_from_firebase.dart';
import '../tab_main.dart';
import 'methods/get_questions_data.dart';

class QuizInitPage extends ConsumerStatefulWidget {
  const QuizInitPage({super.key});

  @override
  ConsumerState<QuizInitPage> createState() => _QuizInitPageState();
}

class _QuizInitPageState extends ConsumerState<QuizInitPage> {
  final List<Future<dynamic>> _futures = [];
  bool _initHasRun = false;

  @override
  void initState() {
    _futures.addAll([getCourseData(), getQuestionsData()]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final editNotifier = ref.read(editQuestionProvider.notifier);
    final startNotifier = ref.watch(startQuizProvider.notifier);
    return Scaffold(
      body: FutureBuilder(
          future: Future.wait(_futures),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (!_initHasRun) {
                _initHasRun = true;
                final courseData = snapshot.data?[0];
                final questionData = snapshot.data?[1];
                List<CourseMixin> courses = [];
                List<QuestionModel> questions = [];
                for (var e in courseData!.docs) {
                  courses.add(
                    Course.fromMap({
                      e.id: e.data(),
                    }),
                  );
                }
                questions = questionData.toList();
                WidgetsBinding.instance.addPostFrameCallback((t) {
                  if (courses.isNotEmpty) {
                    editNotifier
                      ..setCourses(courses)
                      ..setCourse(courses.first);
                  }
                  if (questions.isNotEmpty) {
                    editNotifier.setAllQuestions(questions);
                  }

                  List<UserPref> prefs = [];

// Usage:
                  addUserPrefs(prefs, courses, kIBEconomics);
                  addUserPrefs(prefs, courses, kIGCSEEconomics);
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
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }

  void addUserPrefs(
      List<UserPref> prefs, List<CourseMixin> courses, String courseName) {
    final course = courses.firstWhere((c) => c.name == courseName);
    for (var e in TopicTag.values) {
      prefs.add(
        UserPref(
          course: course as Course,
          topicTag: e,
          numberOfQuestions: 0,
          selectedUnits: [course.units.first as Unit],
          showAnswersAtEnd: false,
        ),
      );
    }
  }
}
