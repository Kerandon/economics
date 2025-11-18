import 'package:economics_app/app/configs/constants.dart';
import 'package:economics_app/diagrams/enums/diagram_bundle_enum.dart';
import 'package:economics_app/home_page/models/slide_content.dart';

import '../../../diagrams/enums/unit_type.dart';
import '../../models/slide.dart' show Slide;
import '../../models/term.dart';

List<Slide> get elasticityDemandSlides => [
  Slide(
    section: Subunit.elasticityDemand,
    title: kKeyTerms,
    contents: [
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
        'Normal goods essential for basic living, with <strong>0 < YED < 1</strong>.',
      ),
      SlideContent.term(
        'Perfectly price elastic demand (PED = infinity)',
        'Consumers are extremely sensitive to price. Any increase in price leads causes demand to fall to zero. e.g., generic goods with perfect substitutes.',
      ),
      SlideContent.term(
        'Perfectly price inelastic demand (PED = 0)',
        'Occurs when a change in price has no effect on quantity demanded. E.g., life-saving medicines.',
      ),
      SlideContent.term(
        'Price elastic demand (PED > 1)',
        'Occurs when a change in price leads to a proportionally larger change in quantity demanded. E.g., many consumer products and luxuries such as holidays.',
      ),
      SlideContent.term(
        'Price inelastic demand (PED < 1)',
        'Occurs when a change in price leads to a proportionally smaller change in quantity demanded. E.g., salt, gasoline, and rice.',
      ),

      SlideContent.term(
        'Unitary price elastic demand (PED = 1)',
        'Occurs when a change in price results in an equal percentage change in quantity demanded.',
      ),
      SlideContent.term(
        'Price Elasticity of Demand (PED)',
        'Measures the responsiveness of quantity demanded to changes in price. <strong>PED = %∆Qd ÷ %∆P</strong>.',
      ),
      SlideContent.term(
        tag: Tag.hl,
        'Primary commodity',
        'A good or resource from nature used in production or consumption, such as crude oil, timber, minerals, and agricultural products.',
      ),
      SlideContent.term(
        tag: Tag.hl,
        'Primary sector',
        'Involves the extraction and production of raw materials, such as farming, fishing, forestry, and mining.',
      ),
      SlideContent.term(
        tag: Tag.hl,
        'Secondary sector',
        'Involves the processing and manufacturing of raw materials into finished goods.',
      ),
      SlideContent.term(
        tag: Tag.hl,
        'Tertiary sector',
        'Involves the provision of services, including banking, healthcare, retail, and education.',
      ),
      SlideContent.term(
        tag: Tag.hl,
        'Total Revenue (TR)',
        'The total income a firm receives from selling goods and services. <strong>TR = Price × Quantity</strong>.',
      ),

      SlideContent.term(
        tag: Tag.hl,
        'Economically Least-Developed Countries (ELDCs)',
        'Low-income countries facing severe barriers to economic development.',
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
