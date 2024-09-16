import 'package:economics_app/sections/diagrams/custom_paint/custom_paint_diagrams.dart';
import 'package:economics_app/sections/diagrams/custom_paint/diagrams/macro_business_cycle.dart';
import 'package:economics_app/sections/quizzes/quiz_models/answer_model.dart';
import 'package:economics_app/sections/quizzes/quiz_models/question_model.dart';

final questionsBank = [
  QuestionModelMulti(
      unit: '4.1',
      question: 'What fruit is yellow?',
      item: DiagramBox(customPainter: MacroBusinessCycle()),
      answers: const [
        MultiAnswerModel(
          'Banana',
          isCorrect: true,
        ),
        MultiAnswerModel(
          'Apple',
        ),
        MultiAnswerModel(
          'Orange',
        ),
        MultiAnswerModel(
          'Pear',
        ),
      ],
      explanation: 'because bananas are yellow'),
  // const QuestionModel(
  //   unit: '4.1',
  //   question: 'What is the highest mountain in the world?',
  //   answers: [
  //     AnswerModel(
  //       'Mount Everest',
  //       isCorrect: true,
  //     ),
  //     AnswerModel(
  //       'Mount Cook',
  //     ),
  //     AnswerModel(
  //       'Mount Fuji',
  //     ),
  //     AnswerModel(
  //       'Mount Rushmore',
  //     ),
  //   ],
  // ),
  // const QuestionModel(
  //   unit: '4.1',
  //   question: 'What is the biggest animal in the World',
  //   answers: [
  //     AnswerModel('Elephant', isCorrect: true),
  //     AnswerModel(
  //       'Lion',
  //     ),
  //     AnswerModel(
  //       'Tiger',
  //     ),
  //     AnswerModel(
  //       'Hippo',
  //     ),
  //   ],
  // ),
];
