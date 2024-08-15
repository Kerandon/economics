import 'package:economics_app/sections/quizzes/quiz_models/answer_model.dart';
import 'package:economics_app/sections/quizzes/quiz_models/question_model.dart';

final questionsBank = [
  const QuestionModel(
    unit: '4.1',
    question: 'What is the highest mountain in the world?',
    answers: [
      AnswerModel(
        'Mount Everest',
        isCorrect: true,
      ),
      AnswerModel(
        'Mount Cook',
      ),
      AnswerModel(
        'Mount Fuji',
      ),
      AnswerModel(
        'Mount Rushmore',
      ),
    ],
  ),
  const QuestionModel(
    unit: '4.1',
    question: 'What is the biggest animal in the World',
    answers: [
      AnswerModel('Elephant', isCorrect: true),
      AnswerModel(
        'Lion',
      ),
      AnswerModel(
        'Tiger',
      ),
      AnswerModel(
        'Hippo',
      ),
    ],
  ),
];
