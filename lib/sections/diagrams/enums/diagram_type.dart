enum DiagramType {
  ppcMicro,
  supplyDemand,
  externalities,
  perfectCompetition,
  monopoly,
  ppcMacro,
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
  floatingExchangeRate,
  fixedExchangeRate,
  jCurve,
  povertyTrap,
}

extension DiagramTypeExtension on DiagramType {
  String toText() {
    switch (this) {
      case DiagramType.ppcMacro:
        return 'PPC Macro';
      case DiagramType.supplyDemand:
        return 'Supply & Demand';
      case DiagramType.externalities:
        return 'Externalities';
      case DiagramType.perfectCompetition:
        return 'Perfect competition';
      case DiagramType.monopoly:
        return 'Monopoly';
      case DiagramType.circularFlowOfIncome:
        return 'Circular flow of income model';
      case DiagramType.businessCycle:
        return 'Business cycle';
      case DiagramType.ppcMicro:
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
      case DiagramType.floatingExchangeRate:
        return 'Floating exchange rate';
      case DiagramType.fixedExchangeRate:
        return 'Fixed exchange rate';
      case DiagramType.jCurve:
        return 'J-Curve';
      case DiagramType.povertyTrap:
        return 'Poverty trap';

    }
  }
}
