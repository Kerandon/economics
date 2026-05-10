import 'package:economics_app/home_page/pages/real_world_examples/real_world_examples.dart';

import '../../../../../../../diagrams/enums/diagram_enum.dart';
import '../../../../../../../diagrams/enums/unit_type.dart';
import '../../../../../../enums/tag.dart';
import '../../../../../../models/slide.dart';
import '../../../../../../models/slide_content.dart';
import '../../../../../../models/term.dart';
import '../../../../../terms/terms.dart';

final rweEvaluateSupplySidePoliciesToIncreaseGrowthLowUnemploymentLowInflation15MarkHL = Slide(
  subunit: Subunit.supplySidePolicies,
  tags: [Tag.hl, Tag.p1a],
  question:
      'Using real-world examples, evaluate the view that the most effective way to increase economic growth, reduce unemployment and maintain a low rate of inflation is by using supply-side policies.',
  contents: [
    SlideContent.econTerms([
      EconTerm.economicGrowth,
      EconTerm.supplySidePolicies,
      EconTerm.supplySidePoliciesMarketBased,
      EconTerm.supplySidePoliciesInterventionist,
    ]),

    SlideContent.simpleTable(
      title: 'Market-Based Supply-Side Policies',
      headers: ['Benefits', 'Limitations'],
      data: [
        ['Improved resource allocation and efficiency', 'Time lags'],
        [
          'Increased competition and export competitiveness',
          'Negative effects on equity / higher income inequality',
        ],
        [
          'Reduced inflationary pressures in the long term',
          'Negative externalities',
        ],
        [
          'No direct cost to government debt',
          'Vested interests may resist reforms',
        ],
        [
          '', // Blank to balance the row
          'Foreign MNCs may replace infant industries / exploit local resources',
        ],
        [
          'Reduced NRU through improved labour market flexibility',
          'Less protection / job security for lower-skilled workers',
        ],
      ],
    ),

    SlideContent.simpleTable(
      title: 'Interventionist Supply-Side Policies',
      headers: ['Strengths', 'Limitations'],
      data: [
        [
          'Targeted support for strategic / high-value industries',
          'Time lags to increase productive capacity',
        ],
        [
          'Direct job creation in the short run',
          'Increased government debt / opportunity cost',
        ],
        [
          'Reduced inflationary pressures in the long term',
          'Higher inflation in the short run due to AD increase',
        ],
        [
          'Improved equity and human capital',
          '', // Blank to balance the row
        ],
      ],
    ),

    SlideContent.diagrams([DiagramEnum.macroLRPCFallInNRU]),
    SlideContent.diagrams([
      DiagramEnum.macroSupplySidePoliciesLowInflation,
      DiagramEnum.globalPPCEconomicGrowth,
    ]),
    SlideContent.realWorldExamples(
      RealWorldExamples.values
          .where((term) => term.subunit == Subunit.supplySidePolicies)
          .toList(),
    ),
  ],
);
