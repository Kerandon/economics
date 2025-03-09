
import '../enums/syllabus_enum.dart';
import '../utils/models/syllabus_model.dart';
import '../utils/models/unit_model.dart';

final ibSyllabus = SyllabusModel(syllabus: Syllabus.ib, units: [
  UnitModel(index: '1', name: 'Introduction to Economics', subunits: [
    UnitModel(index: '1.1', name: 'What is Economics?'),
    UnitModel(index: '1.2', name: 'How do Economists Approach the World?'),
  ]),
  UnitModel(index: '2', name: 'Microeconomics', subunits: [
    UnitModel(index: '2.1', name: 'Demand (includes HL only sub-topics)'),
    UnitModel(index: '2.2', name: 'Supply (includes HL only sub-topics)'),
    UnitModel(index: '2.3', name: 'Competitive Market Equilibrium'),
    UnitModel(index: '2.4', name: 'Critique of the Maximizing Behaviour of Consumers and Producers (HL only)'),
    UnitModel(index: '2.5', name: 'Elasticity of Demand (includes HL only sub-topics)'),
    UnitModel(index: '2.6', name: 'Elasticity of Supply (includes HL only sub-topics)'),
    UnitModel(index: '2.7', name: 'Role of Government in Microeconomics (includes HL only calculation)'),
    UnitModel(index: '2.8', name: 'Market Failure—Externalities and Common Pool or Common Access Resources (includes HL only calculation)'),
    UnitModel(index: '2.9', name: 'Market Failure—Public Goods'),
    UnitModel(index: '2.10', name: 'Market Failure—Asymmetric Information (HL only)'),
    UnitModel(index: '2.11', name: 'Market Failure—Market Power (HL only)'),
    UnitModel(index: '2.12', name: 'The Market’s Inability to Achieve Equity (HL only)'),
  ]),
  UnitModel(index: '3', name: 'Macroeconomics', subunits: [
    UnitModel(index: '3.1', name: 'Measuring Economic Activity and Illustrating Its Variations'),
    UnitModel(index: '3.2', name: 'Variations in Economic Activity—Aggregate Demand and Aggregate Supply'),
    UnitModel(index: '3.3', name: 'Macroeconomic Objectives (includes HL only calculation)'),
    UnitModel(index: '3.4', name: 'Economics of Inequality and Poverty (includes HL only calculation)'),
    UnitModel(index: '3.5', name: 'Demand Management (Demand Side Policies)—Monetary Policy (includes HL only sub-topics)'),
    UnitModel(index: '3.6', name: 'Demand Management—Fiscal Policy (includes HL only sub-topics)'),
    UnitModel(index: '3.7', name: 'Supply-Side Policies'),
  ]),
  UnitModel(index: '4', name: 'The Global Economy', subunits: [
    UnitModel(index: '4.1', name: 'Benefits of International Trade (includes HL only sub-topics and calculation)'),
    UnitModel(index: '4.2', name: 'Types of Trade Protection (includes HL only calculations)'),
    UnitModel(index: '4.3', name: 'Arguments for and Against Trade Control/Protection'),
    UnitModel(index: '4.4', name: 'Economic Integration'),
    UnitModel(index: '4.5', name: 'Exchange Rates (includes HL only sub-topic)'),
    UnitModel(index: '4.6', name: 'Balance of Payments (includes HL only sub-topics)'),
    UnitModel(index: '4.7', name: 'Sustainable Development (includes HL only sub-topic)'),
    UnitModel(index: '4.8', name: 'Measuring Development'),
    UnitModel(index: '4.9', name: 'Barriers to Economic Growth and/or Economic Development'),
    UnitModel(index: '4.10', name: 'Economic Growth and/or Economic Development Strategies'),
  ]),
]);
