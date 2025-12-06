import 'package:economics_app/diagrams/enums/diagram_bundle_enum.dart';

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
     <ul>
  <li>Many firms and consumers</li>
  <li>Homogeneous (identical) products</li>
  <li>Firms are price takers (perfectly elastic demand for each firm)</li>
  <li>Perfect information (buyers & sellers know prices and technology)</li>
  <li>Free entry and exit of firms</li>
  <li>Firms profit-maximise where P = MC</li>
  <li>Normal profit in the long run (zero economic profit)</li>
  <li>Allocative efficiency (P = MC) in long run</li>
  <li>Productive efficiency (firms produce at minimum ATC) in long run</li>
  <li>No non-price competition (advertising is unnecessary)</li>
</ul>
        
        
        '''),
      SlideContent.text('''
In the long-run firms in perfect competition only make normal profit (TR=TC).
Firms are allocatively efficient P=MC, meaning resources are allocatively most efficiently,
but there is no product differentiation for choice for consumers. Also firms have no abnormal profits
to invest in product research.
        
        '''),
      SlideContent.diagrams([
        DiagramEnum.microPerfectCompetitionLongRunIndustry,
        DiagramEnum.microPerfectCompetitionLongRunFirm,
      ]),
      SlideContent.diagrams([DiagramEnum.microPerfectCompetitionLongRunFirm]),
    ],
  ),
];
