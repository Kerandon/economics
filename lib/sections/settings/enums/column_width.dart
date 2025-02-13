enum CustomColumnWidth { one, two, three, four }

extension CustomColumn on CustomColumnWidth {
  int getAddDiagramButtonsWidth() {
    switch (this) {
      case CustomColumnWidth.one:
        return 1;
      case CustomColumnWidth.two:
        return 6;
      case CustomColumnWidth.three:
        return 3;
      case CustomColumnWidth.four:
        return 2;
    }
  }

  int getQuestionsWidth() {
    switch (this) {
      case CustomColumnWidth.one:
        return 12;
      case CustomColumnWidth.two:
        return 2;
      case CustomColumnWidth.three:
        return 2;
      case CustomColumnWidth.four:
        return 2;
    }
  }
}
