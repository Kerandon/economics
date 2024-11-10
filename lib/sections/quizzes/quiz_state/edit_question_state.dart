import 'package:economics_app/app/configs/constants.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/question_type.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/questions/quiz_models/question_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../app/utils/mixins/course_mixin.dart';
import '../../../app/utils/mixins/unit_mixin.dart';
import '../../../app/utils/models/course.dart';
import '../../../app/utils/models/unit.dart';

class EditQuestionState {
  final QuestionType questionType;
  final List<CourseMixin> courses;
  final CourseMixin course;
  final UnitMixin unit;
  final UnitMixin subunit;
  final List<QuestionModel> allQuestions;
  final int numberOfQuestions;
  final bool checkAnswersAtEnd;

  EditQuestionState({
    required this.questionType,
    required this.courses,
    required this.course,
    required this.unit,
    required this.subunit,
    required this.allQuestions,
    required this.numberOfQuestions,
    required this.checkAnswersAtEnd,
  });

  EditQuestionState copyWith({
    QuestionType? questionType,
    List<CourseMixin>? courses,
    CourseMixin? course,
    UnitMixin? unit,
    UnitMixin? subunit,
    List<QuestionModel>? allQuestions,
    int? numberOfQuestions,
    bool? checkAnswersAtEnd,
  }) {
    return EditQuestionState(
      courses: courses ?? this.courses,
      allQuestions: allQuestions ?? this.allQuestions,
      course: course ?? this.course,
      questionType: questionType ?? this.questionType,
      unit: unit ?? this.unit,
      subunit: subunit ?? this.subunit,
      numberOfQuestions: numberOfQuestions ?? this.numberOfQuestions,
      checkAnswersAtEnd: checkAnswersAtEnd ?? this.checkAnswersAtEnd,
    );
  }
}

class EditQuestionNotifier extends StateNotifier<EditQuestionState> {
  EditQuestionNotifier(super._state);

  void setQuestionType(QuestionType type) {
    state = state.copyWith(questionType: type);
  }

  void setCourses(List<CourseMixin> courses) {
    state = state.copyWith(courses: courses);
  }

  void setCourse(CourseMixin course) {
    UnitMixin? u, s;
    if (course.units.isNotEmpty) {
      u = course.units.first;
    }
    if (course.units.first.subunits.isNotEmpty) {
      s = course.units.first.subunits.first;
    }

    state = state.copyWith(
      course: course,
      unit: u,
      subunit: s,
    );
  }

  void setUnit(UnitMixin unit) {
    state = state.copyWith(unit: unit);
  }

  void setSubunit(UnitMixin unit) {
    state = state.copyWith(subunit: unit);
  }

  void setAllQuestions(List<QuestionModel> allQuestions) {
    state = state.copyWith(allQuestions: allQuestions);
  }

  void setNumberOfQuestions(int number) {
    state = state.copyWith(numberOfQuestions: number);
  }

  void setCheckAnswersAtEnd(bool checkAtEnd) {
    state = state.copyWith(checkAnswersAtEnd: checkAtEnd);
  }
}

final editQuestionProvider =
    StateNotifierProvider<EditQuestionNotifier, EditQuestionState>(
  (ref) => EditQuestionNotifier(
    EditQuestionState(
      questionType: QuestionType.multi,
      courses: [],
      course: Course(name: "", units: []),
      unit: Unit(name: ''),
      subunit: Unit(name: ''),
      allQuestions: [],
      numberOfQuestions: kNumberOfQuestions.first,
      checkAnswersAtEnd: false,
    ),
  ),
);
