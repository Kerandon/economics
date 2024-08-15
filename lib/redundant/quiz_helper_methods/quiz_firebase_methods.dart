// import 'dart:convert';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// import '../quiz_models/question_model.dart';
//
// Future<List<QuestionModel>?> getQuestionDataFromFirebase() async {
//   try {
//     List<QuestionModel> questions = [];
//     final snapshot =
//         await FirebaseFirestore.instance.collection('quiz').doc('quiz').get();
//     if (snapshot.data() != null) {
//       String rawJson = snapshot.get('mcq');
//
//       Map<String, dynamic> map = jsonDecode(rawJson); // import 'dart:convert';
//       final questionsData = map['questions'];
//       for (var q in questionsData) {
//         questions.add(QuestionModel.fromMap(q));
//       }
//     }
//
//     return questions;
//   } catch (e) {
//     return null;
//   }
// }
