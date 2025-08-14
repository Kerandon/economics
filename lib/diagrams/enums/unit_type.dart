

import '../../home_page_new/enums/custom_slide.dart';
import 'diagram_bundle_enum.dart';

enum UnitType {
  intro('1', 'Introduction to economics'),
  micro('2', 'Microeconomics'),
  macro('3', 'Macroeconomics'),
  global('4', 'The global economy');

  final String id;
  final String title;

  const UnitType(this.id, this.title);
}

enum Subunit {
  // Intro
  whatIsEconomics('1.1', 'What is economics?', UnitType.intro),
  economistsApproach(
      '1.2', 'How do economists approach the world?', UnitType.intro),

  // Micro
  demand('2.1', 'Demand (includes HL only sub-topics)', UnitType.micro),
  supply('2.2', 'Supply (includes HL only sub-topics)', UnitType.micro),
  competitiveMarket('2.3', 'Competitive market equilibrium', UnitType.micro),
  critiqueBehaviour(
      '2.4',
      'Critique of the maximizing behaviour of consumers and producers (HL only)',
      UnitType.micro),
  elasticityDemand('2.5', 'Elasticity of demand (includes HL only sub-topics)',
      UnitType.micro),
  elasticitySupply('2.6', 'Elasticity of supply (includes HL only sub-topics)',
      UnitType.micro),
  roleOfGovernment(
      '2.7',
      'Role of government in microeconomics (includes HL only calculation)',
      UnitType.micro),
  marketFailureExternalities(
      '2.8',
      'Market failure—externalities and common pool or common access resources (includes HL only calculation)',
      UnitType.micro),
  marketFailurePublicGoods(
      '2.9', 'Market failure—public goods', UnitType.micro),
  marketFailureAsymmetric('2.10',
      'Market failure—asymmetric information (HL only)', UnitType.micro),
  marketFailurePower(
      '2.11', 'Market failure—market power (HL only)', UnitType.micro),
  marketEquity('2.12', 'The market’s inability to achieve equity (HL only)',
      UnitType.micro),

  // Macro
  measuringActivity(
      '3.1',
      'Measuring economic activity and illustrating its variations',
      UnitType.macro),
  variationsActivity(
      '3.2',
      'Variations in economic activity—aggregate demand and aggregate supply',
      UnitType.macro),
  macroObjectives(
      '3.3',
      'Macroeconomic objectives (includes HL only calculation)',
      UnitType.macro),
  inequalityPoverty(
      '3.4',
      'Economics of inequality and poverty (includes HL only calculation)',
      UnitType.macro),
  demandManagementMonetary(
      '3.5',
      'Demand management—monetary policy (includes HL only sub-topics)',
      UnitType.macro),
  demandManagementFiscal(
      '3.6',
      'Demand management—fiscal policy (includes HL only sub-topics)',
      UnitType.macro),
  supplySidePolicies('3.7', 'Supply-side policies', UnitType.macro),

  // Global
  benefitsTrade(
      '4.1',
      'Benefits of international trade (includes HL only subtopics and calculation)',
      UnitType.global),
  typesTradeProtection(
      '4.2',
      'Types of trade protection (includes HL only calculations)',
      UnitType.global),
  tradeArguments('4.3', 'Arguments for and against trade control/protection',
      UnitType.global),
  economicIntegration('4.4', 'Economic integration', UnitType.global),
  exchangeRates(
      '4.5', 'Exchange rates (includes HL only sub-topic)', UnitType.global),
  balanceOfPayments('4.6', 'Balance of payments (includes HL only sub-topics)',
      UnitType.global),
  sustainableDevelopment('4.7',
      'Sustainable development (includes HL only sub-topic)', UnitType.global),
  measuringDevelopment('4.8', 'Measuring development', UnitType.global),
  barriersGrowth(
      '4.9',
      'Barriers to economic growth and/or economic development',
      UnitType.global),
  growthStrategies(
      '4.10',
      'Economic growth and/or economic development strategies',
      UnitType.global);

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
List<CustomSlide> getSlides(dynamic key) {
  final allSlides = [
    CustomSlide(
      section: Subunit.demand,
      title: 'Key Concept & Definitions',
      content: '''
      <strong>Demand</strong> is the <strong>willingness</strong> and <strong>ability</strong> of consumers to purchase a good or service at various prices during a given time period.
    <p>Demand has a downward sloping curve. This reflects a negative relationship between price 
    and the quantity demanded. As price increases the quantity demanded falls, 
    and vice-versa.</p>
    
    ''',
      diagramBundleEnums: [DiagramBundleEnum.microDemand,],
    ),
    CustomSlide(
      section: Subunit.demand,
      title: 'Individual vs. Market Demand',
      content: '''
      <ul>
        <li><strong>Individual demand</strong> refers to the quantity of a good a single consumer is willing and able to buy at different prices.</li>
        <li><strong>Market demand</strong> is the total quantity demanded by all consumers in the market at different prices.</li>
      </ul>
    ''',
      diagramBundleEnums: [DiagramBundleEnum.microDemand,DiagramBundleEnum.microDemandDeterminants,],
    ),
    CustomSlide(
      section: Subunit.demand,
      title: 'Changes in Price and Quantity Demanded',
      content: '''
      <ul>
        <li>A change in price causes a <strong>movement along</strong> the demand curve, changing the quantity demanded.</li>
        <li>This is known as a <strong>change in quantity demanded</strong>.</li>
      </ul>
    ''',
    ),
    CustomSlide(
      section: Subunit.demand,
      title: 'Non-Price Determinants of Demand',
      content: '''
      Factors that shift the demand curve include:
      <ul>
        <li><strong>Income</strong> (normal and inferior goods)</li>
        <li><strong>Prices of related goods</strong> (substitutes and complements)</li>
        <li><strong>Tastes and preferences</strong></li>
        <li><strong>Expectations</strong> of future prices or income</li>
        <li><strong>Demographic changes</strong></li>
      </ul>
    ''',
    ),
    CustomSlide(
      section: Subunit.demand,
      title: 'Reasons for Downward Sloping Demand Curve (HL)',
      content: '''
      The demand curve slopes downwards due to:
      <ul>
        <li><strong>Substitution effect:</strong> consumers switch to cheaper alternatives when price rises.</li>
        <li><strong>Income effect:</strong> a rise in price reduces purchasing power.</li>
        <li><strong>Diminishing marginal utility:</strong> each additional unit consumed provides less satisfaction.</li>
      </ul>
    ''',
    ),
  ];
  if (key is UnitType) {
    return allSlides.where((slide) => slide.section == key).toList();
  }
  // If key is a Subunit, filter by that subunit
  else if (key is Subunit) {
    return allSlides.where((slide) => slide.section == key).toList();
  }

  // Add more type checks for UnitType or String if you want, e.g.:


  // If key type is not handled, return all slides or empty list
  return [];
}
