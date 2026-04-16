import 'package:economics_app/home_page/pages/real_world_examples/real_world_examples.dart';

import '../../../../../../diagrams/enums/diagram_enum.dart';
import '../../../../../../diagrams/enums/unit_type.dart';
import '../../../../../models/slide.dart';
import '../../../../../models/slide_content.dart';
import '../../../../../models/term.dart';
import '../../../../terms/terms.dart';

final useRWEEvaluateMonetaryPolicyReduceInflationaryGap1bHL = Slide(
  subunit: Subunit.demandManagementMonetary,
  tags: [Tag.hl, Tag.p1b],
  question:
      ' Using real-world examples, evaluate the effectiveness of monetary policy in reducing a large deflationary (recessionary) gap.',
  contents: [
    // 2. Definitions / Terms (Updated from the micro terms!)
    SlideContent.econTerms([
      EconTerm.monetaryPolicy,
      EconTerm.deflationaryGap,
      EconTerm.liquidityTrap,
      EconTerm.openMarketOperations,
      EconTerm.minimumReserveRequirement,
      EconTerm.quantitativeEasing,
      EconTerm.minimumLendingRate,
    ]),

    // 3. Explanation Text
    SlideContent.text('''
    <li>Central bank will undertake Open Market Operations (OMO) by buying bonds.</li>
    <li>Other tools are reduce Minimum Reserve Requirement (MRR) and reduce Minimum Lending Rate (MLR).</li>
    <li>Severe recession Quantitative Easing (QE) large scale purchase of bonds and other assets from commercial banks/public.</li>
    '''),
    SlideContent.simpleTable(
      headers: ['Strengths (Effectiveness)', 'Limitations (Effectiveness)'],
      data: [
        [
          'Lower interest rates increase consumption and investment',
          'Low confidence limits consumption and investment'
        ],
        [
          'Quick to implement by central bank',
          'Liquidity trap when interest rates are near zero'
        ],
        [
          'No crowding out so policy fully supports AD',
          'Becomes ineffective in deep recessions'
        ],
        [
          'Currency depreciation increases export demand',
          'Depreciation may be limited if many countries ease policy'
        ],
        [
          'Quantitative easing increases liquidity',
          'Banks may not lend (credit crunch)'
        ],
        [
          'No increase in government debt',
          'Does not solve structural unemployment'
        ],
        [
          'Independent decision-making allows fast response',
          'Risk of future inflation or asset bubbles'
        ],
      ],
    ),
    SlideContent.diagrams([
      DiagramEnum.macroMoneyMarketExpansionaryMonetaryPolicy,
    ]),
    SlideContent.realWorldExamples([
      RealWorldExamples.japanLiquidityTrap1990s,
      RealWorldExamples.eurozoneNegativeRates2014,
      RealWorldExamples.usFinancialCrisis2008,
    ]),
  ],
);
