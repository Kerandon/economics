import 'package:economics_app/sections/quizzes/quiz_enums/answer_stage.dart';
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

  void updateUserPref(UserPref pref) {
    List<QuestionModel> filteredQuestions = _getFilteredQuestions(pref);
    List<UserPref> existing = state.userPrefs.toList();
    for (int i = 0; i < existing.length; i++) {
      if (pref.question?.syllabus == existing[i].question?.syllabus &&
          pref.question?.questionType == existing[i].question?.questionType) {
        existing.removeAt(i);
        existing.insert(
          i,
          pref.copyWith(
            question: pref.question
                ?.copyWith(filteredQuestions: filteredQuestions.toList()),
          ),
        );
      }
    }
    state = state.copyWith(userPrefs: existing.toList());
  }

  List<QuestionModel> _getFilteredQuestions(UserPref pref) {
    List<QuestionModel> filteredQuestions = state.allTopicQuestions.toList();

    final c = pref.question;
    if (c?.syllabus != null) {
      filteredQuestions.retainWhere(
        (e) => e.syllabus == c?.syllabus,
      );
    }

    if (c?.units?.isNotEmpty ?? false) {
      filteredQuestions.retainWhere(
          (e) => e.units?.any((unit) => c!.units!.contains(unit)) ?? false);
    }

    if (c?.subunits?.isNotEmpty ?? false) {
      filteredQuestions.retainWhere((e) =>
          e.subunits?.any((unit) => c!.subunits!.contains(unit)) ?? false);
    }

    if (c?.questionType != null) {
      filteredQuestions.retainWhere((e) => e.questionType == c!.questionType);
    }

    if (c?.tags?.isNotEmpty ?? false) {
      filteredQuestions.retainWhere(
          (e) => e.tags?.any((tag) => c!.tags!.contains(tag)) ?? false);
    }

    return filteredQuestions;
  }

  void setAllUserPrefs(List<UserPref> prefs) {
    state = state.copyWith(userPrefs: prefs);
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
