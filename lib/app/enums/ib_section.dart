// // Enum for IB Sections
// import 'package:economics_app/app/configs/constants.dart';
//
// import '../utils/mixins/unit_mixin.dart';
//
// enum IBSection with UnitMixin {
//   all('', kAllSections, [
//     ...IntroUnits.values,
//     ...MicroUnits.values,
//     ...MacroUnits.values,
//     ...GlobalUnits.values,
//   ]),
//   intro('1', 'Introduction', IntroUnits.values),
//   micro('2', 'Microeconomics', MicroUnits.values),
//   macro('3', 'Macroeconomics', MacroUnits.values),
//   global('4', 'Global Economics', GlobalUnits.values);
//
//   @override
//   final String index; // Section number
//   @override
//   final String name;
//   @override
//   final List<UnitMixin> subunits;
//   @override
//   final int? numberOfQuestions;
//
//   const IBSection(this.index, this.name, this.subunits, {this.numberOfQuestions});
// }
//
// // Enum for IB Intro section
// enum IntroUnits with UnitMixin {
//   all('', kAllUnits),
//   whatIsEconomics('1.1', 'What is economics?'),
//   howEconomistsApproachTheWorld('1.2', 'How do economists approach the world?');
//
//   @override
//   final String index;
//   @override
//   final String name;
//   @override
//   final List<UnitMixin> subunits;
//   @override
//   final int? numberOfQuestions;
//
//   const IntroUnits(this.index, this.name,
//       {this.subunits = const [], this.numberOfQuestions});
// }
//
// // Enum for IB Micro section
// enum MicroUnits with UnitMixin {
//   all('', kAllUnits),
//   demand('2.1', 'Demand'),
//   supply('2.2', 'Supply'),
//   competitiveMarketEquilibrium('2.3', 'Competitive market equilibrium'),
//   critiqueMaximizingBehavior(
//       '2.4', 'Critique of the maximizing behaviour of consumers and producers'),
//   elasticityOfDemand('2.5', 'Elasticity of demand'),
//   elasticityOfSupply('2.6', 'Elasticity of supply'),
//   roleOfGovernment('2.7', 'Role of government in microeconomics'),
//   marketFailureExternalities('2.8',
//       'Market failure—externalities and common pool or common access resources'),
//   marketFailurePublicGoods('2.9', 'Market failure—public goods'),
//   marketFailureAsymmetricInfo('2.10', 'Market failure—asymmetric information'),
//   marketFailureMarketPower('2.11', 'Market failure—market power'),
//   marketInabilityEquity('2.12', 'The market’s inability to achieve equity');
//
//   @override
//   final String index;
//   @override
//   final String name;
//   @override
//   final List<UnitMixin> subunits;
//   @override
//   final int? numberOfQuestions;
//
//   const MicroUnits(this.index, this.name,
//       {this.subunits = const [], this.numberOfQuestions});
// }
//
// // Enum for IB Macro section
// enum MacroUnits with UnitMixin {
//   all('', kAllUnits),
//   measuringEconomicActivity(
//       '3.1', 'Measuring economic activity and illustrating its variations'),
//   variationsInEconomicActivity('3.2',
//       'Variations in economic activity—aggregate demand and aggregate supply'),
//   macroeconomicObjectives('3.3', 'Macroeconomic objectives'),
//   inequalityAndPoverty('3.4', 'Economics of inequality and poverty'),
//   demandManagementMonetaryPolicy(
//       '3.5', 'Demand management (demand-side policies)—monetary policy'),
//   demandManagementFiscalPolicy('3.6', 'Demand management—fiscal policy'),
//   supplySidePolicies('3.7', 'Supply-side policies');
//
//   @override
//   final String index;
//   @override
//   final String name;
//   @override
//   final List<UnitMixin> subunits;
//   @override
//   final int? numberOfQuestions;
//
//   const MacroUnits(this.index, this.name,
//       {this.subunits = const [], this.numberOfQuestions});
// }
//
// // Enum for IB Global section
// enum GlobalUnits with UnitMixin {
//   all('', kAllUnits),
//   benefitsOfInternationalTrade('4.1', 'Benefits of international trade'),
//   typesOfTradeProtection('4.2', 'Types of trade protection'),
//   argumentsForTradeProtection(
//       '4.3', 'Arguments for and against trade control/protection'),
//   economicIntegration('4.4', 'Economic integration'),
//   exchangeRates('4.5', 'Exchange rates'),
//   balanceOfPayments('4.6', 'Balance of payments'),
//   sustainableDevelopment('4.7', 'Sustainable development'),
//   measuringDevelopment('4.8', 'Measuring development'),
//   barriersToGrowth(
//       '4.9', 'Barriers to economic growth and/or economic development'),
//   growthAndDevelopmentStrategies(
//       '4.10', 'Economic growth and/or economic development strategies');
//
//   @override
//   final String index;
//   @override
//   final String name;
//   @override
//   final List<UnitMixin> subunits;
//   @override
//   final int? numberOfQuestions;
//
//   const GlobalUnits(this.index, this.name,
//       {this.subunits = const [], this.numberOfQuestions});
// }
