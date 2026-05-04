import '../../../diagrams/enums/unit_type.dart';
import '../../enums/tag.dart';
import '../../models/term.dart';

enum EconTerm {
  /// 2.1 Demand


  demand(
    termName: 'Demand',
    explanation:
    'The quantity of a good or service consumers are willing and able to buy at different prices, ceteris paribus.',
    subunit: Subunit.demand,
  ),

  substitutionEffect(
    termName: 'Substitution Effect',
    explanation:
    'When a good’s price falls, it becomes relatively cheaper than alternatives, so consumers switch towards it.',
    subunit: Subunit.demand,
    tags: [Tag.hl],

  ),

  incomeEffect(
    termName: 'Income Effect',
    explanation:
    'When a good’s price falls, real income rises, so consumers can buy more.',
    subunit: Subunit.demand,
    tags: [Tag.hl],
  ),

  marginalUtility(
      termName: 'Marginal Utility',
      explanation:
      'The extra satisfaction gained from consuming one more unit of a good.',
      subunit: Subunit.demand,
      tags: [Tag.hl]
  ),

  normalGood(
    termName: 'Normal Good',
    explanation:
    'A good for which demand increases as income increases.',
    subunit: Subunit.demand,
  ),

  inferiorGood(
    termName: 'Inferior Good',
    explanation:
    'A good for which demand decreases as income increases.',
    subunit: Subunit.demand,
  ),

  lawOfDiminishingMarginalUtility(
    termName: 'Law of Diminishing Marginal Utility',
    explanation:
    'As more units are consumed, the extra satisfaction from each additional unit decreases.',
    subunit: Subunit.demand,
    tags: [Tag.hl]
  ),

  marketDemand(
    termName: 'Market Demand',
    explanation:
    'The sum of all individual consumers’ demand for a good at each price.',
    subunit: Subunit.demand,
  ),

  /// 2.2

  supply(
    termName: 'Supply',
    explanation:
    'The quantity of a good or service producers are willing and able to sell at different prices, ceteris paribus.',
    subunit: Subunit.supply,
  ),

  marketSupply(
    termName: 'Market Supply',
    explanation:
    'The sum of all firms’ supply of a good at each price.',
    subunit: Subunit.supply,
  ),

  lawOfDiminishingMarginalReturns(
    termName: 'Law of Diminishing Marginal Returns',
    explanation:
    'As more of a variable input is added to a fixed input, the extra output from each additional unit eventually falls.',
    subunit: Subunit.supply,
  ),



  competitiveSupply(
    termName: 'Competitive Supply',
    explanation:
    'Producing more of one good means producing less of another because they use the same resources (e.g. wheat and corn).',
    subunit: Subunit.supply,
  ),

  jointSupply(
    termName: 'Joint Supply',
    explanation:
    'Producing more of one good increases the supply of another as a by-product (e.g. beef and leather).',
    subunit: Subunit.supply,
  ),

  supplyShock(
    termName: 'Supply Shock',
    explanation:
    'A sudden external event that significantly increases or decreases supply (e.g. bumper harvest / war).',
    subunit: Subunit.supply,
  ),
  marginalProduct(
      termName: 'Marginal Product',
      explanation:
      'The extra output from one more unit of input. <b>∆TP / ∆Input</b>.',
      subunit: Subunit.supply,
      tags: [Tag.hl]
  ),

  marginalCost(
      termName: 'Marginal Cost',
      explanation:
      'The extra cost of producing one more unit. <b>∆TC / ∆Q</b>.',
      subunit: Subunit.supply,
      tags: [Tag.hl]
  ),

  /// 2.3 Competitive market
 priceSignals(
    termName: 'Price Signals',
    explanation:
    'Provide information to producers and consumers about changing market demand and supply which guide resource allocation.',
    subunit: Subunit.demand,
  ),

  incentives(
    termName: 'Incentives',
    explanation:
    'Motivations created by price changes that encourage consumers and producers to adjust behavior to maximize profit or benefit.',
    subunit: Subunit.demand,
  ),

  priceRationing(
    termName: 'Price Rationing',
    explanation:
    'When scarce goods and services are allocated through the price mechanism. If there is a shortage, the price rises and only those willing and able to pay will obtain the good.',
    subunit: Subunit.demand,
  ),
  nonPriceRationing(
    termName: 'Non-Price Rationing',
    explanation:
    'A method of allocating scarce goods and services without using price, such as queues, lotteries, or government allocation.',
    subunit: Subunit.demand,
  ),

  marginalBenefit(
    termName: 'Marginal Benefit',
    explanation:
    'The additional benefit or satisfaction gained from consuming one more unit of a good or service.',
    subunit: Subunit.demand,
  ),

  consumerSurplus(
    termName: 'Consumer Surplus',
    explanation:
    'The difference between the maximum price a consumer is willing to pay and the actual price paid.',
    subunit: Subunit.demand,
  ),

  producerSurplus(
    termName: 'Producer Surplus',
    explanation:
    'The difference between the price a producer is willing to accept and the actual price received.',
    subunit: Subunit.demand,
  ),
  socialSurplus(
    termName: 'Social Surplus',
    explanation:
    'The total surplus in an economy, equal to consumer surplus plus producer surplus, representing the net benefit to society from market transactions.',
    subunit: Subunit.demand,
  ),
  allocativeEfficiency(
    termName: 'Allocative Efficiency',
    explanation:
    'A situation where resources are allocated to produce the combination of goods most valued by society, where price equals marginal cost.',
    subunit: Subunit.demand,
  ),

  /// 2.4 Critique
  rationalConsumerChoice(
    termName: 'Rational Consumer Choice',
    explanation:
    'Assumes consumers are motivated by rational self-interest, have access to perfect information, and aim to maximize their utility based on their budget constraints.',
    subunit: Subunit.critiqueBehaviour,
    tags: [Tag.hl],
  ),
  biases(
    subunit: Subunit.critiqueBehaviour,
    termName: 'Biases',
    explanation: 'Heuristics that simplifies decision-making (rule of thumb, anchoring and framing, availability).',
  tags: [Tag.hl],
  ),
  ruleOfThumb(
    subunit: Subunit.critiqueBehaviour,
    termName: 'Rule of Thumb',
    explanation: 'an informal shortcut that simplifies decision-making (e.g., always buy on sale).',
    tags: [Tag.hl],
  ),
  anchoring(
    subunit: Subunit.critiqueBehaviour,
    termName: 'Anchoring',
    explanation: 'Comparing options to the first piece of information seen.',
    tags: [Tag.hl],
  ),
  framing(
    subunit: Subunit.critiqueBehaviour,
    termName: 'Framing',
    explanation: 'how the presentation of information affects decision making (20% fat-free vs 80% pure fat).',
    tags: [Tag.hl],
  ),
  availabilityBias(
    subunit: Subunit.critiqueBehaviour,
    termName: 'Availability Bias',
    explanation: 'Overestimating the likelihood of recent or vivid events (afraid of air-travel even is safe)',
    tags: [Tag.hl],
  ),
  boundedRationality(
    termName: 'Bounded Rationality',
    explanation:
    'Individuals have limited cognitive ability, time, and imperfect information, which restricts fully rational decision-making.',
    subunit: Subunit.critiqueBehaviour,
    tags: [Tag.hl],
  ),

  boundedSelfControl(
    termName: 'Bounded Self-Control',
    explanation:
    'The limited ability of individuals to control impulses, which can lead to decisions that reduce long-term utility.',
    subunit: Subunit.critiqueBehaviour,
    tags: [Tag.hl],
  ),

  boundedSelfishness(
    termName: 'Bounded Selfishness',
    explanation:
    'Individuals may consider the welfare of others when making decisions, rather than acting purely in self-interest.',
    subunit: Subunit.critiqueBehaviour,
    tags: [Tag.hl],
  ),

  imperfectInformation(
    termName: 'Imperfect Information',
    explanation:
    'A situation where economic agents do not have full access to all relevant information, leading to less than fully rational decisions.',
    subunit:  Subunit.critiqueBehaviour,
    tags: [Tag.hl],
  ),
  choiceArchitecture(
    termName: 'Choice Architecture',
    explanation:
    'How the presentation of choices to consumers can influence decision making: Default (choice if nothing is chosen); restricted (reduced choices to simplify); and mandated choices (must choose between options)',
    subunit:  Subunit.critiqueBehaviour,
    tags: [Tag.hl],
  ),
  nudges(
    termName: 'Nudges',
    explanation:
    'how indirect suggestions can influence the behavior of individuals and groups. E.g., Placing healthy food in more visible spots.',
    subunit:  Subunit.critiqueBehaviour,
    tags: [Tag.hl],
  ),
  alternativeBusinessObjectives(
    termName: 'Alternative Business Objectives',
    explanation:
    'Objectives other than profit maximisation: CRS, revenue maximization, growth, satisficing.',
    subunit: Subunit.critiqueBehaviour,
    tags: [Tag.hl],
  ),

  corporateSocialResponsibility(
    termName: 'Corporate Social Responsibility (CSR)',
    explanation:
    'Firms take responsibility for their social and environmental impacts.',
    subunit:  Subunit.critiqueBehaviour,
    tags: [Tag.hl],
  ),

  marketShare(
    termName: 'Market Share',
    explanation:
    'The proportion of total industry sales accounted for by a firm, measured as firm sales revenue divided by total industry revenue.',
    subunit:  Subunit.critiqueBehaviour,
    tags: [Tag.hl],
  ),

  growth(
    termName: 'Growth (Firm)',
    explanation:
    'A firm objective to increase output or sales over time, often measured by rising units sold or revenue.',
    subunit: Subunit.critiqueBehaviour,
    tags: [Tag.hl],
  ),

  revenueMaximisation(
    termName: 'Revenue Maximisation',
    explanation:
    'A firm objective where total revenue is maximised, occurring where marginal revenue equals zero.',
    subunit:  Subunit.critiqueBehaviour,
    tags: [Tag.hl],
  ),

  satisficing(
    termName: 'Satisficing',
    explanation:
    'A behaviour where firms aim for satisfactory rather than maximum outcomes, often meeting minimum acceptable targets.',
    subunit: Subunit.critiqueBehaviour,
    tags: [Tag.hl],
  ),
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
        'A change in price leads to a proportionally larger change in quantity demanded (luxuries, services).',
    subunit: Subunit.elasticityDemand,
  ),
  priceInelasticDemand(
    termName: 'Price inelastic demand (PED < 1)',
    explanation:
        "A change in price leads to a proportionally smaller change in quantity demanded (most primary commodities like oil, agricultural goods).",
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
        'Processing and manufacturing of raw materials (from primary sector) into finished goods.',
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

  ///2.6 PES
  priceElasticitySupply(
    termName: 'Price Elasticity of Supply (PES)',
    explanation:
    'Measures how sensitive changes in quantity supply are to changes in the price of a product <b>(PES = %∆Qs / %∆P)</b>',
    subunit: Subunit.elasticityDemand,
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
        'Production imposes external costs on third parties (MSC > MPC).',
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

  dynamicEfficiency(
    termName: 'Dynamic Efficiency',
    explanation:
        'Improved long-term efficiency by investment in R&D and innovation (technology).',
    subunit: Subunit.marketFailurePower,
    tags: [Tag.hl],
  ),
  collusion(
    termName: 'Collusion',
    explanation:
        'Firms in oligopoly coordinate by fixing prices or restricting output to limit competition (act as a monopoly).',

    subunit: Subunit.marketFailurePower,
    tags: [Tag.hl],
  ),
  perfectCompetition(
    termName: 'Perfect Competition',
    explanation:
        'Many small firms with no market power (P=MC) selling a homogeneous product. Perfect information, and perfect factor mobility of labor and capital. No barriers to entry/exit means only normal profit in long-run.',
    subunit: Subunit.marketFailurePower,
  ),
  monopolisticCompetition(
    termName: 'Monopolistic Competition',
    explanation:
        'Many small firms, each with some (limited) market power due to product differentiation. Low barriers to entry/exit means only normal profit in long-run.',
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
  shortRunMicro(
    termName: 'Short Run (Micro)',
    explanation:
        'The period of time in which at least one factor of production is fixed.',
    subunit: Subunit.marketFailurePower,
  ),
  barriersToEntry(
    termName: 'Barriers to Entry',
    explanation:
        'Factors with prevents entry of new firms into an industry (economies of scale, branding, patents, or legal barriers).',
    subunit: Subunit.marketFailurePower,
    tags: [Tag.hl],
  ),
  nonPriceCompetition(
    termName: 'Non-Price Competition',
    explanation:
        'Competition between firms that focuses on factors other than price, such as product differentiation, advertising, customer service, and brand loyalty.',
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
    explanation: 'A sustained increase in real GDP over-time.',
    subunit: Subunit.macroObjectives,
  ),
  structuralUnemployment(
    termName: 'Structural Unemployment',
    explanation:
        'Long-term unemployment caused by mismatches between workers’ skills and available jobs; and labor market rigidities (minimum wage, labor-market regulations, trade unions)',
    subunit: Subunit.macroObjectives,
    tags: [],
  ),

  frictionalUnemployment(
    termName: 'Frictional Unemployment',
    explanation:
        'Unemployment occurring when workers are between jobs or entering the labour market.',
    subunit: Subunit.macroObjectives,
    tags: [],
  ),

  seasonalUnemployment(
    termName: 'Seasonal Unemployment',
    explanation:
        'Unemployment caused by seasonal changes in demand for labour (e.g. tourism, agriculture).',
    subunit: Subunit.macroObjectives,
    tags: [],
  ),
  nru(
    termName: 'Natural Rate of Unemployment (NRU)',
    explanation:
        'Sum of frictional, structural, and seasonal unemployment (excluding cyclical unemployment). Occurs when economy is in long-run equilibrium (full employment).',
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
    explanation:
        'Government expenditure exceeds tax revenue (G > T) for one year',
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
        'High debt-to-GDP ratio leading to significant opportunity costs on future economic growth (higher IR on new government debt, higher taxes, cuts in government spending); and risk of sovereign default.',
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

  /// Global
  /// 3.1 Benefits of Trade
  internationalTrade(
    termName: 'International Trade',
    explanation:
        'The exchange of goods and services between countries (imports and exports).',
    subunit: Subunit.benefitsTrade,
  ),
  comparativeAdvantage(
    termName: 'Comparative Advantage',
    explanation:
        'A country can produce a good at a lower opportunity cost than another country.',
    subunit: Subunit.benefitsTrade,
  ),

  ///
  capitalFlight(
    termName: 'Capital Flight',
    explanation:
        'The large-scale movement of money and financial assets out of a country due to fear of political instability, poor governance or economic conditions.',
    subunit: Subunit.sustainableDevelopment,
  ),

  foreignAid(
    termName: 'Foreign Aid',
    explanation:
        'Transfer of money, goods or expertise to developing countries to promote economic development (ODA) or provide humanitarian relief. Should be concessional and non-commercial.',
    subunit: Subunit.sustainableDevelopment,
  ),
  appropriateTechnology(
    termName: 'Appropriate Technology',
    explanation:
        'Technology suited to an developing country’s resources and income level, usually low-cost, simple, and labour-intensive.',
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
        'A sustained improvement in living standards and economic well-being. Multi-dimensional concept which includes: higher real income, increased employment, improvements in health and education, reduction of poverty, discrimination, and inequality.',
    subunit: Subunit.sustainableDevelopment,
  ),
  informalEconomy(
    termName: 'Informal Economy',
    explanation:
        'Economic activity that is not regulated or taxed by the government, often including small-scale, low-income jobs without formal contracts or legal protection.',
    subunit: Subunit.sustainableDevelopment,
  ),

  infrastructure(
    termName: 'Infrastructure',
    explanation:
        'Basic physical and institutional systems needed for economic activity, such as transport, power, water, communication, healthcare, and education facilities.',
    subunit: Subunit.sustainableDevelopment,
  ),

  /// 4.90 Barriers to Economic Development
  economicBarriers(
    termName: 'Economic Barriers',
    explanation:
        'Economic barriers that hinder economic growth and development, including: inequality, dependence of primary sector, poor infrastructure, low human capital, limited access to international markets, informal economy, indebtedness, landlocked geography and endemic disease',
    subunit: Subunit.macroObjectives,
  ),
  socialAndPoliticalBarriers(
    termName: 'Social and Political Barriers',
    explanation:
        'Social and Political Barriers which that hinder economic growth and development, including: unequal political power, discrimination, poor governance/corruption and weak institutions.',
    subunit: Subunit.macroObjectives,
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
