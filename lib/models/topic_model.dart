import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:economics_app/utils/constants.dart';
import '../utils/enums/level_enum.dart';
import 'content_model.dart';

class TopicModel {
  final String? parent;
  final String? grandparent;
  final String? title;

  final String? unit;
  final Level? level;
  final List<ContentModel>? content;

  TopicModel({
    this.parent,
    this.grandparent,
    this.title,
    this.unit,
    this.level,
    this.content,
  });

  factory TopicModel.fromCollection(
      {QueryDocumentSnapshot? collection,
      String? parent,
      String? grandparent,
      DocumentSnapshot? document}) {
    Map<String, dynamic> data;

    if (document == null) {
      data = collection!.data() as Map<String, dynamic>;
    } else {
      data = document.data() as Map<String, dynamic>;
    }
    String? unit;
    Level? level;
    List<ContentModel> contents = [];

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

      /// Get contents. This regex checks if the pattern of "Any-Digit" + "-Content"
      RegExp pattern = RegExp(r'^(\d+)-Content$');

      /// If there is a match.
      if (pattern.hasMatch(d.key)) {
        Match match = pattern.firstMatch(d.key)!;
        final index = int.parse(match.group(1)!);

        String? heading = d.value[kHeading];
        String? body = d.value[kBody];
        String? image = d.value[kImage];

        contents.add(
          ContentModel.copyWith(
              index: index, heading: heading, body: body, image: image),
        );
      }
    }
    return TopicModel(
      parent: parent,
      grandparent: grandparent,
      title: collection?.id ?? document?.id,
      unit: unit,
      level: level,
      content: contents,
    );
  }
}
