import 'package:economics_app/diagrams/enums/diagram_enum.dart';
import 'package:economics_app/home_page/custom_widgets/simple_table.dart';
import 'package:flutter/cupertino.dart';

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
  Slide(
    syllabusPoint: SyllabusPoint.monopoly,
    contents: [
      SlideContent.text('''
        <h3>Characteristics</h3>
     <ul>
  <li>Single supplier of a good or service</li>
  <li>Very high barriers of entry</li>
  <li>Significant market power (sets P > MC)</li>
  </ul>
  
    '''),
      SlideContent.text('''
   <h3>Barriers to entry</h3>
   <ul>
   <li>Economies of scale</li>
   <li>Natural monopoly</li>
   <li>Brand loyalty</li>
   <li>Patents, copyrights, legal contracts</li>
   <li>Control of natural resources</li>
   <li>Network effect</li>
   <li>Anti-competitive behavior</li>
   </ul>
    '''),
      SlideContent.diagrams([
        DiagramEnum.microMonopolyAbnormalProfit,
        DiagramEnum.microMonopolyAbnormalProfitAndCosts,
      ]),
      SlideContent.text('''
      <h3>
      Monopoly Welfare Analysis
      </h3>
      <p>If a monopoly was allocatively efficient it would charge P = MC.
      However, a profit-maximizing monopoly will use its market power to set P > MC (producing where MC=MR).
      Market output falls from Qmc to Qπmax - representing an underallocation of resources compared to socially optimum quantity of P=MC (where MB=MC).
      </p><p>A welfare loss to society includes both consumer and producer surplus. However, the monopolist gains overall
       as it captures consumer surplus due to the ability to charge a higher price.
     Consumers are worse off because they pay a higher price and consume a lower quantity.
      </p>
      '''),
      SlideContent.diagrams([
        DiagramEnum.microMonopolyWelfare,
        DiagramEnum.microMonopolyWelfareAllocativelyEfficient,
      ]),
      SlideContent.text('''
      <h2>Natural Monopoly</h2>
     <p>A natural monopoly is when one firm can supply a good or service
     at a lower long-run average total cost (LRAC) than two or more firms.
     A regulated natural monopoly is unique type of monopoly in that it is socially desirable 
     due to its massive economies of scale. Natural monopolies exist for
     industries with very high sunk costs which provide an essential good or service to the public
     such as railway, supply of utilities (water, electricity, gas)
  and telecommunications.</p>
  <p>The diagram for a monopoly must show the AR=D curve cutting the LRATC while it is still falling.</p>
<p>If a monopoly is unregulated, it produces at the profit-maximizing output where <strong>MC = MR</strong>.
'''),
      SlideContent.diagrams([
        DiagramEnum.microMonopolyNatural,
        DiagramEnum.microMonopolyNaturalUnregulatedWelfare,
      ]),
      SlideContent.text('''
      Since a natural monopoly provides an essential service, government regulation is necessary. Common types of regulation include:</p>

<ul>
  <li><strong>Average-Cost Pricing (Fair-Return Pricing)</strong>: Output and price are set where <strong>P = ATC</strong>.</li>
  <li><strong>Marginal-Cost Pricing (Socially-Optimal Pricing)</strong>: Output and price are set where <strong>P = MC</strong>.</li>
  <li><strong>Price Cap (Maximum Price)</strong>: Often uses <em>CPI - X</em> regulation to control price increases.</li>
  <li><strong>Nationalization</strong>: Government ownership and control, referred to as a <em>State-Owned Enterprise (SOE)</em>.</li>
</ul>

'''),
      SlideContent.diagrams([
        DiagramEnum.microMonopolyNaturalPricingComparisons,
      ]),

      SlideContent.text('''
        <p><strong>Average Cost Pricing</strong> is known as \fair-return pricing'\ as the price (AR) covers
        all explicit costs plus a fair return (implicit costs).
        The regulator sets Price = Average Cost (P=AC).
        '''),
      SlideContent.diagrams([
        DiagramEnum.microMonopolyNaturalAverageCostPricingWelfare,
      ]),
      SlideContent.customWidget(
        const EvaluationWidget(
          title: 'Average-Cost Pricing (Fair Return Pricing) P = LRATC',
          advantages: [
            'Monopoly is not loss-making - covers all economic costs so avoids market-exit'
                'No need for government subsidy',
            'Improves allocatively efficiency by lower price and higher output',
          ],
          limitations: [
            'Some social welfare-loss remains',
            'Incentive for cost-padding (increase costs) to increase X-Inefficiency',
            'Information asymmetry for regulator on costs',
            'Risk of regulatory capture',
          ],
        ),
      ),
      SlideContent.text('''
        <p><strong>Average Cost Pricing</strong> is known as \fair-return pricing'\ as the price (AR) covers
        all explicit costs plus a fair return (implicit costs).
        The regulator sets P = LRATC. Although the market is allocatively efficient, LRATC > AR so the monopoly is loss-making.  
        '''),
      SlideContent.diagrams([
        DiagramEnum.microMonopolyNaturalMarginalCostPricing,
        DiagramEnum.microMonopolyNaturalMarginalCostPricingWelfare,
      ]),
      SlideContent.customWidget(
        const EvaluationWidget(
          title: 'Marginal Cost Pricing (Socially Optimum Pricing) P = MC',
          advantages: [
            'The market is allocatively efficient with no welfare-loss',
            'Consumers surplus is maximized by low prices and high output',
            'Improves equity. Low income groups can access essential services',
          ],
          limitations: [
            'Cost to government budget for subsidy to cover losses.',
            'Lack of abnormal profits to improve dynamic efficiency',
          ],
        ),
      ),
    ],
  ),
  Slide(
    syllabusPoint: SyllabusPoint.oligopoly,
    contents: [
      SlideContent.text('''
<h3>Characteristics</h3>
<ul>
  <li>A few large firms dominate the market</li>
  <li>High barriers to entry</li>
  <li>Interdependence (strategic decision-making)</li>
  <li>Sticky prices</li>
  <li>Product differentiation (or homogeneous products e.g., oil and steel)</li>
  <li>Non-price competition to avoid price-wars</li>
  <li>Conflicting incentives (collude vs. compete)</li>
</ul>

<h3>Types of Oligopoly</h3>
<ul>
  <li>Non-collusive (e.g. banks, supermarkets, streaming services)</li>
  <li>Collusive (cartels, e.g. OPEC)</li>
  <li>Informal collusion (e.g. price leadership)</li>
</ul>

'''),
      SlideContent.text('''
        <h2>Non-collusive oligopoly</h2>
                <h3>Interdependence, Sticky prices, Non-price Competition</h3>
        <p>Non-collusive oligopoly do not engaged in price-fixing however they are still interdependent so pricing and output decisions are still strategic</p>

        <p>Prices in oligopolistic industry tend to be rigid. This can be explained with a simplified Kinked Demand curve (Supplement Diagram)</p>
        <p>Suppose a firm produces at Pe/Qe and wants to increase total revenue (TR)</p> 
        <ul><li><strong>Raises price</strong> due to availability of substitutes consumers will switch to rivals, therefore the firm faces a relatively price-elastic demand (TR falls as the quantity effect > price effect)
        </li>
        <li><strong>Cuts price</strong>
        in the short-term the firm might gain some market-share, but rivals will quickly match, therefore the firm faces price inelastic demand (TR falls as price effect > quantity effect).
       
        </li>
        </ul>
              <p3>Price-Wars</p3>
             <p>This risks a <strong>price-war</strong> as firms seek to gain profits by competing on price, 
             however, this can result in all firms being worse-off (race to the bottom).
             Instead firms seek to avoid price-wars and compete on <strong>Non price competition</strong></p>
             
        '''),
      SlideContent.diagrams([DiagramEnum.microOligopolyKinkedDemandCurve]),
      SlideContent.text('''
    <h3>Non-price competition</h3>
    <ul>
    <li>
    Branding
    </li>
    <li>
    Loyalty Cards
    </li>
    <li>
    Advertising and Sponsorships
    </li>
    <li>
    Bundled Services
    </li>
    <li>
    Warranties
    </li>
    <li>Packaging</li>
    <li>Product features</li>
 
    </ul>
    <h3>High R&D and product innovation</h3>
    <p>Oligopolistic industry use abnormal profits to invest in product research and development (R&D) to gain a competitive advantage.
    Therefore an advantage of oligopoly is relatively high innovation leading to new technologies for society and dynamic efficiency for firms.</p>
    <h3>Homogeneous products</h3>
    <p>Some oligopolistic industries sell homogeneous goods with usually deal with the primary sector e.g., oil, steel, chemicals</p>
    '''),
      SlideContent.customWidget(
        SimpleTable(
          headers: ['Product Differentiation', 'Homogeneous Products'],
          data: [
            ['Supermarkets', 'Oil'],
            ['Electric Vehicles', 'Steel'],
            ['Streaming Services', 'Chemicals'],
          ],
        ),
      ),

      SlideContent.text('''
<h2>Collusive Oligopoly</h2>
<p>In oligopolistic markets there is a strong incentive for firms to <strong>collude</strong> and engage in <strong>price fixing</strong></p>
<p>When firms (or countries) formally collude they form a <strong>cartel</strong></p>
<h3>OPEC</h3>
<p>The most famous <strong>cartel</strong> is the 12 countries who belong to Organization for Petroleum Exporting Countries (OPEC)</p>
<p>The countries include Saudi Arabia, Iraq, Iran, UAE and agree to limit output to increase prices and maximize profit.</p>
<h3>Problems for Cartels</h3>
<ul>
<li>Usually illegal</li>
<li>Incentive to cheat and earn higher profits</li>
<li>Difficulty in how to split profits</li>
<li>Cost differences</li>
<li>Coordination problems</li>
</ul>
<p>All members of a cartel act together as a monopoly. The abnormal profit must be split between all members.</p>
'''),
      SlideContent.diagrams(
          [DiagramEnum.microMonopolyAbnormalProfit]),
      SlideContent.text('''
      <h3>Informal Collusion</h3>
      <p>Forming a cartel and engaging in price-fixing is illegal. However firms in oligopolistic markets still
      have an incentive to tacitly collude by avoiding price-competition. 
      For example, banks might tacitly collude to keep interest rates higher, or supermarkets keep the prices of groceries higher 
      and instead compete on non-price factors such as advertising and loyalty-programs.
      </p>.
      <p>The most common firm is <strong>price leadership</strong> where one dominant firm effectively sets
       the price and the others in the oligopolistic market follow (effectively becoming price takers).
       <p>Information collusion is usually illegal but it because there is no explicit communication it
        is difficult for regulators to identity and prove.</p>
      '''),



      SlideContent.text('''
  <h2>Game Theory & The Prisoner's Dilemma</h2>
  <p>The conflict between the incentive to <strong>collude</strong> and <strong>compete</strong> is modeled using a pay-off matrix for a market of two dominant firms (duopoly).</p>
<p>The below game is an example of a classic <Strong>Prisoner's Dilemma</Strong>. Both firms would be mutually better off cooperating
 to keep prices high. But due to the temptation to cheat to maximize individual profits, the likely outcome is both firms end-up worse off.</p>

'''),
      SlideContent.customWidget(
        SimpleTable(
          title: 'Pay-off Matrix: Pricing Strategy',
          topLabel: 'Firm A',
          leftLabel: 'Firm B',
          headers: ['', 'High Price', 'Low Price'],
          data: [

            [
              '<strong>High Price</strong>',
              // COLLUSION: Light Blue (Rounded Box - circles around double values look messy)
              '<span style="background-color:#ADD8E6; padding:4px 8px; border-radius:8px;">\$120m, \$120m</span>',

              // FIRM B DOMINANT: Black Circle
              '\$30m, <span style="border:1px solid black; padding:4px 6px; border-radius:50%; display:inline-block;">\$150m</span>',
            ],
            [
              '<strong>Low Price</strong>',
              // FIRM A DOMINANT: Underline
              '<span style="text-decoration:underline; font-weight:bold;">\$150m</span>, \$30m',

              // NASH EQUILIBRIUM: Light Red Background
              // Firm A underlined, Firm B Circled
              '<span style="background-color:#FFCDD2; padding:6px 10px; border-radius:12px; display:inline-block;">'
                  '<span style="text-decoration:underline; font-weight:bold;">\$50m</span>, '
                  '<span style="border:1px solid black; padding:3px 5px; border-radius:50%; display:inline-block;">\$50m</span>'
                  '</span>',
            ],
          ],


        ),
      ),
      SlideContent.text('''
<ul>
  <li><strong>Do the firms have an incentive to collude?</strong> Yes. If they form a cartel they can earn joint profits of (\$240m) by acting as a monopoly, earning \$120m each.</li>
  <li><strong>Does either form have an incentive to cheat on each other if they collude?</strong> Yes. Either firm can increase individual profit from \$120m to \$150m by undercutting the cartel price. 
  If a firm did cheat, the other would likely follow and they would end-up mutually worse both earning \$50m each.</li>
  <li><strong>If both firms do not collude, do they have a dominant strategy?</strong> Yes. Either firm would rationally price low - regardless of the actions by the other.</li>
  <li><strong>Is there a Nash Equilibrium?</strong> Yes, both firms earn \$50m each with no incentive for either to unilaterally break from this agreement.</li>
  <li><strong>Is there an incentive for informal collusion?</strong> Yes. In the real-world a dominant firm might try to break from a price-war by raising its price - 'signalling' to the other 
  firm to follow. Understanding its mutually beneficial, the other firm(s) might 'tacitly' collude and raise prices too. </li>
</ul>
'''),



      SlideContent.text('''
       <h2>Concentration-Ratio</h2>
       <p>Concentration ratio measures the market share held by the largest firms in an industry, 
       typically the top four (CR4) or five (CR5), indicating a market dominated by a few players; 
       ratios over 50%-60% signify an oligopoly, showing significant market power and reduced competition. </p>
       <p><strong>(Sales of top XX firms / industry sales) X 100</strong></p>
       <p>CR4: [(220 + 200 + 130 + 120) / (220 + 200 + 130 + 120 + 110 + 80 + 120)] X 100 = 68.37%. 
       This indicates an oligopolistic market, where competition is relatively limited.</p>
       '''),
      SlideContent.customWidget(
        SimpleTable(
          headers: [
            '<em>Firms</em>',
            'Firm A',
            'Firm B',
            'Firm C',
            'Firm D',
            'Firm E',
            'Others',
          ],
          data: [
            // The list for your headers or data row
            [
              '<strong><em>Sales (\$m)</em> </strong>',
              '220',
              '120',
              '80',
              '200',
              '110',
              '130',
            ],
          ],
        ),
      ),
      SlideContent.text('''
       <h3>Concentration-Ratio Limitations</h3>
       <ul>
  <li>Does not take into account foreign imports.</li>
  <li>Excludes substitute products outside the industry.</li>
  <li>Does not show how market share is distributed among firms.</li>
  <li>Does not show firms’ competitive behaviour in the industry.</li>
</ul>

       '''),
    ],
  ),
Slide(
  syllabusPoint: SyllabusPoint.monopolisticCompetition,
  contents: [
    SlideContent.text(
      '''
      <h3>Characteristics</h3>
<ul>
  <li>Many relatively small firms</li>
  <li>Low barriers to entry</li>
  <li>High product differentiation</li>
  <li>Limited market power</li>
</ul>
<h3>Highly Differentiated Products and Limited market power</h3>
<p>Examples of monopolistic competition include many consumer products in supermarkets (e.g., snacks, toiletries, laundry detergent) and restaurants.</p>
<p>Firms aim to make their products more price elastic by focussing on strong branding, packaging 
and bundled services to make their goods appear differentiated in a highly competitive market. </p>
<p>However, due to the availability of many close substitutes for consumers, a firm in monopolistic competition has limited market power. </p>
<p>Limited market power is shown by a relatively price elastic demand curve compared to a monopoly.</p>
<h3>Long-run equilibrium</h3>
<p>A firm in monopolistic competition can only earn <strong>normal profit</strong> in the long-run <strong>P=AC (AR=AC)</strong></p>
<p>The firm is however not allocatively efficient charging P > MC at the profit-maximizing (MC=MR) level of output, thereby leading to <strong>under-allocation of resources.</strong>.</p>
<p>Also not productively efficient as it operates with excess capacity <strong>P≠ATCmin</strong></p>
      
      ''',

    ),SlideContent.diagrams([DiagramEnum.microMonopolisticCompetitionLongRun,
    ]),
    SlideContent.diagrams([DiagramEnum.microMonopolisticCompetitionAbnormalProfit, DiagramEnum.microMonopolisticCompetitionLoss]),

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
