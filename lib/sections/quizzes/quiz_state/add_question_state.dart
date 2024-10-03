import 'package:economics_app/sections/quizzes/quiz_enums/question_type.dart';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../app/enums/course.dart';
import '../../../app/enums/ib_section.dart';
import '../../../app/utils/mixins/unit_mixin.dart';
import '../quiz_models/answer_model.dart';

class AddQuestionState {
  final SelectedCourse course;
  final QuestionType questionType;
  final String questionText;
  final List<AnswerModel> multiAnswers;
  final String explanation;
  final List<DropdownMenuItem> sections;
  final UnitMixin section;
  final List<DropdownMenuItem> units;
  final UnitMixin unit;
  final Map<String, bool> fieldValidation;
  final bool allFieldsAreValidated;

  AddQuestionState({
    required this.course,
    required this.questionType,
    required this.questionText,
    required this.multiAnswers,
    required this.explanation,
    required this.sections,
    required this.section,
    required this.units,
    required this.unit,
    required this.fieldValidation,
    required this.allFieldsAreValidated,
  });

  AddQuestionState copyWith({
    SelectedCourse? course,
    QuestionType? questionType,
    String? questionText,
    List<AnswerModel>? multiAnswers,
    String? explanation,
    List<DropdownMenuItem>? sections,
    UnitMixin? section,
    List<DropdownMenuItem>? units,
    UnitMixin? unit,
    bool? allFieldsAreValidated,
    Map<String, bool>? fieldValidation,
  }) {
    return AddQuestionState(
      course: course ?? this.course,
      questionType: questionType ?? this.questionType,
      questionText: questionText ?? this.questionText,
      multiAnswers: multiAnswers ?? this.multiAnswers,
      explanation: explanation ?? this.explanation,
      sections: sections ?? this.sections,
      section: section ?? this.section,
      units: units ?? this.units,
      unit: unit ?? this.unit,
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

  void setCourseOnFirstInit() {
    state = state.copyWith(course: SelectedCourse.ib);
    // changeToNewSections(sectionValues: IBSection.values.toList());
  }

  void setUnit(UnitMixin section) {
    state = state.copyWith(section: section);
  }

  void setSubunit(UnitMixin unit) {
    state = state.copyWith(unit: unit);
  }

  // void changeToNewSections({required List<UnitMixin> sectionValues}) {
  //   List<UnitMixin> selectedSection = sectionValues.skip(1).toList();
  //   List<DropdownMenuItem> sections = [];
  //
  //   for (var s in selectedSection) {
  //     sections.add(addDropdownMenuItem(s));
  //   }
  //
  //   List<DropdownMenuItem> units =
  //       createSubUnitsDropdown(selectedSection.first);
  //   state = state.copyWith(
  //     sections: sections,
  //     section: selectedSection.first,
  //     units: units.skip(1).toList(),
  //     unit: selectedSection.first.subunits
  //         .skip(1)
  //         .first, // Skip the first subunit
  //   );
  // }

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
      course: SelectedCourse.ib,
      questionType: QuestionType.multi,
      questionText: "",
      multiAnswers: [],
      explanation: "",
      sections: [],
      section: IBSection.intro,
      units: [],
      unit: IBSection.intro.subunits.elementAt(1),
      fieldValidation: {},
      allFieldsAreValidated: false,
    ),
  ),
);
