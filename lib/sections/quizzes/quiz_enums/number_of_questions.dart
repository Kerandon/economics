enum NumberOfQuestions {
  five,
  all;

  // A getter that returns 5 when the value is 'five'
  int get value {
    switch (this) {
      case NumberOfQuestions.five:
        return 5;
      case NumberOfQuestions.all:
        return -1; // Return -1 or any value you want to represent 'all'
    }
  }
}
