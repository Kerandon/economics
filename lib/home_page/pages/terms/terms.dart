import '../../../diagrams/enums/unit_type.dart';
import '../../models/term.dart';

enum EconTerm {
  monopolisticCompetition(
    termName: 'Monopolistic Competition',
    explanation: 'A market with many relatively small firms, limited market power, high production differentiation and low barriers to entry.',
    subunit: Subunit.marketFailurePower,
  ),
  abnormalProfit(
    termName: 'Abnormal Profit',
    explanation: 'Total revenue exceeds total economic costs (AR > AC). Also known as economic profit.',
    subunit: Subunit.marketFailurePower, // Or whatever subunit fits best
  ),
  normalProfit(
    termName: 'Normal Profit',
    explanation: 'The minimum level of profit required to keep a firm in its current line of production (AR = AC).',
    subunit: Subunit.marketFailurePower,
  ),
  shortRun(
    termName: 'Short Run',
    explanation: 'A time period where at least one factor of production (usually capital) is fixed.',
    subunit: Subunit.marketFailurePower, // Example subunit
  ),
  barriersToEntry(
    termName: 'Barriers to Entry',
    explanation: 'Obstacles that prevent new firms from easily entering an industry and competing with existing firms.',
    subunit: Subunit.marketFailurePower,
    tags: [Tag.hl], // Example of adding an HL tag to a specific term!
  );

  // --- PROPERTIES ---
  final String termName;
  final String explanation;
  final Subunit subunit;
  final List<Tag> tags;

  // --- CONSTRUCTOR ---
  const EconTerm({
    required this.termName,
    required this.explanation,
    required this.subunit,
    this.tags = const [], // Defaults to an empty list if no tags are provided
  });

  // --- HELPER METHOD ---
  // Instantly converts your enum data into the Term object your UI already uses!
  Term toTerm() {
    return Term(
      term: termName,
      explanation: explanation,
      // If your Term class takes a single Tag instead of a list, you could do:
      // tag: tags.isNotEmpty ? tags.first : null,
    );
  }
}