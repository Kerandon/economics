import 'package:economics_app/sections/quizzes/quiz_enums/answer_stage.dart';
import 'package:equatable/equatable.dart';
import '../../../../diagrams/models/diagram_model.dart';
import '../../../quiz_enums/question_key.dart';

class AnswerModel extends Equatable {
  final String answer;
  final bool isCorrect;
  final AnswerStage answerStage;
  final List<DiagramModel>? diagrams;

  const AnswerModel(
    this.answer, {
    this.isCorrect = false,
    this.answerStage = AnswerStage.notSelected,
    this.diagrams,
  });

  factory AnswerModel.fromMap(Map<String, dynamic> map) {
    return AnswerModel(
      map[QuestionKey.answer.name] as String? ?? '', // Ensure a non-null string
      isCorrect: map[QuestionKey.correct.name] as bool? ?? true,
      answerStage: AnswerStage.notSelected,
      diagrams: (map[QuestionKey.diagrams.name] != null &&
              map[QuestionKey.diagrams.name] is List)
          ? DiagramModel.fromFirebaseList(
              map[QuestionKey.diagrams.name] as List)
          : null,
    );
  }

  static List<AnswerModel>? fromFirebase(Map<String, dynamic>? map) {
    if (map == null || !map.containsKey(QuestionKey.answers.name)) {
      return null;
    }

    final answersList = map[QuestionKey.answers.name];

    if (answersList is List) {
      return answersList
          .whereType<
              Map<String, dynamic>>() // Ensure only valid maps are processed
          .map(AnswerModel.fromMap)
          .toList();
    }

    return null;
  }

  AnswerModel copyWith({
    String? answer,
    bool? isCorrect,
    AnswerStage? answerStage,
    List<DiagramModel>? diagrams,
  }) {
    return AnswerModel(
      answer ?? this.answer,
      isCorrect: isCorrect ?? this.isCorrect,
      answerStage: answerStage ?? this.answerStage,
      diagrams: diagrams ?? this.diagrams,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      QuestionKey.answer.name: answer,
      QuestionKey.correct.name: isCorrect,
      QuestionKey.answerStage.name: answerStage.name,
      if (diagrams != null)
        QuestionKey.diagrams.name: diagrams!.map((e) => e.toMap()),
    };
  }

  @override
  List<Object?> get props => [answer, isCorrect, answerStage, diagrams];
}
