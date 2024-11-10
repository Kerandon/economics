import 'package:economics_app/sections/quizzes/quiz_sections/questions/quiz_models/question_model.dart';
import 'package:economics_app/sections/quizzes/quiz_state/quiz_state.dart';
import 'package:flutter/material.dart';

import '../quiz_sections/questions/question_page.dart';

void startQuiz({
  required BuildContext context,
  required QuizNotifier quizNotifier,
  required List<QuestionModel> filteredQuestions,
}) {
  quizNotifier.setSelectedQuestions(filteredQuestions);

  WidgetsBinding.instance.addPostFrameCallback((t) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const QuestionPage(),
      ),
    );
  });
}
