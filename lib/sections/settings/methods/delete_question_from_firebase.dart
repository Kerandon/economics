import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../app/enums/firebase_status.dart';
import '../../quizzes/quiz_enums/question_key.dart';

Future<FirebaseStatus> deleteQuestionFromFirebase(String id) async {
  try {
    final ref = FirebaseFirestore.instance;
    await ref.collection(QuestionKey.quiz.name).doc(id).delete();
    return FirebaseStatus.success;
  } catch (e) {
    return FirebaseStatus.error;
  }
}
