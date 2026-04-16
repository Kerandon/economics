import '../../../../../diagrams/enums/diagram_enum.dart';
import '../../../../../diagrams/enums/unit_type.dart';
import '../../../../models/slide.dart';
import '../../../../models/slide_content.dart';
import '../../../../models/term.dart';
import '../../../terms/terms.dart';

final meritVsPublicGoods = Slide(
  subunit: Subunit.marketFailurePublicGoods,
  tags: [Tag.sl, Tag.p1a],
  question: 'Distinguish between public goods and merit goods.',
  contents: [
    SlideContent.econTerms([
      EconTerm.meritGood,
      EconTerm.publicGood,
      EconTerm.rivalrous,
      EconTerm.excludable,
      EconTerm.freeRiderProblem,
    ]),

    // 3. Explanation Text
    SlideContent.simpleTable(
      headers: ['Merit Good', 'Public Good'],
      data: [
        ['Excludable and Rivalrous', 'Non-excludable and Non-rivalrous'],
        ['Rejectable','Usually non-rejectable (can\'t refuse)'],
        [
          'Under-consumed in a free market (positive externalities/information failure)',
          'Complete market failure due to free rider problem',
        ],
        [
          'Provided by private & public sectors (government uses subsidies, direct provision)',
          'Provided by government (tax-funded direct provision or contracting). Uses Cost-Benefit Analysis.',
        ],
        [
          'Healthcare, Education, Vaccinations',
          'Street lighting, National Defense, Flood barriers',
        ],
      ],
    ),

    // 5. Diagrams
    SlideContent.diagrams([DiagramEnum.microPositiveConsumptionExternality]),
  ],
);
