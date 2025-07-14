enum DiagramType {
  ppcMicro,
  supplyDemand,
  externalities,
  taxesAndSubsidies,
  priceControls,
  perfectCompetition,
  monopoly,
  monopolisticCompetition,
  oligopoly,
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
      case DiagramType.taxesAndSubsidies:
        return 'Taxes and Subsidies';
      case DiagramType.priceControls:
        return 'Price Controls';
      case DiagramType.externalities:
        return 'Externalities';
      case DiagramType.perfectCompetition:
        return 'Perfect Competition';
      case DiagramType.monopoly:
        return 'Monopoly';
      case DiagramType.monopolisticCompetition:
        return 'Monopolistic Competition';
      case DiagramType.circularFlowOfIncome:
        return 'Circular Flow of Income Model';
      case DiagramType.businessCycle:
        return 'Business Cycle';
      case DiagramType.ppcMicro:
        return 'Production Possibilities Curve';
      case DiagramType.keynesianADAS:
        return 'Keynesian AD-AS';
      case DiagramType.classicalADAS:
        return 'Monetarist-New Classical AD-AS';
      case DiagramType.phillipsCurve:
        return 'Phillips Curve';
      case DiagramType.tariffs:
        return 'Tariff';
      case DiagramType.internationalTrade:
        return 'International Trade';
      case DiagramType.comparativeAdvantage:
        return 'Comparative Advantage';
      case DiagramType.importQuota:
        return 'Import Quota';
      case DiagramType.productionSubsidy:
        return 'Production Subsidy';
      case DiagramType.exportSubsidy:
        return 'Export Subsidy';
      case DiagramType.floatingExchangeRate:
        return 'Floating Exchange Rate';
      case DiagramType.fixedExchangeRate:
        return 'Fixed Exchange Rate';
      case DiagramType.jCurve:
        return 'J-Curve';
      case DiagramType.povertyTrap:
        return 'Poverty Trap';
      case DiagramType.oligopoly:
        return 'Oligopoly';


    }
  }
}
