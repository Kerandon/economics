import 'package:economics_app/sections/quizzes/quiz_enums/answer_stage.dart';
import 'package:equatable/equatable.dart';

import '../../../../../app/configs/constants.dart';

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
      map[kAnswer],
      isCorrect: map[kIsCorrect] ?? true,
      answerStage: AnswerStage.notSelected,
    );
  }

  static List<AnswerModel> fromMapList(List<dynamic> list) {
    return list
        .map((e) => AnswerModel.fromMap(e as Map<String, dynamic>))
        .toList();
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

  Map<String, dynamic> toMap() {
    return {
      kAnswer: answer,
      kIsCorrect: isCorrect,
      kAnswerStage: answerStage.name, // Assuming it's an enum
    };
  }

  @override
  List<Object?> get props => [answer, isCorrect, answerStage];
}
