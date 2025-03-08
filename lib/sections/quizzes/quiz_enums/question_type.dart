import 'package:economics_app/sections/quizzes/quiz_enums/question_key.dart';

enum QuestionType {
  multi,
  flip,
}

extension QuestionTypeExtension on QuestionType {
  // Convert enum to text
  String toText() {
    switch (this) {
      case QuestionType.multi:
        return 'Multiple Choice';
      case QuestionType.flip:
        return 'Flip Card';
    }
  }

  static QuestionType? fromText(String? text) {
    if (text == null) return null; // Handle null input

    switch (text) {
      case 'multi':
        return QuestionType.multi;
      case 'flip':
        return QuestionType.flip;
      default:
        return null; // Return null for unknown values instead of throwing an exception
    }
  }

  static QuestionType? getQuestionType(Map<String, dynamic>? map) {
    final key = QuestionKey.type.name;

    // Check if the map is null
    if (map == null) {
      return null;
    }

    // Extract the type field
    final typeValue = map[key];

    // Parse the typeValue into a QuestionType using the extension
    return QuestionTypeExtension.fromText(typeValue);
  }
}
