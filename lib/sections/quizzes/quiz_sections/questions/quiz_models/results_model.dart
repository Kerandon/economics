import 'package:economics_app/sections/quizzes/quiz_sections/questions/quiz_models/question_model.dart';

import '../../../quiz_enums/answer_stage.dart';

class ResultsModel {
  final List<QuestionModel> _questions;

  ResultsModel._(this._questions);

  // Factory constructor to create ResultsModel from a list of questions
  factory ResultsModel.fromQuestions(List<QuestionModel> questions) {
    return ResultsModel._(questions);
  }

  // Read-only getters
  int get totalAnswered => _questions
      .where((q) =>
          q.answerStage == AnswerStage.correct ||
          q.answerStage == AnswerStage.incorrect)
      .length;

  int get totalAnsweredCorrect =>
      _questions.where((q) => q.answerStage == AnswerStage.correct).length;

  String get percentCorrect => totalAnswered == 0
      ? "0.00%"
      : "${((totalAnsweredCorrect / totalAnswered) * 100).toStringAsFixed(2)}%";

  String get resultEmoji {
    if (percentCorrect == "100.00%") {
      return '🎯'; // Bullseye emoji for 100%
    } else if (double.parse(percentCorrect.replaceAll('%', '')) >= 90.0) {
      return '😊'; // Smiling face emoji for 90% or above
    } else if (double.parse(percentCorrect.replaceAll('%', '')) >= 70.0) {
      return '😐'; // Neutral face emoji for 70% or above
    } else if (double.parse(percentCorrect.replaceAll('%', '')) >= 50.0) {
      return '😕'; // Confused face emoji for 50% or above
    } else {
      return '😢'; // Crying face emoji for below 50%
    }
  }

  // New getter to check if all questions are correct
  bool get allQuestionsAreCorrect =>
      _questions.every((q) => q.answerStage == AnswerStage.correct);

  ResultsModel copyWith({List<QuestionModel>? questions}) {
    return ResultsModel._(questions ?? _questions);
  }
}
