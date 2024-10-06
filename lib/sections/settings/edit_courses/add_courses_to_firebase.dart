import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../app/utils/models/unit.dart';

Future<void> addCourseToFirebase(
    {required String course, required List<Unit> units}) async {
  Map<String, dynamic> unitsMap = {};

  for (var u in units) {
    unitsMap.addAll(u.toMap());
  }

  final ref = FirebaseFirestore.instance;
  try {
    await ref.collection('courses').doc(course).set(
          unitsMap,
          SetOptions(merge: true),
        );
  } catch (e) {
    debugPrint(e.toString());

    /// Todo error catching here
  }
}
