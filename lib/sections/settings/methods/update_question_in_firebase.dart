import 'package:cloud_firestore/cloud_firestore.dart';

import '../../quizzes/quiz_enums/question_key.dart';

Future<void> updateQuestionInFirebase(
    {required String originalQuestionId,
    required Map<String, dynamic> updatedFields}) async {
  try {
    final ref = FirebaseFirestore.instance;

    ref
        .collection(QuestionKey.quiz.name)
        .doc(originalQuestionId)
        .update(updatedFields);
  } catch (e) {
    throw Exception('Error $e');
  }
}
