import 'package:economics_app/sections/quizzes/quiz_sections/questions/quiz_models/question_model.dart';

class UserPref {
  final QuestionModel? question;
  final int? numberOfQuestions;
  final bool? showAnswersAtEnd;

  const UserPref({
    this.question,
    this.numberOfQuestions,
    this.showAnswersAtEnd,
  });

  // copyWith method
  UserPref copyWith({
    QuestionModel? question,
    int? numberOfQuestions,
    bool? showAnswersAtEnd,
  }) {
    return UserPref(
      question: question ?? this.question,
      numberOfQuestions: numberOfQuestions ?? this.numberOfQuestions,
      showAnswersAtEnd: showAnswersAtEnd ?? this.showAnswersAtEnd,
    );
  }

}
