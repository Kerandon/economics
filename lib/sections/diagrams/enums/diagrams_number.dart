enum DiagramsNumber {
  zero,
  one,
  two,
  three,
  four,
}

extension DiagramsNumberExtension on DiagramsNumber {
  int get toInt {
    switch (this) {
      case DiagramsNumber.zero:
        return 0;
      case DiagramsNumber.one:
        return 1;
      case DiagramsNumber.two:
        return 2;
      case DiagramsNumber.three:
        return 3;
      case DiagramsNumber.four:
        return 4;
    }
  }
}
