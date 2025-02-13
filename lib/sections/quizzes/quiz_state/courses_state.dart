// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import '../../../app/utils/mixins/course_mixin.dart';
// import '../../../app/utils/models/course_model.dart';
//
// class CoursesState {
//   final CourseModel course;
//   final List<CourseModel> courses;
//   final bool createCourseIsSelected;
//
//   CoursesState({
//     required this.course,
//     required this.courses,
//     required this.createCourseIsSelected,
//   });
//
//   CoursesState copyWith({
//     CourseModel? course,
//     List<CourseModel>? courses,
//     bool? createCourseIsSelected,
//   }) {
//     return CoursesState(
//       course: course ?? this.course,
//       courses: courses ?? this.courses,
//       createCourseIsSelected:
//           createCourseIsSelected ?? this.createCourseIsSelected,
//     );
//   }
// }
//
// class CoursesNotifier extends StateNotifier<CoursesState> {
//   CoursesNotifier(super._state);
//
//   void setCourseSelected(CourseMixin course) {
//     state = state.copyWith(
//         course: course, createCourseIsSelected: course.name == "");
//   }
//
//   void setAllCourses(List<CourseMixin> courses) {
//     state = state.copyWith(courses: courses);
//   }
// }
//
// final coursesProvider = StateNotifierProvider<CoursesNotifier, CoursesState>(
//   (ref) => CoursesNotifier(
//     CoursesState(
//       course: CourseModel(name: '', units: []),
//       courses: [],
//       createCourseIsSelected: true,
//     ),
//   ),
// );
