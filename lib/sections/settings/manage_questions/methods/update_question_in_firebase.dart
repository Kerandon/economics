import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../app/configs/constants.dart';

Future<void> updateQuestionInFirebase(
    {required String originalQuestionId,
    required Map<String, dynamic> updatedFields}) async {
  try {
    final ref = FirebaseFirestore.instance;

    ref.collection(kQuiz).doc(originalQuestionId).update(updatedFields);
  } catch (e) {
    throw Exception('Error $e');
  }
}
