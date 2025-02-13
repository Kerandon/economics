import 'package:cloud_firestore/cloud_firestore.dart';
import '../quiz_enums/question_key.dart';

Future<QuerySnapshot<Map<String, dynamic>>> getCourseData() async {
  try {
    final ref = FirebaseFirestore.instance;
    final snapshot = await ref.collection(QuestionKey.courses.name).get();
    // for(var d in snapshot.docs){
    //   print('docs are ${d.id}');
    //   for(var e in d.data().entries){
    //     print('entries are ${e.key} and ${e.value}');
    //   }
    // }

    return snapshot;
  } catch (e) {
    // Throw the exception instead of just creating it
    throw Exception('Cannot get course data: $e');
  }
}
