import 'package:economics_app/app/configs/constants.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/question_key.dart';

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

// Convert a Map<String, String> (from Firebase) back to a TopicTag
  static TopicTag? fromFirebase(Map<String, dynamic>? map) {
    if (map == null || !map.containsKey(QuestionKey.topic.name)) {
      return null; // Return null if map is null or key is missing
    }

    final t = map[QuestionKey.topic.name] as String?; // Safe cast to String?
    if (t == null) {
      return null; // Return null if value is null
    }

    try {
      return TopicTag.values.firstWhere((e) => e.name == t);
    } catch (e) {
      return null; // Return null if no matching enum value is found
    }
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
