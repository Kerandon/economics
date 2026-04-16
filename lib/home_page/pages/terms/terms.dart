import '../../../diagrams/enums/unit_type.dart';
import '../../models/term.dart';

enum EconTerm {
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
    explanation: 'A product processed from raw materials into a finished good.',
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
        'Change in price leads to a proportionally larger change in quantity demanded (PED > 1), (luxuries and services).',
    subunit: Subunit.elasticityDemand,
  ),
  priceInelasticDemand(
    termName: 'Price inelastic demand (PED < 1)',
    explanation:
        "A change in price leads to a proportionally smaller change in quantity demanded (PED < 1) (e.g. salt, gasoline, rice).",
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
        'Extraction of raw materials from nature, such as farming, fishing, forestry, and mining.',
    subunit: Subunit.elasticityDemand,
  ),
  secondarySector(
    termName: 'Secondary sector',
    explanation:
        'Processing / manufacturing of raw materials into finished goods.',
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
        'Many small independent firms with no market power (P=MC) all selling an identical good. No barriers to entry and exit, perfect information on prices, costs and resources, and perfect factor mobility of labor and capital.',
    subunit: Subunit.marketFailurePower,
  ),
  monopolisticCompetition(
    termName: 'Monopolistic Competition',
    explanation:
        'Many small firms relative to a large industry, each with limited (some) market power. Low barriers to entry, very high product differentiation.',
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
        'Factors with prevents entry of new firms into an industry, such as: economies of scale, branding, patents, or legal barriers.',
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
  nru(
    termName: 'Natural Rate of Unemployment (NRU)',
    explanation:
        'Sum of structural, frictional and seasonal unemployment. Full Employment is U = NRU (zero cyclical); Ye=Yp; stable inflation rate (actual inflation = expected inflation).',
    subunit: Subunit.macroObjectives,
    tags: [],
  ),
  nationalDebt(
    termName: 'National Debt',
    explanation:
        'Total accumulation over-time of budget deficits minus budget surpluses.',
    subunit: Subunit.macroObjectives,
    tags: [],
  ),
  budgetDeficit(
    termName: 'Budget Deficit',
    explanation:
        'Government\'s total expenditures > total tax revenues over one year (G>T)',
    subunit: Subunit.macroObjectives,
    tags: [],
  ),
  debtToGDPRatio(
    termName: 'Debt-to-GDP Ratio',
    explanation:
        'A metric that compares a country\'s total national debt to its Gross Domestic Product (GDP). It acts as a key indicator of a country\'s ability to pay back its debt relative to the size and output of its economy.',
    subunit: Subunit.macroObjectives,
    tags: [],
  ),
  sustainableDebt(
    termName: 'Sustainable Debt',
    explanation:
        'A level of national debt where a government can comfortably meet its current and future debt obligations (paying interest and principal) without defaulting, needing debt relief, or restricting economic growth.',
    subunit: Subunit.macroObjectives,
    tags: [],
  ),
  crowdingOut(
    termName: 'Crowding Out',
    explanation:
        'An increase in government spending financed by borrowing may lead to higher interest rates, reducing private investment. It can also occur through competition for scarce resources (labor and capital), raising costs for the private sector.',
    subunit: Subunit.macroObjectives,
    tags: [],
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
        'Central bank buys and sells government securities from commercial banks to influence the money supply and interest rates.',
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
        'Monetary policy ineffective when already low interest rates, increases in money supply fail to stimulate aggregate demand.',
    subunit: Subunit.demandManagementMonetary,
    tags: [],
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
