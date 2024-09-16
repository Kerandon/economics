import 'package:equatable/equatable.dart';

import '../quiz_enums/answer_stage.dart';

class MultiAnswerModel extends Equatable {
  final String answer;
  final bool isCorrect;
  final AnswerStage answerStage;

  const MultiAnswerModel(
    this.answer, {
    this.isCorrect = false,
    this.answerStage = AnswerStage.notSelected,
  });

  factory MultiAnswerModel.fromMap(Map<String, dynamic> map) {
    return MultiAnswerModel(
      map.entries.first.key,
      isCorrect: map.entries.first.value,
      answerStage: AnswerStage.notSelected,
    );
  }

  MultiAnswerModel copyWith({
    String? answer,
    bool? isCorrect,
    AnswerStage? answerStage,
  }) {
    return MultiAnswerModel(
      answer ?? this.answer,
      isCorrect: isCorrect ?? this.isCorrect,
      answerStage: answerStage ?? this.answerStage,
    );
  }

  @override
  List<Object?> get props => [answer, isCorrect, answerStage];
}
