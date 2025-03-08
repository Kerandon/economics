import 'package:economics_app/sections/quizzes/quiz_enums/quiz_filter.dart';

import '../../../../../app/utils/models/course_model.dart';

import '../../../../../app/utils/models/unit_model.dart';

class UserPref {
  final CourseModel course;

  // final TopicTag? topicTag;
  final int? numberOfQuestions;
  final List<UnitModel>? selectedUnits;
  final List<UnitModel>? selectedSubunits;
  final bool? showAnswersAtEnd;

  const UserPref({
    required this.course,
    // this.topicTag,
    this.numberOfQuestions,
    this.selectedUnits,
    this.selectedSubunits,
    this.showAnswersAtEnd,
  });

  // copyWith method
  UserPref copyWith({
    CourseModel? course,
    // TopicTag? topicTag,
    int? numberOfQuestions,
    QuizFilter? quizFilter,
    List<UnitModel>? selectedUnits,
    List<UnitModel>? selectedSubunits,
    bool? showAnswersAtEnd,
  }) {
    return UserPref(
      course: course ?? this.course,
      // topicTag: topicTag ?? this.topicTag,
      numberOfQuestions: numberOfQuestions ?? this.numberOfQuestions,
      selectedUnits: selectedUnits ?? this.selectedUnits,
      selectedSubunits: selectedSubunits ?? this.selectedSubunits,
      showAnswersAtEnd: showAnswersAtEnd ?? this.showAnswersAtEnd,
    );
  }

  @override
  String toString() {
    return 'numberOfQuestions: $numberOfQuestions, selected units: $selectedUnits'
        'selected subunits $selectedSubunits show answers at end $showAnswersAtEnd';
  }
}
