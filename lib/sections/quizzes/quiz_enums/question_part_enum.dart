enum QuestionPart {
  question,
  answer1,
  answer2,
  answer3,
  answer4,
}

extension QuestionPartExtension on String {
  QuestionPart toQuestionPartEnum() {
    switch (toLowerCase()) {
      case 'question':
        return QuestionPart.question;
      case 'answer 0':
        return QuestionPart.answer1;
      case 'answer 1':
        return QuestionPart.answer2;
      case 'answer 2':
        return QuestionPart.answer3;
      case 'answer 3':
        return QuestionPart.answer4;
      default:
        QuestionPart.question;
    }
    return QuestionPart.question;
  }
}

extension QuestionPartEnum on QuestionPart {
  int toIndexEnum() {
    switch (this) {
      case QuestionPart.question:
        return -1;
      case QuestionPart.answer1:
        return 0;
      case QuestionPart.answer2:
        return 1;
      case QuestionPart.answer3:
        return 2;
      case QuestionPart.answer4:
        return 3;
    }
  }
}
