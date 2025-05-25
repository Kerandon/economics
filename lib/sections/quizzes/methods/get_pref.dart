import '../quiz_sections/questions/quiz_models/user_prefs.dart';
import '../quiz_state/start_quiz_state.dart';

UserPref getPref(StartQuizState startState) {
  final c = startState.userPrefs.firstWhere((e) {
    return e.question?.syllabuses?[0] == startState.syllabus &&
        e.question?.questionTypes == startState.questionType;
  }, orElse: () {
    throw Exception('no pref found');
  });
  return c;
}