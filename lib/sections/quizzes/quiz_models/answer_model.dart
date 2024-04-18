import '../quiz_enums/answer_stage.dart';

class AnswerModel {
  final String answer;
  final bool isCorrect;
  final AnswerStage answerStage;

  AnswerModel(this.answer, this.isCorrect, this.answerStage);

  factory AnswerModel.fromMap(Map<String, dynamic> map) {
    return AnswerModel(map.entries.first.key, map.entries.first.value,
        AnswerStage.notSelected);

  }


  AnswerModel copyWith(
      {String? answer, bool? isCorrect, AnswerStage? answerStage}) {
    return AnswerModel(answer ?? this.answer, isCorrect ?? this.isCorrect,
        answerStage ?? this.answerStage);
  }
}
