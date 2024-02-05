import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:economics_app/configs/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../models/topic_model.dart';

Future<QuerySnapshot<Map<String, dynamic>>?> getRawCollectionData(
    String url) async {
  QuerySnapshot<Map<String, dynamic>> data;
  final ref = FirebaseFirestore.instance;
  try {
    data = await ref.collection(url).get();
  } catch (e) {
    return null;
  }
  return data;
}

/// If there is no data or error will return null
Future<List<TopicModel>?> getSectionsAndUnitData() async {
  try {
    /// Get data from firebase
    final sections = await getRawCollectionData('/$kSections');

    /// Define a local variable
    List<TopicModel> topics = [];
    for (int i = 0; i < sections!.docs.length; i++) {
      topics.add(TopicModel.fromMap(snapshot: sections.docs[i]));
    }

    /// Iterate through the main topics and get the units for each
    for (int i = 0; i < topics.length; i++) {
      final unitData =
          await getRawCollectionData('/$kSections/${topics[i].title}/$kUnits/');
      List<TopicModel> units = [];
      for (int j = 0; j < unitData!.docs.length; j++) {
        units.add(TopicModel.fromMap(
            snapshot: unitData.docs[j], parent: topics[i].title));
      }

      topics[i] = topics[i].copyWith(units: units);
    }
    if (topics.isEmpty) {
      return null;
    } else {
      return topics;
    }
  } catch (e) {
    return null;
  }
}

Future<Map<String, Uint8List?>> getImage(String image) async {
  final instance = FirebaseStorage.instance;

  Map<String, Uint8List?> imageBytes = {};

  try {
    final bytes = await instance.ref('$image.png').getData();
    imageBytes.addAll({image: bytes});
  } catch (error) {
    return {}; // Return null in case of an error
  }

  return imageBytes;
}
