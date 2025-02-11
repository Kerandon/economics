import 'package:economics_app/sections/quizzes/quiz_enums/quiz_filter.dart';

import '../../../../../app/utils/models/course.dart';
import '../../../../../app/utils/models/unit.dart';
import '../../../quiz_enums/topic_tag.dart';

class UserPref {
  final Course course;
  final TopicTag? topicTag;
  final int? numberOfQuestions;
  final List<Unit>? selectedUnits;
  final List<Unit>? selectedSubunits;
  final bool? showAnswersAtEnd;

  const UserPref({
    required this.course,
    this.topicTag,
    this.numberOfQuestions,
    this.selectedUnits,
    this.selectedSubunits,
    this.showAnswersAtEnd,
  });

  // copyWith method
  UserPref copyWith({
    Course? course,
    TopicTag? topicTag,
    int? numberOfQuestions,
    QuizFilter? quizFilter,
    List<Unit>? selectedUnits,
    List<Unit>? selectedSubunits,
    bool? showAnswersAtEnd,
  }) {
    return UserPref(
      course: course ?? this.course,
      topicTag: topicTag ?? this.topicTag,
      numberOfQuestions: numberOfQuestions ?? this.numberOfQuestions,
      selectedUnits: selectedUnits ?? this.selectedUnits,
      selectedSubunits: selectedSubunits ?? this.selectedSubunits,
      showAnswersAtEnd: showAnswersAtEnd ?? this.showAnswersAtEnd,
    );
  }

  @override
  String toString() {
    return 'UserPrefs(course: $course, flipCardTag: $topicTag, '
        'numberOfQuestions: $numberOfQuestions, selected units: $selectedUnits'
        'selected subunits $selectedSubunits show answers at end $showAnswersAtEnd';
  }
}
