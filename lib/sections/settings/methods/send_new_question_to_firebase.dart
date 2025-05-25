import 'package:cloud_firestore/cloud_firestore.dart';
import '../../quizzes/quiz_enums/question_key.dart';
import '../../quizzes/quiz_sections/questions/quiz_models/question_model.dart';

Future<void> sendNewQuestionToFirebase(
    {required QuestionModel question, bool existing = false}) async {
  final instance = FirebaseFirestore.instance;

  try {




    await instance
        .collection(QuestionKey.quiz.name)
        .doc(existing ? question.id : null)
        .set(question.toMap());
  } catch (e) {
    throw Exception('Error $e');
  }
}

Future<void> sendNewQuestionsBatchToFirebase(List<QuestionModel> questions) async {
  final instance = FirebaseFirestore.instance;
  final batch = instance.batch();

  try {
    for (final question in questions) {
      // Query Firestore to check if a question with the same text and syllabus exists
      final querySnapshot = await instance
          .collection(QuestionKey.quiz.name)
          .where(QuestionKey.question.name, isEqualTo: question.question)
          .where(QuestionKey.syllabus.name, isEqualTo: question.syllabuses?[0].syllabus?.name)
          .limit(1)
          .get();

      DocumentReference docRef;
      if (querySnapshot.docs.isNotEmpty) {
        // Overwrite existing doc
        docRef = querySnapshot.docs.first.reference;
      } else {
        // Create new doc with auto-generated ID
        docRef = instance.collection(QuestionKey.quiz.name).doc();
      }

      // Add set operation to batch
      batch.set(docRef, question.toMap());
    }

    // Commit the batch
    await batch.commit();

  } catch (e) {
    throw Exception('Error sending batch questions: $e');
  }
}
