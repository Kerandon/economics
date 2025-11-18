import 'package:economics_app/app/configs/constants.dart';
import 'package:economics_app/diagrams/enums/diagram_bundle_enum.dart';
import 'package:economics_app/home_page/models/slide_content.dart';

import '../../../diagrams/enums/unit_type.dart';
import '../../models/slide.dart' show Slide;

List<Slide> get elasticityDemandSlides => [
  Slide(
    section: Subunit.elasticityDemand,
    title: kKeyTerms,
    contents: [
      SlideContent.term(
        'Economically Least-Developed Countries (ELDCs)',
        'Low-income countries facing severe barriers to economic development.',
      ),
      SlideContent.term(
        'Engel Curve',
        'A diagram showing how household expenditure on a good varies as income changes.',
      ),
      SlideContent.term(
        'Income Elasticity of Demand (YED)',
        'Measures the responsiveness of quantity demanded to a change in income. <strong>YED = %∆Qd ÷ %∆Y</strong>.',
      ),
      SlideContent.term(
        'Luxuries',
        'Normal goods that are desirable and prestigious, with <strong>YED > 1</strong>.',
      ),
      SlideContent.term(
        'Manufactured Good',
        'A product processed or transformed from raw materials into a finished good.',
      ),
      SlideContent.term(
        'Necessities',
        'Normal goods essential for basic living, with <strong>0 ≤ YED < 1</strong>.',
      ),
      SlideContent.term(
        'Perfectly price elastic demand (PED → ∞)',
        'Occurs when any change in price leads to an infinitely large change in quantity demanded. Consumers are extremely sensitive to price changes. Examples include generic goods with perfect substitutes.',
      ),
      SlideContent.term(
        'Perfectly price inelastic demand (PED = 0)',
        'Occurs when a change in price has no effect on quantity demanded. Examples include life-saving medicines.',
      ),
      SlideContent.term(
        'Price elastic demand (PED > 1)',
        'Occurs when a change in price leads to a proportionally larger change in quantity demanded. Examples include many consumer products and luxuries such as holidays.',
      ),
      SlideContent.term(
        'Price inelastic demand (PED < 1)',
        'Occurs when a change in price leads to a proportionally smaller change in quantity demanded. Examples include necessities like salt, gasoline, and rice.',
      ),
      SlideContent.term(
        'Price Mechanism',
        'How prices adjust to allocate resources, goods, and services in response to changes in demand and supply, through price signals, incentives, and rationing.',
      ),
      SlideContent.term(
        'Price controls',
        'Government intervention in markets by imposing a minimum (price floor) or maximum (price ceiling) price.',
      ),
      SlideContent.term(
        'Price Elasticity of Demand (PED)',
        'Measures the responsiveness of quantity demanded to changes in price. <strong>PED = %∆Qd ÷ %∆P</strong>.',
      ),
      SlideContent.term(
        'Primary commodity',
        'A good or resource from nature used in production or consumption, such as crude oil, timber, minerals, and agricultural products.',
      ),
      SlideContent.term(
        'Primary sector',
        'Involves the extraction and production of raw materials, such as farming, fishing, forestry, and mining.',
      ),
      SlideContent.term(
        'Secondary sector',
        'Involves the processing and manufacturing of raw materials into finished goods.',
      ),
      SlideContent.term(
        'Tertiary sector',
        'Involves the provision of services, including banking, healthcare, retail, and education.',
      ),
      SlideContent.term(
        'Total Revenue (TR)',
        'The total income a firm receives from selling goods and services. <strong>TR = Price × Quantity</strong>.',
      ),
      SlideContent.term(
        'Unitary price elastic demand (PED = 1)',
        'Occurs when a change in price results in an equal percentage change in quantity demanded.',
      ),

    ],
  ),
  Slide(
    title: 'Price elasticity of demand (PED) (A01, A02, A04)',
    contents: [
      SlideContent.text('''
      PED is calculated as PED = %∆Qd ÷ %∆P.
      
      
      '''),
    ],
  ),
  Slide(
    section: Subunit.elasticityDemand,
    title: 'Importance of PED for firms and government decision-making (AO3)',
    contents: [],
  ),
  Slide(
    section: Subunit.elasticityDemand,
    hl: true,
    title: 'PED and Primary Commodities and Manufactured Goods (AO3)',
    contents: [],
  ),
  Slide(
    section: Subunit.elasticityDemand,
    title: 'Income elasticity of demand (YED) (A02, A04)',
    contents: [],
  ),
  Slide(
    section: Subunit.elasticityDemand,
    title: 'Importance of income elasticity of demand (YED) (A03)',
    contents: [],
  ),
];
