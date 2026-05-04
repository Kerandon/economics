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
      EconTerm.foreignAid,
      EconTerm.economicallyLessDevelopedCountry,
    ]),

    SlideContent.simpleTable(
      title: 'Foreign Aid',
      headers: ['Benefits', 'Limitations'],
      data: [
        [
          'Improved resource allocation / efficiency\n(e.g., UK Privatisation 1980s, India 1991)',
          'Time Lags',
        ],
        [
          'Increased competition increases export competitiveness\n(e.g., China post-1978 SEZs)',
          'Negative effects on equity / higher income inequality\n(e.g., US 2017 Tax Cuts)',
        ],
        [
          'Reduce inflationary pressures in the long-term\n(e.g., US Airline Deregulation 1978)',
          'Negative externalities\n(e.g., environmental costs of deregulation)',
        ],
        [
          'No direct cost to government debt',
          'Vested interests resist\n(e.g., UK Trade Union strikes 1980s)',
        ],
        [
          '', // Blank to balance the row
          'Foreign MNCs replace infant industry / exploit local resources',
        ],
        [
          'Reduce NRU by improving labor-market flexibility\n(e.g., Germany Hartz Reforms, Spain 2012)',
          'Less protection / job security for lower-skilled workers\n(e.g., Spain 2012 temporary contracts)',
        ],
      ],
    ),

    SlideContent.simpleTable(
      title: 'Interventionist Supply-Side Policies',
      headers: ['Strengths', 'Limitations'],
      data: [
        [
          'Targeted support for strategic/high-value industries\n(e.g., US Inflation Reduction Act, S. Korea R&D)',
          'Time lags to see capacity increase\n(e.g., US Infrastructure Law delays)',
        ],
        [
          'Directly create employment in short-term\n(e.g., China Belt and Road 2013)',
          'Increased government debt / opportunity cost\n(e.g., US deficit spending)',
        ],
        [
          'Lower inflationary pressures in long-term',
          'Higher inflation in short-run due to AD shift\n(e.g., Post-pandemic inflation 2022)',
        ],
        [
          'Improve equity and human capital\n(e.g., Singapore SkillsFuture, Germany Apprenticeships)',
          '', // Blank to balance the row
        ],
      ],
    ),

    SlideContent.diagrams([DiagramEnum.macroLRPCFallInNRU]),
    SlideContent.diagrams([DiagramEnum.macroSupplySidePoliciesLowInflation]),
    SlideContent.realWorldExamples([
      RealWorldExamples.chinaReformsPost1978,
      RealWorldExamples.ukPrivatizationDeregulation1980s,
      RealWorldExamples.ukTradeUnionReform1980s,
      RealWorldExamples.postPandemicInflation2022,
      RealWorldExamples.indiaLiberalisation1991,
      RealWorldExamples.germanyHartz2000s,
      RealWorldExamples.spainLabourReform2012,
      RealWorldExamples.singaporeSkillsFuture2015,
      RealWorldExamples.chinaBRI2013,
      RealWorldExamples.usInflationReductionAct2022,
      RealWorldExamples.southKoreaIndustrialPolicy,
      RealWorldExamples.germanyApprenticeshipSystem,
    ]),
  ],
);
