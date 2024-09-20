import 'package:economics_app/sections/quizzes/quiz_enums/question_type.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../app/enums/course.dart';
import '../../../app/enums/ib_section.dart';
import '../../../app/utils/mixins/section_mixin.dart';
import '../../../app/enums/ig_units.dart';
import '../../../app/utils/mixins/unit_mixin.dart';
import '../quiz_models/answer_model.dart';

class AddQuestionState {
  final Course course;
  final QuestionType questionType;
  final String newQuestionText;
  final List<AnswerModel> newMultiAnswers;
  final String explanation;
  final List<DropdownMenuItem> sections;
  final SectionMixin section;
  final List<DropdownMenuItem> units;
  final UnitMixin unit;
  final Map<String, bool> fieldValidation;
  final bool allFieldsAreValidated;

  AddQuestionState({
    required this.course,
    required this.questionType,
    required this.newQuestionText,
    required this.newMultiAnswers,
    required this.explanation,
    required this.sections,
    required this.section,
    required this.units,
    required this.unit,
    required this.fieldValidation,
    required this.allFieldsAreValidated,
  });

  AddQuestionState copyWith({
    Course? course,
    QuestionType? questionType,
    String? newQuestionText,
    List<AnswerModel>? newMultiAnswers,
    String? explanation,
    List<DropdownMenuItem>? sections,
    SectionMixin? section,
    List<DropdownMenuItem>? units,
    UnitMixin? unit,
    bool? allFieldsAreValidated,
    Map<String, bool>? fieldValidation,
  }) {
    return AddQuestionState(
      course: course ?? this.course,
      questionType: questionType ?? this.questionType,
      newQuestionText: newQuestionText ?? this.newQuestionText,
      newMultiAnswers: newMultiAnswers ?? this.newMultiAnswers,
      explanation: explanation ?? this.explanation,
      sections: sections ?? this.sections,
      section: section ?? this.section,
      units: units ?? this.units,
      unit: unit ?? this.unit,
      fieldValidation: fieldValidation ?? this.fieldValidation,
      allFieldsAreValidated: allFieldsAreValidated ?? this.allFieldsAreValidated,
    );
  }
}

class AddQuestionNotifier extends StateNotifier<AddQuestionState> {
  AddQuestionNotifier(super._state);

  void setQuestionType(QuestionType type) {
    state = state.copyWith(questionType: type);
  }

  void setCourse(Course course) {
    if (course == Course.ib) {
      changeToNewSections(sectionValues: IBSection.values);
    } else if (course == Course.igcse) {
      changeToNewSections(sectionValues: IGSection.values);
    }

    state = state.copyWith(course: course);
  }

  void changeToNewSections({required List<SectionMixin> sectionValues}) {
    List<SectionMixin> selectedSection = sectionValues;
    List<DropdownMenuItem> sections = [];

    for (var s in selectedSection) {
      sections.add(
        DropdownMenuItem(
          value: s,
          child: Text(
            s.name,
          ),
        ),
      );
    }

    List<DropdownMenuItem> units = [];

    for (var u in selectedSection.first.units) {
      units.add(
        DropdownMenuItem(
          value: u,
          child: Text(u.unit),
        ),
      );
    }

    state = state.copyWith(
      sections: sections,
      section: selectedSection.first,
      units: units,
      unit: selectedSection.first.units.first,
    );
  }

  void setSections(List<DropdownMenuItem> sections) {
    state = state.copyWith(sections: sections.toList());
  }

  void setSection(SectionMixin section) {
    state = state.copyWith(section: section);
  }

  void setUnits(List<DropdownMenuItem> units) {
    state = state.copyWith(units: units.toList());
  }

  void setUnit(UnitMixin unit) {
    state = state.copyWith(unit: unit);
  }


  void updateValidation(MapEntry entry) {
    Map<String, bool> fields = state.fieldValidation;
    fields.update(
      entry.key,
          (oldValue) => entry.value as bool,
      ifAbsent: () => entry.value as bool, // This adds the key if it doesn't exist
    );

    final allValidated = fields.entries.every((e) => e.value == true);
    state = state.copyWith(fieldValidation: fields, allFieldsAreValidated: allValidated);
  }


}

final addQuestionProvider =
    StateNotifierProvider<AddQuestionNotifier, AddQuestionState>(
  (ref) => AddQuestionNotifier(
    AddQuestionState(
      course: Course.ib,
      questionType: QuestionType.multi,
      newQuestionText: "",
      newMultiAnswers: [],
      explanation: "",
      sections: [],
      section: IBSection.intro,
      units: [],
      unit: IBSection.intro.units.first,
      fieldValidation: {},
      allFieldsAreValidated: false,
    ),
  ),
);
