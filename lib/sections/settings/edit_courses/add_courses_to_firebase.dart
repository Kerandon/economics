import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../app/utils/models/unit.dart';

Future<void> addCourseToFirebase(
    {required String course, required List<Unit> units}) async {
  Map<String, dynamic> unitsMap = {};

  for (var u in units) {
    unitsMap.addAll(u.toMap());
  }

  final ref = FirebaseFirestore.instance;
  try {
    await ref.collection('courses').doc(course).set(unitsMap);
  } catch (e) {
    /// Todo error catching here
  }
}
