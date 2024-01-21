import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:economics_app/utils/helper_methods/sort_string_numbers.dart';

import '../../models/topic_model.dart';

Future<List<TopicModel>> getContentData() async {
  final ref = FirebaseFirestore.instance.collection('contents');
  final data = await ref.get();

  List<TopicModel> topicModels = [];

  for (var d in data.docs) {
    topicModels.add(TopicModel.fromDocumentSnapshot(d));
  }

  for (var t in topicModels) {
    final snapshot = await FirebaseFirestore.instance
        .collection('contents')
        .doc(t.title)
        .collection('Subtopics')
        .get();

    List<TopicModel> subTopics = [];

    for (var d in snapshot.docs) {
      subTopics.add(TopicModel.fromDocumentSnapshot(d));
    }

    // Sort subtopics before adding them to main topic
    subTopics.sort((a, b) => sortStringNumbers(a.unit, b.unit));

    t.subtopics?.addAll(subTopics);
  }

  // Sort the main topics based on the unit property
  topicModels.sort((a, b) => sortStringNumbers(a.unit, b.unit));

  return topicModels;
}
