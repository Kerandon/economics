import 'package:economics_app/app/configs/constants.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/question_type.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/quiz_filter.dart';
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
  final QuizFilter quizFilter;
  final List<QuestionModel> filteredQuestions;
  final UnitMixin unit;
  final UnitMixin subunit;
  final List<QuestionModel> allQuestions;
  final int numberOfQuestions;
  final bool checkAnswersAtEnd;

  EditQuestionState({
    required this.questionType,
    required this.courses,
    required this.course,
    required this.quizFilter,
    required this.unit,
    required this.subunit,
    required this.allQuestions,
    required this.filteredQuestions,
    required this.numberOfQuestions,
    required this.checkAnswersAtEnd,
  });

  EditQuestionState copyWith({
    QuestionType? questionType,
    List<CourseMixin>? courses,
    CourseMixin? course,
    QuizFilter? quizFilter,
    List<QuestionModel>? filteredQuestions,
    UnitMixin? unit,
    UnitMixin? subunit,
    List<QuestionModel>? allQuestions,
    int? numberOfQuestions,
    bool? checkAnswersAtEnd,
  }) {
    return EditQuestionState(
      courses: courses ?? this.courses,
      allQuestions: allQuestions ?? this.allQuestions,
      quizFilter: quizFilter ?? this.quizFilter,
      filteredQuestions: filteredQuestions ?? this.filteredQuestions,
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
    setFilteredQuestions();
  }

  void setCourses(List<CourseMixin> courses) {
    state = state.copyWith(courses: courses);
    setFilteredQuestions();
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
    setFilteredQuestions();
  }

  void setUnit(UnitMixin unit) {
    state = state.copyWith(unit: unit);

    setFilteredQuestions();
  }

  void setSubunit(UnitMixin unit) {
    state = state.copyWith(subunit: unit);
    setFilteredQuestions();
  }

  void setAllQuestions(List<QuestionModel> allQuestions) {
    state = state.copyWith(allQuestions: allQuestions);
    setFilteredQuestions();
  }

  void setQuizFilter(QuizFilter filter){
    state = state.copyWith(quizFilter: filter);
  }

  void setFilteredQuestions() {
    List<QuestionModel> filteredQuestions = state.allQuestions.toList();

    for (var q in state.allQuestions) {
      if (q.course != state.course) {
        filteredQuestions.remove(q);
      }
      if (q.unit != state.unit) {
        filteredQuestions.remove(q);
      }
      if (q.subunit != state.subunit) {
        filteredQuestions.remove(q);
      }
    }

    state = state.copyWith(filteredQuestions: filteredQuestions.toList());
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
      quizFilter: QuizFilter.all,
      courses: [],
      course: Course(name: "", units: []),
      unit: Unit(name: ''),
      subunit: Unit(name: ''),
      allQuestions: [],
      filteredQuestions: [],
      numberOfQuestions: kNumberOfQuestions.first,
      checkAnswersAtEnd: false,
    ),
  ),
);
