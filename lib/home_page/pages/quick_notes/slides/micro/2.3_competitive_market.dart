import '../../../../../diagrams/enums/diagram_enum.dart';
import '../../../../../diagrams/enums/unit_type.dart';
import '../../../../models/slide.dart';
import '../../../../models/slide_content.dart';
import '../../../terms/terms.dart';

final competitiveMarketSlide = Slide(
  subunit: Subunit.competitiveMarket,
  contents: [
    SlideContent.text('''
      <ul><li>When demand or supply shift it can lead to market disequilibrium (shortages and surpluses).</li>
      <li>In a free-market, the price mechanism (via price signaling and incentives) clears shortages and surpluses.</li>
      </ul>
      '''),
    SlideContent.diagrams([
      DiagramEnum.microShortage,
      DiagramEnum.microSurplus,
    ]),
    SlideContent.text('''
<h3>Functions of the price mechanism</h3>
<ul>
  <li>
    <b>Resource allocation</b>
    <ul>
      <li>Price signals</li>
      <li>Incentives</li>
    </ul>
  </li>
  <li>
    <b>Rationing</b>
  </li>
</ul>

      '''),
    SlideContent.tip('''
      <b>Efficiency vs. Equity</b>Allocative efficiency answers the questions of 'what' and 'how' to produce (efficiency) - but it doesn't answer 'for whom to produce for' - this is normative (subjective)
          '''),
    SlideContent.diagrams([DiagramEnum.microAllocativeEfficiency]),
    SlideContent.econTerms(
      EconTerm.values
          .where((term) => term.subunit == Subunit.competitiveMarket)
          .toList(),
    ),
  ],
);
