
import '../enums/syllabus_enum.dart';
import '../utils/models/syllabus_model.dart';
import '../utils/models/unit_model.dart';

final igcse = SyllabusModel(syllabus: Syllabus.igcse, units: [
  UnitModel(index: '1', name: 'The Basic Economic Problem', subunits: [
    UnitModel(index: '1.1', name: 'The Nature of the Economic Problem'),
    UnitModel(index: '1.2', name: 'The Factors of Production'),
    UnitModel(index: '1.3', name: 'Opportunity Cost'),
    UnitModel(index: '1.4', name: 'Production Possibility Curve (PPC) Diagrams'),
  ]),
  UnitModel(index: '2', name: 'The Allocation of Resources', subunits: [
    UnitModel(index: '2.1', name: 'Microeconomics and Macroeconomics'),
    UnitModel(index: '2.2', name: 'The Role of Markets in Allocating Resources'),
    UnitModel(index: '2.3', name: 'Demand'),
    UnitModel(index: '2.4', name: 'Supply'),
    UnitModel(index: '2.5', name: 'Price Determination'),
    UnitModel(index: '2.6', name: 'Price Changes'),
    UnitModel(index: '2.7', name: 'Price Elasticity of Demand (PED)'),
    UnitModel(index: '2.8', name: 'Price Elasticity of Supply (PES)'),
    UnitModel(index: '2.9', name: 'Market Economic System'),
    UnitModel(index: '2.10', name: 'Market Failure'),
    UnitModel(index: '2.11', name: 'Mixed Economic System'),
  ]),
  UnitModel(index: '3', name: 'Microeconomic Decision Makers', subunits: [
    UnitModel(index: '3.1', name: 'Money and Banking'),
    UnitModel(index: '3.2', name: 'Households'),
    UnitModel(index: '3.3', name: 'Workers'),
    UnitModel(index: '3.4', name: 'Trade Unions'),
    UnitModel(index: '3.5', name: 'Firms'),
    UnitModel(index: '3.6', name: 'Firms and Production'),
    UnitModel(index: '3.7', name: 'Firms’ Costs, Revenue and Objectives'),
    UnitModel(index: '3.8', name: 'Market Structure'),
  ]),
  UnitModel(index: '4', name: 'Government and the Macroeconomy', subunits: [
    UnitModel(index: '4.1', name: 'The Role of Government'),
    UnitModel(index: '4.2', name: 'The Macroeconomic Aims of Government'),
    UnitModel(index: '4.3', name: 'Fiscal Policy'),
    UnitModel(index: '4.4', name: 'Monetary Policy'),
    UnitModel(index: '4.5', name: 'Supply-side Policy'),
    UnitModel(index: '4.6', name: 'Economic Growth'),
    UnitModel(index: '4.7', name: 'Employment and Unemployment'),
    UnitModel(index: '4.8', name: 'Inflation and Deflation'),
  ]),
  UnitModel(index: '5', name: 'Economic Development', subunits: [
    UnitModel(index: '5.1', name: 'Living Standards'),
    UnitModel(index: '5.2', name: 'Poverty'),
    UnitModel(index: '5.3', name: 'Population'),
    UnitModel(index: '5.4', name: 'Differences in Economic Development'),
  ]),
  UnitModel(index: '6', name: 'International Trade and Globalisation', subunits: [
    UnitModel(index: '6.1', name: 'International Specialisation Between Countries'),
    UnitModel(index: '6.2', name: 'Globalisation, Free Trade and Protection'),
    UnitModel(index: '6.3', name: 'Foreign Exchange Rates'),
    UnitModel(index: '6.4', name: 'Current Account of Balance of Payments'),
  ]),
]);
