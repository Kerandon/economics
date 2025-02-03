import 'package:economics_app/sections/quizzes/quiz_enums/quiz_filter.dart';

import '../../../../../app/utils/models/course.dart';
import '../../../../../app/utils/models/unit.dart';
import '../../../quiz_enums/flip_card_tag.dart';

class UserPref {
  final Course course;
  final FlipCardTag? flipCardTag;
  final int? numberOfQuestions;
  final QuizFilter? quizFilter;
  final List<Unit>? selectedUnits;
  final List<Unit>? selectedSubunits;
  final bool? showAnswersAtEnd;

  const UserPref({
    required this.course,
    this.flipCardTag,
    this.numberOfQuestions,
    this.quizFilter,
    this.selectedUnits,
    this.selectedSubunits,
    this.showAnswersAtEnd,
  });

  // copyWith method
  UserPref copyWith({
    Course? course,
    FlipCardTag? flipCardTag,
    int? numberOfQuestions,
    QuizFilter? quizFilter,
    List<Unit>? selectedUnits,
    List<Unit>? selectedSubunits,
    bool? showAnswersAtEnd,
  }) {
    return UserPref(
      course: course ?? this.course,
      flipCardTag: flipCardTag ?? this.flipCardTag,
      numberOfQuestions: numberOfQuestions ?? this.numberOfQuestions,
      quizFilter: quizFilter ?? this.quizFilter,
      selectedUnits: selectedUnits ?? this.selectedUnits,
      selectedSubunits: selectedSubunits ?? this.selectedSubunits,
      showAnswersAtEnd: showAnswersAtEnd ?? this.showAnswersAtEnd,
    );
  }

  @override
  String toString() {
    return 'UserPrefs(course: $course, flipCardTag: $flipCardTag, '
        'numberOfQuestions: $numberOfQuestions, selected units: $selectedUnits'
        'selected subunits $selectedSubunits show answers at end $showAnswersAtEnd'
        'quiz filter $quizFilter';
  }
}
