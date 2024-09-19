import 'package:economics_app/sections/diagrams/custom_paint/custom_paint_diagrams.dart';
import 'package:economics_app/sections/diagrams/custom_paint/diagrams/macro_business_cycle.dart';
import 'package:economics_app/sections/quizzes/quiz_models/answer_model.dart';
import 'package:economics_app/sections/quizzes/quiz_models/question_model.dart';
import 'package:economics_app/sections/quizzes/quiz_models/unit_model.dart';

import '../../../../app/enums/course.dart';

final questionsBank = [
  QuestionModel(
      course: Course.ib,
      unit: UnitModel(id: '4.1', unit: 'specific unit'),
      question: 'What fruit is yellow?',
      item: DiagramBox(customPainter: MacroBusinessCycle()),
      answers: const [
        AnswerModel(
          'Banana',
          isCorrect: true,
        ),
        AnswerModel(
          'Apple',
        ),
        AnswerModel(
          'Orange',
        ),
        AnswerModel(
          'Pear',
        ),
      ],
      explanation: 'because bananas are yellow'),
];
