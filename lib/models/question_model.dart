import 'package:economics_app/utils/enums/answer_stage.dart';
import 'package:equatable/equatable.dart';
import '../utils/constants.dart';
import 'answer_model.dart';

class QuestionModel extends Equatable {
  final String question;
  final List<AnswerModel> answers;
  final AnswerStage answerStage;
  final Map<String, String>? tags;

  const QuestionModel(
      {required this.question,
      required this.answers,
      required this.answerStage,
      this.tags});

  QuestionModel copyWith({
    String? question,
    List<AnswerModel>? answers,
    AnswerStage? answerStage,
    Map<String, String>? tags,
  }) {
    return QuestionModel(
        question: question ?? this.question,
        answers: answers ?? this.answers,
        answerStage: answerStage ?? this.answerStage,
        tags: tags);
  }

  factory QuestionModel.fromMap(MapEntry<String?, dynamic> map) {
    String question = map.key!;
    Map<String, dynamic> entries = map.value;

    Map<String, String> tags = {};
    List<AnswerModel> answers = [];

    /// Get tags
    for (var e in entries.entries) {
      if (e.key == kTags && e.value is Map<String, dynamic>) {
        tags = Map<String, String>.from(e.value as Map<String, dynamic>);
      }

      /// Get answers
      if (e.key == kAnswers) {
        Map<String, dynamic> answerValues = e.value;

        for (var a in answerValues.entries) {
          answers.add(AnswerModel(a.key, a.value, AnswerStage.notAnswered));
        }
      }
    }

    return QuestionModel(
      question: question,
      answers: answers,
      answerStage: AnswerStage.notAnswered,
      tags: tags,
    );
  }

  @override
  List<Object?> get props => [question];
}
