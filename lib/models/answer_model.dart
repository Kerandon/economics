import '../utils/enums/answer_stage.dart';

class AnswerModel {
  final String answer;
  final bool isCorrect;
  final AnswerStage answerStage;

  AnswerModel(this.answer, this.isCorrect, this.answerStage);

  AnswerModel copyWith(
      {String? answer, bool? isCorrect, AnswerStage? answerStage}) {
    return AnswerModel(answer ?? this.answer, isCorrect ?? this.isCorrect, answerStage ?? this.answerStage);
  }
}
