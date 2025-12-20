import 'package:economics_app/diagrams/enums/diagram_enum.dart';

import '../../../app/configs/constants.dart';
import '../../../diagrams/enums/unit_type.dart';
import '../../custom_widgets/definitions_grid.dart';
import '../../custom_widgets/evaluation_widget.dart';
import '../../models/slide.dart';
import '../../models/slide_content.dart';

List<Slide> get marketPowerSlides => [
  Slide(
    syllabusPoint: SyllabusPoint.perfectCompetitionCharacteristics,
    contents: [
      SlideContent.text('''
      <h3>Characteristics</h3>
     <ul>
  <li>Many small independent firms and many buyers</li>
  <li>Homogeneous (identical) good</li>
  <li>Firms are price takers (no market power to influence the price)</li>
    <li>No barriers to entry and exit (free entry and exit)</li>
  <li>Perfect information for sellers and buyers (on prices, costs and technology)</li>
  <li>Perfect factor mobility (labor and capital and freely and costlessly move to where most valued)</li>

  <li>Firms are profit-maximizers (produce at MC=MR)</li>
  </ul>
        <h3>Outcomes</h3>  
  <ul>

  <li>Normal profit only in the long run (minimum to keep in the industry)</li>
  <li>Allocative efficiency (P = MC)</li>
  <li>Productive efficiency (P=ATCmin) in long run</li>
    <li>Not dynamically efficient (no investment in product development)</li>
  <li>No non-price competition (no advertising)</li>
</ul>
        
        
        '''),
      SlideContent.text('''
<h3>Long-Run Equilibrium</h3>
<p>There are two diagrams: The whole market (market supply and market demand); and the individual firm.</p>
<p>The firm is a <strong>price taker</strong>: it is insignificant compared to the whole market and therefore has no market power to influence the price.</p>
In the long-run the firm can only make normal profit only (TR=TC). This means total revenue is just sufficient to meet all explicit costs (monetary payments for 
resources outside the firm such as payments for labor and capital); plus <strong>implicit costs</strong>, which is payment for 
using resources the firm already owns (e.g., payment for entrepreneurship).
</li>
</ul>
        
        '''),
      SlideContent.diagrams([
        DiagramEnum.microPerfectCompetitionMarketLongRun,
        DiagramEnum.microPerfectCompetitionFirmLongRun,
      ]),
      SlideContent.text('''
            <h3>Why abnormal profits cannot persist in the long-run</h3>
<ul>
  <li>In the short run, a firm in a perfectly competitive market can make <strong>abnormal profit</strong>.</li>
  <li>There is perfect information on all market conditions. Abnormal profits will attract new firms to enter the market.</li>
  <li>The absence of barriers to entry and perfect factor mobility allows <strong>new firms to enter</strong> the market over time.</li>
  <li>Entry of new firms <strong>increases industry supply</strong>, shifting the supply curve to the right and reducing the market price.</li>
  <li>Entry continues until <strong>price equals the minimum point of the firm's ATC</strong>.</li>
  <li>In the long-run the market reaches equilibrium, <strong>P = ATC</strong> and firms earn only <strong>normal economic profit</strong>.</li>
</ul>

        '''),
      SlideContent.diagrams([
        DiagramEnum.microPerfectCompetitionMarketAbnormalProfit,
        DiagramEnum.microPerfectCompetitionFirmAbnormalProfitAdjustment,
      ]),
      SlideContent.text('''
      <h3>Why economic losses do not persist in the long-run</h3>
<ul>
  <li>In the short run, a firm in a perfectly competitive market <strong>can</strong> make <strong>economic losses</strong>.</li>
  <li>This is because firms cannot exit the market immediately due to fixed factors of production (e.g., fixed contracts for rent and capital)</li>
  <li>Over-time loss-making firms will exit the market when they move into the long-run - when all factors of production are variable.</li>
  <li>As firms exit, the market supply curve shifts left, increasing the market price.</li>
  <li>In the long-run the market reaches equilibrium, <strong>P = ATC</strong> and the remaining firms in the market earn <strong>normal economic profit</strong>.</li>
</ul>

        '''),

      SlideContent.diagrams([
        DiagramEnum.microPerfectCompetitionMarketLoss,
        DiagramEnum.microPerfectCompetitionFirmLoss,
      ]),
      SlideContent.text('''
      <h3>Break-even and Shut-down Point</h3>
      <ul> <li><strong>Break-even Point P = ATC</strong>. When the firm earns normal economic profit. 
      This is the level of profit that will keep the firm in the long-run, ceteris paribus
      </li>
      <li>
      <strong>AFC=ATC-AVC</strong>. At any price below P1 and above P2, the firm will continue to trade in the short-run (but still exit the market in the long-run). That is because 
      TR covers all of its VC - and at least some of its FC (helping to reduce its total losses before it can exit the market).
      </li>
            <li>
      <strong>Shut-down Point P = AVC</strong>The firm will shut-down immediately when price is at or below AVC. In the short-run if the firm's revenue does not cover even its 
     variable costs it will immediately stop trading and shut-down.
      </li>
      </ul>
      '''),
      SlideContent.diagrams([DiagramEnum.microPerfectCompetitionShutdownPoint]),

      SlideContent.text('''
      <h3>Calculating Profit</h3>
      <h3> Calculating Profit (P-ATC) X Q</h3>
      <ol>      <li>Find output (Q) where MR=MC</li>
  <li>At that output calculate profit by: <strong>π = (P-ATC) X Q</strong></li>
 
  
  </ol>
 <p>As per diagram: First find the output at MR=MC (50,000 units). Then (P-ATC)XQ: (\$11 - \$10) X 50,000 = \$50,000 profit</p>
 <h3> Calculating Profit by TR and TC</h3>
 <p>
   TR = AR X Q (\$11 X 50,000 = \$550,000)</p>
  <p>TC = AC X Q (\$10 X 50,000 = \$500,000) </p> 
 <p> π = TR - TC = \$550,000 - 
  \$500,000 = \$50,000</p>
 <h3>Profit when price falls below AVC</h3>
<p>
P = AVC is the <strong>shut-down point</strong>. TR is therefore 0, and the firm's loss would be equal to its fixed cost only.</p>
<p>To calculate: choose <italic>any</italic> quantity on the horizontal axis and calculate AFC by ATC-AVC X Q (TFC = AFC X Q).</p>
<p>For example at a quantity of 100: AFC is \$9 - \$5 = \$4, therefore  π = -\$4000.</p>

      '''),
      SlideContent.diagrams([
        DiagramEnum
            .microPerfectCompetitionAbnormalProfitRevenueCostsCalculation,
        DiagramEnum.microPerfectCompetitionShutdownLossCalculation,
      ]),

      SlideContent.customWidget(
        const EvaluationWidget(
          title: 'Perfect Competition Evaluation',
          advantages: [
            'Allocatively efficient P=MC',
            'Productively Efficient P=ATCmin (long-run)',
            'Responsive to changing consumer tastes',
          ],
          limitations: [
            'Not dynamically efficient',
            'No product differentiation for consumer choice',
            'No economies of scale',
            'Ignores externalities',
            'Unrealistic model for most markets',
          ],
        ),
      ),
    ],
  ),
  ...marketPowerTerms,
];
List<Slide> get marketPowerTerms => [
  Slide(
    subunit: Subunit.marketFailurePower,
    title: kTermsGlossary,
    contents: [
      SlideContent.customWidget(
        GroupedDefinitionGrid(
          groupedItems: {
            'Market Fundamentals': [
              SlideContent.term(
                'Market power',
                'Ability of a firm to set price above marginal cost (P > MC).',
              ),
              SlideContent.term(
                'Industry',
                'Group of firms selling similar goods or services.',
              ),
              SlideContent.term(
                'Barriers to entry',
                'Factors making it difficult for new firms to enter.',
              ),
              SlideContent.term(
                'Concentration ratio',
                'Measures total market share held by largest firms.',
              ),
            ],
            'Revenue & Costs': [
              SlideContent.term(
                'Total Revenue (TR)',
                'Total income earned: TR = P x Q.',
              ),
              SlideContent.term('Average Revenue (AR)', 'TR / Q or AR = P.'),
              SlideContent.term(
                'Marginal Revenue (MR)',
                'Additional revenue from selling one more unit: ΔTR / ΔQ.',
              ),
              SlideContent.term(
                'Fixed Cost (FC)',
                'Costs that do not change with output.',
              ),
              SlideContent.term(
                'Variable Cost (VC)',
                'Costs that change with output.',
              ),
              SlideContent.term(
                'Total Cost (TC)',
                'Sum of fixed and variable costs: TC = FC + VC.',
              ),
              SlideContent.term(
                'Sunk cost',
                'A cost that cannot be recovered.',
              ),
            ],
            'Efficiency Types': [
              SlideContent.term(
                'Productive efficiency',
                'Producing at lowest possible cost (MC = ATC).',
              ),
              SlideContent.term(
                'Allocative efficiency',
                'P = MC; resources follow consumer preference.',
              ),
              SlideContent.term(
                'Dynamic efficiency',
                'Innovation and investment over time to reduce costs.',
              ),
              SlideContent.term(
                'X-efficiency',
                'Effective resource management to minimize costs.',
              ),
            ],
            'Profit & Pricing': [
              SlideContent.term(
                'Profit-maximizing point',
                'Output where MC = MR.',
              ),
              SlideContent.term(
                'Normal Profit',
                'Minimum profit required to stay in industry (TR = TC).',
              ),
              SlideContent.term(
                'Abnormal Profit',
                'Profit exceeding normal level (TR > TC).',
              ),
              SlideContent.term('Break-even price', 'Price where AR = AC.'),
              SlideContent.term('Shut-down price', 'Price where AR = AVC.'),
            ],
            'Market Structures': [
              SlideContent.term(
                'Perfect Competition',
                'Many firms, homogeneous products, no barriers.',
              ),
              SlideContent.term(
                'Monopoly',
                'Single firm, high barriers, P > MC.',
              ),
              SlideContent.term(
                'Oligopoly',
                'Few interdependent dominant firms.',
              ),
              SlideContent.term(
                'Monopolistic competition',
                'Many firms, differentiated products, low barriers.',
              ),
            ],
            'Game Theory & Strategy': [
              SlideContent.term(
                'Game theory',
                'Study of strategic decision-making.',
              ),
              SlideContent.term(
                'Nash equilibrium',
                'No player gains by changing strategy alone.',
              ),
              SlideContent.term(
                'Prisoner’s Dilemma',
                'Self-interest leads to worse mutual outcome.',
              ),
              SlideContent.term(
                'Collusive Oligopoly',
                'Firms agree to fix prices (Cartel).',
              ),
            ],
          },
        ),
      ),
    ],
  ),
];
