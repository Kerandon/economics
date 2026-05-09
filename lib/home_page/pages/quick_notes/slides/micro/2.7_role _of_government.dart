import 'package:economics_app/home_page/pages/real_world_examples/real_world_examples.dart';
import 'package:economics_app/home_page/pages/terms/terms.dart';

import '../../../../../diagrams/enums/diagram_enum.dart';
import '../../../../../diagrams/enums/unit_type.dart';
import '../../../../models/slide.dart';
import '../../../../models/slide_content.dart';

final roleOfGovernmentSlide = Slide(
  subunit: Subunit.roleOfGovernment,
  contents: [
    SlideContent.text('''
<h3>Reasons for government intervention in markets</h3>
<ul>
  <li>Influencing market outcomes in order to:
    <ul>
      <li>Earn government revenue</li>
      <li>Support firms</li>
      <li>Support households on low incomes</li>
      <li>Influence level of production</li>
      <li>Influence the level of consumption</li>
      <li>Correct market failure</li>
      <li>Promote equity</li>
    </ul>
  </li>
</ul>
'''),
    SlideContent.simpleTable(
      title: 'Types of Government Intervention',
      headers: ['Type', 'Pros', 'Cons'],
      data: [
        [
          'Market based (taxes, subsidies)',
          'Efficient; flexible; raises revenue',
          'Regressive taxes (inequity); measurement, unpopular, inflationary',
        ],
        [
          'Command and control (regulations, bans)',
          'Direct; clear; effective',
          'Inflexible; costly enforcement; inefficiency',
        ],
        [
          'Price Controls (price floor, price ceiling)',
          'Protects consumers (price ceiling on rent, necessities). price floor (minimum wage)',
          'Market disequilibrium; shortages/surpluses; black markets; welfare loss, ',
        ],
        [
          'Education',
          'Improves awareness; long-term change',
          'Slow; costly; uncertain impact',
        ],
        [
          'Nudges',
          'Maintains choice; low cost',
          'Limited impact; weak enforcement',
        ],
      ],
    ),
    SlideContent.simpleTable(
      title: 'Price Ceiling vs Price Subsidy (Supporting Low-Income Consumers)',
      headers: ['Policy', 'Pros', 'Cons'],
      data: [
        [
          'Price ceiling',
          'Makes goods affordable, protects low-income consumers',
          'Shortages, black markets, reduced quality',
        ],
        [
          'Subsidy',
          'Increases affordability without shortages, supports firms supply',
          'Costly to government, potential inefficiency/misallocation',
        ],
      ],
    ),
    SlideContent.simpleTable(
      title: 'Indirect Tax vs Regulation',
      headers: ['Policy', 'Pros', 'Cons'],
      data: [
        [
          'Indirect tax',
          'Raises revenue, flexible, reduces consumption via price',
          'Regressive, depends on PED, may not fully eliminate consumption',
        ],
        [
          'Regulation',
          'Direct control, can ban harmful goods, clear rules',
          'Hard to enforce, inflexible, may create black markets',
        ],
      ],
    ),
    SlideContent.simpleTable(
      title:
          'Price Ceiling (Maximum Price) Evaluation (Rent, Medicines, Gasoline)',
      headers: ['Advantages', 'Limitations'],
      data: [
        [
          'Lower prices for low-income consumers',
          'Shortages (Qs < Qd), some consumers miss out',
        ],
        ['Prevents price gouging', 'Black markets (parallel markets)'],
        [
          'Improves affordability of necessities',
          'Reduced incentive for producers to supply',
        ],
        ['', 'Misallocation of resources (welfare loss)'],
      ],
    ),
    SlideContent.diagrams([DiagramEnum.microPriceCeiling]),
    SlideContent.simpleTable(
      title: 'Agricultural Price Floor Evaluation',
      headers: ['Advantages', 'Limitations'],
      data: [
        [
          'Higher farmer income (more producer surplus)',
          'Surpluses (Qs > Qd) build up',
        ],
        [
          'Food security via buffer stock storage',
          'Higher prices for consumers (Qd contracts)',
        ],
        [
          'Can stabilise incomes in volatile markets',
          'High government cost (buying/storage)',
        ],
        ['—', 'Inefficient allocation (overproduction, MB < MC)'],
        ['—', 'Encourages dependence, reduces competitiveness'],
        ['—', 'Trade disputes from exported surplus'],
      ],
    ),
    SlideContent.diagrams([DiagramEnum.microAgriculturalPriceFloor]),
    SlideContent.simpleTable(
      title: 'Minimum Wage Evaluation',
      headers: ['Advantages (Equity)', 'Limitations (Efficiency)'],
      data: [
        ['Higher income for low-paid workers', 'Unemployment (QsL > QdL)'],
        [
          'Reduces exploitation of low-skilled labour',
          'Higher firm costs, possible inflation',
        ],
        [
          'Improves income equality',
          'Reduced non-wage benefits (e.g. holidays)',
        ],
        [
          'Can boost productivity (efficiency wage)',
          'Misallocation of labour resources',
        ],
        ['—', 'Growth of informal/black-market employment'],
      ],
    ),
    SlideContent.diagrams([
      DiagramEnum.microMinimumWageInelasticDemandAndSupply,
    ]),
    SlideContent.econTerms(
      EconTerm.values
          .where((term) => term.subunit == Subunit.roleOfGovernment)
          .toList(),
    ),
    SlideContent.realWorldExamples(
      RealWorldExamples.values
          .where((term) => term.subunit == Subunit.roleOfGovernment)
          .toList(),
    ),
  ],
);
