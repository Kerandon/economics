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
    tags: [Tag.hl],
  ),

  normalGood(
    termName: 'Normal Good',
    explanation: 'A good for which demand increases as income increases.',
    subunit: Subunit.demand,
  ),

  inferiorGood(
    termName: 'Inferior Good',
    explanation: 'A good for which demand decreases as income increases.',
    subunit: Subunit.demand,
  ),

  lawOfDiminishingMarginalUtility(
    termName: 'Law of Diminishing Marginal Utility',
    explanation:
        'As more units are consumed, the extra satisfaction from each additional unit decreases.',
    subunit: Subunit.demand,
    tags: [Tag.hl],
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
    explanation: 'The sum of all firms’ supply of a good at each price.',
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
    tags: [Tag.hl],
  ),

  marginalCost(
    termName: 'Marginal Cost',
    explanation: 'The extra cost of producing one more unit. <b>∆TC / ∆Q</b>.',
    subunit: Subunit.supply,
    tags: [Tag.hl],
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
        'Scarce goods and services allocated by price mechanism. If there is a shortage, the price rises and only those willing and able to pay will obtain the good.',
    subunit: Subunit.demand,
  ),
  nonPriceRationing(
    termName: 'Non-Price Rationing',
    explanation:
        'Non-price methods to allocate resources: queues, lotteries, or government allocation.',
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
        'Difference between the maximum price a consumer is willing to pay and the actual price paid.',
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
        'Total surplus in an economy, sum of consumer surplus and producer surplus.',
    subunit: Subunit.demand,
  ),
  allocativeEfficiency(
    termName: 'Allocative Efficiency',
    explanation:
        'Resources allocation maximises social welfare. P = MC (or MSB = MSC for externalities).',
    subunit: Subunit.demand,
  ),

  /// 2.4 Critique
  rationalConsumerChoice(
    termName: 'Rational Consumer Choice',
    explanation:
        'Consumers are rational / self-interest; perfect information; maximize utility.',
    subunit: Subunit.critiqueBehaviour,
    tags: [Tag.hl],
  ),
  biases(
    subunit: Subunit.critiqueBehaviour,
    termName: 'Biases',
    explanation:
        'Heuristics that simplifies decision-making (rule of thumb, anchoring, framing, availability).',
    tags: [Tag.hl],
  ),
  ruleOfThumb(
    subunit: Subunit.critiqueBehaviour,
    termName: 'Rule of Thumb',
    explanation:
        'Informal shortcut that simplifies decision-making (e.g., always buy on sale).',
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
    explanation:
        'how the presentation of information affects decision making (20% fat-free vs 80% pure fat).',
    tags: [Tag.hl],
  ),
  availabilityBias(
    subunit: Subunit.critiqueBehaviour,
    termName: 'Availability Bias',
    explanation:
        'Overestimating the likelihood of recent / vivid events (afraid of air-crash even if very low risk)',
    tags: [Tag.hl],
  ),
  boundedRationality(
    termName: 'Bounded Rationality',
    explanation:
        'Consumers limited cognitive ability, time, and imperfect information. This restricts fully rational decision-making.',
    subunit: Subunit.critiqueBehaviour,
    tags: [Tag.hl],
  ),

  boundedSelfControl(
    termName: 'Bounded Self-Control',
    explanation:
        'Limited ability of individuals to control impulses, reducing long-term utility (eat too much chocolate when on a diet due to lack of self-control).',
    subunit: Subunit.critiqueBehaviour,
    tags: [Tag.hl],
  ),

  boundedSelfishness(
    termName: 'Bounded Selfishness',
    explanation:
        'Consider the welfare of others when making decisions (altruistic / charity).',
    subunit: Subunit.critiqueBehaviour,
    tags: [Tag.hl],
  ),

  imperfectInformation(
    termName: 'Imperfect Information',
    explanation:
        'Do not have full access to all relevant information / too much information to rationally assess.',
    subunit: Subunit.critiqueBehaviour,
    tags: [Tag.hl],
  ),
  choiceArchitecture(
    termName: 'Choice Architecture',
    explanation:
        'How choices presented to consumers can influence decision making: 3 types: Default Choice (usual choice if nothing is chosen); Restricted Choice (reduced choice to simplify decision making); and Mandated Choice (must choose between options)',
    subunit: Subunit.critiqueBehaviour,
    tags: [Tag.hl],
  ),
  nudges(
    termName: 'Nudges',
    explanation:
        'Indirect suggestions can influence the behavior of individuals and groups. (Placing healthy food in more visible spots).',
    subunit: Subunit.critiqueBehaviour,
    tags: [Tag.hl],
  ),

  corporateSocialResponsibility(
    termName: 'Corporate Social Responsibility (CSR)',
    explanation:
        'Firms take responsibility for their social and environmental impacts over profit-maximizing.',
    subunit: Subunit.critiqueBehaviour,
    tags: [Tag.hl],
  ),

  marketShare(
    termName: 'Market Share',
    explanation: 'Firm sales revenue / total industry revenue.',
    subunit: Subunit.critiqueBehaviour,
    tags: [Tag.hl],
  ),

  revenueMaximisation(
    termName: 'Revenue Maximisation',
    explanation: 'TR is maximized, MR = 0.',
    subunit: Subunit.critiqueBehaviour,
    tags: [Tag.hl],
  ),

  satisficing(
    termName: 'Satisficing',
    explanation:
        'Individuals or firms aim for satisfactory / acceptable outcomes (rather than maximum). Due to conflicting goals, or last bit of utility /  profit requires to much effort.',
    subunit: Subunit.critiqueBehaviour,
    tags: [Tag.hl],
  ),

  ///2.5-2.6 Elasticities
  realIncome(
    termName: 'Real Income',
    explanation:
        'Income adjusted for inflation; shows actual purchasing power.',
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
        'Normal goods that are desirable, with <strong>YED > 1</strong>.',
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
        'Any increase in price leads causes quantity demanded to fall to zero. e.g., generic goods with perfect substitutes.',
    subunit: Subunit.elasticityDemand,
  ),
  perfectlyPriceInelasticDemand(
    termName: 'Perfectly price inelastic demand (PED = 0)',
    explanation:
        'A change in price has no effect on quantity demanded. E.g., life-saving medicines.',
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
  economicallyLessDevelopedCountries(
    termName: 'Economically Less-Developed Countries (ELDCs)',
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

  /// 2.7
  priceControls(
    termName: 'Price Controls',
    explanation:
        'Price floors and price ceilings - results in market-disequilibrium - shortages/surpluses (usually to support low income households or support firms)',
    subunit: Subunit.roleOfGovernment,
  ),

  priceCeiling(
    termName: 'Price Ceiling',
    explanation:
        'A maximum legal price set by the government, below the equilibrium price.',
    subunit: Subunit.roleOfGovernment,
  ),

  priceFloor(
    termName: 'Price Floor',
    explanation:
        'A minimum legal price set by the government, above the equilibrium price (minimum wage or agricultural price floor).',
    subunit: Subunit.roleOfGovernment,
  ),

  minimumWage(
    termName: 'Minimum Wage',
    explanation:
        'A legal price floor in the labor market above market wage to protect low-skilled workers.',
    subunit: Subunit.roleOfGovernment,
  ),

  marketDisequilibrium(
    termName: 'Market Disequilibrium',
    explanation: 'Qd > Qs or Qs > Qd; shortage or a surplus.',
    subunit: Subunit.roleOfGovernment,
  ),

  regulations(
    termName: 'Regulations (command and control)',
    explanation: 'Direct government rules or laws / bans.',
    subunit: Subunit.roleOfGovernment,
  ),

  ///2.8 Externalities
  externalities(
    termName: 'Externalities',
    explanation:
        'Costs or benefits of production/consumption imposed on third parties not reflected in market prices.',
    subunit: Subunit.marketFailureExternalitiesCPR,
  ),

  positiveProductionExternality(
    termName: 'Positive Production Externality',
    explanation:
        'External benefit from production to third parties (MSC < MPC).',
    subunit: Subunit.marketFailureExternalitiesCPR,
  ),

  positiveConsumptionExternality(
    termName: 'Positive Consumption Externality',
    explanation:
        'External benefit from consumption to third parties (MSB > MPB).',
    subunit: Subunit.marketFailureExternalitiesCPR,
  ),

  negativeProductionExternality(
    termName: 'Negative Production Externality',
    explanation: 'External cost from production to third parties (MSC > MPC).',
    subunit: Subunit.marketFailureExternalitiesCPR,
  ),

  negativeConsumptionExternality(
    termName: 'Negative Consumption Externality',
    explanation: 'External cost from consumption to third parties (MSB < MPB).',
    subunit: Subunit.marketFailureExternalitiesCPR,
  ),

  meritGoods(
    termName: 'Merit Goods',
    explanation:
        'Goods under-consumed by individuals but socially beneficial, often subsidised or provided by government.',
    subunit: Subunit.marketFailureExternalitiesCPR,
  ),

  demeritGoods(
    termName: 'Demerit Goods',
    explanation:
        'Goods over-consumed due to imperfect information, with negative externalities (e.g. tobacco).',
    subunit: Subunit.marketFailureExternalitiesCPR,
  ),

  pigouvianTax(
    termName: 'Pigouvian Tax',
    explanation:
        'Tax equal to external cost to correct negative externalities and align MPC with MSC.',
    subunit: Subunit.marketFailureExternalitiesCPR,
  ),

  commandAndControl(
    termName: 'Command and Control',
    explanation:
        'Government rules limiting or banning activities (e.g. emissions caps, bans).',
    subunit: Subunit.marketFailureExternalitiesCPR,
  ),

  carbonTax(
    termName: 'Carbon Tax',
    explanation:
        'Tax on CO₂ emissions to reduce pollution by increasing cost of carbon-intensive production.',
    subunit: Subunit.marketFailureExternalitiesCPR,
  ),

  tradablePermits(
    termName: 'Tradable Permits',
    explanation:
        'Cap-and-trade system where firms buy/sell emission permits within a fixed pollution cap.',
    subunit: Subunit.marketFailureExternalitiesCPR,
  ),

  commonPoolResources(
    termName: 'Common Pool Resources (CPR)',
    explanation:
        'Non-excludable but rival goods prone to overuse and depletion without regulation.',
    subunit: Subunit.marketFailureExternalitiesCPR,
  ),

  tragedyOfTheCommons(
    termName: 'Tragedy of the Commons',
    explanation:
        'Overuse of a common resource due to self-interest leading to depletion of the resource.',
    subunit: Subunit.marketFailureExternalitiesCPR,
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
    subunit: Subunit.marketFailureExternalitiesCPR,
  ),

  /// 2.9 public good
  publicGood(
    termName: 'Public Good',
    explanation: 'Non-excludable and non-rival. Subject to free-rider problem',
    subunit: Subunit.marketFailureExternalitiesCPR,
  ),
  nonRejectable(
    termName: 'Non-rejectable',
    explanation:
        'Cannot reject the benefit of a public good once provided (e.g., everyone benefits from national defense).',
    subunit: Subunit.marketFailurePublicGoods,
  ),
  contractingOut(
    termName: 'Contracting Out',
    explanation:
        'The government hires private firms to provide public goods on its behalf, usually via competitive tendering.',
    subunit: Subunit.marketFailurePublicGoods,
  ),

  costBenefitAnalysis(
    termName: 'Cost-Benefit Analysis',
    explanation:
        'Government estimates social benefits (via surveys, analysis) of supplying a public good, will supply where MSB = MSC.',
    subunit: Subunit.marketFailurePublicGoods,
  ),

  /// 2.10 Asymmetric Information
  informationFailure(
    termName: 'Information Failure',
    explanation:
        'Market failure due to buyers or sellers not having full or accurate information to make rational decisions.',
    subunit: Subunit.marketFailureAsymmetricInformation,
  ),
  asymmetricInformation(
    termName: 'Asymmetric Information',
    explanation:
        'A market failure where one party in an economic transaction possesses more or better information than the other, leading to an inefficient allocation of resources.',
    subunit: Subunit.marketFailureAsymmetricInformation,
  ),
  moralHazard(
    termName: 'Moral Hazard',
    explanation:
        'When one party takes excessive risks because the cost of that risk is borne by another party (often due to insurance, banks make risky investments as expect government bail out).',
    subunit: Subunit.marketFailureAsymmetricInformation,
  ),

  adverseSelection(
    termName: 'Adverse Selection',
    explanation:
        'Where an imbalance of information leads to low-quality products or high-risk participants dominating the market (e.g., used cars, health insurance).',
    subunit: Subunit.marketFailureAsymmetricInformation,
  ),

  screening(
    termName: 'Screening',
    explanation:
        'Action taken by the less-informed party to gather information and assess risk (e.g., an employer requiring background checks).',
    subunit: Subunit.marketFailureAsymmetricInformation,
  ),

  signaling(
    termName: 'Signaling',
    explanation:
        'Action taken by the more-informed party to credibly reveal their hidden information or quality to the other party (e.g., a firm offering a warranty).',
    subunit: Subunit.marketFailureAsymmetricInformation,
  ),

  dynamicEfficiency(
    termName: 'Dynamic Efficiency',
    explanation:
        'Improved long-term efficiency by investment in R&D and innovation (technology).',
    subunit: Subunit.marketFailureMarketPower,
    tags: [Tag.hl],
  ),
  collusion(
    termName: 'Collusion',
    explanation:
        'Firms in oligopoly coordinate by fixing prices or restricting output to limit competition (act as a monopoly).',

    subunit: Subunit.marketFailureMarketPower,
    tags: [Tag.hl],
  ),
  perfectCompetition(
    termName: 'Perfect Competition',
    explanation:
        'Many small firms with no market power (P=MC) selling a homogeneous product. Perfect information, and perfect factor mobility of labor and capital. No barriers to entry/exit means only normal profit in long-run.',
    subunit: Subunit.marketFailureMarketPower,
  ),
  monopolisticCompetition(
    termName: 'Monopolistic Competition',
    explanation:
        'Many small firms, each with some (limited) market power due to product differentiation. Low barriers to entry/exit means only normal profit in long-run.',
    subunit: Subunit.marketFailureMarketPower,
  ),
  monopoly(
    termName: 'Monopoly',
    explanation:
        'A single supplier of a good or service. Very high barriers to entry and significant market power P>MC.',
    subunit: Subunit.marketFailureMarketPower,
  ),
  naturalMonopoly(
    termName: 'Natural Monopoly',
    explanation:
        'A market where a single firm can supply the entire market demand at a lower average cost than two or more firms due to high fixed costs and massive economies of scale.',
    subunit: Subunit.marketFailureMarketPower,
  ),
  marketPower(
    termName: 'Market Power',
    explanation:
        'The ability of a firm to influence the price of a good, set P>MC.',
    subunit: Subunit.marketFailureMarketPower,
  ),
  abnormalProfit(
    termName: 'Abnormal Profit',
    explanation: 'TR > TC (explicit and implicit costs).',
    subunit: Subunit.marketFailureMarketPower,
  ),
  normalProfit(
    termName: 'Normal Profit',
    explanation:
        'TR = TC (implicit and explicit costs). Minimum level of profit required to keep a firm in industry in long-run.',
    subunit: Subunit.marketFailureMarketPower,
  ),
  shortRunMicro(
    termName: 'Short Run (Micro)',
    explanation:
        'The period of time in which at least one factor of production is fixed.',
    subunit: Subunit.marketFailureMarketPower,
  ),
  barriersToEntry(
    termName: 'Barriers to Entry',
    explanation:
        'Factors with prevents entry of new firms into an industry (economies of scale, branding, patents, or legal barriers).',
    subunit: Subunit.marketFailureMarketPower,
    tags: [Tag.hl],
  ),
  nonPriceCompetition(
    termName: 'Non-Price Competition',
    explanation:
        'Competition between firms that focuses on factors other than price, such as product differentiation, advertising, customer service, and brand loyalty.',
    subunit: Subunit.marketFailureMarketPower,
    tags: [Tag.hl],
  ),
  oligopoly(
    termName: 'Oligopoly',
    explanation:
        'A market structure dominated by a few large firms with high barriers to entry and mutual interdependence.',
    subunit: Subunit.marketFailureMarketPower,
    tags: [Tag.hl],
  ),
  concentrationRatio(
    termName: 'Concentration Ratio',
    explanation:
        'A measure of the percentage of total market share held by the largest firms (e.g., CR4) in an industry.',
    subunit: Subunit.marketFailureMarketPower,
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
  windfallTax(
    termName: 'Windfall Tax',
    explanation: 'One-off tax on unexpected supernormal profits.',
    subunit: Subunit.marketFailureMarketPower,
    tags: [Tag.hl],
  ),

  marginalCostPricing(
    termName: 'Marginal Cost Pricing',
    explanation: 'Price set equal to marginal cost (P = MC).',
    subunit: Subunit.marketFailureMarketPower,
    tags: [Tag.hl],
  ),

  averageCostPricing(
    termName: 'Average Cost Pricing',
    explanation: 'Price set equal to average cost (P = AC).',
    subunit: Subunit.marketFailureMarketPower,
    tags: [Tag.hl],
  ),

  productiveEfficiency(
    termName: 'Productive Efficiency',
    explanation: 'Production at the lowest possible cost (minimum AC).',
    subunit: Subunit.marketFailureMarketPower,
    tags: [Tag.hl],
  ),

  cartel(
    termName: 'Cartel',
    explanation: 'Group of firms that collude to fix prices or output.',
    subunit: Subunit.marketFailureMarketPower,
    tags: [Tag.hl],
  ),

  informalCollusion(
    termName: 'Informal Collusion',
    explanation: 'Firms coordinate behaviour without a formal agreement.',
    subunit: Subunit.marketFailureMarketPower,
    tags: [Tag.hl],
  ),

  predatoryPricing(
    termName: 'Predatory Pricing',
    explanation: 'Setting very low prices to force competitors out.',
    subunit: Subunit.marketFailureMarketPower,
    tags: [Tag.hl],
  ),

  bundlingTying(
    termName: 'Bundling / Tying',
    explanation: 'Selling products together or forcing joint purchase.',
    subunit: Subunit.marketFailureMarketPower,
    tags: [Tag.hl],
  ),

  antiCompetitivePractices(
    termName: 'Anti-competitive Practices',
    explanation: 'Actions that reduce or restrict competition.',
    subunit: Subunit.marketFailureMarketPower,
    tags: [Tag.hl],
  ),

  regulatoryCapture(
    termName: 'Regulatory Capture',
    explanation: 'Regulators act in the interest of firms, not consumers.',
    subunit: Subunit.marketFailureMarketPower,
    tags: [Tag.hl],
  ),

  shutdownPoint(
    termName: 'Shutdown Point',
    explanation:
        'Price equals minimum AVC; below this, firm shuts down in short run.',
    subunit: Subunit.marketFailureMarketPower,
    tags: [Tag.hl],
  ),
  priceWar(
    termName: 'Price War',
    explanation: 'Firms repeatedly lower prices to compete for market share.',
    subunit: Subunit.marketFailureMarketPower,
    tags: [Tag.hl],
  ),

  gameTheory(
    termName: 'Game Theory',
    explanation:
        'Use of pay-off matrix to show the conflict firms face between cooperation and self-interest.',
    subunit: Subunit.marketFailureMarketPower,
    tags: [Tag.hl],
  ),
  prisonersDilemma(
    termName: 'Prisoners Dilemma',
    explanation:
        'Players mutually benefit if they cooperate but each has an incentive to secretly cheat. But if both cheat, will both end-up worse off (stuck in Nash Equilibrium)',
    subunit: Subunit.marketFailureMarketPower,
    tags: [Tag.hl],
  ),

  /// 2.11 Equity
  equity(
    termName: 'Equity',
    explanation:
        'Equity is the concept of fairness in the distribution of income and wealth. It is normative (value-based / subjective).',
    subunit: Subunit.marketInequity,
    tags: [Tag.hl],
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
  moneyMarket(
    termName: 'Money Market',
    explanation:
        'A market where the supply and demand for money determines the equilibrium nominal interest rate.',
    subunit: Subunit.demandManagementMonetary,
  ),

  expansionaryMonetaryPolicy(
    termName: 'Expansionary Monetary Policy (loose monetary policy)',
    explanation:
        'Central bank policies that increases money supply to lower interest rates to correct a deflationary/recessionary-gap.',
    subunit: Subunit.demandManagementMonetary,
  ),

  contractionaryMonetaryPolicy(
    termName: 'Contractionary Monetary Policy (tight monetary policy)',
    explanation:
        'Central bank policies that reduces money supply to raise interest rates to correct an inflationary-gap.',
    subunit: Subunit.demandManagementMonetary,
  ),

  equilibriumInterestRate(
    termName: 'Equilibrium Interest Rate',
    explanation:
        'When MD = MS. The target rate of the central bank. The base rate of all interest rates in the economy',
    subunit: Subunit.demandManagementMonetary,
  ),

  OMO(
    termName: 'Open Market Operations (OMO)',
    explanation:
        'Central bank buying or selling government bonds to change money supply.',
    subunit: Subunit.demandManagementMonetary,
  ),

  MLR(
    termName: 'Minimum Lending Rate (MLR)',
    explanation:
        'The rate at which commercial banks can borrow from the central bank when they face liquidity problems (lender of last resort).',
    subunit: Subunit.demandManagementMonetary,
  ),

  MRR(
    termName: 'Minimum Reserve Requirement (MRR)',
    explanation:
        'The fraction (%) of deposits banks must hold as required reserves.',
    subunit: Subunit.demandManagementMonetary,
  ),

  QE(
    termName: 'Quantitative Easing (QE)',
    explanation:
        'Large scale purchase of bonds and other financial assets by the central bank to inject liquidity into the economy during a financial crisis.',
    subunit: Subunit.demandManagementMonetary,
  ),

  quantitativeTightening(
    termName: 'Quantitative Tightening',
    explanation:
        'Reverse of QE: Central bank selling assets or letting them mature to reduce money supply.',
    subunit: Subunit.demandManagementMonetary,
  ),

  fractionalReserveBanking(
    termName: 'Fractional Reserve Banking',
    explanation:
        'A system where banks keep a fraction of deposits as reserves and lend out the rest, thereby creating new money (credit creation).',
    subunit: Subunit.demandManagementMonetary,
  ),

  money(
    termName: 'Money',
    explanation:
        'Widely accepted as a medium of exchange, store of value, and unit of account.',
    subunit: Subunit.demandManagementMonetary,
  ),

  moneySupply(
    termName: 'Money Supply',
    explanation:
        'Total amount of money circulating in an economy at a given time. Commonly MS = C + D (Money Supply = Currency + Deposits).',
    subunit: Subunit.demandManagementMonetary,
  ),

  inflationTargeting(
    termName: 'Inflation Targeting',
    explanation:
        'Central bank uses monetary policy tools to target a desired inflation rate (usually around 2%).',
    subunit: Subunit.demandManagementMonetary,
  ),

  anchoredInflationExpectations(
    termName: 'Anchored Inflation Expectations',
    explanation:
        'When the public (households, firms, investors) expect inflation to remain low and stable, helping central bank maintain price stability.',
    subunit: Subunit.demandManagementMonetary,
  ),

  monetaryPolicyTransmissionMechanism(
    termName: 'Monetary Policy Transmission Mechanism',
    explanation:
        'The process by which changes in interest rates affect consumption, investment, and net exports over-time.',
    subunit: Subunit.demandManagementMonetary,
  ),

  fiatMoney(
    termName: 'Fiat Money',
    explanation:
        'Money that has value because the government declares it legal tender, not because of intrinsic value.',
    subunit: Subunit.demandManagementMonetary,
  ),

  monetaryPolicy(
    termName: 'Monetary Policy',
    explanation:
        'Central bank policy on interest rates and money supply to achieve macroeconomic goals.',
    subunit: Subunit.demandManagementMonetary,
    tags: [],
  ),
  openMarketOperations(
    termName: 'Open Market Operations (OMO)',
    explanation:
        'Central bank buys and sells government securities (bonds) in the open market to influence the money supply and interest rates.',
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
        'Monetary policy ineffective when already low interest rates, increases in money supply fail to stimulate aggregate demand (low consumer/business confidence, bankruptcies, banks unwilling to lend, high real debt burden).',
    subunit: Subunit.demandManagementMonetary,
    tags: [],
  ),

  /// 3.6 Fiscal
  fiscalPolicy(
    termName: 'Ricardian Equivalence',
    explanation:
        'The theory that households increase saving when government borrowing rises because they expect higher future taxes.',
    subunit: Subunit.demandManagementFiscal,
  ),

  fiscalDrag(
    termName: 'Fiscal Drag',
    explanation:
        'An automatic stabilizer where rising incomes push taxpayers into higher tax brackets, reducing growth in disposable income and aggregate demand.',
    subunit: Subunit.demandManagementFiscal,
  ),

  crowdingIn(
    termName: 'Crowding In',
    explanation:
        'When government spending increases private sector investment by raising demand, confidence, and expected profits.',
    subunit: Subunit.demandManagementFiscal,
  ),
  budgetDeficit(
    termName: 'Budget Deficit',
    explanation: 'T < G over one year.',
    subunit: Subunit.demandManagementFiscal,
  ),
  budgetSurplus(
    termName: 'Budget Surplus',
    explanation: 'T > G over one year.',
    subunit: Subunit.demandManagementFiscal,
  ),
  currentExpenditure(
    termName: 'Current Expenditure',
    explanation:
        'Government spending on day-to-day activities such as wages, public services, and maintenance.',
    subunit: Subunit.demandManagementFiscal,
  ),
  capitalExpenditure(
    termName: 'Capital Expenditure',
    explanation:
        'Government spending on long-term investment such as infrastructure, schools, and hospitals.',
    subunit: Subunit.demandManagementFiscal,
  ),
  keynesianSpendingMultiplier(
    termName: 'Keynesian Spending Multiplier',
    explanation:
        'The process where an initial injection of government spending leads to a larger final increase in real GDP through successive rounds of spending.',
    subunit: Subunit.demandManagementFiscal,
  ),
  marginalPropensityToConsume(
    termName: 'Marginal Propensity to Consume',
    explanation:
        'The proportion of additional income that is spent on domestic goods and services.',
    subunit: Subunit.demandManagementFiscal,
  ),
  taxMultiplier(
    termName: 'Tax Multiplier',
    explanation:
        'The change in real GDP resulting from a change in taxes, smaller in magnitude than the government spending multiplier.',
    subunit: Subunit.demandManagementFiscal,
  ),
  expansionaryFiscalPolicy(
    termName: 'Expansionary Fiscal Policy',
    explanation:
        'Government policy that increases aggregate demand through higher government spending or lower taxes.',
    subunit: Subunit.demandManagementFiscal,
  ),
  contractionaryFiscalPolicy(
    termName: 'Contractionary Fiscal Policy',
    explanation:
        'Government policy that reduces aggregate demand through lower government spending or higher taxes.',
    subunit: Subunit.demandManagementFiscal,
  ),
  automaticStabilizers(
    termName: 'Automatic Stabilizers',
    explanation:
        'Built-in fiscal mechanisms such as taxes and welfare payments that reduce fluctuations in the business cycle without deliberate government intervention.',
    subunit: Subunit.demandManagementFiscal,
  ),
  corporationTax(
    termName: 'Corporation Tax',
    explanation:
        'A tax on firm profits that can reduce investment by lowering after-tax returns.',
    subunit: Subunit.demandManagementFiscal,
  ),
  resourceCrowdingOut(
    termName: 'Resource Crowding Out',
    explanation:
        'When government demand for scarce resources increases input prices and reduces availability for the private sector.',
    subunit: Subunit.demandManagementFiscal,
  ),

  /// 3.7 Supply-Side
  supplySidePolicies(
    termName: 'Supply-Side Policies',
    explanation:
        'Policies to increase LRAS and potential output. Market-based and interventionist.',
    subunit: Subunit.supplySidePolicies,
  ),
  supplySidePoliciesMarketBased(
    termName: 'Market-Based Supply-Side Policies',
    explanation:
        'Policies to promote free market forces to improve efficiency and incentives (e.g., deregulation, privatisation, lower taxes).',
    subunit: Subunit.supplySidePolicies,
  ),

  supplySidePoliciesInterventionist(
    termName: 'Interventionist Supply-Side Policies',
    explanation:
        'Government intervention policies to increase productive capacity (e.g., investment in education, infrastructure, subsidies).',
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

  foreignDirectInvestment(
    termName: 'Foreign Direct Investment (FDI)',
    explanation:
        'Long-term investment by a firm from one country into productive assets (e.g. factories, businesses) in another country, involving a lasting interest and some control.',
    subunit: Subunit.balanceOfPayments,
  ),
  multinationalCorporations(
    termName: 'Multinational Corporations (MNCs)',
    explanation:
        'Firms that operate in more than one country, with production or business activities located across different nations.',
    subunit: Subunit.balanceOfPayments,
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
