import 'package:cloud_firestore/cloud_firestore.dart';
import '../../quizzes/quiz_enums/question_key.dart';
import '../../quizzes/quiz_sections/questions/quiz_models/question_model.dart';

Future<void> sendNewQuestionToFirebase(
    {required QuestionModel question}) async {
  final instance = FirebaseFirestore.instance;

  try {
    await instance
        .collection(QuestionKey.quiz.name)
        .doc()
        .set(question.toMap());
  } catch (e) {
    throw Exception('Error $e');
  }
}
