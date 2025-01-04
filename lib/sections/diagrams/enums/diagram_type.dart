enum DiagramType {
  perfectCompetition,
  circularFlowOfIncome,
  negativeProductionExternalities
}

extension DiagramTypeExtension on DiagramType {
  String toText() {
    switch (this) {
      case DiagramType.perfectCompetition:
        return 'Perfect Competition';
      case DiagramType.circularFlowOfIncome:
        return 'Circular Flow of Income';
      case DiagramType.negativeProductionExternalities:
        return 'Negative Production Externalities';
    }
  }
}
