import 'package:economics_app/app/configs/constants.dart';

import 'package:economics_app/sections/diagrams/enums/diagrams_number.dart';
import 'package:economics_app/sections/diagrams/models/diagram_model.dart';

import 'package:economics_app/sections/quizzes/quiz_enums/question_type.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/quiz_filter.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/questions/quiz_models/question_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../app/utils/mixins/course_mixin.dart';
import '../../../app/utils/mixins/unit_mixin.dart';
import '../../../app/utils/models/course.dart';
import '../../../app/utils/models/unit.dart';
import '../quiz_enums/custom_tag.dart';
import '../quiz_enums/flip_card_tag.dart';

class EditQuestionState {
  final QuestionType questionType;
  final List<CourseMixin> courses;
  final CourseMixin course;
  final QuizFilter quizFilter;
  final List<QuestionModel> filteredQuestions;
  final UnitMixin unit;
  final UnitMixin subunit;
  final List<QuestionModel> allQuestions;
  final int maxNumberOfQuestions;
  final bool checkAnswersAtEnd;
  final FlipCardTag flipCardTag;
  List<FlipCardTag> selectedFlipCardTags;
  final bool isHL;
  final DiagramsNumber diagramsNumber;
  final List<DiagramModel> selectedDiagrams;
  final List<CustomTag> customTags;

  EditQuestionState({
    required this.questionType,
    required this.courses,
    required this.course,
    required this.quizFilter,
    required this.unit,
    required this.subunit,
    required this.allQuestions,
    required this.filteredQuestions,
    required this.maxNumberOfQuestions,
    required this.checkAnswersAtEnd,
    required this.flipCardTag,
    required this.selectedFlipCardTags,
    required this.isHL,
    required this.diagramsNumber,
    required this.selectedDiagrams,
    required this.customTags,
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
    int? maxNumberOfQuestions,
    bool? checkAnswersAtEnd,
    FlipCardTag? flipCardTag,
    List<FlipCardTag>? selectedFlipCardTags,
    bool? isHL,
    DiagramsNumber? diagramsNumber,
    List<DiagramModel>? selectedDiagrams,
    List<CustomTag>? customTags,
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
      maxNumberOfQuestions: maxNumberOfQuestions ?? this.maxNumberOfQuestions,
      checkAnswersAtEnd: checkAnswersAtEnd ?? this.checkAnswersAtEnd,
      flipCardTag: flipCardTag ?? this.flipCardTag,
      selectedFlipCardTags: selectedFlipCardTags ?? this.selectedFlipCardTags,
      isHL: isHL ?? this.isHL,
      diagramsNumber: diagramsNumber ?? this.diagramsNumber,
      selectedDiagrams: selectedDiagrams ?? this.selectedDiagrams,
      customTags: customTags ?? this.customTags,
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

  void setQuizFilter(QuizFilter filter) {
    state = state.copyWith(quizFilter: filter);
    setFilteredQuestions();
  }

  void setFilteredQuestions() {
    List<QuestionModel> filteredQuestions = state.allQuestions.toList();

    for (var q in state.allQuestions) {
      if (q.questionType != state.questionType) {
        filteredQuestions.remove(q);
      }

      if (q.course != state.course) {
        filteredQuestions.remove(q);
      }
      if (state.quizFilter == QuizFilter.unit) {
        if (q.unit != state.unit) {
          filteredQuestions.remove(q);
        }
      }
      if (state.quizFilter == QuizFilter.subunit) {
        if (q.subunit != state.subunit) {
          filteredQuestions.remove(q);
        }
      }
      if (state.questionType == QuestionType.flip) {
        if (!state.selectedFlipCardTags.contains(q.flipCardTag)) {
          filteredQuestions.remove(q);
        }
      }
    }

    filteredQuestions.sort((a, b) => a.question!.compareTo(b.question!));

    state = state.copyWith(filteredQuestions: filteredQuestions.toList());
  }

  void setNumberOfQuestions(int number) {
    state = state.copyWith(maxNumberOfQuestions: number);
  }

  void setCheckAnswersAtEnd(bool checkAtEnd) {
    state = state.copyWith(checkAnswersAtEnd: checkAtEnd);
  }

  void setFlipCardTag(FlipCardTag tag) {
    state = state.copyWith(flipCardTag: tag);
  }

  void setSelectedFlipCardTags(FlipCardTag tag) {
    final updatedTags = List<FlipCardTag>.from(state.selectedFlipCardTags);

    if (updatedTags.contains(tag)) {
      updatedTags.remove(tag);
    } else {
      updatedTags.add(tag);
    }

    state = state.copyWith(selectedFlipCardTags: updatedTags);
  }

  void setHL(bool hl) {
    state = state.copyWith(isHL: hl);
  }

  void setDiagramsNumber(BuildContext context, Size size,
      {required DiagramsNumber diagramsNumber}) {
    state = state.copyWith(diagramsNumber: diagramsNumber);
    final diagramsNum = diagramsNumber.toInt;
    final currentLengthList = state.selectedDiagrams.length;

    if (diagramsNum > currentLengthList) {
      final difference = diagramsNum - currentLengthList;

      final allDiagrams = DiagramModel.getDiagrams(size, context);

      final newEntries = List.generate(
        difference,
        (index) => allDiagrams.first,
      );
      state.selectedDiagrams.addAll(newEntries);
    }
    if (diagramsNum < currentLengthList) {
      state.selectedDiagrams.removeRange(diagramsNum, currentLengthList);
    }
  }

  void setDiagramsSelected(DiagramModel diagram, int index) {
    final currentList = state.selectedDiagrams.toList();
    if (index < currentList.length) {
      currentList[index] = diagram;
    }

    state = state.copyWith(selectedDiagrams: currentList);
  }

  void setCustomTags(CustomTag tag) {
    final currentList = state.customTags.toList();
    if (currentList.contains(tag)) {
      currentList.remove(tag);
    } else {
      currentList.add(tag);
    }
    state = state.copyWith(customTags: currentList);
  }
}

final editQuestionProvider =
    StateNotifierProvider<EditQuestionNotifier, EditQuestionState>(
  (ref) => EditQuestionNotifier(
    EditQuestionState(
        questionType: QuestionType.flip,
        quizFilter: QuizFilter.all,
        courses: [],
        course: Course(name: "", units: []),
        unit: Unit(name: ''),
        subunit: Unit(name: ''),
        allQuestions: [],
        filteredQuestions: [],
        maxNumberOfQuestions: kNumberOfQuestions.first,
        checkAnswersAtEnd: false,
        flipCardTag: FlipCardTag.general,
        selectedFlipCardTags: FlipCardTag.values,
        isHL: false,
        diagramsNumber: DiagramsNumber.zero,
        selectedDiagrams: [],
        customTags: []),
  ),
);
