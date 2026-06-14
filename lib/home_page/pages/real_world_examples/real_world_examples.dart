import '../../../diagrams/enums/unit_type.dart';
import '../../enums/tag.dart';
import '../../models/term.dart';

/// Helper class to hold individual example data
class ExampleDetail {
  final String title;
  final String explanation;
  final List<Tag> tags;

  const ExampleDetail({
    required this.title,
    required this.explanation,
    this.tags = const [],
  });
}

enum RealWorldExamples {
  /// 2.4 Critique
  critiqueBehaviour(
    topicName: 'Critique of Economic Behavior',
    subunit: Subunit.critiqueBehaviour,
    examples: [
      ExampleDetail(
        title: 'Organ Donation (Choice Architecture: Default Choice)',
        explanation:
            'France - automatically enrolled as an organ donor if you die (unless you opt-out).',
        tags: [Tag.hl],
      ),
      ExampleDetail(
        title: 'School Cafeteria (Nudges)',
        explanation:
            'Healthy food placement nudges students toward better choices.',
        tags: [Tag.hl],
      ),
      ExampleDetail(
        title: 'Tax Collection (Social Norms)',
        explanation:
            'The UK government increased on-time tax payments by sending letters stating how many people in the local area had already paid their taxes.',
        tags: [Tag.hl],
      ),
      ExampleDetail(
        title: 'Piano Stairs (Sweden)',
        explanation:
            'Piano stairs encourage exercise instead of taking elevator.',
        tags: [Tag.hl],
      ),
      ExampleDetail(
        title: 'Plain Packaging (Australia)',
        explanation:
            'Australia bans cigarette branding and mandates graphic images (of real sick people) to nudge people to quit smoking.',
        tags: [Tag.hl],
      ),
      ExampleDetail(
        title: 'Tyson Foods (Choice Architecture: Framing)',
        explanation: 'Tyson markets beef as "90% Lean" rather than "10% Fat',
        tags: [Tag.hl],
      ),
      ExampleDetail(
        title: 'Hidden Cigarettes (Australia) - Nudges',
        explanation:
            'Australia law - must hide cigarettes (e.g., in a cabinet) in the store (reduce impulse purchases).',
      ),
      ExampleDetail(
        title: 'CSR (Tony\'s Chocolonely - chocolate brand)',
        explanation:
            '100% traceable cocoa, living income for farmers, combats child labor, deforestation-free.',
      ),

      ExampleDetail(
        title: 'CSR (Ben & Jerry\'s - ice cream brand)',
        explanation:
            'Fairtrade ingredients, profit donations for social / climate causes.',
      ),

      ExampleDetail(
        title: 'CSR (Patagonia - outdoor clothing brand)',
        explanation: 'Recycled materials, ethical sourcing, lower emissions.',
      ),
    ],
  ),
  cSR(
    topicName: 'Corporate Social Responsibility',
    subunit: Subunit.critiqueBehaviour,
    examples: [
      ExampleDetail(
        title: 'Hidden Cigarettes (Australia)',
        explanation: 'Retail display restriction reduces impulse smoking.',
      ),
      ExampleDetail(
        title: 'Patagonia / Unilever CSR',
        explanation:
            'Environmental responsibility via sustainable materials and sourcing.',
      ),
    ],
  ),

  /// PED
  pedPriceDiscrimination(
    topicName: 'PED and Price Discrimination',
    subunit: Subunit.elasticityDemand,
    examples: [
      ExampleDetail(
        title:
            'PED - Price Discrimination (Airlines, e.g., British Airways, Qantas, etc.)',
        explanation:
            'Business travelers pay higher fares (inelastic demand) while leisure tourists get cheaper tickets (elastic demand).',
      ),

      ExampleDetail(
        title: 'PED - Price Discrimination - Disneyland Shanghai Tickets',
        explanation:
            'Higher prices during holidays/summer (inelastic) and lower prices on weekdays/off-season (elastic).',
      ),

      ExampleDetail(
        title: 'New Zealand - Alcohol Excise Tax',
        explanation:
            'Inelastic demand enables steady revenue from high excise taxes on beer, wine & spirits.',
      ),
      ExampleDetail(
        title: 'Uber Surge Pricing',
        explanation:
            'Prices increase during peak hours/rain (inelastic) and drop during low demand (elastic).',
      ),
    ],
  ),

  /// YED
  yedSectorStructure(
    topicName: 'YED and Sector Structure',
    subunit: Subunit.elasticityDemand,
    examples: [
      ExampleDetail(
        title: 'USA Economy - YED tertiary sector dominate',
        explanation:
            'Service-dominated economy: almost 77% of GDP in tertiary sector; 1% in primary sector. highly developed.',
      ),
      ExampleDetail(
        title: 'New Zealand Economy - YED highly developed economy',
        explanation:
            'Developed country with strong primary sector: 7% from agricultural but still 77% in services (developed)',
      ),
      ExampleDetail(
        title: 'Burundi - YED underdeveloped economic sectors',
        explanation:
            'Agriculture-dominated (85% employment is in primary sector), low development.',
      ),
      ExampleDetail(
        title: 'Hong Kong Transition - YED structural change',
        explanation:
            'Services rose from 67% of GDP in 1980 - to 93% today, as manufacturing declined sharply.',
      ),
    ],
  ),

  /// 2.7 Government Intervention
  priceFloorMinWageExamples(
    topicName: 'Price Floor (Min Wage)',
    subunit: Subunit.roleOfGovernment,
    examples: [
      ExampleDetail(
        title: 'Minimum Wage in California (price floor)',
        explanation:
            'In 2024 California set a \$20/hour minimum wage for fast food workers, above equilibrium, risking unemployment.',
      ),
      ExampleDetail(
        title: 'Australia National Minimum Wage (price floor)',
        explanation:
            'One of the highest in the world at \$24.95/hour (2025) to support low-skilled workers.',
      ),
    ],
  ),
  priceFloorAgricultural(
    topicName: 'Price Floor (Agri)',
    subunit: Subunit.roleOfGovernment,
    examples: [
      ExampleDetail(
        title: 'Common Agricultural Policy (CAP) in the European Union',
        explanation:
            'CAP maintains price floors via subsidies, costing about €55 billion annually and creating surpluses.',
      ),
      ExampleDetail(
        title: 'Minimum Support Price (MSP) in India',
        explanation:
            'India has MSP to protect farmer incomes to guarantee a minimum income.',
      ),
    ],
  ),
  priceCeilingExamples(
    topicName: 'Price Ceiling',
    subunit: Subunit.roleOfGovernment,
    examples: [
      ExampleDetail(
        title: 'Rent Control in New York City',
        explanation:
            'NYC rent control caps rents for over 1 million apartments, causing shortages and reduced supply of rental housing.',
      ),
      ExampleDetail(
        title: 'Gasoline (Price Ceiling) - Philippines',
        explanation:
            'During 2026 oil shock, government capped fuel price hikes to protect consumers, leading to supply issues and panic buying.',
      ),
      ExampleDetail(
        title: 'Insulin (Price Ceiling) in USA',
        explanation:
            'The US capped insulin at \$35/month for Medicare patients in 2023.',
      ),
    ],
  ),

  /// 2.8 Externalities / CPR
  negativeProductionExternalities(
    topicName: 'Negative Production Externalities',
    subunit: Subunit.marketFailureExternalitiesCPR,
    examples: [
      ExampleDetail(
        title: 'Bluefin Tuna Overfishing',
        explanation:
            'Pacific stocks declined by 95% due to industrial overfishing.',
      ),

      ExampleDetail(
        title: 'Sweden Carbon Tax',
        explanation:
            'Cut emissions around 25% since 1991 while real GDP grew strongly.',
      ),

      ExampleDetail(
        title: 'New Zealand Fisheries Quotas (ITQ)',
        explanation:
            'Individual Transferable Quotas since 1986 (permits for fishing - caps total limit - market-based).',
      ),

      ExampleDetail(
        title: 'EU Emissions Trading System (ETS)',
        explanation:
            'Cap-and-trade system reduced emissions by 50% since 2005.',
      ),

      ExampleDetail(
        title: 'US Clean Air Act - Tradeable Permits',
        explanation:
            'Cap-and-trade for SO₂ under 1990 Amendments reduced power plant emissions by more than 90% since 1990.',
      ),

      ExampleDetail(
        title: 'Belgium Coal Phase-out - Regulations',
        explanation: 'Fully banned coal-fired power generation by 2016.',
      ),
    ],
  ),
  negativeConsumptionExternalities(
    topicName: 'Negative Consumption Externalities',
    subunit: Subunit.marketFailureExternalitiesCPR,
    examples: [
      ExampleDetail(
        title: 'UK Sugar Tax (Soft Drinks Levy)',
        explanation: 'Sugar content in drinks fell 44% since 2018.',
      ),
      ExampleDetail(
        title: 'Australia Tobacco Tax',
        explanation: 'Cigarette prices AUD \$40+ per pack; smoking rate ~10%.',
      ),
      ExampleDetail(
        title: 'New Zealand Plastic Bag Ban',
        explanation: 'Single-use plastic bag use fell >90% since 2019 ban.',
      ),
      ExampleDetail(
        title: 'US Anti-Smoking Campaigns (CDC) - Education Awareness',
        explanation: 'Smoking prevalence fell from 21% (2005) to 11% (2023).',
      ),
      ExampleDetail(
        title: 'Australia Plain Packaging Law',
        explanation:
            'Cannot advertise brand - packets have education such as \'SMOKING CAUSES CANCER\' in big font and pictures of sick people.',
      ),
      ExampleDetail(
        title: 'London Congestion Charge',
        explanation: 'Traffic entering central London of £18 per day.',
      ),
    ],
  ),
  positiveProductionExternalities(
    topicName: 'Positive Production Externalities',
    subunit: Subunit.marketFailureExternalitiesCPR,
    examples: [
      ExampleDetail(
        title: 'mRNA Vaccines',
        explanation:
            'COVID vaccines research in mRNA spillovers into cancer research vaccinations. Over 120 clinical trials for cancers such as breast and prostate.',
      ),
      ExampleDetail(
        title: 'Quantum Computing',
        explanation:
            'Billions invested globally (e.g. IBM, Google) with cross-sector spillovers.',
      ),
      ExampleDetail(
        title: 'China Solar Industry',
        explanation:
            'Solar panel costs fell 80% since 2010 due to scale economies.',
      ),
      ExampleDetail(
        title: 'High-Speed Rail (China)',
        explanation:
            'Network exceeds 40,000 km, boosting regional productivity.',
      ),
    ],
  ),
  positiveConsumptionExternalities(
    topicName: 'Positive Consumption Externalities',
    subunit: Subunit.marketFailureExternalitiesCPR,
    examples: [
      ExampleDetail(
        title: '\'No-Jab No-Pay\' Policy (Australia) - Regulations',
        explanation: 'Vaccination required to receive childcare subsidies.',
      ),
      ExampleDetail(
        title: 'Vaccination Subsidies (UK)',
        explanation: 'Free NHS vaccinations for all children.',
      ),
      ExampleDetail(
        title: 'Finland Free Public Education',
        explanation: 'Near 100% adult literacy rate.',
      ),
      ExampleDetail(
        title: 'Singapore Gym & Sport Subsidies',
        explanation:
            'Subsidised gym memberships via ActiveSG promote exercise and high life expectancy (~84 years).',
      ),
      ExampleDetail(
        title: 'Free Childcare (UK 30-hour scheme)',
        explanation:
            '30 hours free weekly childcare boosts female labour participation.',
      ),
      ExampleDetail(
        title: 'Compulsory Schooling (China)',
        explanation: '9 years compulsory education from age 6 to 15.',
      ),
      ExampleDetail(
        title: 'COVID Vaccination App (China)',
        explanation:
            'Green Health Code system encouraged high vaccination rates.',
      ),
    ],
  ),

  /// 2.9 Public Goods
  publicGoodsDirectProvisionExamples(
    topicName: 'Public Goods - Direct Provision',
    subunit: Subunit.marketFailurePublicGoods,
    examples: [
      ExampleDetail(
        title: 'UK NHS',
        explanation:
            'Free universal healthcare in UK; budget exceeds £180bn - but long-wait times.',
      ),
      ExampleDetail(
        title: 'Singapore Defence',
        explanation: 'Publicly funded military.',
      ),
    ],
  ),
  publicGoodsContractingOutExamples(
    topicName: 'Public Goods - Contracting Out',
    subunit: Subunit.marketFailurePublicGoods,
    examples: [
      ExampleDetail(
        title: 'US Defence Contracts (Pentagon procurement)',
        explanation:
            'Lockheed Martin supply F-35 programme cost overrun exceeded \$1.7 trillion.',
      ),
      ExampleDetail(
        title: 'NASA / SpaceX',
        explanation: 'SpaceX helped NASA reduce launch costs.',
      ),
    ],
  ),

  /// 2.10 Asymmetric information
  adverseSelectionExamples(
    topicName: 'Adverse Selection',
    subunit: Subunit.marketFailureAsymmetricInformation,
    examples: [
      ExampleDetail(
        title: 'Used Cars Market',
        explanation: 'Information gaps reduce average quality traded.',
      ),
      ExampleDetail(
        title: 'Insurance Market',
        explanation: 'High-risk individuals dominate market, raising premiums.',
      ),
    ],
  ),
  moralHazardExamples(
    topicName: 'Moral Hazard',
    subunit: Subunit.marketFailureAsymmetricInformation,
    examples: [
      ExampleDetail(
        title: 'Car Insurance',
        explanation: 'Insured drivers take more risks.',
      ),
      ExampleDetail(
        title: '2008 Financial Crisis',
        explanation: 'Risky lending encouraged by bailout expectations.',
      ),
    ],
  ),

  /// 2.10 Market Power & Market Structures
  perfectCompetitionApproximations(
    topicName: 'Perfect Competition',
    subunit: Subunit.marketFailureMarketPower,
    examples: [
      ExampleDetail(
        title: 'Wheat Markets',
        explanation:
            'Global wheat price set on world markets; millions of farmers act as price takers.',
      ),
      ExampleDetail(
        title: 'Forex Market (Foreign Exchange Market)',
        explanation:
            'Over 7.5 trillion US dollars traded daily. Identical good (e.g., a currency USD\$; many buyers/sellers; perfect information on exchange rate).',
        tags: [Tag.hl],
      ),
    ],
  ),
  monopolisticCompetition(
    topicName: 'Monopolistic Competition',
    subunit: Subunit.marketFailureMarketPower,
    examples: [
      ExampleDetail(
        title: 'Melbourne Cafés',
        explanation:
            'Over 3000 cafés operate in a highly differentiated local service market.',
      ),
      ExampleDetail(
        title: 'Sydney Hair Salons',
        explanation:
            'Thousands of small hair salons compete with low barriers to entry.',
      ),
      ExampleDetail(
        title: 'Shanghai Restaurants',
        explanation:
            'Many small/medium restaurants, product differentiation (Chinese, Indian, American cuisine), but lots of close substitutes for consumers and low barriers to enter/exit.',
      ),
    ],
  ),
  oligopoly(
    topicName: 'Oligopoly Behavior',
    subunit: Subunit.marketFailureMarketPower,
    examples: [
      ExampleDetail(
        title: 'Australian Banks',
        explanation:
            'Top four banks control around 80 percent of lending market share. Interdependent on setting interest rates.',
      ),
      ExampleDetail(
        title: 'Coles and Woolworths',
        explanation:
            'Duopoly accounts for around 65 percent of supermarket sales. Accused \'tacit collusion\' avoid price-wars and keep grocery prices high to earn abnormal profits.',
      ),
      ExampleDetail(
        title: 'Chinese EV Market',
        explanation:
            'BYD holds over 30 percent of domestic electric vehicle sales. Highly competitive oligopoly with high innovation (dynamic efficiency / non-price competition by nw features)',
      ),
      ExampleDetail(
        title: 'AI Industry',
        explanation:
            'Major firms invest over 10 billion US dollars annually in AI research. Incredible dynamic efficiency (innovation)',
        tags: [Tag.hl],
      ),
      ExampleDetail(
        title: 'Coca-Cola and Pepsi',
        explanation:
            'Together hold over 40 percent of global soft drink market share. Very interdependent on pricing.',
      ),
      ExampleDetail(
        title: 'Boeing and Airbus',
        explanation:
            'Duopoly controls 90%+ of large commercial aircraft market. Desirable due to massive economies of scale for industry, and regulatory barriers (aircraft highly regulated).',
      ),
      ExampleDetail(
        title: 'OPEC',
        explanation:
            'Controls around 80 percent of global proven oil reserves. 1973 oil-embargo caused supply-shock. Restrict output to force high prices. Challenges to maintain oligopoly (different costs, split profits, agreements, political conflicts).',
        tags: [Tag.hl],
      ),
    ],
  ),
  naturalMonopoly(
    topicName: 'Natural Monopoly',
    subunit: Subunit.marketFailureMarketPower,
    examples: [
      ExampleDetail(
        title: 'Electricity Grid (China)',
        explanation: 'Very high fixed infrastructure costs (sunk costs)',
        tags: [Tag.hl],
      ),
      ExampleDetail(
        title: 'Rail Networks',
        explanation:
            'High fixed costs mean one provider can supply at lower average cost. 40,000km of tracks.',
        tags: [Tag.hl],
      ),
      ExampleDetail(
        title: 'Sydney Water (Australia)',
        explanation:
            'Single provider for water pipes, treatment plants and sewerage (very high fixed costs)',
        tags: [Tag.hl],
      ),
    ],
  ),
  abuseOfMonopolyPower(
    topicName: 'Abuse of Monopoly Power',
    subunit: Subunit.marketFailureMarketPower,
    examples: [
      ExampleDetail(
        title: 'Google',
        explanation:
            'Abused dominance by self-preferencing Google Shopping and Android apps.',
        tags: [Tag.hl],
      ),
      ExampleDetail(
        title: 'Amazon',
        explanation:
            'Used marketplace power to copy successful third-party sellers and favour own products.',
        tags: [Tag.hl],
      ),
      ExampleDetail(
        title: 'Meta (Facebook)',
        explanation:
            'Acquired Instagram and WhatsApp to eliminate future competition.',
        tags: [Tag.hl],
      ),
    ],
  ),
  macroeconomicShocks(
    topicName: 'Macroeconomic Objectives and Shocks',
    subunit: Subunit.macroObjectives,
    examples: [
      ExampleDetail(
        title: '1973 Oil Supply-Shock United States',
        explanation:
            'Oil price rose from about 3 dollars to 12 dollars per barrel causing stagflation (high inflation and high unemployment SRPC shifted out).',
        tags: [Tag.hl],
      ),
      ExampleDetail(
        title: '2008 Global Financial Crisis',
        explanation:
            'Unemployment in the United States rose from about 5 percent to 10 percent.',
        tags: [Tag.hl],
      ),
      ExampleDetail(
        title: '2022 Inflation Surge United States',
        explanation:
            'Inflation peaked at 9.1 percent while unemployment remained around 3.5 percent.',
        tags: [Tag.hl],
      ),
    ],
  ),
  monetaryPolicy(
    topicName: 'Demand Management Monetary Policy',
    subunit: Subunit.demandManagementMonetary,
    examples: [
      ExampleDetail(
        title: 'Japan Quantitative Easing 2013–2020s',
        explanation:
            'The Bank of Japan used prolonged quantitative easing and near-zero interest rates to increase aggregate demand, but inflation and economic growth remained weak due to low consumer spending and inflation expectations.',
        tags: [Tag.hl, Tag.p1b],
      ),
      ExampleDetail(
        title: 'United States Expansionary Monetary Policy 2020',
        explanation:
            'The Federal Reserve reduced interest rates to near zero and implemented over 4 trillion US dollars of quantitative easing to support aggregate demand during the COVID-19 recession.',
        tags: [Tag.hl, Tag.p1b],
      ),
      ExampleDetail(
        title: 'Eurozone Expansionary Monetary Policy 2020',
        explanation:
            'The European Central Bank maintained near-zero and negative interest rates while expanding quantitative easing, but high uncertainty limited the increase in aggregate demand.',
        tags: [Tag.hl, Tag.p1b],
      ),
      ExampleDetail(
        title: 'United States Contractionary Monetary Policy 2022–2023',
        explanation:
            'The Federal Reserve increased interest rates rapidly to reduce demand-pull inflation by decreasing consumption, investment, and aggregate demand.',
        tags: [Tag.hl, Tag.p1b],
      ),
    ],
  ),
  fiscalPolicy(
    topicName: 'Demand Management Fiscal Policy',
    subunit: Subunit.demandManagementFiscal,
    examples: [
      ExampleDetail(
        title: 'United States CARES Act 2020',
        explanation:
            'A 2.3 trillion US dollar expansionary fiscal policy package that included cash transfers to households, enhanced unemployment benefits, and support for businesses to increase aggregate demand during the COVID-19 recession.',
        tags: [Tag.hl, Tag.p1b],
      ),
      ExampleDetail(
        title: 'United States American Rescue Plan 2021',
        explanation:
            'A 1.9 trillion US dollar fiscal stimulus package that increased transfer payments, supported state governments, and boosted consumption and aggregate demand during the economic recovery.',
        tags: [Tag.hl, Tag.p1b],
      ),
      ExampleDetail(
        title: 'Singapore Fiscal Stimulus 2020',
        explanation:
            'Large-scale government spending, wage subsidies, and business support helped limit unemployment and support aggregate demand during the COVID-19 recession.',
        tags: [Tag.hl, Tag.p1b],
      ),
      ExampleDetail(
        title: 'China Fiscal Stimulus 2008–2009',
        explanation:
            'China implemented a 4 trillion yuan expansionary fiscal stimulus focused on infrastructure, housing, and transport projects to increase aggregate demand and support economic growth during the Global Financial Crisis.',
        tags: [Tag.hl, Tag.p1b],
      ),
    ],
  ),
  supplySideMarketBased(
    topicName: 'Supply-Side Policies (Market-Based)',
    subunit: Subunit.supplySidePolicies,
    examples: [
      ExampleDetail(
        title: 'UK Privatisation (1980s)',
        explanation:
            'Over 50 state-owned enterprises (e.g., British Telecom) were privatised, increasing efficiency and competition.',
      ),
      ExampleDetail(
        title: 'India Economic Reforms (1991)',
        explanation:
            'Dismantled "Licence Raj" (bureaucracy); trade liberalisation raised GDP growth from ~2% to over 6% in the 1990s.',
      ),
      ExampleDetail(
        title: 'China SEZs (Post-1978)',
        explanation:
            'SEZs like Shenzhen attracted FDI; GDP growth averaged ~10%, with ~800 million lifted out of poverty.',
      ),
      ExampleDetail(
        title: 'US Airline Deregulation (1978)',
        explanation:
            'Removal of price controls increased competition; real airfares fell by ~30%.',
      ),
      ExampleDetail(
        title: 'US Tax Cuts and Jobs Act (2017)',
        explanation:
            'Corporate tax cut from 35% to 21%, boosting investment but increasing inequality and deficit.',
      ),
      ExampleDetail(
        title: 'UK Trade Union Reforms (1980s)',
        explanation:
            'Reduced union power and strikes, improving labour market flexibility.',
      ),
      ExampleDetail(
        title: 'Germany Hartz Reforms (2003–2005)',
        explanation:
            'Labour market reforms (reduced unemployment benefits / easier to hire/fire) cut unemployment from ~11% (2005) to below 5% by 2015.',
      ),
    ],
  ),
  supplySideInterventionist(
    topicName: 'Supply-Side Policies (Interventionist)',
    subunit: Subunit.supplySidePolicies,
    examples: [
      ExampleDetail(
        title: 'US Inflation Reduction Act (2022)',
        explanation:
            '\$369 billion invested in clean energy to expand long-run productive capacity.',
      ),
      ExampleDetail(
        title: 'South Korea R&D Investment',
        explanation:
            'R&D spending exceeds 4% of GDP, supporting high-tech industry growth.',
      ),
      ExampleDetail(
        title: 'China Belt and Road Initiative (2013–)',
        explanation:
            'Over \$1 trillion invested in infrastructure, boosting global trade links.',
      ),
      ExampleDetail(
        title: 'China “Big Fund” (Semiconductors)',
        explanation:
            'State-backed fund (since 2014) invested over \$50 billion to develop domestic chip industry and reduce reliance on imports.',
      ),
      ExampleDetail(
        title: 'China EV Subsidies',
        explanation:
            'Government subsidies (2009–2022) helped China become the largest EV market, accounting for ~60% of global EV sales by 2023.',
      ),
      ExampleDetail(
        title: 'US Infrastructure Investment (2021)',
        explanation:
            '\$1.2 trillion plan; significant time lags before increasing AS.',
      ),
      ExampleDetail(
        title: 'Singapore SkillsFuture',
        explanation:
            'Government-funded training credits to improve human capital and productivity.',
      ),
      ExampleDetail(
        title: 'Germany Apprenticeship System',
        explanation:
            'Dual education system keeps youth unemployment below ~6%.',
      ),
      ExampleDetail(
        title: 'Post-COVID Inflation (2021–2022)',
        explanation:
            'US inflation peaked at ~9% due to AD recovery and supply bottlenecks, highlighting short-run inflation risks of intervention.',
      ),
    ],
  ),
  foreignDirectInvestmentExamples(
    topicName: 'FDI – Real World Examples (Costs and Benefits)',
    subunit: Subunit.sustainableDevelopment,
    examples: [
      ExampleDetail(
        title: 'China – Manufacturing FDI Growth',
        explanation:
            'Large inflows of MNC investment increased industrial output, exports and GDP growth.',
        tags: [Tag.hl],
      ),
      ExampleDetail(
        title: 'Vietnam – Samsung Investment',
        explanation:
            'FDI created jobs, boosted exports and supported rapid economic development.',
        tags: [Tag.hl],
      ),
      ExampleDetail(
        title: 'Nigeria – Oil Extraction',
        explanation:
            'MNCs exploit natural resources, causing environmental damage and limited local benefits.',
        tags: [Tag.hl],
      ),
      ExampleDetail(
        title: 'Bangladesh – Garment Industry',
        explanation:
            'Low wages and poor working conditions highlight labour exploitation by MNCs.',
        tags: [Tag.hl],
      ),
    ],
  ),
  tradeOffInflationUnemployment(
    topicName: 'Trade-Off Between Inflation and Unemployment',
    subunit: Subunit.macroObjectives,
    examples: [
      ExampleDetail(
        title: 'US – COVID-19 Pandemic (Short Run Trade-Off)',
        explanation:
            'Lockdowns: U >10%, low inflation (~1%). Reopening: U <5%, inflation ~9% due to strong AD and supply shortages.',
        tags: [Tag.hl],
      ),
      ExampleDetail(
        title: '1973 Oil Crisis – Stagflation (Breakdown)',
        explanation:
            'High inflation and high unemployment due to cost-push inflation from rising oil prices.',
        tags: [Tag.hl],
      ),
      ExampleDetail(
        title: '1990s US – Internet Boom',
        explanation:
            'Low inflation and low unemployment due to productivity gains.',
        tags: [Tag.hl],
      ),
      ExampleDetail(
        title: 'Post-COVID US – Long Run',
        explanation:
            'Unemployment near natural rate; inflation ~3.3% showing no long-run trade-off as expectations adjust.',
        tags: [Tag.hl],
      ),
    ],
  ),
  monetaryPolicyRealWorldExamples(
    topicName: 'Monetary Policy Examples & Limitations',
    subunit: Subunit.demandManagementMonetary,
    examples: [
      ExampleDetail(
        title: 'UK 2022–2023 (Contractionary)',
        explanation:
            'With inflation above 10%, the Bank of England sold government bonds (gilts) to reduce money supply and raise interest rates. This helped bring inflation down but also increased borrowing costs, reduced consumption and investment, and contributed to a mild recession in 2023.',
        tags: [Tag.hl],
      ),
      ExampleDetail(
        title: 'New Zealand 2020–2021 (Expansionary)',
        explanation:
            'During COVID-19, the Reserve Bank of New Zealand bought around NZD 100bn of government bonds under LSAP, lowering long-term interest rates. This encouraged borrowing and spending, supporting aggregate demand and preventing a deeper recession.',
        tags: [Tag.hl],
      ),
      ExampleDetail(
        title: 'USA 2020–2021 (Expansionary)',
        explanation:
            'The Federal Reserve purchased over 1.7 trillion dollars in bonds during COVID-19, lowering long-term interest rates and supporting consumption and investment. However, strong demand recovery later contributed to inflation rising above 7%.',
        tags: [Tag.hl],
      ),
      ExampleDetail(
        title: 'Japan 2013–Present (Expansionary)',
        explanation:
            'Under Abenomics, the Bank of Japan used large-scale QE to keep interest rates near zero in order to fight persistent low inflation. This supported asset prices and demand but had limited success in sustainably raising inflation to target.',
        tags: [Tag.hl],
      ),
      ExampleDetail(
        title: 'USA Post-2008 (Liquidity Trap)',
        explanation:
            'After the Global Financial Crisis, interest rates were cut to near zero but borrowing and spending remained weak. Banks held excess reserves and households increased saving, limiting the effectiveness of monetary policy despite QE.',
        tags: [Tag.hl],
      ),
      ExampleDetail(
        title: 'Japan 1990s (Liquidity Trap)',
        explanation:
            'After the asset bubble burst, weak confidence and high debt levels led households and firms to reduce borrowing and increase saving. Even very low interest rates had little effect, resulting in prolonged stagnation and deflation.',
        tags: [Tag.hl],
      ),
    ],
  ),
  barriersToDevelopment(
    topicName: 'Barriers to Sustainable Development',
    subunit: Subunit.sustainableDevelopment,
    examples: [
      ExampleDetail(
        title: 'Burundi',
        explanation:
            'GDP per capita below 300 US dollars with most employment in subsistence agriculture.',
      ),
      ExampleDetail(
        title: 'Bangladesh',
        explanation:
            'Over 20 percent of population below poverty line with high climate vulnerability.',
      ),
    ],
  );

  // --- PROPERTIES ---
  final String topicName;
  final Subunit? subunit;
  final List<ExampleDetail> examples;

  // --- CONSTRUCTOR ---
  const RealWorldExamples({
    required this.topicName,
    required this.examples,
    this.subunit,
  });
}
