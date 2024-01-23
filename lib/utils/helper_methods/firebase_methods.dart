import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:economics_app/utils/helper_methods/sort_string_numbers.dart';
import '../../models/topic_model.dart';

Future<List<TopicModel>> getData(String url, {String? parent}) async {
  /// Get a reference to firebase
  final ref = FirebaseFirestore.instance;

  List<TopicModel> models = [];

  /// Get data
  final data = await ref.collection(url).get();

  for (var d in data.docs) {
    models.add(TopicModel.fromDocumentSnapshot(d, parent));
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
