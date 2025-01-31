import '../../../app/configs/constants.dart';

enum QuestionType {
  multi,
  flip,
}

extension QuestionTypeExtension on QuestionType {
  // Convert enum to text
  String toText() {
    switch (this) {
      case QuestionType.multi:
        return kMultipleChoiceQuestions;
      case QuestionType.flip:
        return kFlipCardQuestions;
    }
  }

  // Convert text to enum
  static QuestionType fromText(String text) {
    switch (text) {
      case 'multi':
        return QuestionType.multi;
      case 'flip':
        return QuestionType.flip;
      default:
        throw Exception('Unknown question type: $text');
    }
  }
}
