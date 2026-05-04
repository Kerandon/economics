import '../../../../../../../diagrams/enums/diagram_enum.dart';
import '../../../../../../../diagrams/enums/unit_type.dart';
import '../../../../../../enums/tag.dart';
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
        ['Economies of scale (natural monopoly)', 'Higher prices, lower output'],
        [
          'Dynamic efficiency – abnormal profits fund innovation (e.g. AI, EVs)',
          'Allocative inefficiency (P > MC), causing consumer and welfare loss',
        ],
        [
          'Natural monopoly can supply at lower average cost (when regulated) (e.g. utilities, railways)',
          'Increased income inequality – higher prices transfer welfare to firms and disproportionately affect low-income consumers',
        ],
        [
          'Reduced duplication/waste; greater convenience from a single supplier (e.g. transport, airports)',
          'Anti-competitive behaviour (e.g. collusion, abuse of dominance)',
        ],
      ],
    ),
    SlideContent.text('''
Desirability depends on the industry and the type of efficiency (allocative, productive, dynamic). 

In highly competitive markets (e.g. foreign exchange), low market power is desirable due to high efficiency. In differentiated markets (e.g. restaurants), some market power is accepted as consumers trade some efficiency for greater choice and variety. 

In industries like AI and electric vehicles, market power can support innovation and dynamic efficiency. Natural monopolies (e.g. railways, utilities) can be desirable due to very large economies of scale, especially when regulated. 

Overall, significant market power is not always undesirable, but it should be regulated to limit anti-competitive behaviour (e.g. collusion, price gouging) and protect consumer welfare.
'''),
    SlideContent.diagrams([DiagramEnum.microPerfectCompetitionMarketLongRun]),
    SlideContent.diagrams([
      DiagramEnum.microMonopolyWelfare,
      DiagramEnum.microMonopolyNatural,
    ]),
    SlideContent.realWorldExamples([
      RealWorldExamples.oligopolyBoeingAirbusDuopoly,
      RealWorldExamples.oligopolyBigSuperMarketsAustralia,
      RealWorldExamples.oligopolyAIIndustry,
      RealWorldExamples.oligopolyEVIndustryInChina,
      RealWorldExamples.oligopolyOpecCartel,
      RealWorldExamples.marketPowerAmazon,
      RealWorldExamples.marketPowerMicrosoft,
      RealWorldExamples.naturalMonopolyChinaRailway,
      RealWorldExamples.naturalMonopolyStateGridChina,
    ]),
  ],
);