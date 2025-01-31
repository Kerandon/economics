import 'package:economics_app/app/configs/constants.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/question_type.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/quiz_filter.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/questions/quiz_models/question_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../app/utils/mixins/course_mixin.dart';
import '../../../app/utils/models/course.dart';
import '../quiz_enums/custom_tag.dart';
import '../quiz_enums/flip_card_tag.dart';
import '../quiz_sections/questions/quiz_models/user_prefs.dart';

class StartQuizState {
  final QuestionType questionType;
  final CourseMixin course;
  final QuizFilter quizFilter;
  final List<QuestionModel> filteredQuestions;
  final FlipCardTag flipCardTag;
  final bool isHL;
  final List<UserPrefs> userPrefs;
  final List<CustomTag> customTags;

  StartQuizState({
    required this.questionType,
    required this.course,
    required this.quizFilter,
    required this.filteredQuestions,
    required this.flipCardTag,
    required this.isHL,
    required this.userPrefs,
    required this.customTags,
  });

  StartQuizState copyWith({
    QuestionType? questionType,
    CourseMixin? course,
    QuizFilter? quizFilter,
    List<QuestionModel>? filteredQuestions,
    bool? checkAnswersAtEnd,
    FlipCardTag? flipCardTag,
    bool? isHL,
    List<UserPrefs>? userPrefs,
    List<CustomTag>? customTags,
  }) {
    return StartQuizState(
      quizFilter: quizFilter ?? this.quizFilter,
      filteredQuestions: filteredQuestions ?? this.filteredQuestions,
      course: course ?? this.course,
      questionType: questionType ?? this.questionType,
      flipCardTag: flipCardTag ?? this.flipCardTag,
      isHL: isHL ?? this.isHL,
      userPrefs: userPrefs ?? this.userPrefs,
      customTags: customTags ?? this.customTags,
    );
  }
}

class StartQuizNotifier extends StateNotifier<StartQuizState> {
  StartQuizNotifier(super._state);

  void setQuestionType(QuestionType type) {
    state = state.copyWith(questionType: type);
  }

  void setCourse(CourseMixin course) {
    state = state.copyWith(
      course: course,
    );
  }

  void setQuizFilter(QuizFilter filter) {
    state = state.copyWith(quizFilter: filter);
  }

  void setCheckAnswersAtEnd(bool checkAtEnd) {
    state = state.copyWith(checkAnswersAtEnd: checkAtEnd);
  }

  void setFlipCardTag(FlipCardTag tag) {
    state = state.copyWith(flipCardTag: tag);
  }

  void setHL(bool hl) {
    state = state.copyWith(isHL: hl);
  }

  void updateUserPrefs(UserPrefs prefs) {
    List<UserPrefs> existing = state.userPrefs.toList();
    for (int i = 0; i < existing.length; i++) {
      if (prefs.course == existing[i].course &&
          prefs.flipCardTag == existing[i].flipCardTag) {
        existing.removeAt(i);
        existing.insert(i, prefs);
      }
    }

    state = state.copyWith(userPrefs: existing);
  }

  setAllUserPrefs(List<UserPrefs> prefs) {
    state = state.copyWith(userPrefs: prefs);
  }

  void setCustomTags(CustomTag tag) {
    final currentList = state.customTags.toList();
    if (currentList.contains(tag)) {
      currentList.remove(tag);
    } else {
      currentList.add(tag);
    }
    state = state.copyWith(customTags: currentList);
  }
}

final startQuizProvider =
    StateNotifierProvider<StartQuizNotifier, StartQuizState>(
  (ref) => StartQuizNotifier(
    StartQuizState(
      questionType: QuestionType.flip,
      quizFilter: QuizFilter.all,
      course: Course(name: kIBEconomics, units: []),
      filteredQuestions: [],
      flipCardTag: FlipCardTag.definitions,
      isHL: false,
      userPrefs: [],
      customTags: [],
    ),
  ),
);
