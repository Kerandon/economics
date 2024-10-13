import 'package:economics_app/sections/quizzes/quiz_enums/question_type.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../../app/utils/mixins/course_mixin.dart';
import '../../../app/utils/mixins/unit_mixin.dart';
import '../../../app/utils/models/course.dart';
import '../quiz_enums/answer_stage.dart';
import 'answer_model.dart';

class QuestionModel extends Equatable {
  final QuestionType? type;
  final CourseMixin? course;
  final String? question;
  final Widget? item;
  final List<AnswerModel>? answers;
  final AnswerStage answerStage;
  final String? explanation;
  final UnitMixin? section;
  final UnitMixin? unit;
  final bool? hl;

  const QuestionModel({
    this.type,
    this.course,
    this.question,
    this.answers,
    this.item,
    this.answerStage = AnswerStage.notSelected,
    this.explanation,
    this.section,
    this.unit,
    this.hl,
  });

  // More flexible copyWith
  QuestionModel copyWith({
    QuestionType? type,
    Course? course,
    String? question,
    List<AnswerModel>? answers,
    AnswerStage? answerStage,
    UnitMixin? section,
    UnitMixin? unit,
    String? explanation,
    bool? hl,
  }) {
    return QuestionModel(
      type: type ?? this.type,
      course: course ?? this.course,
      question: question ?? this.question,
      answers: answers ?? this.answers,
      answerStage: answerStage ?? this.answerStage,
      explanation: explanation ?? this.explanation,
      section: section ?? this.section,
      unit: unit ?? this.unit,
      hl: hl ?? this.hl,
    );
  }

  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    List<AnswerModel> answers = (map['answers'] as List)
        .map((e) => AnswerModel.fromMap(e))
        .toList()
      ..shuffle();

    return QuestionModel(
      type: QuestionTypeExtension.fromText(map['type']),
      question: map['question'],
      answers: answers,
      answerStage: AnswerStage.notSelected,
      explanation: map['explanation'],
      hl: map['hl'] ?? false,
    );
  }

  // Converts QuestionModel to a map that can be sent to Firebase
  Map<String, dynamic> toMap() {
    return {
      'type': type?.name,
      'course': course?.name,
      'question': question,
      'answers': answers?.map((e) => e.toMap()).toList(),
      'answerStage': answerStage.name, // Enum
      'explanation': explanation,
      'section': section?.name,
      'unit': unit?.name,
      'hl': hl,
    };
  }

  QuestionModel shuffleAnswers() {
    List<AnswerModel> shuffledAnswers = List.from(answers ?? [])..shuffle();
    return copyWith(answers: shuffledAnswers);
  }

  @override
  List<Object?> get props => [question];
}
