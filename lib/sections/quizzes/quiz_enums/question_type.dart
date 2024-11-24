enum QuizType {
  multi,
  flip,
}

extension QuestionTypeExtension on QuizType {
  // Convert enum to text
  String toText() {
    switch (this) {
      case QuizType.multi:
        return 'Multi-choice';
      case QuizType.flip:
        return 'Flip-card';
    }
  }

  // Convert text to enum
  static QuizType fromText(String text) {
    switch (text) {
      case 'multi':
        return QuizType.multi;
      case 'flip':
        return QuizType.flip;
      default:
        throw Exception('Unknown question type: $text');
    }
  }
}
