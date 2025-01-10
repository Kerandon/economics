enum DiagramType {
  negativeProductionExternalities,
  perfectCompetition,
  monopoly,
  ppc,
  circularFlowOfIncome,
  businessCycle,
  keynesianADAS,
  classicalADAS,
  phillipsCurve,
  internationalTrade,
  comparativeAdvantage,
  tariffs,
  importQuota,
  productionSubsidy,
  exportSubsidy,
}

extension DiagramTypeExtension on DiagramType {
  String toText() {
    switch (this) {
      case DiagramType.negativeProductionExternalities:
        return 'Negative production externalities';
      case DiagramType.perfectCompetition:
        return 'Perfect competition';
      case DiagramType.monopoly:
        return 'Monopoly';
      case DiagramType.circularFlowOfIncome:
        return 'Circular flow of income model';
      case DiagramType.businessCycle:
        return 'Business cycle';
      case DiagramType.ppc:
        return 'Production possibilities curve';
      case DiagramType.keynesianADAS:
        return 'Keynesian AD-AS';
      case DiagramType.classicalADAS:
        return 'Monetarist-new classical AD-AS';
      case DiagramType.phillipsCurve:
        return 'Phillips curve';
      case DiagramType.tariffs:
        return 'Tariff';
      case DiagramType.internationalTrade:
        return 'International trade';
      case DiagramType.comparativeAdvantage:
        return 'Comparative advantage';
      case DiagramType.importQuota:
        return 'Import quota';
      case DiagramType.productionSubsidy:
        return 'Production subsidy';
      case DiagramType.exportSubsidy:
        return 'Export subsidy';
    }
  }
}
