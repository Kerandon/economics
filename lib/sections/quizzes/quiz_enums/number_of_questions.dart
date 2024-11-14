enum NumberOfQuestions {
  five,
  ten,
  twenty,
}

extension NumberOfQuestionsExtension on NumberOfQuestions {
  int get toInt {
    switch (this) {
      case NumberOfQuestions.five:
        return 5;
      case NumberOfQuestions.ten:
        return 10;
      case NumberOfQuestions.twenty:
        return 20;
    }
  }
}
