// import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';
// import '../quiz_enums/answer_stage.dart';
// import 'answer_model.dart';
//
// class QuestionModelMulti extends Equatable {
//   final String question;
//   final Widget? item;
//   final List<MultiAnswerModel> answers;
//   final AnswerStage answerStage;
//   final String? explanation; // Nullable
//   final String? unit; // Nullable string for unit
//   final bool isHLOnly; // Boolean flag for HL only
//
//   const QuestionModelMulti({
//     required this.question,
//     required this.answers,
//     this.item,
//     this.answerStage = AnswerStage.notSelected, // Default value
//     this.explanation, // Nullable, default is null
//     this.unit, // Nullable, default is null
//     this.isHLOnly = false, // Default to false
//   });
//
//   QuestionModelMulti copyWith({
//     String? question,
//     List<MultiAnswerModel>? answers,
//     AnswerStage? answerStage,
//     String? explanation,
//     String? unit,
//     bool? isHLOnly,
//   }) {
//     return QuestionModelMulti(
//       question: question ?? this.question,
//       answers: answers ?? this.answers,
//       answerStage: answerStage ?? this.answerStage,
//       explanation: explanation ?? this.explanation,
//       unit: unit ?? this.unit,
//       isHLOnly:
//           isHLOnly ?? this.isHLOnly, // Preserve existing value if not provided
//     );
//   }
//
//   factory QuestionModelMulti.fromMap(Map<String, dynamic> map) {
//     final a = map['answers'];
//     List<MultiAnswerModel> answers = [];
//     for (var e in a) {
//       answers.add(MultiAnswerModel.fromMap(e));
//     }
//
//     return QuestionModelMulti(
//       question: map['question'],
//       answers: answers,
//       answerStage: AnswerStage.notSelected, // Default value
//       explanation: map['explanation'], // Nullable field
//       unit: map['unit'], // Nullable field
//       isHLOnly: map['isHLOnly'] ?? false, // Default to false if not provided
//     );
//   }
//
//   QuestionModelMulti shuffleAnswers() {
//     List<MultiAnswerModel> shuffledAnswers = List.from(answers)..shuffle();
//     return copyWith(answers: shuffledAnswers);
//   }
//
//   @override
//   List<Object?> get props => [question];
// }

import 'package:economics_app/app/utils/mixins/section_mixin.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/question_type.dart';
import 'package:economics_app/sections/quizzes/quiz_models/unit_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../../app/enums/course.dart';
import '../quiz_enums/answer_stage.dart';
import 'answer_model.dart';
class QuestionModel extends Equatable {
  final QuestionType? type;
  final Course? course;
  final String? question;
  final Widget? item; // You can't store this in Firestore, so exclude it
  final List<AnswerModel>? answers;
  final AnswerStage answerStage;
  final String? explanation;
  final SectionMixin? section; // Needs special handling, depending on its structure
  final UnitModel? unit;
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
    SectionMixin? section,
    UnitModel? unit,
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
        .toList();

    return QuestionModel(
      type: map['type'],
      course: map['course'],
      question: map['question'],
      answers: answers,
      answerStage: AnswerStage.notSelected, // Default value
      explanation: map['explanation'],
      unit: UnitModel.fromMap(map['unit']),
      hl: map['hl'] ?? false,
    );
  }

  // Converts QuestionModel to a map that can be sent to Firebase
  Map<String, dynamic> toMap() {
    return {
      'type': type?.toString(), // Assuming QuestionType is an enum
      'course': course?.toString(), // Assuming Course is an enum
      'question': question,
      'answers': answers?.map((e) => e.toMap()).toList(),
      'answerStage': answerStage.toString(), // Enum
      'explanation': explanation,
      'section': section?.toString(), // Assuming section has a toString() method or needs special handling
      'unit': unit?.toMap(), // Assuming UnitModel has a toMap() method
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
