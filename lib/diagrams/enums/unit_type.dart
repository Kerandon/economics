import '../../home_page/enums/skill.dart';

enum UnitType {
  intro('1', 'Introduction'),
  micro('2', 'Microeconomics'),
  macro('3', 'Macroeconomics'),
  global('4', 'The Global Economy');

  final String id;
  final String title;

  const UnitType(this.id, this.title);
}

enum Subunit {
  // Intro
  whatIsEconomics('1.1', 'What is economics?', UnitType.intro),
  economistsApproach(
    '1.2',
    'How do economists approach the world?',
    UnitType.intro,
  ),

  // Micro
  demand('2.1', 'Demand', UnitType.micro),
  supply('2.2', 'Supply', UnitType.micro),
  competitiveMarket('2.3', 'Competitive market equilibrium', UnitType.micro),
  critiqueBehaviour(
    '2.4',
    'Critique of the maximizing behaviour of consumers and producers (HL only)',
    UnitType.micro,
  ),
  elasticityDemand('2.5', 'Elasticity of demand', UnitType.micro),
  elasticitySupply('2.6', 'Elasticity of supply', UnitType.micro),
  roleOfGovernment(
    '2.7',
    'Role of government in microeconomics',
    UnitType.micro,
  ),
  marketFailureExternalities(
    '2.8',
    'Market failure externalities and common pool or common access resources',
    UnitType.micro,
  ),
  marketFailurePublicGoods(
    '2.9',
    'Market failure public goods',
    UnitType.micro,
  ),
  marketFailureAsymmetric(
    '2.10',
    'Market failure asymmetric information (HL only)',
    UnitType.micro,
  ),
  marketFailurePower(
    '2.11',
    'Market failure market power (HL only)',
    UnitType.micro,
  ),
  marketEquity(
    '2.12',
    'The market’s inability to achieve equity (HL only)',
    UnitType.micro,
  ),

  // Macro
  measuringActivity(
    '3.1',
    'Measuring economic activity and illustrating its variations',
    UnitType.macro,
  ),
  variationsActivity(
    '3.2',
    'Variations in economic activity—aggregate demand and aggregate supply',
    UnitType.macro,
  ),
  macroObjectives(
    '3.3',
    'Macroeconomic objectives (includes HL only calculation)',
    UnitType.macro,
  ),
  inequalityPoverty(
    '3.4',
    'Economics of inequality and poverty (includes HL only calculation)',
    UnitType.macro,
  ),
  demandManagementMonetary(
    '3.5',
    'Demand management monetary policy (includes HL only sub-topics)',
    UnitType.macro,
  ),
  demandManagementFiscal(
    '3.6',
    'Demand management fiscal policy (includes HL only sub-topics)',
    UnitType.macro,
  ),
  supplySidePolicies('3.7', 'Supply-side policies', UnitType.macro),

  // Global
  benefitsTrade(
    '4.1',
    'Benefits of international trade (includes HL only subtopics and calculation)',
    UnitType.global,
  ),
  typesTradeProtection(
    '4.2',
    'Types of trade protection (includes HL only calculations)',
    UnitType.global,
  ),
  tradeArguments(
    '4.3',
    'Arguments for and against trade control/protection',
    UnitType.global,
  ),
  economicIntegration('4.4', 'Economic integration', UnitType.global),
  exchangeRates(
    '4.5',
    'Exchange rates (includes HL only sub-topic)',
    UnitType.global,
  ),
  balanceOfPayments(
    '4.6',
    'Balance of payments (includes HL only sub-topics)',
    UnitType.global,
  ),
  sustainableDevelopment(
    '4.7',
    'Sustainable development (includes HL only sub-topic)',
    UnitType.global,
  ),
  measuringDevelopment('4.8', 'Measuring development', UnitType.global),
  barriersGrowth(
    '4.9',
    'Barriers to economic growth and/or economic development',
    UnitType.global,
  ),
  growthStrategies(
    '4.10',
    'Economic growth and/or economic development strategies',
    UnitType.global,
  );

  final String id;
  final String title;
  final UnitType unit;

  const Subunit(this.id, this.title, this.unit);
}

extension UnitExt on UnitType {
  String get iconJpg => 'assets/images/${toString().split('.').last}.jpg';

  List<Subunit> get subunits =>
      Subunit.values.where((s) => s.unit == this).toList();
}

enum SyllabusPoint {
  lawOfDemand(
    Subunit.demand,
    'The law of demand: relationship between price and quantity demanded',
    [Skill.a02],
  ),
  assumptionsLawOfDemand(
    Subunit.demand,
    'Assumptions underlying the law of demand',
    [Skill.a02],
    hlOnly: true,
  ),
  demandCurve(Subunit.demand, 'Demand curve', [Skill.a04]),
  individualVsMarketDemand(
    Subunit.demand,
    'Relationship between individual and market demand',
    [Skill.a02],
  ),
  nonPriceDeterminants(Subunit.demand, 'Non-price determinants of demand', [
    Skill.a02,
  ]),
  movementsAndShiftsOfDemand(
    Subunit.demand,
    'Movements along the demand curve and shifts of the demand curve',
    [Skill.a02, Skill.a04],
  ),

  /// UNIT 2.10 — Market Failure & Market Power (HL)
  // Perfect competition
  perfectCompetitionCharacteristics(
    Subunit.marketFailurePower,
    'Perfect competition: many firms, free entry, homogeneous products',
    [Skill.a02],
  ),

  // Monopoly
  monopoly(
    Subunit.marketFailurePower,
    'Monopoly: single or dominant firm, high barriers to entry, no close substitutes, standard and natural monopoly',
    [Skill.a02],
  ),

  // Oligopoly
  oligopoly(
    Subunit.marketFailurePower,
    'Oligopoly: few large interdependent firms, high barriers to entry, collusive and non-collusive',
    [Skill.a03, Skill.a04],
  ),
  monopolisticCompetition(
    Subunit.marketFailurePower,
    'Monopolistic Competition: many relatively small firms with high production differentiation, limited market power and low barriers to entry',
    [Skill.a03, Skill.a04],
  ),
  advantagesAndRisksOfMarketPower(
    Subunit.marketFailurePower,
    'Economies of scale, dynamic efficiency, natural monopoly vs. P > MC, under-allocation, higher prices, welfare loss, anti-competitive behavior',
    [Skill.a03],
  ),
  governmentInterventionInResponseToAbuseOfMarketPower(
    Subunit.marketFailurePower,
    'Legislation, regulations, government ownership and fines',
    [Skill.a03],
  );

  final Subunit subunit;
  final String title;
  final List<Skill> skills;
  final bool hlOnly;

  const SyllabusPoint(
    this.subunit,
    this.title,
    this.skills, {
    this.hlOnly = false,
  });
}
