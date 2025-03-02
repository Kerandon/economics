import 'package:economics_app/app/configs/constants.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/questions/quiz_models/question_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../app/enums/course_enum.dart';

import '../../../app/utils/models/course_model.dart';
import '../quiz_enums/topic_tag.dart';
import '../quiz_sections/questions/quiz_models/user_prefs.dart';

class StartQuizState {
  final CourseModel course;
  final List<QuestionModel> allTopicQuestions;
  final List<QuestionModel> filteredQuestions;
  final TopicTag topicTag;
  final List<UserPref> userPrefs;
  final List<int> numberOfQuestions;

  StartQuizState({
    required this.course,
    required this.allTopicQuestions,
    required this.filteredQuestions,
    required this.topicTag,
    required this.userPrefs,
    required this.numberOfQuestions,
  });

  StartQuizState copyWith({
    CourseModel? course,
    List<QuestionModel>? allTopicQuestions,
    List<QuestionModel>? filteredQuestions,
    TopicTag? topicTag,
    List<UserPref>? userPrefs,
    List<int>? numberOfQuestions,
  }) {
    return StartQuizState(
      course: course ?? this.course,
      allTopicQuestions: allTopicQuestions ?? this.allTopicQuestions,
      filteredQuestions: filteredQuestions ?? this.filteredQuestions,
      topicTag: topicTag ?? this.topicTag,
      userPrefs: userPrefs ?? this.userPrefs,
      numberOfQuestions: numberOfQuestions ?? this.numberOfQuestions,
    );
  }
}

class StartQuizNotifier extends StateNotifier<StartQuizState> {
  StartQuizNotifier(super._state);

  void setCourse(CourseModel course) {
    state = state.copyWith(
      course: course,
    );
  }

  void setAllTopicQuestions(List<QuestionModel> allQuestions) {
    List<QuestionModel> allTopic = allQuestions.toList();
    allTopic.retainWhere(
        (e) => e.course == state.course && e.topicTag == state.topicTag);

    state = state.copyWith(allTopicQuestions: allTopic.toList());
  }

  void setFilteredQuestions(UserPref pref, List<QuestionModel> allQuestions) {
    List<QuestionModel> filteredQuestions = allQuestions.toList();

    if (pref.selectedUnits?.isNotEmpty ?? false) {
      filteredQuestions.retainWhere((e) {
        return pref.selectedUnits!.contains(e.unit);
      });
    }
    if (pref.selectedSubunits?.isNotEmpty ?? false) {
      filteredQuestions.retainWhere((e) {
        return pref.selectedUnits!.contains(e.unit) &&
            pref.selectedSubunits!.contains(e.subunit);
      });
    }

    state = state.copyWith(filteredQuestions: filteredQuestions.toList());
    setNumberOfPossibleQuestions(pref);
  }

  void setFlipCardTag(TopicTag tag) {
    state = state.copyWith(topicTag: tag);
  }

  void updateUserPrefs(UserPref pref, List<QuestionModel> allQuestions) {
    List<UserPref> existing = state.userPrefs.toList();
    for (int i = 0; i < existing.length; i++) {
      if (pref.course == existing[i].course &&
          pref.topicTag == existing[i].topicTag) {
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
          state.allTopicQuestions.toList());
    }
  }
}

final startQuizProvider =
    StateNotifierProvider<StartQuizNotifier, StartQuizState>(
  (ref) => StartQuizNotifier(
    StartQuizState(
      course: CourseModel(course: CourseEnum.ib, units: []),
      allTopicQuestions: [],
      filteredQuestions: [],
      topicTag: TopicTag.term,
      userPrefs: [],
      numberOfQuestions: [],
    ),
  ),
);
