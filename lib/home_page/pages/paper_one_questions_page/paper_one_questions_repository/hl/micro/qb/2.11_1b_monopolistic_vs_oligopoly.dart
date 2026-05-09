// We use a top-level variable so we can import it elsewhere
import '../../../../../../../diagrams/enums/diagram_enum.dart';
import '../../../../../../../diagrams/enums/unit_type.dart';
import '../../../../../../enums/tag.dart';
import '../../../../../../models/slide.dart';
import '../../../../../../models/slide_content.dart';
import '../../../../../../models/term.dart';
import '../../../../../real_world_examples/real_world_examples.dart';
import '../../../../../terms/terms.dart';

final evaluateMonopolisticVsOligopolyQuestion = Slide(
  subunit: Subunit.marketFailureMarketPower,
  tags: [Tag.hl, Tag.p1b],
  question:
      'Using real-world examples, discuss the view that monopolistic competition is a more desirable market structure than oligopoly.',
  contents: [
    SlideContent.econTerms([
      EconTerm.monopolisticCompetition,
      EconTerm.oligopoly,
      EconTerm.dynamicEfficiency,
      EconTerm.collusion,
    ]),
    // Explanation Text
    SlideContent.text('''
<ul>
  <li>Desirability depends on the industry. Evaluate using efficiency (allocative, productive, dynamic), consumer welfare, variety, and competition.</li>
  <li><b>Monopolistic Competition (e.g., Shanghai restaurants):</b> Higher variety and consumer choice. Strong competition pushes prices closer to marginal cost, improving allocative efficiency.</li>
  <li><b>Oligopoly (e.g., Boeing/Airbus, AI):</b> Suitable for high fixed cost industries due to economies of scale. Abnormal profits can fund dynamic efficiency through R&D. However, risk of collusion reduces consumer welfare.</li>
</ul>
'''),
    // Monopolistic Competition
    SlideContent.simpleTable(
      title: 'Monopolistic Competition',
      headers: ['Pros', 'Cons'],
      data: [
        ['Variety / consumer choice', 'Limited economies of scale'],
        ['Consumer sovereignty', 'Productive inefficiency (P > ATCmin)'],
        [
          'Closer to allocative efficiency due to competition',
          'Low R&D / Dynamic Efficiency',
        ],
        ['Low barriers to entry', ''],
      ],
    ),

    // Oligopoly
    SlideContent.simpleTable(
      title: 'Oligopoly',
      headers: ['Pros', 'Cons'],
      data: [
        [
          'Dynamic efficiency (R&D and innovation)',
          'Anti-competitive behaviour',
        ],
        ['Economies of scale (low LRAC)', 'Price rigidity'],
        ['Global competitiveness (MNCs)', 'Informal / implicit collusion'],
        [
          'Non-price competition (product features)',
          'Cartels and price fixing',
        ],
        [
          'Price wars closer to allocative efficiency',
          'High barriers to entry',
        ],
        ['', 'Possible X-inefficiency'],
        ['', 'Market concentration and inequality'],
      ],
    ),
    SlideContent.diagrams([
      DiagramEnum.microMonopolisticCompetitionLongRun,
      DiagramEnum.microOligopolyCartel,
    ]),
    // Real World Examples
    SlideContent.realWorldExamples([]),
  ],
);
