import '../quiz_sections/questions/quiz_models/user_prefs.dart';
import '../quiz_state/start_quiz_state.dart';

UserPref getPref(StartQuizState startState) {
  final c = startState.userPrefs.firstWhere((e) {
    return e.question?.syllabus == startState.syllabus &&
        e.question?.questionType == startState.questionType;
  }, orElse: () {
    throw Exception('no pref found');
  });
  return c;
}