import '../../../diagrams/enums/unit_type.dart';
import '../../models/term.dart';

enum RealWorldExamples {
  /// PED
  airlinesPriceDiscrimination(
    'Airlines (e.g. Singapore Airlines, British Airways)',
    explanation:
        'Use PED to price discriminate; business travellers (inelastic) pay higher last-minute fares, while tourists (elastic) get cheaper advance tickets, increasing total revenue.',
    subunit: Subunit.elasticityDemand,
  ),

  cigaretteTaxRevenue(
    'Cigarette Taxes (e.g. UK, Australia)',
    explanation:
        'Governments tax cigarettes with PED < 1, so %∆Qd < %∆P; demand falls slightly while tax revenue remains stable or increases.',
    subunit: Subunit.elasticityDemand,
  ),

  disneylandPricing(
    'Disneyland (e.g. Shanghai, California)',
    explanation:
        'Uses PED-based price discrimination by charging higher peak/weekend prices (more inelastic demand) and lower off-peak prices to increase revenue.',
    subunit: Subunit.elasticityDemand,
  ),

  // --- OLIGOPOLY ---
  bigFourBanks(
    'Big-Four Banks in Australia (CBA, Westpac, NAB, ANZ)',
    explanation:
        'High strategic interdependence; when one bank changes mortgage rates, others typically follow within hours.',
    subunit: Subunit.marketFailurePower,
  ),
  bigSuperMarketsAustralia(
    'Coles and Woolworths (Australia)',
    explanation:
        'A "Duopoly" accused of using market power to squeeze suppliers and inflate grocery prices (Implicit Collusion).',
    subunit: Subunit.marketFailurePower,
  ),
  eVIndustryInChina(
    'Xiaomi, Tesla, BYD',
    explanation:
        'Fierce "Price Wars" and rapid innovation (Non-price competition) to capture market share in a growing industry.',
    subunit: Subunit.marketFailurePower,
  ),
  llmMarket(
    'Google (Gemini), Anthropic (Claude), OpenAI (ChatGPT)',
    explanation:
        'A modern "Tech Oligopoly" where firms compete through massive R&D and rapid feature releases.',
    subunit: Subunit.marketFailurePower,
    tags: [Tag.hl],
  ),

  // --- MONOPOLISTIC COMPETITION ---
  shanghaiCoffeeShops(
    'Coffee Shops in Shanghai / Melbourne',
    explanation:
        'Many sellers with low barriers to entry. Each shop uses "Brand Differentiation" (vibe, specialty beans) to gain some price-making power.',
    subunit: Subunit.marketFailurePower,
  ),
  fastFashion(
    'Zara, H&M, Uniqlo',
    explanation:
        'Products are similar but not identical. Heavy reliance on advertising and branding to create "Perceived Differentiation."',
    subunit: Subunit.marketFailurePower,
  ),

  // --- PERFECT COMPETITION (Closest Real-World Approximations) ---
  wheatFarmers(
    'Global Wheat or Corn Markets',
    explanation:
        'Large number of buyers and sellers dealing with a "Homogeneous Product." Farmers are "Price Takers" based on global exchange prices.',
    subunit: Subunit.marketFailurePower,
  ),
  forexMarket(
    'Foreign Exchange (USD/AUD)',
    explanation:
        'Almost perfect information and a perfectly standardized product. No single buyer or seller can influence the market price.',
    subunit: Subunit.marketFailurePower,
    tags: [Tag.hl],
  ),

  // --- MONOPOLY (Pros & Cons) ---
  luxottica(
    'Luxottica (Eyewear)',
    explanation:
        'Controls ~80% of major eyewear brands (Ray-Ban, Oakley). CON: Higher prices for consumers due to lack of viable substitutes.',
    subunit: Subunit.marketFailurePower,
  ),
  pharmaceuticalPatents(
    'Patented Life-Saving Drugs',
    explanation:
        'PRO: High abnormal profits provide the incentive for expensive R&D. CON: Creates "Allocative Inefficiency" (P > MC).',
    subunit: Subunit.marketFailurePower,
    tags: [Tag.hl],
  ),

  // --- NATURAL MONOPOLY ---
  sydneyWater(
    'Sydney Water / Utility Grid',
    explanation:
        'Extremely high fixed "Set-up Costs." It is most efficient for one firm to provide the service to reach "Economies of Scale" and avoid duplicating pipes.',
    subunit: Subunit.marketFailurePower,
  ),
  stateGridChina(
    'State Grid Corporation of China',
    explanation:
        'An industry where the "Minimum Efficient Scale" is so large that the market can only support one producer profitably.',
    subunit: Subunit.marketFailurePower,
    tags: [Tag.hl],
  ),
  oilCrisisStagflationUSA1970s(
    '1973–74 Oil Shock Causes Stagflation in USA',
    explanation:
        'OPEC oil embargo: oil prices rose \$3 to ~\$12/barrel. USA high inflation + high unemployment.',
    subunit: Subunit.macroObjectives,
    tags: [Tag.hl],
  ),

  economicBoomOf1990s(
    '1990s USA: Strong real GDP growth and low inflation',
    explanation:
        'US real GDP was strong ~4% (late 1990s), unemployment fell to ~4% (2000) while inflation remained low ~3%.',
    subunit: Subunit.macroObjectives,
    tags: [Tag.hl],
  ),

  globalFinancialCrisis2008(
    '2008–09 Global Financial Crisis',
    explanation:
        'US unemployment rose from ~5% (2007) to ~10% (2009) while inflation fell to ~-0.4% (2009).',
    subunit: Subunit.macroObjectives,
    tags: [Tag.hl],
  ),

  covidPandemic2020(
    '2020 COVID-19 Pandemic',
    explanation:
        'US unemployment spiked to ~14.7% (Apr 2020) while inflation initially fell ~0.1%.',
    subunit: Subunit.macroObjectives,
    tags: [Tag.hl],
  ),

  postPandemicInflation2022(
    '2021–22 Inflation Surge (US/UK)',
    explanation:
        'US inflation peaked ~9.1% (2022) with unemployment ~3.5% → Phillips Curve shift, unstable trade-off.',
    subunit: Subunit.macroObjectives,
    tags: [Tag.hl],
  ),

  usFinancialCrisis2008(
    '2008–14 Global Financial Crisis (US)',
    explanation:
        'Fed cut rates to ~0–0.25% and used QE (> \$3 trillion) → lower borrowing costs, boosting C and I, shifting AD right.',
    subunit: Subunit.demandManagementMonetary,
    tags: [Tag.hl, Tag.p1b],
  ),
  japanLiquidityTrap1990s(
    '1990s–Present Liquidity Trap (Japan)',
    explanation:
        'Despite 0% interest rates, negative consumer and firm confidence remained.',
    subunit: Subunit.demandManagementMonetary,
    tags: [Tag.hl, Tag.p1b],
  ),
  eurozoneNegativeRates2014(
    '2014–19 Negative Interest Rates (Eurozone)',
    explanation: '',
    subunit: Subunit.demandManagementMonetary,
    tags: [Tag.hl, Tag.p1b],
  ),

  /// Supply-side policies

  // 1. Competition / Market-based reforms

  ukPrivatizationDeregulation1980s(
    '1980s Deregulation (UK) - Supply-Side Market Based Policies',
    explanation:
        'Privatization of state-owned monopolies (British Telecom, Gas, Airways, Steel) and deregulation (reduce waste, increase competition, efficiency).',
    subunit: Subunit.supplySidePolicies,
    tags: [Tag.hl],
  ),
  ukTradeUnionReform1980s(
    '1980s Trade Union Reforms (UK)',
    explanation:
        'Reduced union power increased labour flexibility and reduced wage rigidity.',
    subunit: Subunit.supplySidePolicies,
    tags: [Tag.hl],
  ),

  chinaReformsPost1978(
    'Post-1978 Market Reforms (China)',
    explanation:
        '1978 Special Economic Zones (China), Shenzhen (average GDP growth 20%pa), to encourage FDI, competition, efficiency, trade liberalization (China economy is 48X bigger 1978-2024).',
    subunit: Subunit.supplySidePolicies,
    tags: [Tag.hl],
  ),

  // Added
  indiaLiberalisation1991(
    '1991 Economic Liberalisation (India) (market-based deregulation / LMR)',
    explanation:
        'Reduced "Licence Raj" (system of state control over economy). Significant deregulation, reduce trade barriers to increased competition and growth.',
    subunit: Subunit.supplySidePolicies,
    tags: [Tag.hl],
  ),

  // 2. Labour Market Reforms (LMR)

  germanyHartz2000s(
    '2000s Hartz Reforms (Germany) - LMR',
    explanation:
        'Labor-market had excessive rigidities. Reduced unemployment benefits, and increased flexibility (easier to hire/fire), lowering structural unemployment (reducing NRU). Unemployment fall from 11%+ peak in 2005 to under 5% by 2019..',
    subunit: Subunit.supplySidePolicies,
    tags: [Tag.hl],
  ),

  // Added
  spainLabourReform2012(
    '2012 Labour Market Reform (Spain)',
    explanation:
        'Made hiring/firing easier, improving flexibility and reducing unemployment.',
    subunit: Subunit.supplySidePolicies,
    tags: [Tag.hl],
  ),

  // 3. Incentive-based policies

  // Replaced 2001 with the more recent and impactful 2017 TCJA
  usTaxCutsAndJobsAct2017(
    '2017 Tax Cuts and Jobs Act (USA)',
    explanation:
        'Slashed the federal corporate tax rate from 35% to 21%, significantly increasing after-tax profits to incentivize capital investment and R&D.',
    subunit: Subunit.supplySidePolicies,
    tags: [Tag.hl],
  ),

  // Added specific rate reduction stats
  ukCorporationTaxCuts2010s(
    '2010–2017 Corporation Tax Cuts (UK)',
    explanation:
        'Gradually reduced the main corporate tax rate from 28% to 19%, directly incentivizing domestic firm expansion and attracting foreign direct investment (FDI).',
    subunit: Subunit.supplySidePolicies,
    tags: [Tag.hl],
  ),

  // 4. Government intervention (human/physical capital)

  singaporeSkillsFuture2015(
    '2015 SkillsFuture (Singapore)',
    explanation:
        'Provided adult citizens with base \$500 credits for lifelong learning, helping raise the national training participation rate from 35% to roughly 50% to boost long-run human capital and productivity.',
    subunit: Subunit.supplySidePolicies,
    tags: [Tag.hl],
  ),

  chinaBRI2013(
    '2013 Belt and Road Initiative (China)',
    explanation:
        'Large infrastructure investment improved connectivity and long-run growth.',
    subunit: Subunit.supplySidePolicies,
    tags: [Tag.hl],
  ),

  usInflationReductionAct2022(
    '2022 Inflation Reduction Act (USA)',
    explanation:
        'Subsidies for clean energy and manufacturing increased investment and LRAS.',
    subunit: Subunit.supplySidePolicies,
    tags: [Tag.hl],
  ),

  // Added
  southKoreaIndustrialPolicy(
    '1960s–90s Industrial Policy (South Korea)',
    explanation:
        'Targeted subsidies and export promotion developed high-value industries.',
    subunit: Subunit.supplySidePolicies,
    tags: [Tag.hl],
  ),

  germanyApprenticeshipSystem(
    'Dual Apprenticeship System (Germany)',
    explanation:
        'Vocational training system improves skills and reduces structural unemployment.',
    subunit: Subunit.supplySidePolicies,
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
