import 'package:economics_app/app/configs/constants.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/answer_stage.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/question_type.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/quiz_filter.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/questions/quiz_models/question_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../app/utils/mixins/course_mixin.dart';
import '../../../app/utils/models/course.dart';
import '../quiz_enums/flip_card_tag.dart';
import '../quiz_sections/questions/quiz_models/user_prefs.dart';

class StartQuizState {
  final QuestionType questionType;
  final CourseMixin course;
  final List<QuestionModel> filteredQuestions;
  final FlipCardTag flipCardTag;
  final List<UserPref> userPrefs;
  final List<int> numberOfQuestions;

  StartQuizState({
    required this.questionType,
    required this.course,
    required this.filteredQuestions,
    required this.flipCardTag,
    required this.userPrefs,
    required this.numberOfQuestions,
  });

  StartQuizState copyWith({
    QuestionType? questionType,
    CourseMixin? course,
    List<QuestionModel>? filteredQuestions,
    FlipCardTag? flipCardTag,
    List<UserPref>? userPrefs,
    List<int>? numberOfQuestions,
  }) {
    return StartQuizState(
      filteredQuestions: filteredQuestions ?? this.filteredQuestions,
      course: course ?? this.course,
      questionType: questionType ?? this.questionType,
      flipCardTag: flipCardTag ?? this.flipCardTag,
      userPrefs: userPrefs ?? this.userPrefs,
      numberOfQuestions: numberOfQuestions ?? this.numberOfQuestions,
    );
  }
}

class StartQuizNotifier extends StateNotifier<StartQuizState> {
  StartQuizNotifier(super._state);

  void setCourse(CourseMixin course) {
    state = state.copyWith(
      course: course,
    );
  }

  void setFilteredQuestions(UserPref pref, List<QuestionModel> allQuestions) {
    // Step 1: Filter questions by course
    List<QuestionModel> filteredQuestions = allQuestions
        .where((q) =>
            q.course == pref.course) // Keep questions that match the course
        .toList();

    // Step 2: Filter questions by selected units (if selectedUnits is not null and not empty)
    if (pref.quizFilter == QuizFilter.unit && pref.selectedUnits != null) {
      filteredQuestions = filteredQuestions
          .where((q) => pref.selectedUnits!
              .contains(q.unit)) // Keep questions that match selected units
          .toList();
    }

    // If no units are selected, include all questions (matching the course) by default
    if (pref.quizFilter == QuizFilter.subunit && pref.selectedSubunits != null) {
      filteredQuestions = filteredQuestions
          .where((q) => pref.selectedSubunits!
              .contains(q.subunit)) // Keep questions that match selected units
          .toList();
    }

    // If no units are selected, include all questions (matching the course) by default
    // Step 3: Sort the filtered questions
    filteredQuestions.shuffle();
    for (var q in filteredQuestions) {
      q.answers?.shuffle();
      for (var i = 0; i < q.answers!.length; i++) {
        // Update the answer directly in the list
        q.answers![i] =
            q.answers![i].copyWith(answerStage: AnswerStage.notSelected);
      }
    }

    // Step 4: Update the state with the filtered and sorted questions

    state = state.copyWith(filteredQuestions: filteredQuestions);
    setNumberOfPossibleQuestions(pref, allQuestions.toList());
  }

  void setFlipCardTag(FlipCardTag tag) {
    state = state.copyWith(flipCardTag: tag);
  }

  void updateUserPrefs(UserPref pref, List<QuestionModel> allQuestions) {
    List<UserPref> existing = state.userPrefs.toList();
    for (int i = 0; i < existing.length; i++) {
      if (pref.course == existing[i].course &&
          pref.flipCardTag == existing[i].flipCardTag) {
        existing.removeAt(i);
        existing.insert(i, pref);
      }
    }

    state = state.copyWith(userPrefs: existing);
    setFilteredQuestions(pref, allQuestions);
  }

  void setAllUserPrefs(List<UserPref> prefs) {
    state = state.copyWith(userPrefs: prefs);
  }

  void setNumberOfPossibleQuestions(UserPref pref, List<QuestionModel> allQuestions) {
    final totalQuestions = state.filteredQuestions.length;
    List<int> numberOfPossibleQuestions =
    kMaxNumberOfQuestions.where((n) => n <= totalQuestions).toList();

    if (totalQuestions == 0) {
      numberOfPossibleQuestions = []; // Ensure an empty list when there are zero questions
    } else {
      if (numberOfPossibleQuestions.isEmpty || totalQuestions < kMaxNumberOfQuestions.first) {
        numberOfPossibleQuestions.add(totalQuestions);
      }
      if (totalQuestions > kMaxNumberOfQuestions.last) {
        numberOfPossibleQuestions.add(totalQuestions);
      }
    }

    state = state.copyWith(numberOfQuestions: numberOfPossibleQuestions);
    if(numberOfPossibleQuestions.isNotEmpty && !numberOfPossibleQuestions.contains(pref.numberOfQuestions)){
updateUserPrefs(pref.copyWith(numberOfQuestions: numberOfPossibleQuestions.first), allQuestions.toList());
    }
  }

}

final startQuizProvider =
    StateNotifierProvider<StartQuizNotifier, StartQuizState>(
  (ref) => StartQuizNotifier(
    StartQuizState(
      questionType: QuestionType.flip,
      course: Course(name: kIBEconomics, units: []),
      filteredQuestions: [],
      flipCardTag: FlipCardTag.definitions,
      userPrefs: [],
      numberOfQuestions: [],
    ),
  ),
);
