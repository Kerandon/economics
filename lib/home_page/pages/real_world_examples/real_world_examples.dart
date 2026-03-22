import '../../../diagrams/enums/unit_type.dart';
import '../../models/term.dart';
enum RealWorldExamples {
  // --- OLIGOPOLY ---
  bigFourBanks(
    'Big-Four Banks in Australia (CBA, Westpac, NAB, ANZ)',
    explanation: 'High strategic interdependence; when one bank changes mortgage rates, others typically follow within hours.',
    subunit: Subunit.marketFailurePower,
  ),
  bigSuperMarketsAustralia(
    'Coles and Woolworths (Australia)',
    explanation: 'A "Duopoly" accused of using market power to squeeze suppliers and inflate grocery prices (Implicit Collusion).',
    subunit: Subunit.marketFailurePower,
  ),
  eVIndustryInChina(
    'Xiaomi, Tesla, BYD',
    explanation: 'Fierce "Price Wars" and rapid innovation (Non-price competition) to capture market share in a growing industry.',
    subunit: Subunit.marketFailurePower,
  ),
  llmMarket(
    'Google (Gemini), Anthropic (Claude), OpenAI (ChatGPT)',
    explanation: 'A modern "Tech Oligopoly" where firms compete through massive R&D and rapid feature releases.',
    subunit: Subunit.marketFailurePower,
    tags: [Tag.hl],
  ),

  // --- MONOPOLISTIC COMPETITION ---
  shanghaiCoffeeShops(
    'Coffee Shops in Shanghai / Melbourne',
    explanation: 'Many sellers with low barriers to entry. Each shop uses "Brand Differentiation" (vibe, specialty beans) to gain some price-making power.',
    subunit: Subunit.marketFailurePower,
  ),
  fastFashion(
    'Zara, H&M, Uniqlo',
    explanation: 'Products are similar but not identical. Heavy reliance on advertising and branding to create "Perceived Differentiation."',
    subunit: Subunit.marketFailurePower,
  ),

  // --- PERFECT COMPETITION (Closest Real-World Approximations) ---
  wheatFarmers(
    'Global Wheat or Corn Markets',
    explanation: 'Large number of buyers and sellers dealing with a "Homogeneous Product." Farmers are "Price Takers" based on global exchange prices.',
    subunit: Subunit.marketFailurePower,
  ),
  forexMarket(
    'Foreign Exchange (USD/AUD)',
    explanation: 'Almost perfect information and a perfectly standardized product. No single buyer or seller can influence the market price.',
    subunit: Subunit.marketFailurePower,
    tags: [Tag.hl],
  ),

  // --- MONOPOLY (Pros & Cons) ---
  luxottica(
    'Luxottica (Eyewear)',
    explanation: 'Controls ~80% of major eyewear brands (Ray-Ban, Oakley). CON: Higher prices for consumers due to lack of viable substitutes.',
    subunit: Subunit.marketFailurePower,
  ),
  pharmaceuticalPatents(
    'Patented Life-Saving Drugs',
    explanation: 'PRO: High abnormal profits provide the incentive for expensive R&D. CON: Creates "Allocative Inefficiency" (P > MC).',
    subunit: Subunit.marketFailurePower,
    tags: [Tag.hl],
  ),

  // --- NATURAL MONOPOLY ---
  sydneyWater(
    'Sydney Water / Utility Grid',
    explanation: 'Extremely high fixed "Set-up Costs." It is most efficient for one firm to provide the service to reach "Economies of Scale" and avoid duplicating pipes.',
    subunit: Subunit.marketFailurePower,
  ),
  stateGridChina(
    'State Grid Corporation of China',
    explanation: 'An industry where the "Minimum Efficient Scale" is so large that the market can only support one producer profitably.',
    subunit: Subunit.marketFailurePower,
    tags: [Tag.hl],
  );

  // --- PROPERTIES ---
  final String example;
  final String? explanation;
  final Subunit? subunit;
  final List<Tag> tags;

  // --- CONSTRUCTOR ---
  const RealWorldExamples(
      this.example, {
        this.explanation,
        this.subunit,
        this.tags = const [],
      });
}