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
}
