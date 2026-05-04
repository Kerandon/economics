import '../../../diagrams/enums/unit_type.dart';
import '../../enums/tag.dart';
import '../../models/term.dart';

enum RealWorldExamples {
  /// 2.4 Critique
  organDonationOptOut(
    'Organ Donation (Choice Architecture - Default Choice)',
    explanation:
    'Countries with "opt-out" systems have higher donation rates than "opt-in" systems, leveraging the default bias.',
    subunit: Subunit.critiqueBehaviour,
    tags: [Tag.hl],
  ),

  cafeteriaLayoutNudge(
    'School Cafeteria',
    explanation:
    'Placing healthy foods at eye-level nudges students toward healthier eating without banning junk food.',
    subunit: Subunit.critiqueBehaviour,

    tags: [Tag.hl],
  ),
  pianoStairs(
    'Piano Stairs (Sweden)',
    explanation:
    'A Stockholm subway turned stairs into a working piano, increasing stair usage by 66% by making exercise fun.',
    subunit: Subunit.critiqueBehaviour,
    tags: [Tag.hl],
  ),

  fatFreeFraming(
    '90% Fat-Free (Framing)',
    explanation:
    'Labeling milk "90% fat-free" instead of "10% fat" uses positive framing to make the exact same product seem healthier.',
    subunit: Subunit.critiqueBehaviour,
  ),

  hiddenCigarettes(
    'Hidden Cigarettes (Australia)',
    explanation:
    'Requiring stores to hide cigarettes behind cupboard doors adds friction, nudging consumers away from impulse purchases.',
    subunit: Subunit.critiqueBehaviour,
  ),
  patagoniaCSR(
    'Patagonia: Corporate Social Responsibility (CSR)',
    explanation:
    'Uses recycled materials and donates 1% of sales to environmental causes.',
    subunit: Subunit.critiqueBehaviour,
  ),
  unileverCSR(
    'Unilever: Corporate Social Responsibility (CSR)',
    explanation:
    'Focuses on sustainable sourcing and reducing environmental impact.',
    subunit: Subunit.critiqueBehaviour,
  ),
  /// PED
  airlinesPriceDiscrimination(
    'Airlines (e.g. Singapore Airlines, British Airways): PED and Price Discrimination',
    explanation:
        'Use PED to price discriminate; business travellers (inelastic) pay higher last-minute fares, while tourists (elastic) get cheaper advance tickets, increasing total revenue.',
    subunit: Subunit.elasticityDemand,
  ),

  cigaretteTaxRevenue(
    'Cigarette Taxes (e.g. UK, Australia): PED and Price Discrimination',
    explanation:
        'Governments tax cigarettes with PED < 1, so %∆Qd < %∆P; demand falls slightly while tax revenue remains stable or increases.',
    subunit: Subunit.elasticityDemand,
  ),

  disneylandPricing(
    'Disneyland (e.g. Shanghai, California): PED and Price Discrimination',
    explanation:
        'Uses PED-based price discrimination by charging higher peak/weekend prices (more inelastic demand) and lower off-peak prices to increase revenue.',
    subunit: Subunit.elasticityDemand,
  ),

 /// YED
  usSectorStructure(
    'USA: YED and Tertiary Sector',
    explanation:
    'The US economy is highly service-based: 80% of GDP comes from tertiary sector, ~19% from secondary, and 1% from primary sector. High development, productivity.',
    subunit: Subunit.elasticityDemand,
  ),
  burundiSectorStructure(
    'Burundi: Very High Primary Sector Dependence',
    explanation:
    'Primary sector over 1/3 of GDP and employs 85% of the workforce. Very low industrialisation / development.',
    subunit: Subunit.elasticityDemand,
  ),
  hongKongSectorShift(
    'Hong Kong: Shift to a Service Economy',
    explanation:
    'Hong Kong shifted from manufacturing to services: today tertiary is 90%+ of GDP (50 years ago 60%).',
    subunit: Subunit.elasticityDemand,
  ),
  // Oligopoly examples

  oligopolyXbox(
    'Xbox Game Pass (Bundling)',
    explanation:
    'Bundling (Oligopoly): Microsoft bundles hundreds of individual games into a single monthly subscription. This increases overall sales and makes it harder for competing services to attract players.',
    subunit: Subunit.marketFailurePower,
  ),
  oligopolyBigFourBanks(
    'Big Four Banks Australia',
    explanation:
        'Tacit collusion (oligopoly - interdependence): Firms avoid price wars through price leadership.',
    subunit: Subunit.marketFailurePower,
  ),

  oligopolyBigSuperMarketsAustralia(
    'Coles & Woolworths',
    explanation:
        'Implicit collusion (oligopoly - duopoly): Market power linked to higher grocery prices.',
    subunit: Subunit.marketFailurePower,
  ),

  oligopolyEVIndustryInChina(
    'BYD, Tesla, Xiaomi (EVs)',
    explanation:
        'Price competition + innovation (oligopoly - dynamic competition): strong R&D and price wars.',
    subunit: Subunit.marketFailurePower,
  ),

  oligopolyAIIndustry(
    'Google, OpenAI, DeepSeek',
    explanation:
        'R&D-driven competition (oligopoly - tech industry): high dynamic efficiency through innovation.',
    subunit: Subunit.marketFailurePower,
    tags: [Tag.hl],
  ),
  marketPowerAmazon(
    'Amazon (anti-competitive)',
    explanation:
    'Predatory pricing: temporarily setting very low prices (even below cost) to drive smaller competitors out of the market, then raising prices once market power is increased.',
    subunit: Subunit.marketFailurePower,
    tags: [Tag.hl],
  ),

  marketPowerMicrosoft(
    'Microsoft (anti-competitive)',
    explanation:
    'Bundling: combining products (e.g. operating system + browser/software) to reduce consumer choice and make it harder for rival firms to compete.',
    subunit: Subunit.marketFailurePower,
    tags: [Tag.hl],
  ),
  oligopolyBoeingAirbusDuopoly(
    'Boeing & Airbus',
    explanation:
        'Duopoly (oligopoly - duopoly): high barriers, compete via non-price factors (safety, efficiency).',
    subunit: Subunit.marketFailurePower,
  ),

  oligopolyOpecCartel(
    'OPEC',
    explanation:
        'Cartel (oligopoly - cartel): restricts output to increase oil prices.',
    subunit: Subunit.marketFailurePower,
    tags: [Tag.hl],
  ),

  // Monopolistic competition examples

  monopolisticCompetitionMelbourneCoffeeShops(
    'Melbourne Coffee Shops',
    explanation:
        'Monopolistic competition: many firms, low barriers, product differentiation.',
    subunit: Subunit.marketFailurePower,
  ),

  monopolisticCompetitionSydneyHairSalons(
    'Sydney Hair Salons',
    explanation:
        'Monopolistic competition: differentiated services, easy entry and exit.',
    subunit: Subunit.marketFailurePower,
  ),

  monopolisticCompetitionShanghaiRestaurants(
    'Shanghai Restaurants',
    explanation:
        'Monopolistic competition: many firms, strong non-price competition.',
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
  marketPowerPharmaceuticalPatents(
    'Patented Life-Saving Drugs',
    explanation:
        'PRO: High abnormal profits provide the incentive for expensive R&D. CON: Creates "Allocative Inefficiency" (P > MC).',
    subunit: Subunit.marketFailurePower,
    tags: [Tag.hl],
  ),

  // --- NATURAL MONOPOLY ---
  naturalMonopolyStateGridChina(
    'State Grid Corporation of China',
    explanation:
    'Extremely high fixed "Set-up Costs." It is most efficient for one firm to provide the service to reach "Economies of Scale" and avoid duplicating pipes.',
    subunit: Subunit.marketFailurePower,
    tags: [Tag.hl],
  ),
  naturalMonopolyChinaRailway(
    'China State Railway Group',
    explanation:
    'Extremely high fixed costs for infrastructure like tracks and stations. It is most efficient for one firm to provide the service to reach "Economies of Scale" and avoid duplicating railway networks.',
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
    tags: [],
  ),

  germanyApprenticeshipSystem(
    'Dual Apprenticeship System (Germany)',
    explanation:
        'Vocational training system improves skills and reduces structural unemployment.',
    subunit: Subunit.supplySidePolicies,
    tags: [],
  ),

  burundiBarriersToDevelopment(
    'Burundi (East Africa) – Barriers to Development',
    explanation:
        'Burundi is a landlocked ELDC in East Africa facing multiple barriers to development. Around 85% of employment is in agriculture, showing heavy dependence on low-productivity primary sector activity. Limited infrastructure, weak human capital, poor governance, and restricted access to international markets constrain development. Its geography and tropical climate also contribute to disease burdens and low productivity.',
    subunit: Subunit.sustainableDevelopment,
  ),
  bangladeshBarriersToDevelopment(
    'Bangladesh (South Asia) – Barriers to Development',
    explanation:
        'Bangladesh is a developing country facing several structural barriers to development. A significant share of employment is still in low-productivity agriculture and informal urban work, limiting productivity growth. It also faces vulnerability to climate change (flooding and cyclones), high population density, infrastructure constraints, and uneven access to education and healthcare, despite recent strong export-led growth in garments.',
    subunit: Subunit.sustainableDevelopment,
  ),
  boliviaBarriersToDevelopment(
    'Bolivia (South America) – Barriers to Development',
    explanation:
        'Bolivia is a landlocked developing country in South America facing structural barriers to development. Around 30% of employment is in agriculture, showing continued reliance on lower-productivity primary sector activity. It faces geographic isolation, limited access to international markets, weak infrastructure in rural areas, and regional inequality, despite recent improvements in poverty reduction.',
    subunit: Subunit.sustainableDevelopment,
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
