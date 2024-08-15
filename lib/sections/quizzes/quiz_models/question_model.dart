import 'package:equatable/equatable.dart';
import '../quiz_enums/answer_stage.dart';
import 'answer_model.dart';

class QuestionModel extends Equatable {
  final String question;
  final List<AnswerModel> answers;
  final AnswerStage answerStage;
  final String? explanation;  // Nullable
  final String? unit;         // Nullable string for unit
  final bool isHLOnly;        // Boolean flag for HL only

  const QuestionModel({
    required this.question,
    required this.answers,
    this.answerStage = AnswerStage.notSelected,  // Default value
    this.explanation,  // Nullable, default is null
    this.unit,         // Nullable, default is null
    this.isHLOnly = false,  // Default to false
  });

  QuestionModel copyWith({
    String? question,
    List<AnswerModel>? answers,
    AnswerStage? answerStage,
    String? explanation,
    String? unit,
    bool? isHLOnly,
  }) {
    return QuestionModel(
      question: question ?? this.question,
      answers: answers ?? this.answers,
      answerStage: answerStage ?? this.answerStage,
      explanation: explanation ?? this.explanation,
      unit: unit ?? this.unit,
      isHLOnly: isHLOnly ?? this.isHLOnly,  // Preserve existing value if not provided
    );
  }

  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    final a = map['answers'];
    List<AnswerModel> answers = [];
    for (var e in a) {
      answers.add(AnswerModel.fromMap(e));
    }

    return QuestionModel(
      question: map['question'],
      answers: answers,
      answerStage: AnswerStage.notSelected,  // Default value
      explanation: map['explanation'],  // Nullable field
      unit: map['unit'],  // Nullable field
      isHLOnly: map['isHLOnly'] ?? false,  // Default to false if not provided
    );
  }

  QuestionModel shuffleAnswers() {
    List<AnswerModel> shuffledAnswers = List.from(answers)..shuffle();
    return copyWith(answers: shuffledAnswers);
  }

  @override
  List<Object?> get props => [question, answers, answerStage, explanation, unit, isHLOnly];
}
