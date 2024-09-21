// Enum for IB Sections
// ignore_for_file: unused_element

import 'package:economics_app/app/utils/mixins/unit_mixin.dart';

import '../../../app/utils/mixins/section_mixin.dart';

// Enum for IB Sections
enum IBSection with SectionMixin {
  all('All sections', [
    ...IntroUnits.values,
    ...MicroUnits.values,
    ...MacroUnits.values,
    ...GlobalUnits.values,
  ]),
  intro('Introduction', IntroUnits.values),
  micro('Microeconomics', MicroUnits.values),
  macro('Macroeconomics', MacroUnits.values),
  global('Global Economics', GlobalUnits.values);

  @override
  final String name;
  @override
  final List<UnitMixin> units;

  const IBSection(this.name, this.units);
}

// Enum for IB Intro section
enum IntroUnits with UnitMixin {
  whatIsEconomics('1.1', 'What is economics?'),
  howEconomistsApproachTheWorld('1.2', 'How do economists approach the world?');

  @override
  final String id;
  @override
  final String unit;

  const IntroUnits(this.id, this.unit, {this.topics = const []});

 @override
  final List<String> topics;


}

// Enum for IB Micro section
enum MicroUnits with UnitMixin {
  demand('2.1', 'Demand'),
  supply('2.2', 'Supply'),
  competitiveMarketEquilibrium('2.3', 'Competitive market equilibrium'),
  critiqueMaximizingBehavior(
      '2.4', 'Critique of the maximizing behaviour of consumers and producers'),
  elasticityOfDemand('2.5', 'Elasticity of demand'),
  elasticityOfSupply('2.6', 'Elasticity of supply'),
  roleOfGovernment('2.7', 'Role of government in microeconomics'),
  marketFailureExternalities('2.8',
      'Market failure—externalities and common pool or common access resources'),
  marketFailurePublicGoods('2.9', 'Market failure—public goods'),
  marketFailureAsymmetricInfo('2.10', 'Market failure—asymmetric information'),
  marketFailureMarketPower('2.11', 'Market failure—market power'),
  marketInabilityEquity('2.12', 'The market’s inability to achieve equity');

  @override
  final String id;
  @override
  final String unit;
  @override
  final List<String> topics;
  const MicroUnits(this.id, this.unit, {this.topics = const []});




}

// Enum for IB Macro section
enum MacroUnits with UnitMixin {
  measuringEconomicActivity(
      '3.1', 'Measuring economic activity and illustrating its variations'),
  variationsInEconomicActivity('3.2',
      'Variations in economic activity—aggregate demand and aggregate supply'),
  macroeconomicObjectives('3.3', 'Macroeconomic objectives'),
  inequalityAndPoverty('3.4', 'Economics of inequality and poverty'),
  demandManagementMonetaryPolicy(
      '3.5', 'Demand management (demand-side policies)—monetary policy'),
  demandManagementFiscalPolicy('3.6', 'Demand management—fiscal policy'),
  supplySidePolicies('3.7', 'Supply-side policies');

  @override
  final String id;
  @override
  final String unit;
  @override
  final List<String> topics;
  const MacroUnits(this.id, this.unit, {this.topics = const []});


}
// Enum for IB Global section
enum GlobalUnits with UnitMixin {
  benefitsOfInternationalTrade('4.1', 'Benefits of international trade', ['trade', 'international']),
  typesOfTradeProtection('4.2', 'Types of trade protection', ['trade', 'protection']),
  argumentsForTradeProtection('4.3', 'Arguments for and against trade control/protection', ['protection', 'arguments']),
  economicIntegration('4.4', 'Economic integration', ['integration', 'economic']),
  exchangeRates('4.5', 'Exchange rates', ['exchange', 'rates']),
  balanceOfPayments('4.6', 'Balance of payments', ['balance', 'payments']),
  sustainableDevelopment('4.7', 'Sustainable development', ['sustainable', 'development']),
  measuringDevelopment('4.8', 'Measuring development', ['measuring', 'development']),
  barriersToGrowth('4.9', 'Barriers to economic growth and/or economic development', ['barriers', 'growth', 'development']),
  growthAndDevelopmentStrategies('4.10', 'Economic growth and/or economic development strategies', ['growth', 'development', 'strategies']);

  @override
  final String id;
  @override
  final String unit;
  @override
  final List<String> topics;

  const GlobalUnits(this.id, this.unit, this.topics);
}
