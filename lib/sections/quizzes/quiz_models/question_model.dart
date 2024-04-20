import 'package:equatable/equatable.dart';
import '../quiz_enums/answer_stage.dart';
import 'answer_model.dart';

class QuestionModel extends Equatable {
  final String question;
  final List<AnswerModel> answers;
  final AnswerStage answerStage;
  final String explanation;
  final List<String>? tags;

  const QuestionModel({
    required this.question,
    required this.answers,
    required this.answerStage,
    required this.explanation,
    this.tags,
  });

  QuestionModel copyWith({
    String? question,
    List<AnswerModel>? answers,
    AnswerStage? answerStage,
    String? explanation,
    List<String>? tags,
  }) {
    return QuestionModel(
      question: question ?? this.question,
      answers: answers ?? this.answers,
      explanation: explanation ?? this.explanation,
      answerStage: answerStage ?? this.answerStage,
      tags: tags,
    );
  }

  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    final a = map['answers'];
    List<AnswerModel> answers = [];
    for (var e in a) {
      answers.add(AnswerModel.fromMap(e));
    }

    final t = map['tags'];
    List<String>? tags;
    if (t != null) {
      tags = List<String>.from(t);
    }

    return QuestionModel(
      question: map['question'],
      answers: answers,
      answerStage: AnswerStage.notSelected,
      explanation: map['explanation'] ?? "",
      tags: tags,
    );
  }

  QuestionModel shuffleAnswers() {
    List<AnswerModel> shuffledAnswers = List.from(answers)..shuffle();
    return copyWith(answers: shuffledAnswers);
  }

  @override
  List<Object?> get props => [question];
}
