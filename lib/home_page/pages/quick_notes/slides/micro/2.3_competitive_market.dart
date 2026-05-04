import '../../../../../diagrams/enums/diagram_enum.dart';
import '../../../../../diagrams/enums/unit_type.dart';
import '../../../../models/slide.dart';
import '../../../../models/slide_content.dart';
import '../../../terms/terms.dart';

final competitiveMarketSlide =
Slide(
  subunit: Subunit.competitiveMarket,
  contents: [
    SlideContent.text(
      '''
      <ul><li>When demand or supply shift it can lead to market disequilibrium (shortages and surpluses).</li></ul>
      <p>The price mechanism (via price signaling and incentives) will clear shortages and surpluses in a free-market.</p>
      '''

    ),
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
      <li><b>Price signals</b></li>
      <li><b>Incentives</b></li>
    </ul>
  </li>
  <li>
    <b>Rationing</b>
  </li>
</ul>

      '''),
    SlideContent.tip('''
      <h3>Efficiency Vs. Equity</h3>
      <ui><li>Allocative efficiency answers the questions of 'what' and 'how' to produce (efficiency) - but it doesn't answer 'for whom to produce for' - this is normative (subjective)</li></ui>
          '''),
    SlideContent.diagrams([
      DiagramEnum.microAllocativeEfficiency,
    ]),
    SlideContent.econTerms([
      EconTerm.priceSignals,
      EconTerm.incentives,
      EconTerm.priceRationing,
      EconTerm.nonPriceRationing,
      EconTerm.consumerSurplus,
      EconTerm.producerSurplus,
      EconTerm.allocativeEfficiency,

    ]),
  ],

);