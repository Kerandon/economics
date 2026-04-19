import '../../../diagrams/enums/unit_type.dart';
import '../../models/term.dart';

enum EconTerm {
  ///2.5-2.6 Elasticities
  realIncome(
    termName: 'Real Income',
    explanation:
        'Income adjusted for inflation, showing actual purchasing power.',
    subunit: Subunit.elasticityDemand,
  ),
  incomeElasticityOfDemand(
    termName: 'Income Elasticity of Demand (YED)',
    explanation:
        'Responsiveness of quantity demanded to a change in income. <strong>YED = %∆Qd ÷ %∆Y</strong>.',
    subunit: Subunit.elasticityDemand,
  ),
  luxuries(
    termName: 'Luxuries',
    explanation:
        'Normal goods that are desirable and prestigious, with <strong>YED > 1</strong>.',
    subunit: Subunit.elasticityDemand,
  ),
  manufacturedGood(
    termName: 'Manufactured Good',
    explanation:
        'A product processed from raw materials (primary sector) into a finished good.',
    subunit: Subunit.elasticityDemand,
  ),
  necessities(
    termName: 'Necessities',
    explanation:
        'Normal goods essential for basic living, with <strong>0 < YED < 1</strong>.',
    subunit: Subunit.elasticityDemand,
  ),
  perfectlyPriceElasticDemand(
    termName: 'Perfectly price elastic demand (PED = infinity)',
    explanation:
        'Consumers are extremely sensitive to price. Any increase in price leads causes demand to fall to zero. e.g., generic goods with perfect substitutes.',
    subunit: Subunit.elasticityDemand,
  ),
  perfectlyPriceInelasticDemand(
    termName: 'Perfectly price inelastic demand (PED = 0)',
    explanation:
        'Occurs when a change in price has no effect on quantity demanded. E.g., life-saving medicines.',
    subunit: Subunit.elasticityDemand,
  ),
  priceElasticDemand(
    termName: 'Price elastic demand (PED > 1)',
    explanation:
        'Change in price leads to a proportionally larger change in quantity demanded (PED > 1) (luxuries, services).',
    subunit: Subunit.elasticityDemand,
  ),
  priceInelasticDemand(
    termName: 'Price inelastic demand (PED < 1)',
    explanation:
        "A change in price leads to a proportionally smaller change in quantity demanded (PED < 1) (salt, gasoline, rice).",
    subunit: Subunit.elasticityDemand,
  ),
  unitaryPriceElasticDemand(
    termName: 'Unitary price elastic demand (PED = 1)',
    explanation:
        'Occurs when a change in price results in an equal percentage change in quantity demanded.',
    subunit: Subunit.elasticityDemand,
  ),
  priceElasticityOfDemand(
    termName: 'Price Elasticity of Demand (PED)',
    explanation:
        'Measures the responsiveness of quantity demanded to changes in price. <strong>PED = %∆Qd ÷ %∆P</strong>.',
    subunit: Subunit.elasticityDemand,
  ),
  primaryCommodity(
    termName: 'Primary commodity',
    explanation:
        'Raw material from nature used directly in production and consumption (crude oil, minerals, fish, agricultural products).',
    subunit: Subunit.elasticityDemand,
  ),
  primarySector(
    termName: 'Primary sector',
    explanation:
        'Extraction of raw materials from nature (agricultural, fishing, forestry, mining).',
    subunit: Subunit.elasticityDemand,
  ),
  secondarySector(
    termName: 'Secondary sector',
    explanation:
        'Processing and manufacturing of raw materials (primary sector) into finished goods.',
    subunit: Subunit.elasticityDemand,
  ),
  tertiarySector(
    termName: 'Tertiary sector',
    explanation:
        'Services, including banking, healthcare, retail, and education.',
    subunit: Subunit.elasticityDemand,
  ),
  totalRevenue(
    termName: 'Total Revenue (TR)',
    explanation:
        'The total income a firm receives from selling goods and services. <strong>TR = Price × Quantity</strong>.',
    subunit: Subunit.elasticityDemand,
  ),
  economicallyLeastDevelopedCountries(
    termName: 'Economically Least-Developed Countries (ELDCs)',
    explanation:
        'Low-income countries facing severe barriers to economic development.',
    subunit: Subunit.measuringDevelopment,
  ),

  ///2.8 Externalities
  externalities(
    termName: 'Externalities',
    explanation:
        'Costs or benefits of production/consumption imposed on third parties not reflected in market prices.',
    subunit: Subunit.marketFailureExternalities,
  ),

  negativeProductionExternality(
    termName: 'Negative Production Externality',
    explanation:
        'External cost from production imposed on third parties (MSC > MPC), leading to overproduction.',
    subunit: Subunit.marketFailureExternalities,
  ),

  tradablePermits(
    termName: 'Tradable Permits',
    explanation:
        'Market-based policy setting a cap on pollution; firms can buy/sell permits, internalising external costs.',
    subunit: Subunit.marketFailureExternalities,
  ),

  ///2.9 Public Goods
  freeRiderProblem(
    termName: 'Free Rider Problem',
    explanation:
        'As can consume without paying a price (non-excludability) private market will not supply.',
    subunit: Subunit.marketFailurePublicGoods,
  ),
  excludable(
    termName: 'Excludable',
    explanation:
        'Can be prevented from consuming (usually by charging a price).',
    subunit: Subunit.marketFailurePublicGoods,
  ),
  rivalrous(
    termName: 'Rivalrous',
    explanation: 'Consumption reduces availability for others.',
    subunit: Subunit.marketFailurePublicGoods,
  ),
  meritGood(
    termName: 'Merit Good',
    explanation:
        'A private good that is socially desirable (external benefits) but is underconsumed.',
    subunit: Subunit.marketFailurePower,
  ),
  publicGood(
    termName: 'Public Good',
    explanation: 'Non-excludable and non-rival. Subject to free-rider problem',
    subunit: Subunit.marketFailurePower,
  ),
  allocativeEfficiency(
    termName: 'Allocative Efficiency',
    explanation:
        'Occurs when firms produce the combination of goods and services most preferred by consumers; technically where P = MC.',
    subunit: Subunit.marketFailurePower,
  ),
  dynamicEfficiency(
    termName: 'Dynamic Efficiency',
    explanation:
        'Occurs when abnormal profits are reinvested into research, development, and innovation to lower costs or improve products over time.',
    subunit: Subunit.marketFailurePower,
    tags: [Tag.hl],
  ),
  collusion(
    termName: 'Collusion',
    explanation:
        'When two or more firms in an oligopoly coordinate to limit competition, typically by fixing prices or restricting output to act as a monopoly.',
    subunit: Subunit.marketFailurePower,
    tags: [Tag.hl],
  ),
  perfectCompetition(
    termName: 'Perfect Competition',
    explanation:
        'Many small firms with no market power (price-takers), selling a homogeneous product. Free entry/exit, perfect information on prices and technology, and perfect factor mobility of labor and capital.',
    subunit: Subunit.marketFailurePower,
  ),
  monopolisticCompetition(
    termName: 'Monopolistic Competition',
    explanation:
        'Many small firms, each with some (limited) market power. Very high product differentiation, low barriers to entry/exit.',
    subunit: Subunit.marketFailurePower,
  ),
  monopoly(
    termName: 'Monopoly',
    explanation:
        'A single supplier of a good or service. Very high barriers to entry and significant market power P>MC.',
    subunit: Subunit.marketFailurePower,
  ),
  naturalMonopoly(
    termName: 'Natural Monopoly',
    explanation:
        'A market where a single firm can supply the entire market demand at a lower average cost than two or more firms due to high fixed costs and massive economies of scale.',
    subunit: Subunit.marketFailurePower,
  ),
  marketPower(
    termName: 'Market Power',
    explanation:
        'The ability of a firm to influence the price of a good, set P>MC.',
    subunit: Subunit.marketFailurePower,
  ),
  abnormalProfit(
    termName: 'Abnormal Profit',
    explanation: 'TR > TC (explicit and implicit costs).',
    subunit: Subunit.marketFailurePower,
  ),
  normalProfit(
    termName: 'Normal Profit',
    explanation:
        'TR = TC (implicit and explicit costs). Minimum level of profit required to keep a firm in industry in long-run.',
    subunit: Subunit.marketFailurePower,
  ),
  shortRun(
    termName: 'Short Run',
    explanation:
        'The period of time in which at least one factor of production is fixed (usually capital).',
    subunit: Subunit.marketFailurePower,
  ),
  barriersToEntry(
    termName: 'Barriers to Entry',
    explanation:
        'Factors with prevents entry of new firms into an industry (economies of scale, branding, patents, or legal barriers).',
    subunit: Subunit.marketFailurePower,
    tags: [Tag.hl],
  ),
  oligopoly(
    termName: 'Oligopoly',
    explanation:
        'A market structure dominated by a few large firms with high barriers to entry and mutual interdependence.',
    subunit: Subunit.marketFailurePower,
    tags: [Tag.hl],
  ),
  concentrationRatio(
    termName: 'Concentration Ratio',
    explanation:
        'A measure of the percentage of total market share held by the largest firms (e.g., CR4) in an industry.',
    subunit: Subunit.marketFailurePower,
    tags: [Tag.hl],
  ),

  /// MACRO
  /// 3.1 Economic Activity
  nationalIncome(
    termName: 'National income',
    explanation:
        'Total market value of all final goods and services produced by a country in one year.',
    subunit: Subunit.economicActivity,
  ),

  /// 3.2 AD-AS

  equilibriumNationalIncome(
    termName: 'Equilibrium level of national income',
    explanation:
        'The level of output where aggregate demand equals aggregate supply (AD = SRAS/AS).',
    subunit: Subunit.aDAS,
  ),
  deflationaryGap(
    termName: 'Deflationary Gap',
    explanation:
        'Real GDP < potential output, caused by lack of AD leading to low inflation pressure and rising unemployment.',
    subunit: Subunit.macroObjectives,
    tags: [],
  ),

  /// 3.3 Macro-objectives
  /// 3.5 Demand-side fiscal
  interestRates(
    termName: 'Interest rates',
    explanation:
        'The cost of borrowing money (price of a loan); or the reward for saving.',
    subunit: Subunit.demandManagementMonetary,
  ),

  inflation(
    termName: 'Inflation',
    explanation:
        'Sustained increase in the general price level of goods and services.',
    subunit: Subunit.macroObjectives,
    tags: [Tag.hl],
  ),
  unemployment(
    termName: 'Unemployment',
    explanation:
        'Working age who are actively looking for a job but are unable to find one.',
    subunit: Subunit.macroObjectives,
    tags: [Tag.hl],
  ),
  economicGrowth(
    termName: 'Economic Growth',
    explanation:
        'A sustained increase in the real output (real GDP) of an economy over-time.',
    subunit: Subunit.macroObjectives,
  ),
  nru(
    termName: 'Natural Rate of Unemployment (NRU)',
    explanation:
        'Sum of frictional, structural, and seasonal unemployment, excluding cyclical unemployment. Occurs when economy is in long-run equilibrium (full employment).',
    subunit: Subunit.macroObjectives,
    tags: [],
  ),
  nationalDebt(
    termName: 'National Debt',
    explanation:
        'Total government borrowing over time. Sum of budget deficits less budget surpluses.',
    subunit: Subunit.macroObjectives,
    tags: [],
  ),

  budgetDeficit(
    termName: 'Budget Deficit',
    explanation: 'G > T for one year',
    subunit: Subunit.macroObjectives,
    tags: [],
  ),
  debtToGDPRatio(
    termName: 'Debt-to-GDP Ratio',
    explanation: '(Total Debt / GDP) × 100.',
    subunit: Subunit.macroObjectives,
  ),
  crowdingOut(
    termName: 'Crowding Out',
    explanation:
        'Increased government borrowing causes higher interest rates, which reduces (crowds out) private sector investment due to higher costs of borrowing.',
    subunit: Subunit.macroObjectives,
  ),
  unsustainableDebt(
    termName: 'Unsustainable Debt',
    explanation:
        'High debt-to-GDP ratio - significant opportunity costs on future economic growth (higher IR, higher T, lower G); and risk of sovereign default.',
    subunit: Subunit.macroObjectives,
  ),

  /// Monetary Policy
  monetaryPolicy(
    termName: 'Monetary Policy',
    explanation:
        'Central bank policy on interest rates and money supply to achieve macroeconomic goals.',
    subunit: Subunit.macroObjectives,
    tags: [],
  ),
  openMarketOperations(
    termName: 'Open Market Operations (OMO)',
    explanation:
        'Central bank buys and sells government securities (bonds) from commercial banks to influence the money supply and interest rates.',
    subunit: Subunit.macroObjectives,
    tags: [],
  ),
  minimumReserveRequirement(
    termName: 'Minimum Reserve Requirement (MRR)',
    explanation:
        'The % of bank deposits commercial banks are required to keep in reserves at the central bank.',
    subunit: Subunit.macroObjectives,
    tags: [],
  ),
  minimumLendingRate(
    termName: 'Minimum Lending Rate (MLR)',
    explanation:
        'The minimum interest rate charged by the central bank on loans to commercial banks.',
    subunit: Subunit.macroObjectives,
    tags: [],
  ),
  quantitativeEasing(
    termName: 'Quantitative Easing (QE)',
    explanation:
        'Central bank creates new money to make large scale purchases of bonds and other financial assets during a financial crisis.',
    subunit: Subunit.macroObjectives,
    tags: [],
  ),
  liquidityTrap(
    termName: 'Liquidity Trap',
    explanation:
        'Monetary policy ineffective when already low interest rates, increases in money supply fail to stimulate aggregate demand (low AD: very low consumer/business confidence, high unemployment, firm bankruptcies, high real debt burden).',
    subunit: Subunit.demandManagementMonetary,
    tags: [],
  ),

  /// 3.7 Supply-Side
  supplySidePolicies(
    termName: 'Supply-Side Policies',
    explanation:
        'Policies to increase LRAS and potential output. Market-based and interventionist.',
    subunit: Subunit.supplySidePolicies,
  ),
  foreignAid(
    termName: 'Foreign Aid',
    explanation:
        'Transfer of money, goods or expertise to developing countries to promote economic development (ODA) or provide humanitarian relief. Should be concessional and non-commercial.',
    subunit: Subunit.sustainableDevelopment,
  ),

  economicallyLessDevelopedCountry(
    termName: 'Economically Less Developed Country (ELDC)',
    explanation:
        'A country with low income and living standards. Often has high poverty, limited infrastructure, and reliance on the primary sector.',
    subunit: Subunit.sustainableDevelopment,
  ),

  economicDevelopment(
    termName: 'Economic Development',
    explanation:
        'An improvement in living standards and quality of life, including higher income, better health and education, and reduced poverty and inequality.',
    subunit: Subunit.sustainableDevelopment,
  );

  /// 4.10 Economic Development Strategies

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
