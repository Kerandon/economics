enum QuestionType {
  multi,
  flip,
}

extension QuestionTypeExtension on QuestionType {
  // Convert enum to text
  String toText() {
    switch (this) {
      case QuestionType.multi:
        return QuestionType.multi.name;
      case QuestionType.flip:
        return QuestionType.flip.name;
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
}
