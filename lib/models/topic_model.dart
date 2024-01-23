import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:economics_app/utils/constants.dart';
import '../utils/enums/level_enum.dart';

class TopicModel {
  final String? parent;
  final String? title;
  final String? unit;
  final Level? level;
  final String? content;

  TopicModel({
    this.parent,
    this.title,
    this.unit,
    this.level,
    this.content,
  });

  factory TopicModel.fromDocumentSnapshot(QueryDocumentSnapshot doc,
      [String? parent]) {
    final data = doc.data() as Map<String, dynamic>;

    String? unit;
    Level? level;
    String? content;

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
    }

    return TopicModel(
      parent: parent,
      title: doc.id,
      unit: unit,
      level: level,
      content: content,
    );
  }

  TopicModel copyWith({
    String? parent,
    String? title,
    String? unit,
    Level? level,
    String? content,
    List<TopicModel>? subtopics,
  }) {
    return TopicModel(
      parent: parent ?? this.parent,
      title: title ?? this.title,
      unit: unit ?? this.unit,
      level: level ?? this.level,
      content: content ?? this.content,
    );
  }
}
