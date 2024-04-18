import 'package:equatable/equatable.dart';
import '../quiz_enums/answer_stage.dart';
import 'answer_model.dart';

class QuestionModel extends Equatable {
  final String question;
  final List<AnswerModel> answers;
  final AnswerStage answerStage;
  final List<String>? tags;

  const QuestionModel(
      {required this.question,
      required this.answers,
      required this.answerStage,
      this.tags});

  QuestionModel copyWith({
    String? question,
    List<AnswerModel>? answers,
    AnswerStage? answerStage,
    List<String>? tags,
  }) {
    return QuestionModel(
        question: question ?? this.question,
        answers: answers ?? this.answers,
        answerStage: answerStage ?? this.answerStage,
        tags: tags);
  }

  factory QuestionModel.fromMap(Map<String, dynamic> map) {


    final a = map['answers'];
    List<AnswerModel> answers = [];
    for(var e in a){
      answers.add(AnswerModel.fromMap(e));
    }
    final t = map['tags'];
    List<String> tags = [];
   for(var e in t){
     tags.add(e);
   }

    return QuestionModel(
      question: map['question'],
      answers: answers,
      answerStage: AnswerStage.notSelected,
      tags: tags,
    );
  }

  @override
  List<Object?> get props => [question];
}
