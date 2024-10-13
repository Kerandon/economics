import 'package:economics_app/sections/quizzes/quiz_enums/question_type.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../app/utils/mixins/course_mixin.dart';
import '../../../app/utils/mixins/unit_mixin.dart';
import '../../../app/utils/models/course.dart';
import '../../../app/utils/models/unit.dart';
import '../quiz_models/answer_model.dart';

class AddQuestionState {
  final Course course;
  final QuestionType questionType;
  final String questionText;
  final List<AnswerModel> multiAnswers;
  final String explanation;
  final UnitMixin unit;
  final UnitMixin subunit;
  final Map<String, bool> fieldValidation;
  final bool allFieldsAreValidated;

  AddQuestionState({
    required this.course,
    required this.questionType,
    required this.questionText,
    required this.multiAnswers,
    required this.explanation,
    required this.unit,
    required this.subunit,
    required this.fieldValidation,
    required this.allFieldsAreValidated,
  });

  AddQuestionState copyWith({
    Course? course,
    QuestionType? questionType,
    String? questionText,
    List<AnswerModel>? multiAnswers,
    String? explanation,
    UnitMixin? unit,
    UnitMixin? subunit,
    bool? allFieldsAreValidated,
    Map<String, bool>? fieldValidation,
  }) {
    return AddQuestionState(
      course: course ?? this.course,
      questionType: questionType ?? this.questionType,
      questionText: questionText ?? this.questionText,
      multiAnswers: multiAnswers ?? this.multiAnswers,
      explanation: explanation ?? this.explanation,
      unit: unit ?? this.unit,
      subunit: subunit ?? this.subunit,
      fieldValidation: fieldValidation ?? this.fieldValidation,
      allFieldsAreValidated:
          allFieldsAreValidated ?? this.allFieldsAreValidated,
    );
  }
}

class AddQuestionNotifier extends StateNotifier<AddQuestionState> {
  AddQuestionNotifier(super._state);

  void setQuestionType(QuestionType type) {
    state = state.copyWith(questionType: type);
  }

  void setCourse(CourseMixin course) {
    state = state.copyWith(course: course as Course);
  }

  void setUnit(UnitMixin unit) {
    state = state.copyWith(unit: unit);
  }

  void setSubunit(UnitMixin unit) {
    state = state.copyWith(subunit: unit);
  }

  void addQuestionAndAnswer(MapEntry field) {
    Map<String, bool> fields = state.fieldValidation;
    fields.update(
      field.key,
      (oldValue) => field.value as bool,
      ifAbsent: () =>
          field.value as bool, // This adds the key if it doesn't exist
    );
    validateInput(
      field: MapEntry(field.key, field.value),
    );

    state = state.copyWith(fieldValidation: fields);
  }

  void removeLastAnswer() {
    Map<String, bool> fields = state.fieldValidation;

    if (fields.isNotEmpty) {
      String lastKey = fields.keys.last;
      fields.remove(lastKey);
    }
    validateInput(field: fields.entries.last);
    state = state.copyWith(fieldValidation: fields);
  }

  void validateInput({required MapEntry<String, bool> field}) {
    Map<String, bool> fields = state.fieldValidation;

    fields.update(field.key, (value) => field.value,
        ifAbsent: () => field.value);

    final allValidated = fields.values.every((value) => value == true);

    state = state.copyWith(
        fieldValidation: fields, allFieldsAreValidated: allValidated);
  }

  void resetState() {
    state = state.copyWith(
        questionType: state.questionType,
        questionText: '',
        multiAnswers: [],
        explanation: '');
  }
}

final addQuestionProvider =
    StateNotifierProvider<AddQuestionNotifier, AddQuestionState>(
  (ref) => AddQuestionNotifier(
    AddQuestionState(
      course: Course(name: "", units: []),
      questionType: QuestionType.multi,
      questionText: "",
      multiAnswers: [],
      explanation: "",
      unit: Unit(name: ''),
      subunit: Unit(name: ''),
      fieldValidation: {},
      allFieldsAreValidated: false,
    ),
  ),
);
