import '../../../../../../../diagrams/enums/diagram_enum.dart';
import '../../../../../../../diagrams/enums/unit_type.dart';
import '../../../../../../models/slide.dart';
import '../../../../../../models/slide_content.dart';
import '../../../../../../models/term.dart';
import '../../../../../terms/terms.dart';

final explainWhyPerfectCompetitionOnlyEarnNormalProfitInLR = Slide(
  subunit: Subunit.marketFailurePower,
  tags: [Tag.hl],
  question:
      'Explain why firms in perfect competition can only earn abnormal profits in the short run.',

  contents: [
    SlideContent.econTerms([
      EconTerm.perfectCompetition,
      EconTerm.barriersToEntry,
      EconTerm.abnormalProfit,
      EconTerm.normalProfit,
    ]),
    SlideContent.text('''
<ul>
  <li>In the short run, abnormal profits (AR > ATC at MC = MR) attract new entrants due to <b>free entry and exit</b>.</li>
  <li>Firms have <b>perfect information</b> on profits and costs; and <b>perfect factor mobility</b>, allowing resources to be easily reallocated to the industry.</li>
  <li>New firms enter, increasing <b>market supply</b> and causing the <b>market price to fall</b> (firms are price takers).</li>
  <li>In the long run, price falls until <b>P = minimum ATC</b>, so firms earn only <b>normal profit</b>.</li>
</ul>
'''),
    SlideContent.diagrams([
      DiagramEnum.microPerfectCompetitionMarketAbnormalProfit,
      DiagramEnum.microPerfectCompetitionFirmAbnormalProfitAdjustment,
    ]),

    // 6. Diagrams (Group 2: Long Run)
    SlideContent.diagrams([
      DiagramEnum.microPerfectCompetitionMarketLongRun,
      DiagramEnum.microPerfectCompetitionFirmLongRun,
    ]),
  ],
);
