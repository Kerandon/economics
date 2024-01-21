import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:economics_app/utils/constants.dart';

import '../utils/enums/level_enum.dart';

class TopicModel {
  final String? title;
  final String? unit;
  final Level? level;
  final String? content;
  final List<TopicModel>? subtopics;

  TopicModel(
      {this.title,
      this.unit,
      this.level,
      this.content,
      List<TopicModel>? subtopics})
      : subtopics = subtopics ?? [];

  factory TopicModel.fromDocumentSnapshot(QueryDocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    String? unit;
    Level? level;
    String? content;
    List<TopicModel> subtopics = [];

    for (var d in data.entries) {
      if (d.key == kUnit) {
        unit = d.value;
      }

      if (d.key == kLevel) {
        if (d.value.toUpperCase() == Level.hL.name.toUpperCase()) {
          level = Level.hL;
        } else {
          level = Level.sL; // Set a default value in case there's no match
        }
      }

      if (d.key == kContents) {
        content = d.value;
      }

      if (d.key == kSubtopics) {
        subtopics = d.value;
      }
    }

    return TopicModel(
      title: doc.id,
      unit: unit,
      level: level,
      content: content,
      subtopics: subtopics,
    );
  }
}
