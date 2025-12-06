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
  monopolyCharacteristics(
    Subunit.marketFailurePower,
    'Monopoly: single or dominant firm, high barriers to entry, no close substitutes',
    [Skill.a02],
  ),
  naturalMonopoly(
    Subunit.marketFailurePower,
    'Natural monopoly and economies of scale',
    [Skill.a03, Skill.a04],
  ),
  // Imperfect competition general
  imperfectCompetitionOverview(
    Subunit.marketFailurePower,
    'Imperfect competition: varying degrees of market power, firm as price maker',
    [Skill.a02],
  ),

  // Monopolistic competition
  monopolisticCompetitionCharacteristics(
    Subunit.marketFailurePower,
    'Monopolistic competition: many firms, free entry, product differentiation',
    [Skill.a02],
  ),
  monopolisticCompetitionProfitMaximizationSR(
    Subunit.marketFailurePower,
    'Monopolistic competition profit maximization in the short run',
    [Skill.a03, Skill.a04],
  ),
  monopolisticCompetitionProfitMaximizationLR(
    Subunit.marketFailurePower,
    'Monopolistic competition profit maximization in the long run',
    [Skill.a03, Skill.a04],
  ),
  monopolisticCompetitionEfficiency(
    Subunit.marketFailurePower,
    'Monopolistic competition: allocative inefficiency but greater product variety',
    [Skill.a03],
  ),
  monopolisticCompetitionDiagrams(
    Subunit.marketFailurePower,
    'Monopolistic competition diagrams: abnormal profit, normal profit, losses',
    [Skill.a03, Skill.a04],
  ),

  // Oligopoly
  oligopolyCharacteristics(
    Subunit.marketFailurePower,
    'Oligopoly: few large firms, high barriers to entry, interdependence',
    [Skill.a02],
  ),
  oligopolyCollusiveVsNonCollusive(
    Subunit.marketFailurePower,
    'Oligopoly: collusive vs non-collusive behaviour, risk of price war, incentives to cheat',
    [Skill.a03],
  ),
  oligopolyGameTheory(
    Subunit.marketFailurePower,
    'Game theory payoff matrix (HL only)',
    [Skill.a03],
    hlOnly: true,
  ),
  oligopolyCompetition(
    Subunit.marketFailurePower,
    'Oligopoly price and non-price competition',
    [Skill.a02],
  ),
  oligopolyConcentrationRatios(
    Subunit.marketFailurePower,
    'Market concentration and concentration ratios',
    [Skill.a02],
  ),
  oligopolyDiagrams(
    Subunit.marketFailurePower,
    'Collusive oligopoly diagram acting like a monopoly',
    [Skill.a03, Skill.a04],
  ),

  // Rational producer behaviour (HL only)
  profitMaximizationHL(
    Subunit.marketFailurePower,
    'Rational producer behaviour: profit maximization (TR - TC, MC = MR)',
    [Skill.a02],
    hlOnly: true,
  ),
  abnormalProfitDefinition(
    Subunit.marketFailurePower,
    'Abnormal profit (AR > AC)',
    [Skill.a02],
  ),
  normalProfitDefinition(
    Subunit.marketFailurePower,
    'Normal profit (AR = AC)',
    [Skill.a02],
  ),
  lossDefinition(Subunit.marketFailurePower, 'Losses (AR < AC)', [Skill.a02]),
  hlCalculations(
    Subunit.marketFailurePower,
    'HL calculations: profit, MC, MR, AC, AR from data',
    [Skill.a04],
    hlOnly: true,
  ),

  // Market failure — market power
  meaningOfMarketPower(
    Subunit.marketFailurePower,
    'Meaning and degrees of market power',
    [Skill.a02],
  ),

  // Stakeholders + info failures
  stakeholderConsequences(
    Subunit.marketFailurePower,
    'Consequences of market power for stakeholders',
    [Skill.a02],
  ),
  freeRiderProblem(Subunit.marketFailurePower, 'Free rider problem', [
    Skill.a02,
  ]),
  adverseSelection(Subunit.marketFailurePower, 'Adverse selection', [
    Skill.a02,
  ]),
  moralHazard(Subunit.marketFailurePower, 'Moral hazard', [Skill.a02]),

  // Benefits & Risks of Market Power
  benefitsLargeFirms(
    Subunit.marketFailurePower,
    'Advantages of large firms: economies of scale, R&D investment, innovation',
    [Skill.a03],
  ),
  risksLargeFirms(
    Subunit.marketFailurePower,
    'Risks of markets dominated by one or few large firms: output, price, consumer choice',
    [Skill.a03],
  ),

  // Government intervention
  governmentInterventionMarketPower(
    Subunit.marketFailurePower,
    'Government response to abuse of market power: legislation, regulation, fines, public ownership',
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
