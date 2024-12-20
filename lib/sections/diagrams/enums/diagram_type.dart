// // ignore_for_file: constant_identifier_names
//
// import 'package:economics_app/sections/diagrams/models/diagram_model.dart';
//
// enum DiagramType {
//   micro_PerfectCompetition_LongRun_Equilibrium,
//   micro_PerfectCompetition_AbnormalProfits,
//   micro_PerfectCompetition_EconomicLosses,
//   micro_MonopolisticCompetition_LongRun_Default,
//   micro_MonopolisticCompetition_WelfareLoss,
//   micro_MonopolisticCompetition_AbnormalProfits,
//   micro_MonopolisticCompetition_EconomicLosses,
//   micro_MonopolisticCompetition_WelfareAnalysis,
//   macro_CircularFlowOfIncome_Closed_Default,
//   macro_CircularFlowOfIncome_IncomeOutputExpenditure,
//   macro_CircularFlowOfIncome_Open,
//   macro_BusinessCycle_Default,
//   macro_PPC_Default,
//   macro_PPC_Growth,
//   macro_PPC_NegativeGrowth,
//   macro_PPC_IncreasePotential,
//   macro_PPC_DecreasePotential,
//   macro_PPC_Concave,
//   macro_PPC_Constant,
//   global_Tariffs_Standard_Default,
//   global_Tariffs_Labels,
//   global_Tariffs_Calculation,
//   global_Quotas_Standard_Default,
//   global_Quotas_Labels,
//   global_Quotas_Calculation,
//   global_ProductionSubsidies_Standard_Default,
//   global_ProductionSubsidies_Calculation,
//   global_ExportSubsidies_Standard_Default,
//   global_ExportSubsidies_Calculation,
//   global_Forex_Equilibrium_Default,
//   global_Forex_DemandIncrease,
//   global_Forex_DemandDecrease,
//   global_Forex_SupplyIncrease,
//   global_Forex_SupplyDecrease,
//   global_JCurve_CorrectingTradeDeficit_Default,
//   global_JCurve_CorrectingTradeSurplus,
// }
//
// extension DiagramExplainer on DiagramType {
//   String explanation() {
//     switch (this) {
//       case DiagramType.micro_MonopolisticCompetition_LongRun_Default:
//         return 'The demand curve in monopolistic competition slopes downwards because '
//             'firms in monopolistic competition have some market power due to product differentiation'
//             'Point a - firms are assumed to be profit maximizers, so they will produce at the quantity'
//             'where MR = MC.'
//             'Point b - the price charged will be at the point directly above MC=MR which intersects with the demand curve'
//             'In the long-run, firms produce where P = AC. Because P, D, AR are all represented by the same curve, this means AR = AC, and the firm makes normal (zero) economic profit in the long-run.';
//       case DiagramType.macro_CircularFlowOfIncome_Closed_Default:
//         return '<h3> Closed economy </h3>'
//             'This model represents a simple economy of only two economic units: '
//             '<strong>households</strong> and <strong>firms</strong>. '
//             'Households own the factors of production (labor, land, capital, enterprise), '
//             'which they sell to firms '
//             'in exchange for <strong>factor payments</strong>. '
//             'Households use factor payments to buy products (goods and services)';
//       case DiagramType.macro_CircularFlowOfIncome_IncomeOutputExpenditure:
//         return '<h3>In balance</h3>'
//             'A key idea shown in the closed circular flow of model is '
//             '<strong>income</strong> = <strong>spending</strong> = <strong>output</strong>. '
//             'Because each measure is the same, <strong>GDP</strong> '
//             'can be calculated via measuring any one of these flows. <ol>'
//             '<li>National income (is the sum of all factor payments)</li>'
//             '<li>Total output of all final goods & services produced</li>'
//             '<li>Total spending on all final goods and services</li>'
//             '</ol>';
//       case DiagramType.macro_CircularFlowOfIncome_Open:
//         return '<h3> Interdependent sectors in an economy </h3>'
//             'In the real-world, there are more economic actors than just <strong> households </strong> and '
//             '<strong> firms </strong>. '
//             'The three main sectors are <ul><li>Financial Sector</li>'
//             '<li>Government / Public Sector</li>'
//             '<li>Foreign / International Sector </li></ul>'
//             'Each of these three sectors can grow or shrink the size of the economy via leakages and injections.'
//             '<h3> Injections </h3>'
//             '<strong> Private Investment </strong> - '
//             'Firms taking out loans from banks and using these funds to invest in capital, represents an injection into the economy '
//             'On the other hand, if consumers save part of their wages in banks, this shrinks economic activity, and is a leakage.';
//
//       case DiagramType.macro_BusinessCycle_Default:
//       // TODO: Handle this case.
//       case DiagramType.macro_PPC_Default:
//       // TODO: Handle this case.
//       case DiagramType.macro_PPC_Growth:
//       // TODO: Handle this case.
//       case DiagramType.macro_PPC_NegativeGrowth:
//       // TODO: Handle this case.
//       case DiagramType.macro_PPC_IncreasePotential:
//       // TODO: Handle this case.
//       case DiagramType.macro_PPC_DecreasePotential:
//       // TODO: Handle this case.
//       case DiagramType.macro_PPC_Concave:
//       // TODO: Handle this case.
//       case DiagramType.macro_PPC_Constant:
//       // TODO: Handle this case.
//       case DiagramType.global_Tariffs_Standard_Default:
//       // TODO: Handle this case.
//       case DiagramType.global_Tariffs_Labels:
//       // TODO: Handle this case.
//       case DiagramType.global_Tariffs_Calculation:
//       // TODO: Handle this case.
//       case DiagramType.global_Quotas_Standard_Default:
//       // TODO: Handle this case.
//       case DiagramType.global_Quotas_Labels:
//       // TODO: Handle this case.
//       case DiagramType.global_Quotas_Calculation:
//       // TODO: Handle this case.
//       case DiagramType.global_ProductionSubsidies_Standard_Default:
//       // TODO: Handle this case.
//       case DiagramType.global_ProductionSubsidies_Calculation:
//       // TODO: Handle this case.
//       case DiagramType.global_ExportSubsidies_Standard_Default:
//       // TODO: Handle this case.
//       case DiagramType.global_ExportSubsidies_Calculation:
//       // TODO: Handle this case.
//       case DiagramType.global_Forex_Equilibrium_Default:
//       // TODO: Handle this case.
//       case DiagramType.global_Forex_DemandIncrease:
//       // TODO: Handle this case.
//       case DiagramType.global_Forex_DemandDecrease:
//       // TODO: Handle this case.
//       case DiagramType.global_Forex_SupplyIncrease:
//       // TODO: Handle this case.
//       case DiagramType.global_Forex_SupplyDecrease:
//       // TODO: Handle this case.
//       case DiagramType.global_JCurve_CorrectingTradeDeficit_Default:
//       // TODO: Handle this case.
//       case DiagramType.global_JCurve_CorrectingTradeSurplus:
//       // TODO: Handle this case.
//       case DiagramType.micro_MonopolisticCompetition_WelfareLoss:
//       // TODO: Handle this case.
//       case DiagramType.micro_MonopolisticCompetition_AbnormalProfits:
//       // TODO: Handle this case.
//       case DiagramType.micro_MonopolisticCompetition_EconomicLosses:
//         return '<ul><li><strong>Red</strong> = Economic losses</li></ul>'
//             '<h3>Economic Losses</h3>'
//             'Profit maximizing firm produces where MR=MC'
//             'However at this quantity (q1), AC is higher than AR'
//             'The difference betw  MacroCircularFlow(),een AC-AR (rectangle) represents the economic losses'
//             'in the short-run. However, in the long-run, some firms will exit'
//             'the industry, and the remaining firms will pick-up new customers. '
//             'This will in effect shift the demand curve right until it is at a'
//             'tangent (touches) AC. Thus, in the long-run AC=AR.';
//       case DiagramType.micro_MonopolisticCompetition_WelfareAnalysis:
//         return '<ul><li><strong>Green</strong> = Consumer surplus</li>'
//             '<li><strong>Blue</strong> = Producer surplus</li>'
//             '<li><strong>Orange</strong> = Welfare loss</li></ul>'
//             '<h3> Allocative efficiency </h3>'
//             'Monopolistic competition is not <Strong>allocatively efficient</Strong>. '
//             'This is because firms produce at Qm where MR=MC. However, '
//             'social surplus would be maximized where P=MC (same as MB=MC).';
//       case DiagramType.micro_PerfectCompetition_LongRun_Equilibrium:
//         return 'In the <strong>long-run</strong> firms in '
//             'perfect competition only '
//             'earn <strong>normal (zero) economic profit</strong>. '
//             'Firms produce where <strong>MC=MR</strong> '
//             'which is also at the bottom of the <strong>average costs (AC) </strong> curve.';
//       case DiagramType.micro_PerfectCompetition_AbnormalProfits:
//         return 'If <strong>average costs (AC)</strong> are lower than '
//             '<strong>average revenue (AR)</strong> (at the point where MR-MC), firms '
//             'in perfect competition can make <strong>abnormal (super) economic profits </strong> '
//             'in the <strong>short-run</strong>. The amount of the abnormal profit can be '
//             'calculated by working out the size of the shaded rectangle.';
//       case DiagramType.micro_PerfectCompetition_EconomicLosses:
//         return 'If <strong>average costs (AC)</strong> are higher than '
//             '<strong>average revenue (AR)</strong> (at the point where MR-MC), firms '
//             'in perfect competition make <strong>economic losses</strong> in the <strong>short-run</strong>. The amount of the losses can be '
//             'calculated by working out the size of the shaded rectangle.';
//     }
//   }
// }
//
// extension DiagramTypeTextExtension on DiagramType {
//   String toText() {
//     // Convert enum name to string and make it user-friendly
//     return toString()
//         .split('.')
//         .last // Get the part after the enum type name
//         .replaceAllMapped(
//             RegExp(r'([a-z])([A-Z])'),
//             (match) =>
//                 '${match.group(1)} ${match.group(2)}') // Insert space between camel case words
//         .replaceAll('_', ' ') // Replace underscores with spaces
//         .split(' ') // Split into words
//         .map((word) =>
//             word[0].toUpperCase() + word.substring(1)) // Capitalize each word
//         .join(' '); // Join back into a single string
//   }
// }
