import 'package:cloud_firestore/cloud_firestore.dart';
import '../quiz_enums/question_key.dart';
import '../quiz_sections/questions/quiz_models/question_model.dart';

Future<List<QuestionModel>> getQuestionsData() async {

  final instance = FirebaseFirestore.instance;
  final collectionSnapshot =
      await instance.collection(QuestionKey.quiz.name).get();
  List<QuestionModel> questions = [];
  try {
    if (collectionSnapshot.docs.isNotEmpty) {

      for (var d in collectionSnapshot.docs) {
        questions.add(QuestionModel.fromMap(d.id, d.data()));
      }
    }
  } catch (e) {
    throw Exception(e);
  }
  return questions;
}
