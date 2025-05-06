import 'package:cloud_firestore/cloud_firestore.dart';
import '../quiz_enums/question_key.dart';
import '../quiz_sections/questions/quiz_models/question_model.dart';

Future<List<QuestionModel>> getQuestionsData() async {
print('GET');
  final instance = FirebaseFirestore.instance;
  final collectionSnapshot =
      await instance.collection(QuestionKey.quiz.name).get();
  List<QuestionModel> questions = [];
  try {
    if (collectionSnapshot.docs.isNotEmpty) {
      print('GET 2');
      for (var d in collectionSnapshot.docs) {
        print('GET 3');
        questions.add(QuestionModel.fromMap(d.id, d.data()));
      }
    }
  } catch (e) {
    throw Exception(e);
  }
print('GET 4');
  return questions;
}
