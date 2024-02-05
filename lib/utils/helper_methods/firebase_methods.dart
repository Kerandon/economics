import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:economics_app/configs/constants.dart';
import 'package:economics_app/utils/helper_methods/sort_string_numbers.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../models/article_model.dart';
import '../../models/topic_model.dart';

Future<QuerySnapshot<Map<String, dynamic>>?> getRawCollectionData(
    String url) async {
  try {
    QuerySnapshot<Map<String, dynamic>> data;
    final ref = FirebaseFirestore.instance;

    data = await ref.collection(url).get();
    return data;
  } catch (e) {
    return null;
  }
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
      units.sort((a, b) => sortStringNumbers(a.unit, b.unit));
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

Future<Map<String, Uint8List?>?> getImage(String image) async {
  try {
    final instance = FirebaseStorage.instance;
    Map<String, Uint8List?> imageBytes = {};
    final bytes = await instance.ref('$image.png').getData();
    imageBytes.addAll({image: bytes});
    return imageBytes;
  } catch (error) {
    return null;
  }
}

Future<List<ArticleModel>?> getArticlesData(TopicModel topic) async {
  try {
    /// Define a list of [ArticleModel]
    List<ArticleModel> articles = [];

    /// Get the [QuerySnapshot<Map<String, dynamic>>] from firebase
    final snapshot = await getRawCollectionData(
        '/$kSections/${topic.parent}/$kUnits/${topic.title}/$kArticles/');

    if (snapshot != null) {
      for (var a in snapshot.docs) {
        articles.add(
            ArticleModel.fromMap(map: a.data(), index: int.tryParse(a.id)));
      }
    } else {
      return null;
    }
    return articles;
  } catch (e) {
    return null;
  }
}
