import 'package:economics_app/app/configs/constants.dart';
import 'package:economics_app/app/utils/models/unit.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/question_type.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../../../../app/utils/mixins/course_mixin.dart';
import '../../../../../app/utils/mixins/unit_mixin.dart';

import '../../../../../app/utils/models/course.dart';
import '../../../quiz_enums/answer_stage.dart';
import 'answer_model.dart';

class QuestionModel extends Equatable {
  final String? id;
  final QuizType? questionType;
  final CourseMixin? course;
  final String? question;
  final Widget? item;
  final List<AnswerModel>? answers;
  final AnswerStage answerStage;
  final String? explanation;
  final UnitMixin? unit;
  final UnitMixin? subunit;
  final bool? hl;

  const QuestionModel({
    this.id,
    this.questionType,
    this.course,
    this.question,
    this.answers,
    this.item,
    this.answerStage = AnswerStage.notSelected,
    this.explanation,
    this.unit,
    this.subunit,
    this.hl,
  });

  // More flexible copyWith
  QuestionModel copyWith({
    String? id,
    QuizType? questionType,
    CourseMixin? course,
    String? question,
    List<AnswerModel>? answers,
    AnswerStage? answerStage,
    UnitMixin? unit,
    UnitMixin? subunit,
    String? explanation,
    bool? hl,
  }) {
    return QuestionModel(
      id: id ?? this.id,
      questionType: questionType ?? this.questionType,
      course: course ?? this.course,
      question: question ?? this.question,
      answers: answers ?? this.answers,
      answerStage: answerStage ?? this.answerStage,
      explanation: explanation ?? this.explanation,
      unit: unit ?? this.unit,
      subunit: subunit ?? this.subunit,
      hl: hl ?? this.hl,
    );
  }

  factory QuestionModel.fromMap(String id, Map<String, dynamic> map) {
    List<AnswerModel> answers =
        (map[kAnswers] as List).map((e) => AnswerModel.fromMap(e)).toList();

    return QuestionModel(
      id: id,
      questionType: QuestionTypeExtension.fromText(map[kType]),
      course: Course(name: map[kCourse], units: []),
      unit: Unit.fromFirebase(map),
      subunit: Unit.fromFirebase(map, subunit: true),
      question: map[kQuestion],
      answers: answers,
      answerStage: AnswerStage.notSelected,
      explanation: map[kExplanation],
      hl: map[kHL] ?? false,
    );
  }

  // Converts QuestionModel to a map that can be sent to Firebase
  Map<String, dynamic> toMap() {
    return {
      kType: questionType?.name,
      kCourse: course?.name,
      kQuestion: question,
      kAnswers: answers?.map((e) => e.toMap()).toList(),
      kAnswerStage: answerStage.name, // Enum
      kExplanation: explanation,
      kUnit: {unit?.index ?? "": unit?.name ?? ""},
      kSubunit: {subunit?.index ?? "": subunit?.name ?? ""},
      kHL: hl,
    };
  }

  QuestionModel shuffleAnswers() {
    List<AnswerModel> shuffledAnswers = List.from(answers ?? [])..shuffle();
    return copyWith(answers: shuffledAnswers);
  }

  @override
  List<Object?> get props => [question];
}
