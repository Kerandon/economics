import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../app/configs/constants.dart';

Future<QuerySnapshot<Map<String, dynamic>>?> getCourseData() async {
  try {
    final ref = FirebaseFirestore.instance;
    final snapshot = await ref.collection(kCourses).get();
    return snapshot;
  } catch (e) {
    debugPrint('cannot get course data $e');
    return null;
  }
}
