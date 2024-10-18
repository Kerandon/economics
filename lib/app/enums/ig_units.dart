// // Enum for IGCSE Sections
// import '../configs/constants.dart';
// import '../utils/mixins/unit_mixin.dart';
//
// enum IGSection with UnitMixin {
//   all('', kAllSections, subunits: [
//     ...IGBasicProblemUnits.values,
//     ...IGAllocationOfResourcesUnits.values,
//     ...IGMicroDecisionMakersUnits.values,
//     ...IGMacroEconomyUnits.values,
//     ...IGEconomicDevelopmentUnits.values,
//     ...IGInternationalTradeUnits.values,
//   ]),
//   basicProblem('1', 'The Basic Economic Problem',
//       subunits: IGBasicProblemUnits.values),
//   allocationOfResources('2', 'The Allocation of Resources',
//       subunits: IGAllocationOfResourcesUnits.values),
//   microDecisionMakers('3', 'Microeconomic Decision-Makers',
//       subunits: IGMicroDecisionMakersUnits.values),
//   macroEconomy('4', 'Government and the Macroeconomy',
//       subunits: IGMacroEconomyUnits.values),
//   economicDevelopment('5', 'Economic Development',
//       subunits: IGEconomicDevelopmentUnits.values),
//   internationalTrade('6', 'International Trade and Globalisation',
//       subunits: IGInternationalTradeUnits.values);
//
//   @override
//   final String index; // Section number
//   @override
//   final String name; // Section name
//   @override
//   final List<UnitMixin> subunits; // Subunits (list of units)
//   @override
//   final int? numberOfQuestions;
//
//   const IGSection(this.index, this.name,
//       {this.subunits = const [], this.numberOfQuestions});
// }
//
// // Enum for IGCSE Basic Economic Problem section
// enum IGBasicProblemUnits with UnitMixin {
//   all('', kAllUnits),
//   natureOfProblem('1.1', 'The nature of the basic economic problem'),
//   factorsOfProduction('1.2', 'Factors of production'),
//   opportunityCost('1.3', 'Opportunity cost'),
//   ppcDiagrams('1.4', 'Production possibility curve (PPC) diagrams');
//
//   @override
//   final String index;
//   @override
//   final String name;
//   @override
//   final List<UnitMixin> subunits; // No further subunits for basic problem units
//   @override
//   final int? numberOfQuestions;
//
//   const IGBasicProblemUnits(this.index, this.name,
//       {this.subunits = const [], this.numberOfQuestions});
// }
//
// // Enum for IGCSE Allocation of Resources section
// enum IGAllocationOfResourcesUnits with UnitMixin {
//   all('', kAllUnits),
//   roleOfMarkets('2.1', 'The role of markets in allocating resources'),
//   demand('2.2', 'Demand'),
//   supply('2.3', 'Supply'),
//   priceDetermination('2.4', 'Price determination'),
//   priceChanges('2.5', 'Price changes'),
//   ped('2.6', 'Price elasticity of demand (PED)'),
//   pes('2.7', 'Price elasticity of supply (PES)'),
//   marketSystem('2.8', 'Market economic system'),
//   marketFailure('2.9', 'Market failure'),
//   mixedEconomicSystem('2.10', 'Mixed economic system');
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
//   const IGAllocationOfResourcesUnits(
//     this.index,
//     this.name, {
//     this.subunits = const [],
//     this.numberOfQuestions,
//   });
// }
//
// // Enum for IGCSE Microeconomic Decision Makers section
// enum IGMicroDecisionMakersUnits with UnitMixin {
//   all('', kAllUnits),
//   moneyAndBanking('3.1', 'Money and banking'),
//   households('3.2', 'Households'),
//   workers('3.3', 'Workers'),
//   firms('3.4', 'Firms'),
//   firmsAndProduction('3.5', 'Firms and production'),
//   firmsCostsRevenueObjectives('3.6', 'Firms’ costs, revenue and objectives'),
//   typesOfMarkets('3.7', 'Types of markets');
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
//   const IGMicroDecisionMakersUnits(
//     this.index,
//     this.name, {
//     this.subunits = const [],
//     this.numberOfQuestions,
//   });
// }
//
// // Enum for IGCSE Macro Economy section
// enum IGMacroEconomyUnits with UnitMixin {
//   all('', kAllUnits),
//   governmentIntervention('4.1', 'Government macroeconomic intervention'),
//   fiscalPolicy('4.2', 'Fiscal policy'),
//   monetaryPolicy('4.3', 'Monetary policy'),
//   supplySidePolicy('4.4', 'Supply-side policy'),
//   economicGrowth('4.5', 'Economic growth'),
//   employment('4.6', 'Employment and unemployment'),
//   inflation('4.7', 'Inflation');
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
//   const IGMacroEconomyUnits(
//     this.index,
//     this.name, {
//     this.subunits = const [],
//     this.numberOfQuestions,
//   });
// }
//
// // Enum for IGCSE Economic Development section
// enum IGEconomicDevelopmentUnits with UnitMixin {
//   all('', kAllUnits),
//   livingStandards('5.1', 'Living standards'),
//   poverty('5.2', 'Poverty'),
//   population('5.3', 'Population'),
//   differencesInDevelopment(
//       '5.4', 'Differences in economic development between countries');
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
//   const IGEconomicDevelopmentUnits(
//     this.index,
//     this.name, {
//     this.subunits = const [],
//     this.numberOfQuestions,
//   });
// }
//
// // Enum for IGCSE International Trade section
// enum IGInternationalTradeUnits with UnitMixin {
//   all('', kAllUnits),
//   specialisationFreeTrade('6.1', 'Specialisation and free trade'),
//   globalisationTradeRestrictions('6.2', 'Globalisation and trade restrictions'),
//   foreignExchangeRates('6.3', 'Foreign exchange rates'),
//   currentAccount('6.4', 'Current account of the balance of payments');
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
//   const IGInternationalTradeUnits(
//     this.index,
//     this.name, {
//     this.subunits = const [],
//     this.numberOfQuestions,
//   });
// }
