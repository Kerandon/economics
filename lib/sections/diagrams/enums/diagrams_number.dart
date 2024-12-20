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

extension DiagramsToIntExtension on int {
  DiagramsNumber get toDiagramsNumber {
    switch (this) {
      case 0:
        return DiagramsNumber.zero;
      case 1:
        return DiagramsNumber.one;
      case 2:
        return DiagramsNumber.two;
      case 3:
        return DiagramsNumber.three;
      case 4:
        return DiagramsNumber.four;
      default:
        throw ArgumentError('Invalid integer for DiagramsNumber');
    }
  }
}
