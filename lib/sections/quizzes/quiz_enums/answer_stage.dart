enum AnswerStage {
  notSelected,
  selected,
  correct,
  incorrect,
}

extension AnswerStageExtension on AnswerStage {
  // Convert enum to text
  String toText() {
    switch (this) {
      case AnswerStage.notSelected:
        return 'Not Selected';
      case AnswerStage.selected:
        return 'Selected';
      case AnswerStage.correct:
        return 'Correct';
      case AnswerStage.incorrect:
        return 'Incorrect';
    }
  }

  // Convert text to enum
  static AnswerStage fromText(String text) {
    switch (text) {
      case 'notSelected':
        return AnswerStage.notSelected;
      case 'selected':
        return AnswerStage.selected;
      case 'correct':
        return AnswerStage.correct;
      case 'incorrect':
        return AnswerStage.incorrect;
      default:
        throw Exception('Unknown answer stage: $text');
    }
  }
}
