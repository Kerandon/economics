import 'package:economics_app/diagrams/enums/diagram_enum.dart';
import 'package:economics_app/home_page/custom_widgets/simple_table.dart';
import 'package:flutter/cupertino.dart';

import '../../../app/configs/constants.dart';
import '../../../diagrams/custom_paint/painter_constants.dart';
import '../../../diagrams/enums/unit_type.dart';
import '../../custom_widgets/definitions_grid.dart';
import '../../custom_widgets/evaluation_widget.dart';
import '../../models/slide.dart';
import '../../models/slide_content.dart';

List<Slide> get marketPowerSlides => [
  Slide(
    syllabusPoint: SyllabusPoint.perfectCompetitionCharacteristics,
    contents: [
      /// *********************************************************************************************************************
      /// Perfect Competition

      SlideContent.text('''
<h3>Characteristics</h3>
<ul style="list-style: none; padding-left: 5px;">
  <li><strong>Many small firms</strong> — each firm is too small to influence market price</li>
  <li><strong>Homogeneous product</strong> — no product differentiation</li>
  <li><strong>Price takers</strong> — firms accept the market-determined price</li>
  <li><strong>Free entry and exit</strong> — no barriers to entry or exit</li>
  <li><strong>Perfect information</strong> — buyers and sellers know prices, costs, and technology</li>
  <li><strong>Perfect factor mobility</strong> — labour and capital can move freely</li>
  <li><strong>Profit maximisation</strong> — firms produce where MR = MC</li>
</ul>

<h3>Outcomes</h3>
<ul>
  <li>Normal profit only in the long run</li>
  <li>Allocative efficiency (P = MC)</li>
  <li>Productive efficiency in the long run (P = ATC<sub>min</sub>)</li>
  <li>Little or no non-price competition (e.g. no advertising)</li>
  <li>Limited dynamic efficiency due to lack of abnormal profits</li>
</ul>
'''),

      SlideContent.text('''
<h2>Long-Run Equilibrium</h2>
<p>Firms are <strong>price takers</strong> because each firm is insignificant relative to the market.</p>

<p>In the long run, firms earn <strong>normal economic profit</strong> only, where:</p>
<ul>
  <li><strong>P = ATC</strong></li>
  <li><strong>TR = TC</strong></li>
</ul>

<p>Normal profit includes both:</p>
<ul>
  <li><strong>Explicit costs</strong> (wages, rent, interest)</li>
  <li><strong>Implicit costs</strong> (entrepreneurship and owned resources)</li>
</ul>
'''),

      SlideContent.diagrams([
        DiagramEnum.microPerfectCompetitionMarketLongRun,
        DiagramEnum.microPerfectCompetitionFirmLongRun,
      ]),

      SlideContent.text('''
<h3>Why abnormal profits do not persist in the long run</h3>
<ul>
  <li>Firms may earn abnormal profit in the short run.</li>
  <li>Perfect information makes abnormal profits visible.</li>
  <li>Free entry allows new firms to enter the market.</li>
  <li>Market supply increases, causing price to fall.</li>
  <li>Entry continues until <strong>P = ATC<sub>min</sub></strong>.</li>
  <li>In the long run, firms earn only <strong>normal economic profit</strong>.</li>
</ul>
'''),

      SlideContent.diagrams([
        DiagramEnum.microPerfectCompetitionMarketAbnormalProfit,
        DiagramEnum.microPerfectCompetitionFirmAbnormalProfitAdjustment,
      ]),

      SlideContent.text('''
<h3>Why economic losses do not persist in the long run</h3>
<ul>
  <li>Firms may make losses in the short run.</li>
  <li>Fixed factors prevent immediate exit.</li>
  <li>In the long run, all factors become variable.</li>
  <li>Loss-making firms exit the market.</li>
  <li>Market supply falls, causing price to rise.</li>
  <li>Long-run equilibrium is restored at <strong>P = ATC</strong>.</li>
</ul>
'''),

      SlideContent.diagrams([
        DiagramEnum.microPerfectCompetitionMarketLoss,
        DiagramEnum.microPerfectCompetitionFirmLoss,
      ]),

      SlideContent.text('''
<h3>Break-even and Shut-down Points</h3>
<ul>
  <li><strong>Break-even point: P = ATC</strong> — firm earns normal profit.</li>
  <li><strong>Shut-down point: P = AVC</strong> — firm stops production in the short run.</li>
  <li>If <strong>AVC &lt; P &lt; ATC</strong>, the firm operates in the short run to minimise losses.</li>
</ul>
'''),

      SlideContent.diagrams([DiagramEnum.microPerfectCompetitionShutdownPoint]),

      SlideContent.text('''
<h3>Calculating Profit</h3>

<h4>Method 1: Using (P − ATC) × Q</h4>
<ol>
  <li>Find output where <strong>MR = MC</strong>.</li>
  <li>Calculate profit: <strong>π = (P − ATC) × Q</strong>.</li>
</ol>

<h4>Method 2: Using TR and TC</h4>
<p><strong>TR = AR × Q</strong></p>
<p><strong>TC = ATC × Q</strong></p>
<p><strong>π = TR − TC</strong></p>

<h4>Losses at the Shut-down Point</h4>
<p>When <strong>P = AVC</strong>, the firm shuts down and losses equal <strong>fixed costs only</strong>.</p>
'''),

      SlideContent.diagrams([
        DiagramEnum
            .microPerfectCompetitionAbnormalProfitRevenueCostsCalculation,
        DiagramEnum.microPerfectCompetitionShutdownLossCalculation,
      ]),

      SlideContent.customWidget(
        EvaluationWidget(
          title: 'Perfect Competition: Evaluation',
          leftTitle: kAdvantages,
          rightTitle: kLimitations,
          leftItems: [
            'Allocative efficiency (P = MC)',
            'Productive efficiency in the long run',
            'Highly responsive to changes in consumer demand',
          ],
          rightItems: [
            'Limited dynamic efficiency',
            'No product differentiation',
            'Few economies of scale',
            'Externalities ignored',
            'Rare in the real world',
          ],
        ),
      ),
    ],
  ),

  /// *********************************************************************************************************************
  /// Monopoly
  Slide(
    syllabusPoint: SyllabusPoint.monopoly,
    contents: [


      SlideContent.text('''
<h3>Characteristics</h3>
<ul>
  <li>Single firm supplying the entire market</li>
  <li>High barriers to entry prevent competition</li>
  <li>Price maker with significant market power</li>
  <li>Profit maximisation where <strong>MR = MC</strong></li>
</ul>
'''),

      SlideContent.text('''
<h3>Barriers to Entry</h3>
<ul>
  <li>Economies of scale</li>
  <li>Natural monopoly (falling LRATC)</li>
  <li>Legal barriers (patents, copyrights, licences)</li>
  <li>Brand loyalty</li>
  <li>Control of key resources</li>
  <li>Network effects</li>
  <li>Anti-competitive behaviour</li>
</ul>
'''),

      SlideContent.diagrams([
        DiagramEnum.microMonopolyAbnormalProfit,
        DiagramEnum.microMonopolyAbnormalProfitAndCosts,
      ]),

      SlideContent.text('''
<h3>Monopoly Welfare Analysis</h3>
<p>A profit-maximising monopoly produces where <strong>MR = MC</strong> and charges a price on the demand (AR) curve.</p>

<p>This results in <strong>P &gt; MC</strong>, meaning the monopoly is allocatively inefficient.</p>

<p>Compared with the socially optimal outcome (P = MC), output is lower and price is higher, creating a
<strong>deadweight welfare loss</strong>.</p>

<p>Consumer surplus falls, producer surplus rises, but total social welfare decreases.</p>
'''),

      SlideContent.diagrams([
        DiagramEnum.microMonopolyWelfare,
        DiagramEnum.microMonopolyWelfareAllocativelyEfficient,
      ]),

      SlideContent.text('''
<h2>Natural Monopoly</h2>
<p>A natural monopoly exists when one firm can supply the entire market at a lower
<strong>long-run average total cost (LRATC)</strong> than two or more firms.</p>

<p>This occurs due to very large economies of scale and high sunk costs.</p>

<p>Examples include utilities such as water, electricity, railways, and telecommunications.</p>

<p>In a natural monopoly diagram, the demand (AR) curve intersects LRATC while it is still falling.</p>

<p>If unregulated, the monopoly produces where <strong>MR = MC</strong>, resulting in high prices and welfare loss.</p>
'''),

      SlideContent.diagrams([
        DiagramEnum.microMonopolyNatural,
        DiagramEnum.microMonopolyNaturalUnregulatedWelfare,
      ]),

      SlideContent.text('''
<h3>Regulation of Natural Monopolies</h3>
<ul>
  <li><strong>Average Cost Pricing (Fair-Return Pricing)</strong>: P = ATC</li>
  <li><strong>Marginal Cost Pricing (Socially Optimal Pricing)</strong>: P = MC</li>
  <li><strong>Price Cap Regulation</strong>: CPI − X</li>
  <li><strong>Nationalisation</strong>: Government ownership (SOE)</li>
</ul>
'''),

      SlideContent.diagrams([
        DiagramEnum.microMonopolyNaturalPricingComparisons,
      ]),

      SlideContent.text('''
<p><strong>Average Cost Pricing</strong> (fair-return pricing) sets <strong>P = ATC</strong>.</p>

<p>The firm earns normal profit, covers all economic costs, and avoids exit.</p>

<p>Allocative efficiency improves compared to an unregulated monopoly, but
<strong>P &gt; MC</strong> means some welfare loss remains.</p>
'''),

      SlideContent.diagrams([
        DiagramEnum.microMonopolyNaturalAverageCostPricingWelfare,
      ]),

      SlideContent.customWidget(
        const EvaluationWidget(
          title: 'Average-Cost Pricing (Fair-Return Pricing)',
          leftTitle: kAdvantages,
          rightTitle: kLimitations,
          leftItems: [
            'Covers all economic costs (normal profit)',
            'No need for government subsidy',
            'Lower prices and higher output than unregulated monopoly',
          ],
          rightItems: [
            'Allocative inefficiency remains',
            'X-inefficiency and cost-padding risk',
            'Information asymmetry for regulators',
            'Risk of regulatory capture',
          ],
        ),
      ),

      SlideContent.text('''
<p><strong>Marginal Cost Pricing</strong> sets <strong>P = MC</strong>, achieving allocative efficiency.</p>

<p>However, because <strong>LRATC &gt; MC</strong>, the monopoly makes losses and requires a government subsidy.</p>
'''),

      SlideContent.diagrams([
        DiagramEnum.microMonopolyNaturalMarginalCostPricing,
        DiagramEnum.microMonopolyNaturalMarginalCostPricingWelfare,
      ]),

      SlideContent.customWidget(
        const EvaluationWidget(
          title: 'Marginal Cost Pricing (Socially Optimal Pricing)',
          leftTitle: kAdvantages,
          rightTitle: kLimitations,
          leftItems: [
            'Allocatively efficient (P = MC)',
            'Maximises consumer surplus',
            'Improves equity for essential services',
          ],
          rightItems: [
            'Requires government subsidy',
            'Budgetary cost to taxpayers',
            'Weak incentives for cost reduction and innovation',
          ],
        ),
      ),
    ],
  ),

  /// *********************************************************************************************************************
  /// Oligopoly
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
      // SlideContent.customWidget(
      //   SimpleTable(
      //     headers: ['Product Differentiation', 'Homogeneous Products'],
      //     data: [
      //       ['Supermarkets', 'Oil'],
      //       ['Electric Vehicles', 'Steel'],
      //       ['Streaming Services', 'Chemicals'],
      //     ],
      //   ),
      // ),

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
      SlideContent.diagrams([DiagramEnum.microMonopolyAbnormalProfit]),
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

  /// *********************************************************************************************************************
  /// Monopolistic Competition
  Slide(
    syllabusPoint: SyllabusPoint.monopolisticCompetition,
    contents: [

      SlideContent.text('''
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
<p>Like a firm in perfect competition, a firm in monopolistic competition can only earn <strong>normal profit</strong> in the long-run <strong>P=AC (TR = Explicit + Implicit Costs)</strong></p>
<p>Unlike a firm in perfect competition, a firm in monopolistic competition is not allocatively efficient charging P > MC at the profit-maximizing (MC=MR) level of output, thereby leading to <strong>under-allocation of resources.</strong>.</p>
<p>Also not productively efficient (excess capacity) as it operates with excess capacity (e.g., a cafe prefers to focus on production differentiation such as the quality of the coffee and creating a relaxing environment, rather than just sell coffees at the lowest possible cost). <strong>P≠ATCmin</strong></p>

      '''),
      SlideContent.diagrams([DiagramEnum.microMonopolisticCompetitionLongRun]),
      SlideContent.text('''
      <h2>Abnormal Profit (L) to Long-Run Equilibrium (R)</h2>
      <ul><li>In the short-run a firm can make abnormal profits.</li>
      <li>Other firms will enter the market due to low barriers to entry</li>
      <li>Some market share of existing firms will be lost to new entrants (increased substitutes).</li>
      <li>Demand (AR) will shift <strong>left</strong> until it is at a tangent to ATC (P=AC) (Demand will also become relatively more price elastic due to higher competition).</li>
      </ul>
      '''),
      SlideContent.diagrams([
        DiagramEnum.microMonopolisticCompetitionAbnormalProfit,
        DiagramEnum.microMonopolisticCompetitionAbnormalProfitShift,
      ]),
      SlideContent.text('''
            <h2>Loss (L) to Long-Run Equilibrium (R)</h2>
      <ul><li>In the short-run a firm can make economic losses.</li>
      <li>Other firms will exit the market as they move into the long-run (all inputs are variable).</li>
      <li>Market share of existing firms will be increase (decreased substitutes).</li>
      <li>Demand (AR) will shift <strong>right</strong> until it is at a tangent to ATC (P=AC) (Demand will also become relatively more price inelastic due to less competition).</li>
      </ul>
      '''),
      SlideContent.diagrams([
        DiagramEnum.microMonopolisticCompetitionLoss,
        DiagramEnum.microMonopolisticCompetitionLossShift,
      ]),
      SlideContent.text('''
        <h3>Efficiency Vs. Product Variety</h3>
        <p>Monopolistic competition are in industries exemplified by variety and a range of choice for consumers.
        For example, restaurants focus on making their restaurant appear unique to increase market-power (Cantonese, Italian, Upscale Dining, Fusion, etc.).
        Therefore, it can be argued that a trade-off for economic efficiency
         found in perfect competition, is greater product variety which consumers also place value-on.
         </p>
        '''),
      // SlideContent.customWidget(
      //   const EvaluationWidget(
      //     title: 'Perfect Competition Vs. Monopolistic Competition',
      //     leftTitle: 'Similar to Perfect Competition',
      //     rightTitle: 'Different from Perfect Competition',
      //     leftItems: [
      //       'Normal Profit (Long-Run) P=AC',
      //       'Many Small Firms',
      //       'Low Barriers to Entry',
      //       'Profit-Maximizers',
      //     ],
      //     rightItems: [
      //       'Some market power P > MC',
      //       'Allocatively inefficient',
      //       'High Product Variety',
      //       'Productively Inefficient (excess capacity)',
      //     ],
      //   ),
      // ),
    ],
  ),

  /// *********************************************************************************************************************
  /// Advantages and Risks of Market Power
  Slide(
    syllabusPoint: SyllabusPoint.advantagesAndRisksOfMarketPower,
    contents: [
      SlideContent.customWidget(
        const EvaluationWidget(
          title: 'Evaluation of Market Power',
          leftTitle: kAdvantages,
          rightTitle: kLimitations,
          leftItems: [
            'Economies of Scale - MNCs are more competitive internationally',
            'Abnormal Profits - invested in innovation (dynamic efficiency)',
            'Natural Monopoly - lower LRAC passed on to consumers (when regulated)',
          ],
          rightItems: [
            'Allocative inefficiency P > MC (Welfare Loss)',
            'Higher Prices and Lower Output',
            'Worsen Income Distribution (Regressive Effect)',
            'Excess Capacity (Productive Inefficiency)',
            'Internal inefficiency (X-inefficient)',
            'Anti-Competitive Practices (Collusion, Informal Collusion, Predatory Pricing, Exclusive Dealing, Tying Arrangements, etc.)',
          ],
        ),
      ),
    ],
  ),
  Slide(
    syllabusPoint:
        SyllabusPoint.governmentInterventionInResponseToAbuseOfMarketPower,
    contents: [
    ],
  ),

  /// *********************************************************************************************************************
  /// Government Intervention to Market Power
  ...marketPowerTerms,
];

List<Slide> get marketPowerTerms => [
  Slide(
    subunit: Subunit.marketFailurePower,
    title: kTermsGlossary,
    contents: [
      // SlideContent.customWidget(
      //   GroupedDefinitionGridRedundant(
      //     groupedItems: {
      //       'Market Fundamentals': [
      //         SlideContent.term(
      //           'Market power',
      //           'Ability of a firm to set price above marginal cost (P > MC).',
      //         ),
      //         SlideContent.term(
      //           'Industry',
      //           'Group of firms selling similar goods or services.',
      //         ),
      //         SlideContent.term(
      //           'Barriers to entry',
      //           'Factors making it difficult for new firms to enter.',
      //         ),
      //         SlideContent.term(
      //           'Concentration ratio',
      //           'Measures total market share held by largest firms.',
      //         ),
      //       ],
      //       'Revenue & Costs': [
      //         SlideContent.term(
      //           'Total Revenue (TR)',
      //           'Total income earned: TR = P x Q.',
      //         ),
      //         SlideContent.term('Average Revenue (AR)', 'TR / Q or AR = P.'),
      //         SlideContent.term(
      //           'Marginal Revenue (MR)',
      //           'Additional revenue from selling one more unit: ΔTR / ΔQ.',
      //         ),
      //         SlideContent.term(
      //           'Fixed Cost (FC)',
      //           'Costs that do not change with output.',
      //         ),
      //         SlideContent.term(
      //           'Variable Cost (VC)',
      //           'Costs that change with output.',
      //         ),
      //         SlideContent.term(
      //           'Total Cost (TC)',
      //           'Sum of fixed and variable costs: TC = FC + VC.',
      //         ),
      //         SlideContent.term(
      //           'Sunk cost',
      //           'A cost that cannot be recovered.',
      //         ),
      //       ],
      //       'Efficiency Types': [
      //         SlideContent.term(
      //           'Productive efficiency',
      //           'Producing at lowest possible cost (MC = ATC).',
      //         ),
      //         SlideContent.term(
      //           'Allocative efficiency',
      //           'P = MC; resources follow consumer preference.',
      //         ),
      //         SlideContent.term(
      //           'Dynamic efficiency',
      //           'Innovation and investment over time to reduce costs.',
      //         ),
      //         SlideContent.term(
      //           'X-efficiency',
      //           'Effective resource management to minimize costs.',
      //         ),
      //       ],
      //       'Profit & Pricing': [
      //         SlideContent.term(
      //           'Profit-maximizing point',
      //           'Output where MC = MR.',
      //         ),
      //         SlideContent.term(
      //           'Normal Profit',
      //           'Minimum profit required to stay in industry (TR = TC).',
      //         ),
      //         SlideContent.term(
      //           'Abnormal Profit',
      //           'Profit exceeding normal level (TR > TC).',
      //         ),
      //         SlideContent.term('Break-even price', 'Price where AR = AC.'),
      //         SlideContent.term('Shut-down price', 'Price where AR = AVC.'),
      //       ],
      //       'Market Structures': [
      //         SlideContent.term(
      //           'Perfect Competition',
      //           'Many firms, homogeneous products, no barriers.',
      //         ),
      //         SlideContent.term(
      //           'Monopoly',
      //           'Single firm, high barriers, P > MC.',
      //         ),
      //         SlideContent.term(
      //           'Oligopoly',
      //           'Few interdependent dominant firms.',
      //         ),
      //         SlideContent.term(
      //           'Monopolistic competition',
      //           'Many firms, differentiated products, low barriers.',
      //         ),
      //       ],
      //       'Game Theory & Strategy': [
      //         SlideContent.term(
      //           'Game theory',
      //           'Study of strategic decision-making.',
      //         ),
      //         SlideContent.term(
      //           'Nash equilibrium',
      //           'No player gains by changing strategy alone.',
      //         ),
      //         SlideContent.term(
      //           'Prisoner’s Dilemma',
      //           'Self-interest leads to worse mutual outcome.',
      //         ),
      //         SlideContent.term(
      //           'Collusive Oligopoly',
      //           'Firms agree to fix prices (Cartel).',
      //         ),
      //       ],
      //     },
      //   ),
      // ),
    ],
  ),
];
