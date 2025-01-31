import 'package:economics_app/app/configs/constants.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/question_type.dart';

enum FlipCardTag {
  multipleChoiceQuestions,
  calculations,
  definitions,
  longAnswer,
  diagrams,
}

extension FlipCardFirebase on FlipCardTag {
  String toFireBase() {
    return name;
  }

  // Convert a Map<String, String> (from Firebase) back to a FlipCardTag
  static fromFirebase(Map<String, dynamic> map) {
    final t = map[kFlipCardTag] as String;
    return FlipCardTag.values.firstWhere((e) => e.name == t);
  }
}

// Extension to add toText method
extension FlipCardTagToText on FlipCardTag {
  String toText() {
    switch (this) {
      case FlipCardTag.multipleChoiceQuestions:
        return kMultipleChoiceQuestions;
      case FlipCardTag.calculations:
        return "Calculations";
      case FlipCardTag.definitions:
        return "Definitions";
      case FlipCardTag.longAnswer:
        return "Long Answer";
      case FlipCardTag.diagrams:
        return "Diagrams";
    }
  }
}

extension FlipCardType on FlipCardTag {
  QuestionType toQuestionType() {
    switch (this) {
      case FlipCardTag.multipleChoiceQuestions:
        return QuestionType.multi;
      case FlipCardTag.calculations:
        return QuestionType.flip;
      case FlipCardTag.definitions:
        return QuestionType.flip;
      case FlipCardTag.longAnswer:
        return QuestionType.flip;
      case FlipCardTag.diagrams:
        return QuestionType.flip;
    }
  }
}
