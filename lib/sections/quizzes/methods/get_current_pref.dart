import 'package:economics_app/sections/quizzes/quiz_sections/questions/quiz_models/user_prefs.dart';
import 'package:economics_app/sections/quizzes/quiz_state/start_quiz_state.dart';

UserPref getCurrentPref(StartQuizState startState) {
  return startState.userPrefs.toList().firstWhere((p) =>
      p.question?.syllabus == startState.syllabus);
}
