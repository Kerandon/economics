import '../../../../../../../diagrams/enums/diagram_enum.dart';
import '../../../../../../../diagrams/enums/unit_type.dart';
import '../../../../../../enums/tag.dart';
import '../../../../../../models/slide.dart';
import '../../../../../../models/slide_content.dart';
import '../../../../../../models/term.dart';
import '../../../../../terms/terms.dart';

final distinguishBetweenPerfectCompetitionAndMonopolisticCompetitionHL10Mark = Slide(
  subunit: Subunit.marketFailurePower,
  tags: [Tag.p1a, Tag.hl],
  question:
      'Distinguish between perfect competition and monopolistic competition.',
  contents: [
  //   SlideContent.text('''
  // <p>Perfect competition is characterized by many small, independent firms in a large industry selling a homogeneous product. There is perfect information on profits and technology, perfect factor mobility, and firms have no market power, setting prices at P = MC.</p>
  // <p>Monopolistic competition is similar because it is also characterized by many relatively small firms; however, an important distinction is that firms have some (limited) market power due to product differentiation from non-price competition (e.g., product features/branding), allowing them to set prices at P > MC.</p>
  // <p>Monopolistic competition is therefore a more realistic model of many real-world industries, such as city restaurants.</p>
  // <p>Another similarity is that both markets feature high competition (many substitutes for consumers) and low barriers to entry/exit, meaning firms in both structures can only earn normal profits in the long run (minimum profit to remain in the industry in the long-run).</p>
  // <p>However, a key difference is that firms in monopolistic competition are neither allocatively efficient (P > MC) nor productively efficient (P ≠ ATCmin) in the long run due to their market power. In contrast, firms in perfect competition are both allocatively and productively efficient in the long run, where P = MC = ATCmin.</p>
  // '''),
    SlideContent.simpleTable(
      title: 'Similarities',
      headers: ['Perfect Competition', 'Monopolistic Competition'],
      data: [
        [
          'Very many small, independent firms',
          'Many relatively small, independent firms',
        ],
        ['No barriers to entry or exit', 'Low barriers to entry or exit'],
        [
          'Normal profit in the long run (P=AC)',
          'Normal profit in the long run (P=AC)',
        ],
      ],
    ),
    SlideContent.simpleTable(
      title: 'Differences',
      headers: ['Perfect Competition', 'Monopolistic Competition'],
      data: [
        ['Homogeneous products', '<strong>Differentiated</strong> products'],
        [
          'No market power: perfectly elastic demand (price taker P = MC)',
          'Some market power due to product differentiation: downward sloping demand (price setter P > MC)',
        ],
        [
          'Allocatively efficient (P=MC) and productively efficient (P=ATCmin) in the long run',
          'Not allocatively efficient (P>MC); not productively efficient (P≠ATCmin)',
        ],
        ['An industry and firm diagram', 'Only a firm diagram'],
      ],
    ),

    SlideContent.simpleTable(
      title: 'Examples',
      headers: ['Perfect Competition', 'Monopolistic Competition'],
      data: [
        ['Foreign exchange markets', 'City restaurants'],
        ['Agricultural markets (e.g., fruit and veg)', 'City coffee shops'],
      ],
    ),
    SlideContent.diagrams([DiagramEnum.microPerfectCompetitionMarketLongRun]),
    SlideContent.diagrams([DiagramEnum.microMonopolisticCompetitionLongRun]),

    SlideContent.econTerms([
      EconTerm.perfectCompetition,
      EconTerm.monopolisticCompetition,
      EconTerm.barriersToEntry,
      EconTerm.nonPriceCompetition,
      EconTerm.shortRunMicro,
      EconTerm.abnormalProfit,
      EconTerm.normalProfit,
    ]),
  ],
);
