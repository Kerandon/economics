enum QuestionType {
  multi,
  flip,
}

extension QuestionTypeExtension on QuestionType {
  // Convert enum to text
  String toText() {
    switch (this) {
      case QuestionType.multi:
        return 'Multi-choice';
      case QuestionType.flip:
        return 'Flip-card';
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
