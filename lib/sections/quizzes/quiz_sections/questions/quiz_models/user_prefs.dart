import '../../../../../app/utils/models/course.dart';
import '../../../../../app/utils/models/unit.dart';
import '../../../quiz_enums/flip_card_tag.dart';

class UserPrefs {
  final Course course;
  final FlipCardTag? flipCardTag;
  final int? numberOfQuestions;
  final List<Unit>? selectedUnits;
  final List<Unit>? selectedSubunits;

  const UserPrefs({
    required this.course,
    this.flipCardTag,
    this.numberOfQuestions,
    this.selectedUnits,
    this.selectedSubunits,
  });

  // copyWith method
  UserPrefs copyWith({
    Course? course,
    FlipCardTag? flipCardTag,
    int? numberOfQuestions,
    List<Unit>? selectedUnits,
    List<Unit>? selectedSubunits,
  }) {
    return UserPrefs(
      course: course ?? this.course,
      flipCardTag: flipCardTag ?? this.flipCardTag,
      numberOfQuestions: numberOfQuestions ?? this.numberOfQuestions,
      selectedUnits: selectedUnits ?? this.selectedUnits,
      selectedSubunits: selectedSubunits ?? this.selectedSubunits,
    );
  }

  @override
  String toString() {
    return 'UserPrefs(course: $course, flipCardTag: $flipCardTag, '
        'numberOfQuestions: $numberOfQuestions, selected units: $selectedUnits'
        'selected subunits $selectedSubunits';
  }
}
