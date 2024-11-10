import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../app/configs/constants.dart';
import '../../../../app/enums/firebase_status.dart';

Future<FirebaseStatus> deleteQuestionFromFirebase(String id) async {
  try {
    final ref = FirebaseFirestore.instance;
    await ref.collection(kQuiz).doc(id).delete();
    return FirebaseStatus.success;
  } catch (e) {
    return FirebaseStatus.error;
  }
}
