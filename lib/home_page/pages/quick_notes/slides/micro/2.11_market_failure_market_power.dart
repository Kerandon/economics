import 'package:economics_app/diagrams/enums/diagram_enum.dart';
import 'package:economics_app/home_page/pages/real_world_examples/real_world_examples.dart';
import 'package:economics_app/home_page/pages/terms/terms.dart';
import '../../../../../diagrams/enums/unit_type.dart';
import '../../../../enums/tag.dart';
import '../../../../models/slide.dart';
import '../../../../models/slide_content.dart';

final marketFailureMarketPower = Slide(
  subunit: Subunit.marketFailureMarketPower,
  contents: [
    SlideContent.simpleTable(
      title: 'Key Rules',
      headers: ['Concept', 'Equation', 'Explanation'],
      data: [
        [
          'Allocative Efficiency',
          'P = MC',
          'Resources allocated to maximise social welfare',
        ],
        [
          'Productive Efficiency',
          'MC = AC (minimum AC)',
          'Production at lowest possible cost',
        ],
        [
          'Normal Profit (Break-even)',
          'AR = AC',
          'Zero economic costs. TR = TC (implicit and explicit costs)',
        ],
        [
          'Shutdown Point',
          'P = AVC',
          'Firm covers variable costs only; below this, shut down in short run',
        ],
        [
          'Profit Maximisation',
          'MC = MR',
          'Quantity where profit is maximised',
        ],
        [
          'Revenue Maximisation',
          'MR = 0',
          'Output where TR is maximised (where PED = 1)',
        ],
        [
          'Market Power',
          'P > MC',
          'Market failure (underallocation). All markets except perfect competition',
        ],
        ['Total Revenue (TR)', 'TR = P × Q', 'Total income from sales'],
        [
          'Marginal Cost (MC)',
          'MC = ∆TC / ∆Q',
          'Cost of producing one extra unit',
        ],
      ],
    ),
    SlideContent.text('''
      <h1>Perfect Competition</h1>
      <ul>
      <li>Perfect competition is only market structure where P = MC (no market failure). Allocative Efficiency at cost of: product variety (choice) and dynamic efficiency (innovation)</li>
      <li>Currency exchange (USD / Euro); primary commodity markets (wheat/corn).</li>
      </ul>
      
      '''),
    SlideContent.diagrams(
      description:
          'Abnormal profits only in short-run. In long-run free entry (no barriers) mean new firms enter industry attracted by abnormal profit, shifting market supply right, lowering marker price, until P = ATCmin (normal profit).',
      [DiagramEnum.microPerfectCompetitionMarketAbnormalProfit],
    ),
    SlideContent.diagrams(
      description:
          'Economic losses only in short-run. In long-run free exit mean some firms leave industry, shifting market supply left, increasing market price, until P = ATCmin (normal profit).',
      [DiagramEnum.microPerfectCompetitionMarketLoss],
    ),
    SlideContent.diagrams(
      description:
          'In the long-run firms in perfect competition are allocatively and productively efficient, earning only normal profit P=MC=ATCmin. Note: THE LEFT MARKET/INDUSTRY DIAGRAM shows maximum consumer and producer welfare (no welfare loss as MB = MC)',
      [DiagramEnum.microPerfectCompetitionMarketLongRun],
    ),
    SlideContent.text('''
      <h1>Monopolistic Competition</h1>
      <ul>
      <li>Similar to perfect competition (many small firms with no/low barriers, normal profit only in long-run) - but firms have SOME (LIMITED) market power due to product differentiation (non-price competition).</li>
      <li>Difference to perfect competition: never allocatively inefficient P > MC, and productively inefficient P ≠ ATCmin.</li>
      <li>Restaurants, cafes, hair salons, burger outlets</li>
      </ul>
      
      '''),
    SlideContent.diagrams(
      description:
          'SHORT RUN: abnormal profit when P > ATC; economic loss when P < ATC. LONG RUN: low barriers to entry and exit mean firms enter when profits exist (demand shifts left, more elastic) and exit when losses occur (demand shifts right, more inelastic), until P is tangent to ATC and only normal profit is earned.',

      [
        DiagramEnum.microMonopolisticCompetitionAbnormalProfit,
        DiagramEnum.microMonopolisticCompetitionEconomicLoss,
        DiagramEnum.microMonopolisticCompetitionLongRun,
      ],
    ),
    SlideContent.text('''
      <h1>Oligopoly</h1>
      <ul>
      <li>Many large interdependent firms (2-12) with strong market power. Measured by <b>concentration ratio</b>.</li>
      <li>Usually high product differentiation, heavy non-price competition (EV, AI, Airlines); but some industry sell homogeneous good (oil)</li>
      <li>Boeing/Airbus (duopoly); Australian supermarkets (Coles, Woolworths); AI/Tech firms (Google, OpenAI(Chat GPT); Microsoft, Deepseek); Australian big-four banks; EV market (BYD, Tesla, Xiaomi). Collusive: OPEC (cartel)</li>
      </ul>
      '''),
    SlideContent.diagrams(
      description:
          'Cartel acts as a monopoly, restricts output to increase price and earn abnormal profits. A kinked demand curve shows \'sticky\' prices (price rigidity) - thus avoid price-wars. Raise prices demand is elastic TR falls. Decrease prices, other quickly follow (price-war) inelastic demand TR falls.',
      [
        DiagramEnum.microOligopolyCartel,
        DiagramEnum.microOligopolyKinkedDemandCurve,
      ],
    ),
    SlideContent.text('''
The pay-off matrix illustrates the conflict between cooperation and self-interest in an oligopoly. If both firms collude and set PRICE-HIGH (top-left), each earns \$100 profit. However, each firm has a strong incentive to cheat by pricing low, earning \$150 while the other gets only \$30. This triggers a price war, leading both firms to price low and earn \$60 each (bottom-right). Thus, while it is in both firms’ interest to cooperate and avoid a price war, the temptation to cheat remains.
'''),
    SlideContent.simpleTable(
      flexColumnWidths: [1, 1, 1, 1],
      tags: [Tag.hl],
      title: 'Game Theory - Payoff Matrix (Prisoner\'s Dillema',
      headers: ['', '', 'Firm B', ''], // Identifies row vs. column player
      data: [
        ['', '', 'Price High', 'Price Low'],
        ['<b>Firm A</b>', 'Price High', '\$100, \$100', '\$30, \$150'],
        ['', 'Price Low', '\$150, \$30', '\$60, \$60'],
      ],
    ),

    SlideContent.simpleTable(
      title: 'Evaluate Oligopoly vs Monopolistic Competition',
      headers: [
        'Oligopoly',
        'Monopolistic Competition',
      ], // <-- Fixed: Removed the extra '' header
      data: [
        ['PROS', 'PROS'],
        ['Economies of scale', 'Product variety (choice)'],
        ['Dynamic efficiency (innovation)', 'Consumer sovereignty'],
        ['Global competitiveness (MNCs)', 'Closer to allocative efficiency'],
        ['Price-wars benefit consumers', ''],
        ['CONS', 'CONS'],
        [
          'Anti-Competitive (predatory pricing, tying arrangement)',
          'Lack dynamic efficiency',
        ],
        [
          'High prices, consumer welfare loss',
          'Still P > MC, and excess capacity',
        ],
        ['Collusion', ''],
        ['High barriers', ''],
        ['Sticky prices', ''],
      ],
    ),
    SlideContent.text('''
      <h1>Monopoly</h1>
      <ul>
       <li>Single firm supply whole market with significant barriers: patents, regulatory barriers, branding, massive economies of scale.</li>
      </ul>
      '''),
    SlideContent.diagrams(
      description:
          'Monopoly can sustain abnormal profits in long-run due to barriers. Charges P > MC, welfare loss; some consumer surplus transferred to monopolist (increasing inequality).',
      [
        DiagramEnum.microMonopolisticCompetitionAbnormalProfit,
        DiagramEnum.microMonopolyWelfare,
      ],
    ),
    SlideContent.text('''
      <h2>Natural Monopoly</h2>
      <ul>
       <li>Usually seen as desirable. One firm can supply whole market at lower LRAC than two or more firms (China railway).</li>
       <li>Requires regulations: nationalize; pricing regulation (P = MC; P = ATC)</li>
       <li>Note a natural monopoly can be LOSS-MAKING but the government is willing to subsidize due to its social welfare benefit.</li>
      </ul>
      '''),
    SlideContent.diagrams(
      description:
          'A natural monopoly - AR/D must cut LRAC whilst still falling.',
      [DiagramEnum.microMonopolyNatural],
    ),
    SlideContent.diagrams(
      description:
          'Marginal Cost Pricing force monopoly to charge P = MC; and Average Cost Pricing force charge P = ATC',
      [
        DiagramEnum.microMonopolyNaturalMarginalCostPricingWelfare,
        DiagramEnum.microMonopolyNaturalAverageCostPricingWelfare,
      ],
    ),
    SlideContent.simpleTable(
      title: 'Evaluation of Market Power',
      headers: ['Pros', 'Cons'],
      data: [
        [
          'Economies of scale, lower prices if regulated; dynamic efficiency.',
          'Allocative inefficiency (P > MC), reduced consumer welfare.',
        ],
        [
          'International competitiveness, MNCs.',
          'Worsen inequality (abnormal profits to wealthy, regressive pricing).',
        ],
        ['Possible dynamic efficiency.', 'Possible X-inefficiency.'],
        [
          'Natural monopolies can be efficient in utilities and infrastructure.',
          'Anti-competitive behaviour.',
        ],
      ],
    ),

    SlideContent.simpleTable(
      title: 'Evaluation of Anti-Monopoly Policies',
      headers: ['Policy', 'Pros', 'Cons'],
      data: [
        [
          'Nationalisation',
          'Social welfare > profit',
          'X-inefficiency, weak profit incentives',
        ],
        [
          'Windfall Tax',
          'Increases government revenue, redistribution',
          'Limited impact, reduce in profit-incentives',
        ],
        [
          'Break-up of Firms',
          'Increases competition / reduces market power',
          'Lower economies of scale',
        ],
        [
          'Merger Regulation',
          'Prevents excessive market concentration',
          'High monitoring costs; block efficiency gains from mergers',
        ],
        [
          'Marginal Cost Pricing + Subsidy',
          'Allocative efficiency where P = MC',
          'Requires government subsidy; fiscal cost and potential inefficiency',
        ],
        [
          'Average Cost Pricing',
          'Ensures normal profit and market survival',
          'Weak cost-cutting incentives; still P > MC; risk of regulatory capture',
        ],
        [
          'Regulation',
          'Protects consumers and limits abuse of market power',
          'High administrative cost; risk of regulatory capture',
        ],
      ],
    ),
    SlideContent.econTerms(
      EconTerm.values
          .where((term) => term.subunit == Subunit.marketFailureMarketPower)
          .toList(),
    ),
    SlideContent.realWorldExamples(
      RealWorldExamples.values
          .where((term) => term.subunit == Subunit.marketFailureMarketPower)
          .toList(),
    ),
  ],
);
