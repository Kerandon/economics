import 'package:economics_app/sections/quizzes/quiz_enums/answer_stage.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/questions/quiz_models/question_model.dart';
import 'package:economics_app/sections/quizzes/quiz_state/quiz_state.dart';
import 'package:flutter/material.dart';
import '../quiz_sections/questions/question_page.dart';

void startQuiz({
  required BuildContext context,
  required List<QuestionModel> filteredQuestions,
  required int limit,
  required QuizNotifier quizNotifier,
}) {
  final selectedQuestions = filteredQuestions..shuffle();

  final limitedQuestions = selectedQuestions.take(limit).toList();
  for (var q in limitedQuestions) {
    q.answers?.shuffle();
    for (var i = 0; i < q.answers!.length; i++) {
      q.answers![i] =
          q.answers![i].copyWith(answerStage: AnswerStage.notSelected);
    }
  }

  quizNotifier.setSelectedQuestions(limitedQuestions.toList());

  WidgetsBinding.instance.addPostFrameCallback((t) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const QuestionPage(),
      ),
    );
  });
}
