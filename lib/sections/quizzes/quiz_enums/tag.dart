import 'package:economics_app/sections/quizzes/quiz_enums/question_key.dart';

enum Tag {
  term,
  general,
  calculation,
  shortAnswer,
  longAnswer,
  workbook,
  coursebook,
  pastPaper,
  diagram,
  hl
}

extension TagFirebaseExtension on Tag {
  /// Converts a Firebase map to a list of Tags
  static List<Tag> fromFirebase(Map<String, dynamic>? map) {
    if (map == null) return [];

    final dynamic data = map[QuestionKey.tags.name];

    if (data is List) {
      return data
          .whereType<String>() // Ensures only Strings are processed
          .map((e) => fromFirebaseValue(e))
          .toList();
    }

    return [];
  }

  /// Converts a single tag to its Firebase representation
  static String toFirebase(Tag tag) => tag.name;

  /// Converts a list of Tags to a list of Firebase Strings
  static List<String> toFirebaseList(List<Tag> tags) =>
      tags.map((tag) => tag.name).toList();

  /// Converts a String back to a Tag enum
  static Tag fromFirebaseValue(String value) {
    return Tag.values.firstWhere(
      (tag) => tag.name == value,
      orElse: () => throw ArgumentError('Invalid value for Tag: $value'),
    );
  }
}

extension CustomTagExtension on Tag {
  /// Converts a CustomTag to a user-friendly text representation.
  String toText() {
    switch (this) {
      case Tag.term:
        return "Term";
      case Tag.general:
        return "General";
      case Tag.calculation:
        return "Calculation";
      case Tag.shortAnswer:
        return "Short Answer";
      case Tag.longAnswer:
        return "Long Answer";
      case Tag.workbook:
        return "Workbook";
      case Tag.coursebook:
        return "Coursebook";
      case Tag.pastPaper:
        return "Past paper";
      case Tag.hl:
        return "HL";
      case Tag.diagram:
        return 'Diagram';
    }
  }
}
