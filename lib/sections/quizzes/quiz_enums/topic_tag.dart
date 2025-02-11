import 'package:economics_app/app/configs/constants.dart';

enum TopicTag {
  multipleChoiceQuestions,
  calculations,
  definitions,
  longAnswer,
  diagrams,
}

extension TopicTagFirebase on TopicTag {
  String toFireBase() {
    return name;
  }

  // Convert a Map<String, String> (from Firebase) back to a FlipCardTag
  static fromFirebase(Map<String, dynamic> map) {
    final t = map[kFlipCardTag] as String;
    return TopicTag.values.firstWhere((e) => e.name == t);
  }
}

// Extension to add toText method
extension TopicTagToText on TopicTag {
  String toText() {
    switch (this) {
      case TopicTag.multipleChoiceQuestions:
        return kMultipleChoiceQuestions;
      case TopicTag.calculations:
        return "Calculations";
      case TopicTag.definitions:
        return "Definitions";
      case TopicTag.longAnswer:
        return "Long Answer";
      case TopicTag.diagrams:
        return "Diagrams";
    }
  }
}
