import 'package:economics_app/home_page/pages/paper_one_questions_page/paper_one_answer.dart';
import 'package:economics_app/home_page/pages/paper_one_questions_page/paper_question.dart';

import '../../../diagrams/enums/diagram_enum.dart';
import '../../../diagrams/enums/unit_type.dart';
import '../../models/slide_content.dart';
import '../../models/term.dart';
import '../terms/terms.dart';
import 'diagram_group.dart';
List<PaperQuestion> paperOneQuestions = [
  PaperQuestion(
    subunit: Subunit.marketFailurePower,
    tags: [Tag.hl],
    question:
    'Explain why, in monopolistic competition, abnormal profits can be made only in the short run.',

    answer: PaperOneAnswer(
      tldr: 'SHORT-RUN: abnormal profits can be made but attract new firms, who enter the market due to LOW BARRIERS. LONG-RUN: New entrants TAKE MARKET SHARE SHIFTING DEMAND (AR) for existing firms shift LEFT until AR tangent to AC (LONG RUN REACHED, NORMAL PROFIT TR=TC)',
      terms: [
        EconTerm.monopolisticCompetition,
        EconTerm.abnormalProfit,
        EconTerm.shortRun,
      ],
      explanation: [
        SlideContent.text('''
    <ul>
      <li><b>Short-Run Abnormal Profits:</b> Firms can earn abnormal profit when Average Revenue is greater than Average Cost (<b>AR > AC</b>) at the profit-maximizing level of output (<b>MC = MR</b>).</li>
      
      <li><b>Low Barriers to Entry:</b> The existence of abnormal profits signals new entrepreneurs to enter the market in the long run, which is easy to do because of low setup costs and minimal regulatory barriers.</li>
      
      <li><b>Shift in Demand:</b> As new firms enter, existing firms lose market share. The demand (AR) curve for existing firms shifts to the <b>LEFT</b> and becomes more <b>elastic</b> (flatter) because consumers now have more substitutes.</li>
      
      <li><b>Long-Run Normal Profit:</b> New firms will continue to enter until the demand (AR) curve is exactly <b>tangent</b> to the AC curve. At this new equilibrium, <b>AR = AC</b>, meaning firms earn only <b>normal profit</b> and there is no longer an incentive for new firms to enter.</li>
    </ul>

    <p><b>Real-World Example:</b> A restaurant might earn abnormal profits if a new food trend hits. However, low barriers to entry mean rival restaurants will quickly open nearby, stealing market share until prices are driven down to the normal profit level.</p> 
    
    <p><i>Note: Always draw two diagrams side-by-side—one showing the short-run abnormal profit, and a second showing the long-run normal profit.</i></p>
  '''),
      SlideContent.alert('Monopolistic competition has limited market power P > MC. Draw the curves for Monopolistic competition relatively elastic (FLAT)')
      ],
      
      // ✨ THE FIX: Pass both the diagrams and the specific explanation here!
      diagrams: DiagramGroup(
        enums: [
          DiagramEnum.microMonopolisticCompetitionAbnormalProfit,
          DiagramEnum.microMonopolisticCompetitionLongRun,
        ],
        explanation: '<b>Figure 1:</b> The short-run diagram (left) shows abnormal profit where AR > AC. As new firms enter, the AR curve shifts leftwards until it is tangent to AC, resulting in long-run normal profit (right).',
      ),
    ),
  ),
];