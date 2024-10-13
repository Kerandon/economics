import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:economics_app/app/enums/firebase_status.dart';
import 'package:flutter/material.dart';
import '../../../../app/utils/models/unit.dart';

Future<FirebaseStatus> addCourseToFirebase({
  required String course,
  required List<Unit> units,
}) async {
  Map<String, dynamic> unitsMap = {};

  for (var u in units) {
    unitsMap.addAll(u.toMap());
  }

  final ref = FirebaseFirestore.instance;

  try {
    if (course.isEmpty) {
      return FirebaseStatus.error;
    }

    ref
        .collection('courses')
        .doc(course)
        .set(unitsMap, SetOptions(merge: true));
    return FirebaseStatus.success;
  } catch (e) {
    debugPrint('Error sending data to firebase ${e.toString()}');

    // Return error if an exception is caught
    return FirebaseStatus.error;
  }
}
