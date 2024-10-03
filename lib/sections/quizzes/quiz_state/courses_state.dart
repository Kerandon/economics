import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../app/utils/mixins/course_mixin.dart';
import '../../../app/utils/models/course.dart';

class CoursesState {
  final CourseMixin course;
  final List<String> courses;

  CoursesState({
    required this.course,
    required this.courses,
  });

  CoursesState copyWith({
    CourseMixin? course,
    List<String>? courses,
  }) {
    return CoursesState(
      course: course ?? this.course,
      courses: courses ?? this.courses,
    );
  }
}

class CoursesNotifier extends StateNotifier<CoursesState> {
  CoursesNotifier(super._state);

  void setCourseSelected(CourseMixin course) {
    state = state.copyWith(course: course);
  }

  void setAllCourses(List<String> courses) {
    state = state.copyWith(courses: courses);
  }
}

final coursesProvider = StateNotifierProvider<CoursesNotifier, CoursesState>(
  (ref) => CoursesNotifier(
    CoursesState(
      course: Course(name: '', units: []),
      courses: [],
    ),
  ),
);
