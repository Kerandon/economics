import 'package:economics_app/diagrams/enums/diagram_enum.dart';
import 'package:economics_app/home_page/custom_widgets/simple_table.dart';

import '../../../app/configs/constants.dart';
import '../../../diagrams/enums/unit_type.dart';
import '../../models/slide.dart';
import '../../models/slide_content.dart';

List<Slide> get marketPowerSlides => [
  Slide(
    subunit: Subunit.marketFailurePower,
    title: kKeyTerms,
    contents: [
      SlideContent.term(
        'Market power',
        'is the ability of a firm to set price above marginal cost (P > MC).',
      ),

      SlideContent.term(
        'Industry',
        'is a group of firms selling similar goods or services.',
      ),
      SlideContent.term(
        'Barriers to entry',
        'are factors that make it difficult for new firms to enter and compete in an industry.',
      ),
      SlideContent.term(
        'Free entry',
        'is when there are no barriers for a firm to enter an industry.',
      ),
      SlideContent.term(
        'Productive efficiency',
        'refers to producing goods at the lowest possible cost (MC = ATC).',
      ),
      SlideContent.term(
        'Dynamic efficiency',
        'refers to innovation and investment over time that improve production and reduce long-run costs.',
      ),
      SlideContent.term(
        'X-efficiency',
        'refers to how effectively a firm manages internal resources to minimize average costs.',
      ),
      SlideContent.term(
        'Revenue',
        'are the payments a firm receives from selling goods or services.',
      ),
      SlideContent.term(
        'Total Revenue (TR)',
        'Total income earned by a firm: TR = P × Q.',
      ),
      SlideContent.term(
        'Average Revenue (AR)',
        'is total revenue divided by quantity sold: AR = TR / Q or AR = P.',
      ),
      SlideContent.term(
        'Marginal Revenue (MR)',
        'is the additional revenue gained from selling one more unit: MR = ΔTR / ΔQ.',
      ),
      SlideContent.term(
        'Fixed Cost (FC)',
        'are costs that do not change with output and must be paid even if output is zero.',
      ),
      SlideContent.term(
        'Variable Cost (VC)',
        'are costs that change with output and increase as production rises.',
      ),
      SlideContent.term(
        'Total Cost (TC)',
        'is the sum of fixed and variable costs: TC = FC + VC.',
      ),
      SlideContent.term(
        'Economic cost',
        'are the total costs of production including explicit (monetary) and implicit (opportunity) costs.',
      ),
      SlideContent.term(
        'Explicit costs',
        'are monetary payments for resources from outside the firm, e.g., raw materials, wages, rent.',
      ),
      SlideContent.term(
        'Implicit costs',
        'refer to the opportunity costs of using resources already owned, e.g., profit foregone from alternative uses.',
      ),
      SlideContent.term(
        'Profit',
        'Difference between total revenue and total economic cost: Profit = TR – Total Economic Cost.',
      ),
      SlideContent.term(
        'Abnormal Profit (Economic Profit)',
        'Profit exceeding the normal level when TR > TC.',
      ),
      SlideContent.term(
        'Normal Profit',
        'Minimum profit required for a firm to remain in the industry in the long run, when TR = TC.',
      ),
      SlideContent.term(
        'Negative Profit (Loss)',
        'When total revenue is less than total cost, resulting in a loss.',
      ),
      SlideContent.term(
        'Profit-maximizing point',
        'Output where marginal cost equals marginal revenue (MC = MR).',
      ),
      SlideContent.term(
        'Economies of scale',
        'Increasing output leads to lower long-run average costs.',
      ),
      SlideContent.term(
        'Diseconomies of scale',
        'When a firm grows too large and higher output increases long-run average costs.',
      ),
      SlideContent.term(
        'Perfect Competition',
        'Market with many buyers and sellers trading a homogeneous product, no barriers, perfect information, and firms earn normal profit in the long run.',
      ),
      SlideContent.term(
        'Break-even price',
        'Price at which AR = AC, allowing normal profit; no incentive for firms to enter or exit.',
      ),
      SlideContent.term(
        'Shut-down price',
        'Price at which AR = AVC; any lower price means firms cannot cover variable costs and should shut down.',
      ),
      SlideContent.term(
        'Monopoly',
        'Market with a single firm, high barriers, significant market power (P > MC), and potential for abnormal profits.',
      ),
      SlideContent.term(
        'Anti-competitive behavior',
        'Actions by firms with market power that reduce competition, e.g., price-fixing, collusion, barriers to entry.',
      ),
      SlideContent.term(
        'Revenue Maximization',
        'Firm aims to maximize total revenue (TR), occurring where MR = 0.',
      ),
      SlideContent.term(
        'Output Maximization',
        'Firm produces as much as possible without making a loss; occurs where AR = ATC, earning normal profit.',
      ),
      SlideContent.term(
        'Nationalization',
        'When the government takes ownership of a private firm or industry.',
      ),
      SlideContent.term(
        'Marginal cost pricing',
        'Government mandates price = MC, resulting in allocative efficiency.',
      ),
      SlideContent.term('Sunk cost', 'A cost that cannot be recovered.'),
      SlideContent.term(
        'Average cost pricing',
        'Government mandates price = ATC, allowing the firm to cover costs and earn normal profit.',
      ),
      SlideContent.term(
        'Monopsony',
        'Market with a single buyer for a good or resource.',
      ),
      SlideContent.term(
        'Monopolistic competition',
        'Market with many small firms selling differentiated products, low barriers, limited market power, earning normal profit long term.',
      ),
      SlideContent.term(
        'Oligopoly',
        'Market dominated by a few interdependent firms; high barriers, products may be differentiated or homogeneous, sticky prices, potential for abnormal profits.',
      ),
      SlideContent.term(
        'Non-collusive oligopoly',
        'Firms do not cooperate to fix prices but remain interdependent and strategic.',
      ),
      SlideContent.term(
        'Price war',
        'Firms continuously cut prices to gain a competitive edge, reducing industry profitability.',
      ),
      SlideContent.term(
        'Sticky prices',
        'Prices do not change easily despite market conditions such as cost changes.',
      ),
      SlideContent.term(
        'Collusive Oligopoly',
        'Few dominant firms agree to fix prices, usually illegal, limiting output to earn abnormal profits.',
      ),
      SlideContent.term(
        'Cartel',
        'Formal agreement to fix prices, usually illegal.',
      ),
      SlideContent.term(
        'Informal collusion (implicit)',
        'Firms follow a dominant firm’s pricing decisions without a formal agreement to avoid price wars.',
      ),
      SlideContent.term(
        'Concentration ratio',
        'Measures total market share held by the largest firms, indicating market power.',
      ),
      SlideContent.term(
        'Incentive to cheat',
        'When some cartel members are motivated to secretly break agreements to earn higher profits.',
      ),
      SlideContent.term(
        'Pay-off Matrix',
        'A model illustrating the conflict between self-interest and cooperation.',
      ),
      SlideContent.term(
        'Dominant strategy',
        'The best strategy for a player regardless of what others choose.',
      ),
      SlideContent.term(
        'Game theory',
        'Study of strategic decision-making where outcomes depend on choices of all participants.',
      ),
      SlideContent.term(
        'Prisoner’s Dilemma',
        'A scenario where two players are tempted to cheat for self-interest despite mutual cooperation being better.',
      ),
      SlideContent.term(
        'Nash equilibrium',
        'A situation where no player can gain by changing their strategy given the choices of others.',
      ),
      SlideContent.term(
        'Windfall tax',
        'Additional tax on firms earning supernormal profits in an industry.',
      ),
      SlideContent.term(
        'Anti-competitive legislation',
        'Laws aimed at reducing monopoly power and preventing unfair competition.',
      ),
      SlideContent.term(
        'Duopoly',
        'Market with two dominant suppliers of a good or service.',
      ),
      SlideContent.term(
        'Predatory pricing',
        'Firm temporarily lowers prices to drive competitors out of the market.',
      ),
    ],
  ),
  Slide(
    syllabusPoint: SyllabusPoint.perfectCompetitionCharacteristics,
    contents: [
      SlideContent.text('''
      <h3>Characteristics</h3>
     <ul>
  <li>Many small independent firms and many buyers</li>
  <li>Homogeneous (identical) good</li>
  <li>Firms are price takers (no market power to influence the price)</li>
    <li>No barriers to entry and exit</li>
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
<ul>
<li>
The market and firm is allocatively (P=MC) and productively efficient (P=ATCmin).
</li>
<li>
Firms make normal profit only (P=ATC). This means total revenue covers all explicit costs (monetary payments for 
resources outside the firm), plus implicit costs which is payment for the 
opportunity costs of using resources the firm already owns
(such as compensation for entrepreneurship).
</li>
</ul>
        
        '''),
      SlideContent.diagrams([
        DiagramEnum.microPerfectCompetitionMarketLongRun,
        DiagramEnum.microPerfectCompetitionFirmLongRun,
      ]),
      SlideContent.text('''
            <h1>Why abnormal profits cannot persist in the long-run</h1>
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
      <h1>Why economic losses do not persist in the long-run</h1>
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
      <h1>Break-even and Shut-down Point</h1>
      <ul> <li><strong>Break-even Point P = ATC</strong>. When the firm earns normal economic profit. 
      This is the level of profit that will keep the firm in the long-run, ceteris paribus
      </li>
      <li>
      <strong>AFC=ATC-AVC</strong>. At any price below P1 and above P2, the firm will continue to trade in the short-run (but still exit the market in the long-run). That is because 
      TR covers TVC and at least some of its FC (helping to reduce total losses before it can exit the market).
      </li>
            <li>
      <strong>Shut-down Point P = AVC</strong>The firm will shut-down immediately when price is at or below AVC. In the short-run if the firm's revenue does not cover even its 
      average variable costs it will immediately stop trading and shut-down.
      </li>
      </ul>
      '''),
      SlideContent.diagrams([DiagramEnum.microPerfectCompetitionShutdownPoint]),

      SlideContent.text('''
      <h2>Calculating Profit, Revenue and Costs</h2>
      <h3> Calculating Profit by TR and TC</h3>
      <ol>      <li>Find output (Q) where MR=MC</li>
  <li>At that output calculate profit by: <strong>π = (P-ATC) X Q</strong></li>
 
  
  </oi>
 <ul><li>MR=MC is 50,000 units. (\$11 - \$10) X 50,000 = \$50,000 profit</li>
 
 </ul>
<h3> Calculating Profit by TR and TC</h3>
 <p>
   TR = AR X Q (\$11 X 50,000 = \$550,000)</p>
  <p>TC = AC X (\$10 X 50,000 = \$500,000) </p> 
 <p> π = TR - TC = \$550,000 - 
  \$500,000 = \$50,000</p>
<p>
Note - if P < AVC, then the firm would shut-down immediately. The firm's TR = 0, and its loss would be equal to its fixed cost.
Choose <italic>any</italic> output on the diagram and calculate AFC by ATC-AVC X Q (TFC = AFC X Q).</p>
<p>E.g., at output of 100 AFC is \$9 - \$5 = \$4, therefore  π = -\$4000.</p>

      '''),
      SlideContent.diagrams([
        DiagramEnum
            .microPerfectCompetitionAbnormalProfitRevenueCostsCalculation,
        DiagramEnum.microPerfectCompetitionShutdownLossCalculation,
      ]),

      SlideContent.customWidget(
        SimpleTable(
          title: 'Perfect Competition Evaluation',
          headers: ['Advantages', 'Limitations'],
          data: [
            [
              'Allocatively Efficient P=MC'
                  'Dynamically Inefficient (lack of abnormal profits)',
              '',
            ],
          ],
        ),
      ),
    ],
  ),
];
