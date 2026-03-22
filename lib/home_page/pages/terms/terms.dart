import '../../../diagrams/enums/unit_type.dart';
import '../../models/term.dart';

enum EconTerm {

  /// 2.11 Market Power Terms
  monopolisticCompetition(
    termName: 'Monopolistic Competition',
    explanation: 'A market with many relatively small firms, limited market power, high production differentiation and low barriers to entry.',
    subunit: Subunit.marketFailurePower,
  ),
  abnormalProfit(
    termName: 'Abnormal Profit',
    explanation: 'Total revenue exceeds total economic costs (AR > AC). Also known as economic profit. Total Costs include'
        'explicit costs and implicit costs.',
    subunit: Subunit.marketFailurePower, // Or whatever subunit fits best
  ),
  normalProfit(
    termName: 'Normal Profit',
    explanation: 'The minimum level of profit required to keep a firm in its current line of production (AR = AC).',
    subunit: Subunit.marketFailurePower,
  ),
  shortRun(
    termName: 'Short Run',
    explanation: 'A time period where at least one factor of production is fixed (for example rent contract of a machine or lease of store).',
    subunit: Subunit.marketFailurePower, // Example subunit
  ),
  barriersToEntry(
    termName: 'Barriers to Entry',
    explanation: 'Obstacles that prevent new firms from easily entering an industry. E.g., high set-up costs / economies of scale, regulatory barriers, brand loyalty, patents.',
    subunit: Subunit.marketFailurePower,
    tags: [Tag.hl], // Example of adding an HL tag to a specific term!
  ),
  oligopoly(
  termName: 'Oligopoly',
  explanation: 'A few large dominant firms with high barriers to entry. Non-collusive, or collusive. Usually high product differentiation (supermarkets, airlines), but also not (oil firms). Strategic decision is key characteristic.',
  subunit: Subunit.marketFailurePower,
  tags: [Tag.hl], // Example of adding an HL tag to a specific term!
  ),
  concentrationRation(
  termName: 'Concentration ratio',
    explanation: 'Measures how dominant the top firms are by proportion of market share (CR3, CR4)',
    subunit: Subunit.marketFailurePower,
    tags: [Tag.hl],
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