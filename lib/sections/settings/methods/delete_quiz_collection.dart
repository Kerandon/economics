import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Future<void> deleteQuizCollection(BuildContext context) async {
  final collection = FirebaseFirestore.instance.collection('quiz');

  try {
    final snapshot = await collection.get();
    final batch = FirebaseFirestore.instance.batch();

    for (final doc in snapshot.docs) {
      batch.delete(doc.reference);
    }

    await batch.commit();
  } catch (e){
    throw Exception('errror deleting quiz qn $e');
  }
}
