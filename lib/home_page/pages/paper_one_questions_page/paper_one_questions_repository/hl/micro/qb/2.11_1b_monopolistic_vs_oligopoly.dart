// We use a top-level variable so we can import it elsewhere
import '../../../../../../../diagrams/enums/diagram_enum.dart';
import '../../../../../../../diagrams/enums/unit_type.dart';
import '../../../../../../models/slide.dart';
import '../../../../../../models/slide_content.dart';
import '../../../../../../models/term.dart';
import '../../../../../real_world_examples/real_world_examples.dart';
import '../../../../../terms/terms.dart';

final evaluateMonopolisticVsOligopolyQuestion = Slide(
  subunit: Subunit.marketFailurePower,
  tags: [Tag.hl, Tag.p1b],
  question:
      'Using real-world examples, discuss the view that monopolistic competition is a more desirable market structure than oligopoly.',
  contents: [
    // 1. TL;DR
    SlideContent.tldr('''
    <ul>
      <li><b>Monopolistic Competition:</b> Desirable for <b>consumer choice</b> and price competition, but lacks <b>economies of scale</b> and R&D.</li>
      <li><b>Oligopoly:</b> Desirable for <b>dynamic efficiency</b> and <b>economies of scale</b>, but carries risks of <b>collusion</b> and higher prices.</li>
      <li><b>Verdict:</b> Depends on the industry (need for R&D) and the strength of <b>government regulation</b>.</li>
    </ul>
    '''),

    // 2. Definitions / Terms
    SlideContent.econTerms([
      EconTerm.monopolisticCompetition,
      EconTerm.oligopoly,
      EconTerm.meritGood,
      EconTerm.dynamicEfficiency,
      EconTerm.collusion,
    ]),

    // 3. Explanation Text
    SlideContent.text('''
    <p>Desirability is evaluated through <b>efficiency</b> (allocative, productive, dynamic) and <b>consumer welfare</b> (choice and price).</p>

    <p><b>The Case for Monopolistic Competition:</b> In fragmented markets like <b>Shanghai’s coffee shop industry</b>, low barriers to entry ensure high competition. Consumers benefit from vast <b>product variety</b> and prices closer to marginal cost (closer to allocative efficiency) compared to a monopoly.</p>

    <p><b>The Case for Oligopoly:</b> In capital-intensive industries like <b>commercial aircraft (Boeing vs. Airbus)</b> or <b>UK mobile networks</b>, high fixed costs require firms to be large. Oligopolies can achieve <b>economies of scale</b>, potentially lowering prices below what a small firm could offer. Furthermore, <b>abnormal profits</b> allow for <b>dynamic efficiency</b> (e.g., Apple or Pfizer investing in R&D).</p>

    <p><b>The Risk of Oligopoly:</b> Without regulation, firms may engage in <b>tacit collusion</b>. For example, the <b>Coles and Woolworths duopoly</b> in Australia has faced scrutiny for high grocery prices and "price shadowing," reducing consumer surplus.</p>
    '''),

    // 4. Diagrams
    SlideContent.diagrams([
      DiagramEnum.microMonopolisticCompetitionLongRun,
      DiagramEnum.microOligopolyCartel,
    ]),

    // 5. Diagram Explanation (Italicized text below diagrams)
    SlideContent.text(
      '<i>Contrast Monopolistic Competition (LR normal profit, relatively elastic demand) with a Collusive Oligopoly (Abnormal profit, inelastic demand, acting as a monopoly).</i>',
    ),

    // 6. Real World Examples
    SlideContent.realWorldExamples([
      RealWorldExamples.shanghaiCoffeeShops,
      RealWorldExamples.bigSuperMarketsAustralia,
      RealWorldExamples.eVIndustryInChina,
    ]),

    // 7. Evaluation Block 1: Monopolistic Competition
    SlideContent.evaluation(
      title: 'Monopolistic Competition',
      leftTitle: 'Pros',
      rightTitle: 'Cons',
      leftItems: [
        'High consumer sovereignty and choice.',
        'Lower prices due to high competition.',
      ],
      rightItems: [
        'Productive inefficiency (not at min AC).',
        'Lack of R&D investment due to long-run normal profits.',
      ],
    ),

    // 8. Evaluation Block 2: Oligopoly
    SlideContent.evaluation(
      title: 'Oligopoly',
      leftTitle: 'Pros',
      rightTitle: 'Cons',
      leftItems: [
        'Dynamic efficiency: R&D leading to innovation.',
        'Economies of scale can lead to lower Long-Run AC.',
      ],
      rightItems: [
        'Potential for collusive behavior (higher prices).',
        'High barriers to entry limit market contestability.',
      ],
    ),
  ],
);
