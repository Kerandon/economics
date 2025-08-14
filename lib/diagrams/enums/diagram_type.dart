enum DiagramType {
  microPPC,
  microDemand,
  microSupply,
  priceMechanism,
  taxesAndSubsidies,
  priceControls,
  externalities,
  perfectCompetition,
  monopoly,
  monopolisticCompetition,
  oligopoly,
  ppcMacro,
  circularFlowOfIncome,
  businessCycle,
  aggregateDemand,
  classicalADAS,
  keynesianADAS,
  moneyMarket,
  demandSidePolicies,
  keynesianMultiplier,
  supplySidePolicies,
  phillipsCurve,
  internationalTrade,
  comparativeAdvantage,
  tariff,
  importQuota,
  productionSubsidy,
  exportSubsidy,
  floatingExchangeRate,
  fixedExchangeRate,
  managedExchangeRate,
  jCurve,
  povertyTrap,
}

extension DiagramTypeExtension on DiagramType {
  String toText() {
    switch (this) {
      case DiagramType.ppcMacro:
        return 'PPC Macro';
      case DiagramType.priceMechanism:
        return 'Price Mechanism';
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
      case DiagramType.microPPC:
        return 'Production Possibilities Curve (PPC) - Micro';
      case DiagramType.classicalADAS:
        return 'Monetarist/New Classical AD-AS Model';
      case DiagramType.phillipsCurve:
        return 'Phillips Curve';
      case DiagramType.tariff:
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
      case DiagramType.jCurve:
        return 'J-Curve';
      case DiagramType.povertyTrap:
        return 'Poverty Trap';
      case DiagramType.oligopoly:
        return 'Oligopoly';
      case DiagramType.fixedExchangeRate:
        return 'Fixed Exchange Rate';
      case DiagramType.managedExchangeRate:
        return 'Managed Exchange Rate';
      case DiagramType.aggregateDemand:
        return 'Aggregate Demand';
      case DiagramType.keynesianADAS:
        return 'Keynesian AD-AS Model';
      case DiagramType.moneyMarket:
        return 'Money Market';
      case DiagramType.demandSidePolicies:
        return 'Demand-Side Policies';
      case DiagramType.supplySidePolicies:
        return 'Supply-Side Policies';
      case DiagramType.keynesianMultiplier:
        return 'Keynesian Multiplier';
      case DiagramType.microDemand:
        return 'Demand';
      case DiagramType.microSupply:
        return 'Supply';
    }
  }
}