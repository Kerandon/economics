import 'dart:math';

import '../quiz_sections/questions/quiz_models/question_model.dart';

List<QuestionModel> shuffleQuestionsAndAnswers(List<QuestionModel> questions) {
  final random = Random();

  // Shuffle the questions
  questions.shuffle(random);

  // Shuffle the answers for each question
  for (var q in questions) {
    q.answers?.shuffle(random);
  }

  return questions;
}
