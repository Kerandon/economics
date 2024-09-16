enum QuestionType {
  multi,
  flip,
}

extension Type on QuestionType {
  String toText() {
    switch (this) {
      case QuestionType.multi:
        return 'Multi-choice';
      case QuestionType.flip:
        return 'Flip-card';
    }
  }
}
