import '../quiz_enums/answer_stage.dart';
import '../quiz_sections/questions/quiz_models/question_model.dart';

List<QuestionModel> resetAnswerStage(List<QuestionModel> questions) {
  return questions.map((q) {
    return q.copyWith(
      answerStage: AnswerStage.notSelected,
      answers: q.answers
          ?.map((a) => a.copyWith(answerStage: AnswerStage.notSelected))
          .toList(),
    );
  }).toList();
}
