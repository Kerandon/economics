import 'package:economics_app/app/configs/constants.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/question_type.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/questions/quiz_models/question_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../app/enums/syllabus_enum.dart';
import '../../../app/utils/models/syllabus_model.dart';
import '../quiz_sections/questions/quiz_models/user_prefs.dart';

class StartQuizState {
  final SyllabusModel syllabus;
  final QuestionType questionType;
  final List<QuestionModel> allTopicQuestions;
  final List<QuestionModel> filteredQuestions;
  final List<UserPref> userPrefs;

  StartQuizState({
    required this.syllabus,
    required this.questionType,
    required this.allTopicQuestions,
    required this.filteredQuestions,
    required this.userPrefs,
  });

  StartQuizState copyWith({
    SyllabusModel? syllabus,
    QuestionType? questionType,
    List<QuestionModel>? allTopicQuestions,
    List<QuestionModel>? filteredQuestions,
    List<UserPref>? userPrefs,
    List<int>? numberOfQuestions,
  }) {
    return StartQuizState(
      syllabus: syllabus ?? this.syllabus,
      questionType: questionType ?? this.questionType,
      allTopicQuestions: allTopicQuestions ?? this.allTopicQuestions,
      filteredQuestions: filteredQuestions ?? this.filteredQuestions,
      userPrefs: userPrefs ?? this.userPrefs,
    );
  }
}

class StartQuizNotifier extends StateNotifier<StartQuizState> {
  StartQuizNotifier(super._state);

  void setSyllabus(SyllabusModel syllabus) {
    state = state.copyWith(
      syllabus: syllabus,
    );
  }

  void setQuestionType(QuestionType type) {
    state = state.copyWith(
      questionType: type,
    );
  }

  void setAllTopicQuestions(List<QuestionModel> allQuestions) {
    List<QuestionModel> allTopic = allQuestions.toList();
    allTopic.retainWhere((e) => e.syllabus == state.syllabus);

    state = state.copyWith(allTopicQuestions: allTopic.toList());
  }

  void setFilteredQuestions(UserPref pref, List<QuestionModel> allQuestions) {
    List<QuestionModel> filteredQuestions = allQuestions.toList();

    state = state.copyWith(filteredQuestions: filteredQuestions.toList());
    setNumberOfPossibleQuestions(pref);
  }

  void updateUserPrefs(UserPref pref) {
    List<UserPref> existing = state.userPrefs.toList();
    for (int i = 0; i < existing.length; i++) {
      if (pref.question?.syllabus == existing[i].question?.syllabus &&
          pref.question?.questionType == existing[i].question?.questionType) {
        existing.removeAt(i);
        existing.insert(i, pref);
      }
    }

    state = state.copyWith(userPrefs: existing);
  }

  void setAllUserPrefs(List<UserPref> prefs) {
    state = state.copyWith(userPrefs: prefs);
  }

  void setNumberOfPossibleQuestions(UserPref pref) {
    final totalQuestions = state.filteredQuestions.length;
    List<int> numberOfPossibleQuestions =
        kMaxNumberOfQuestions.where((n) => n <= totalQuestions).toList();

    if (totalQuestions == 0) {
      numberOfPossibleQuestions =
          []; // Ensure an empty list when there are zero questions
    } else {
      if (numberOfPossibleQuestions.isEmpty ||
          totalQuestions < kMaxNumberOfQuestions.first) {
        numberOfPossibleQuestions.add(totalQuestions);
      }
      if (totalQuestions > kMaxNumberOfQuestions.last) {
        numberOfPossibleQuestions.add(totalQuestions);
      }
    }

    state = state.copyWith(numberOfQuestions: numberOfPossibleQuestions);
    if (numberOfPossibleQuestions.isNotEmpty &&
        !numberOfPossibleQuestions.contains(pref.numberOfQuestions)) {
      updateUserPrefs(
        pref.copyWith(numberOfQuestions: numberOfPossibleQuestions.first),
      );
    }
  }
}

final startQuizProvider =
    StateNotifierProvider<StartQuizNotifier, StartQuizState>(
  (ref) => StartQuizNotifier(
    StartQuizState(
      syllabus: SyllabusModel(syllabus: Syllabus.ib, units: []),
      allTopicQuestions: [],
      filteredQuestions: [],
      userPrefs: [],
      questionType: QuestionType.multi,
    ),
  ),
);
