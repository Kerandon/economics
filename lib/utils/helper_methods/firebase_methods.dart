import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:economics_app/utils/enums/firebase_type_enum.dart';
import 'package:economics_app/utils/helper_methods/sort_string_numbers.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../models/topic_model.dart';

Future<List<TopicModel>> getData(String url,
    {String? parent,
    String? grandparent,
    FirebaseType firebaseType = FirebaseType.collection}) async {
  /// Get a reference to firebase
  final ref = FirebaseFirestore.instance;

  List<TopicModel> models = [];

  if (firebaseType == FirebaseType.document) {
    final data = await ref.doc(url).get();
    models.add(TopicModel.fromCollection(
        parent: parent, grandparent: grandparent, document: data));
  } else {
    /// Get data
    final data = await ref.collection(url).get();
    for (var d in data.docs) {
      models.add(TopicModel.fromCollection(
          collection: d, parent: parent, grandparent: grandparent));
    }
  }

  /// Sort models by [unit] property
  models.sort((a, b) => sortStringNumbers(a.unit, b.unit));

  return models;
}

Future<List<TopicModel>> getAllContentData() async {
  List<TopicModel> mainTopicModels = [],
      subtopicModels = [],
      articleModels = [];

  mainTopicModels = await getData('/contents');
  for (var t in mainTopicModels) {
    subtopicModels.addAll(
        await getData('/contents/${t.title}/Subtopics', parent: t.title));
    for (var s in subtopicModels) {
      articleModels.addAll(await getData(
          '/contents/${t.title}/Subtopics/${s.title}/Articles',
          parent: s.title));
    }
  }

  mainTopicModels.sort((a, b) => sortStringNumbers(a.unit, b.unit));
  subtopicModels.sort((a, b) => sortStringNumbers(a.unit, b.unit));
  articleModels.sort((a, b) => sortStringNumbers(a.unit, b.unit));

  return mainTopicModels;
}

Future<Map<String, Uint8List?>> getImage(String image) async {
  final instance = FirebaseStorage.instance;

  Map<String, Uint8List?> imageBytes = {};

  try {
    final bytes = await instance.ref('$image.png').getData();
    imageBytes.addAll({image: bytes});
  } catch (error) {
    ///to-do add error catcher
  }

  return imageBytes;
}
