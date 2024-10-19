import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../../app/configs/constants.dart';

import '../../questions/quiz_models/question_model.dart';

Future<void> sendQuestionToFirebase({required QuestionModel question}) async {
  final instance = FirebaseFirestore.instance;

  try {
    await instance.collection(kQuiz).doc().set(question.toMap());
  } catch (e) {
    debugPrint('Could not send data to firebase $e');

    ///ToDo add error catching here
  }
}
