import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:economics_app/sections/quizzes/quiz_models/question_model.dart';

Future<List<QuestionModel>> getQuestionsFromFirebase() async {
  final instance = FirebaseFirestore.instance;
  final collectionSnapshot = await instance.collection('quiz').get();
  List<QuestionModel> questions = [];
  try {
    if (collectionSnapshot.docs.isNotEmpty) {
      for (var d in collectionSnapshot.docs) {
        questions.add(QuestionModel.fromMap(d.data()));
      }
    }
  } catch (e) {
    throw Exception(e);
  }
  return questions;
}
