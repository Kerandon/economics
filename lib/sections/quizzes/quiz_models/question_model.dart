import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../quiz_enums/answer_stage.dart';
import 'answer_model.dart';

class QuestionModelMulti extends Equatable {
  final String question;
  final Widget? item;
  final List<MultiAnswerModel> answers;
  final AnswerStage answerStage;
  final String? explanation; // Nullable
  final String? unit; // Nullable string for unit
  final bool isHLOnly; // Boolean flag for HL only

  const QuestionModelMulti({
    required this.question,
    required this.answers,
    this.item,
    this.answerStage = AnswerStage.notSelected, // Default value
    this.explanation, // Nullable, default is null
    this.unit, // Nullable, default is null
    this.isHLOnly = false, // Default to false
  });

  QuestionModelMulti copyWith({
    String? question,
    List<MultiAnswerModel>? answers,
    AnswerStage? answerStage,
    String? explanation,
    String? unit,
    bool? isHLOnly,
  }) {
    return QuestionModelMulti(
      question: question ?? this.question,
      answers: answers ?? this.answers,
      answerStage: answerStage ?? this.answerStage,
      explanation: explanation ?? this.explanation,
      unit: unit ?? this.unit,
      isHLOnly:
          isHLOnly ?? this.isHLOnly, // Preserve existing value if not provided
    );
  }

  factory QuestionModelMulti.fromMap(Map<String, dynamic> map) {
    final a = map['answers'];
    List<MultiAnswerModel> answers = [];
    for (var e in a) {
      answers.add(MultiAnswerModel.fromMap(e));
    }

    return QuestionModelMulti(
      question: map['question'],
      answers: answers,
      answerStage: AnswerStage.notSelected, // Default value
      explanation: map['explanation'], // Nullable field
      unit: map['unit'], // Nullable field
      isHLOnly: map['isHLOnly'] ?? false, // Default to false if not provided
    );
  }

  QuestionModelMulti shuffleAnswers() {
    List<MultiAnswerModel> shuffledAnswers = List.from(answers)..shuffle();
    return copyWith(answers: shuffledAnswers);
  }

  @override
  List<Object?> get props => [question];
}
