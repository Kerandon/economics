import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../app/configs/constants.dart';

Future<QuerySnapshot<Map<String, dynamic>>?> getCourseData() async {
  try {
    final ref = FirebaseFirestore.instance;
    return await ref.collection(kCourses).get();
  } catch (e) {
    debugPrint('Could not get data $e');
    return null;
  }
}
