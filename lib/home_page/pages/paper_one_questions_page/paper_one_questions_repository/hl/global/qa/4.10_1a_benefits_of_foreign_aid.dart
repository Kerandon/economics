import '../../../../../../../diagrams/enums/diagram_enum.dart';
import '../../../../../../../diagrams/enums/unit_type.dart';
import '../../../../../../enums/tag.dart';
import '../../../../../../models/slide.dart';
import '../../../../../../models/slide_content.dart';
import '../../../../../../models/term.dart';
import '../../../../../terms/terms.dart';

final explainBenefitsOfForeignAid1aHL = Slide(
  subunit: Subunit.sustainableDevelopment,
  tags: [Tag.hl, Tag.p1a],
  question:
      'Explain the benefits of foreign aid for economically less developed countries.',
  contents: [
    SlideContent.econTerms([
      EconTerm.foreignAid,
      EconTerm.economicallyLessDevelopedCountry,
      EconTerm.economicGrowth,
      EconTerm.economicDevelopment,
    ]),

    SlideContent.text('''
<ul>
  <li>Breaks poverty cycle (raises income, savings, investment)</li>
  <li>Bridges savings gap (boosts investment)</li>
  <li>Bridges foreign exchange gap (funds imports of capital goods)</li>
  <li>Promotes economic growth (AD/AS increase)</li>
  <li>Reduces income inequality</li>
  <li>Improves health and education (human capital)</li>
  <li>Develops infrastructure</li>
  <li>Supports SDGs</li>
  <li>Provides humanitarian aid in crises</li>
  <li>Encourages technology transfer</li>
</ul>
'''),
    SlideContent.diagrams([
      DiagramEnum.macroAggregateDemandInflationTradeOff,
      DiagramEnum.macroADASKeynesianSpareCapacity,
    ]),
    SlideContent.diagrams([
      DiagramEnum.macroClassicalInflationaryGapAdjustment,
    ]),
  ],
);
