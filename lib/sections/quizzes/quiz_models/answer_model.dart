import 'package:equatable/equatable.dart';

import '../quiz_enums/answer_stage.dart';
class AnswerModel extends Equatable {
  final String answer;
  final bool isCorrect;
  final AnswerStage answerStage;

  const AnswerModel(
      this.answer, {
        this.isCorrect = false,
        this.answerStage = AnswerStage.notSelected,
      });

  factory AnswerModel.fromMap(Map<String, dynamic> map) {
    return AnswerModel(
      map.entries.first.key,
      isCorrect: map.entries.first.value,
      answerStage: AnswerStage.notSelected,
    );
  }

  AnswerModel copyWith({
    String? answer,
    bool? isCorrect,
    AnswerStage? answerStage,
  }) {
    return AnswerModel(
      answer ?? this.answer,
      isCorrect: isCorrect ?? this.isCorrect,
      answerStage: answerStage ?? this.answerStage,
    );
  }

  // Add the toMap method to serialize AnswerModel
  Map<String, dynamic> toMap() {
    return {
      'answer': answer,
      'isCorrect': isCorrect,
      'answerStage': answerStage.toString(), // Assuming it's an enum
    };
  }

  @override
  List<Object?> get props => [answer, isCorrect, answerStage];
}
