import '../../../../../../diagrams/enums/diagram_enum.dart';
import '../../../../../../diagrams/enums/unit_type.dart';
import '../../../../../models/slide.dart';
import '../../../../../models/slide_content.dart';
import '../../../../../models/term.dart';
import '../../../../terms/terms.dart';

final explainWhyMonopolisticOnlyEarnNormalProfitInLR = Slide(
  subunit: Subunit.marketFailurePower,
  tags: [Tag.hl],
  question:
      'Explain why firms in monopolistic competition can only earn abnormal profits in the short run.',
  contents: [
    SlideContent.econTerms([
      EconTerm.monopolisticCompetition,
      EconTerm.barriersToEntry,
      EconTerm.abnormalProfit,
      EconTerm.normalProfit,
    ]),

    // 3. Explanation Text
    SlideContent.text('''
<ul>
  <li><b>Short run:</b> AR > AC at the profit-maximizing output. Firms earn abnormal (supernormal) profits (TR > TC).</li>
  <li><b>Low barriers to entry</b> allow new firms to enter the industry.</li>
  <li>Firm’s demand (AR) curve shifts <b>left</b> and becomes <b>more elastic</b> as market share is lost to new entrants.</li>
  <li><b>Long run:</b> AR is <b>tangent</b> to AC (TR = TC). Firms earn only <b>normal profit</b>.</li>
</ul>
<p>A restaurant earning abnormal profits attracts new entrants due to low barriers to entry. As more restaurants enter, consumers have greater choice, reducing demand and profits for existing firms.</p>
'''),
    // 4. Alert / Exam Tip
    SlideContent.alert(
      'In LR equilibrium, AR curve is tangent to AC directly above where MC = MR.',
    ),

    // 5. Diagrams
    SlideContent.diagrams([
      DiagramEnum.microMonopolisticCompetitionAbnormalProfit,
      DiagramEnum.microMonopolisticCompetitionLongRun,
    ]),
  ],
);
