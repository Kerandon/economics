enum QuizFilter {
  all,
  unit,
  subunit,
}

extension Filter on QuizFilter {
  String toText() {
    switch (this) {
      case QuizFilter.all:
        return 'All questions';
      case QuizFilter.unit:
        return 'Unit only';
      case QuizFilter.subunit:
        return 'Unit & subunit';
    }
  }
}
