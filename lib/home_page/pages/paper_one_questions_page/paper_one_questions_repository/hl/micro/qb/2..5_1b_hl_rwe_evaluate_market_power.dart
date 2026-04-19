import '../../../../../../../diagrams/enums/diagram_enum.dart';
import '../../../../../../../diagrams/enums/unit_type.dart';
import '../../../../../../models/slide.dart';
import '../../../../../../models/slide_content.dart' show SlideContent;
import '../../../../../../models/term.dart';
import '../../../../../real_world_examples/real_world_examples.dart';
import '../../../../../terms/terms.dart';

final rweEvaluateMarketPowerAlwaysUndesirableMicro1bHL = Slide(
  subunit: Subunit.marketFailurePower,
  tags: [Tag.hl, Tag.p1b],
  question:
      'Using real-world examples, evaluate the view that the existence of significant market power is always undesirable.',
  contents: [
    SlideContent.econTerms([EconTerm.marketPower]),
    SlideContent.simpleTable(
      title: 'Evaluation of Market Power',
      headers: ['Advantages', 'Drawbacks'],
      data: [
        ['Economies of Scale', 'Higher price, lower output'],
        [
          'Dynamic Efficiency: Abnormal Profits invest in innovation (AI, EVs)',
          'Allocatively inefficient P>MC, welfare loss.',
        ],
        [
          'Natural Monopoly, supply market at lower average cost (when regulated)(utilities, railway)',
          'Increase income inequality: some consumer welfare transferred to monopolist, higher prices has regressive effect on low income consumers.',
        ],
        [
          'Reduce duplication / waste, more convenient one supplier (trains, airport)',
          'Anti-competitive practices / collusion',
        ],
      ],
    ),
    SlideContent.text('''
      Evaluating the term 'desirability' depends on industry examined. Currency exchange (close to perfect competition) is desirable. Shanghai restaurants have limited market power, consumers benefit by trading some efficiency for variety and choice. EV market in China provides large benefits due to EOS, dynamic efficiency. Natural monopoly (china railway, utilities) has big benefit. Firms will monopoly power should be appropriately regulated however to avoid anti-competitive practices (implicit collusion, price gouging, collusion).'
      '''),
    SlideContent.diagrams([DiagramEnum.microPerfectCompetitionMarketLongRun]),
    SlideContent.diagrams([
      DiagramEnum.microMonopolyWelfare,
      DiagramEnum.microMonopolyNatural,
    ]),
    SlideContent.realWorldExamples([]),
  ],
);
