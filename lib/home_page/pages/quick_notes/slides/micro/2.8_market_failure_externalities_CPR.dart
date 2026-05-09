import 'package:economics_app/home_page/pages/real_world_examples/real_world_examples.dart';
import 'package:economics_app/home_page/pages/terms/terms.dart';

import '../../../../../diagrams/enums/diagram_enum.dart';
import '../../../../../diagrams/enums/unit_type.dart';
import '../../../../models/slide.dart';
import '../../../../models/slide_content.dart';

final marketFailureExternalitiesCPRSLide = Slide(
  subunit: Subunit.marketFailureExternalitiesCPR,
  contents: [
    SlideContent.text('''
  <h1>Externalities</h1>
  <ul>
    <li>Social optimum (allocative efficiency) occurs where MSB = MSC.</li>
    <li>Externalities are third-party effects not reflected in the free-market price, leading to market failure (allocative inefficiency).</li>
    <li>This results in misallocation of resources: over-allocation (MSB &lt; MSC) or under-allocation (MSB &gt; MSC).</li>
  </ul>
  <h2>Negative Production Externalities</h2>
'''),
    SlideContent.diagrams(
      description:
          'Negative production externality: MSC &gt; MPC due to external costs imposed on third parties. Examples include factory pollution and overuse of common pool resources (e.g. overfishing, air pollution), leading to over-allocation of resources. To correct: LEFT: PIGOUVIAN TAX; RIGHT: REGULATIONS.',
      [
        DiagramEnum.microNegativeProductionExternality,
        DiagramEnum.microNegativeProductionExternalityPigouvianTax,
        DiagramEnum.microNegativeProductionExternalityRegulations,
      ],
    ),
    SlideContent.text('''
      <h3>Common Pool Resources (CPR)</h3>
      <ul><li><b>Non-excludable</b> but <b>rivalrous</b>.</li>
      <li>Leads to <b>tragedy of the commons</b>. Unsustainable production <b>(overuse)</b> of natural resources creates negative production externality (MSC > MPC). Examples: overfishing of Pacific Blue-Fin Tuna.</li>
      </ul>
      '''),
    SlideContent.simpleTable(
      title: 'Policies to correct market failure caused by CPR',
      headers: ['Policy', 'Example', 'Pros', 'Cons'],
      data: [
        [
          'Assign Property Rights',
          'New Zealand Individual Transferable Quota (ITQ) system',
          'Market-based, low cost, incentive to conserve',
          'Hard to enforce, not suitable for global CPR (ocean)',
        ],
        [
          'Command and Control',
          'NZ Fisheries Act 1996 (limits on season, size, catch)',
          'Clear rules, quick to implement, effective if enforced',
          'High enforcement cost, inflexible, no extra incentive',
        ],
        [
          'International agreements',
          'Paris Agreement (2015) on climate signed by 190+ countries',
          'Addresses global CPR, cooperation between countries',
          'Free-rider problem, weak enforcement, conflicts between countries',
        ],
        [
          'Collective self-governance',
          'Maine lobster fishery (community-managed, ongoing)',
          'Local knowledge, flexible, promotes cooperation',
          'Needs trust, hard for large CPR, monitoring issues',
        ],
      ],
    ),
    SlideContent.text('''
  <h3>CO₂ Emissions</h3>
  <h3>Carbon Tax</h3>
  <ul>
    <li>A Pigouvian tax on the production of emissions, designed to reduce the external costs of CO₂ (climate change).</li>
    <li>Sweden introduced a carbon tax in 1991 at €33 per tonne, rising to around €120 per tonne over time.</li>
    <li>Australia attempted a carbon pricing scheme in 2012, but it was repealed in 2014 due to political opposition.</li>
  </ul>
'''),
    SlideContent.diagrams(
      description:
          'As tax is on carbon emissions, the size of externality reduces as firms substitute to cleaner energy sources.',
      [DiagramEnum.microNegativeProductionCarbonTax],
    ),
    SlideContent.simpleTable(
      title: 'Carbon Tax Evaluation',
      headers: ['Pros', 'Cons'],
      data: [
        [
          'Incentive to reduce emissions / substitute to cleaner energy',
          'Higher costs of production for firms',
        ],
        [
          'Raises government revenue',
          'Difficult to measure emissions accurately',
        ],
        [
          'Revenue can fund green investment / support low-income groups',
          'Regressive – higher prices for energy & food',
        ],
        [
          'Internalizes negative externality (polluter pays)',
          'Carbon leakage to countries with weaker regulation',
        ],
        ['Improves environmental outcomes', 'Inelastic demand'],
      ],
    ),
    SlideContent.text('''
      <h3>Tradeable Permits</h3>
      <ul><li>Government sells (or allocates) permits to emit carbon, aiming to reduce the social cost of emissions.</li>
      <li>Demand for permits fall overtime as firms switch to cleaner sources.</li>
      <li>New Zealand Emissions Trading Scheme (2008).</li>
      </ul>
      '''),
    SlideContent.diagrams(
      description:
          'Supply of permits is perfectly inelastic as set by government. Supply and demand can fall over-time as firms substitute to clean energ sources.',
      [
        DiagramEnum.microTradablePollutionPermits,
        DiagramEnum.microTradablePollutionPermitsSupplyDemandDecrease,
      ],
    ),
    SlideContent.simpleTable(
      title: 'Tradable Permits (Cap-and-Trade) Evaluation',
      headers: ['Pros', 'Cons'],
      data: [
        [
          'Targets fixed pollution level (cap)',
          'Cap set too high/low; ineffective or costly',
        ],
        [
          'Generates government revenue (auctioning permits)',
          'Political influence / unfair allocation',
        ],
        [
          'Cost-efficient (trade between firms)',
          'Limited coverage (specific industries only)',
        ],
        [
          'Incentive to reduce emissions over time',
          'Complex to set up and monitor',
        ],
        ['Can reduce supply if permits withheld', ''],
      ],
    ),
    SlideContent.text('''
  <h3>Negative Consumption Externalities</h3>
  <ul>
    <li>Over-consumption of demerit goods generates external costs on society, where MPB &gt; MSB.</li>
    <li>Demerit goods are over-consumed due to information failure (underestimation of social costs), low relative price, and addiction.</li>
  </ul>
'''),
    SlideContent.diagrams(
      description: 'Negative consumption externality MPB > MSB',
      [DiagramEnum.microNegativeConsumptionExternality],
    ),

    SlideContent.diagrams(
      description:
          'Solutions for negative consumption externalities: LEFT: PIGOUVIAN TAX; CENTER: REGULATIONS; RIGHT: EDUCATION/NUDGES.',
      [
        DiagramEnum.microNegativeConsumptionExternalityPigouvianTax,
        DiagramEnum.microNegativeConsumptionExternalityRegulations,
        DiagramEnum.microNegativeConsumptionExternalityEducationAndNudges,
      ],
    ),
    SlideContent.text('''
      <h3>Positive Production Externalities</h3>
      <ul>
      <li>MPC > MSC.</li>
      <li>mRNA vaccination research - spill-over for other vaccines.</li>
      </ul>
      '''),
    SlideContent.diagrams(
      description:
          'Solutions for positive production externalities: CENTER: GOVERNMENT PROVISION; RIGHT: SUBSIDY FOR PRIVATE FIRMS.',
      [
        DiagramEnum.microPositiveProductionExternality,
        DiagramEnum.microPositiveProductionExternalityGovernmentProvision,
        DiagramEnum.microPositiveProductionExternalitySubsidy,
      ],
    ),
    SlideContent.text('''
      <h3>Positive Consumption Externalities</h3>
      <ul>
      <li>MSB > MPB.</li>
      <li>Covid vaccination, gym-memberships</li>
      </ul>
      '''),
    SlideContent.diagrams(
      description:
          'Solutions for negative production externalities: LEFT: SUBSIDY; RIGHT: REGULATIONS (MUST BUY HEALTH INSURANCE / VACCINATIONS).',
      [
        DiagramEnum.microPositiveConsumptionExternalitySubsidy,
        DiagramEnum.microPositiveConsumptionExternalityRegulations,
      ],
    ),
    SlideContent.diagrams(
      description:
          'LEFT: EDUCATION / NUDGES; RIGHT: DIRECT GOVERNMENT PROVISION.',
      [
        DiagramEnum.microPositiveConsumptionExternalityEducationAndNudges,
        DiagramEnum.microPositiveProductionExternalityGovernmentProvision,
      ],
    ),
    SlideContent.simpleTable(
      title: 'EVALUATION OF POLICIES TO CORRECT EXTERNALITIES',
      headers: [
        '',
        'Market-based (Tax/Subsidies)',
        'Command and Control (Regulation/Bans)',
        'Public Awareness (Education)',
        'Nudges (Behavioural Economics)',
        'Government Provision',
      ],
      data: [
        [
          'Strengths',
          'Internalises external costs/benefits; efficient and flexible; generates government revenue.',
          'Clear enforceable standards; direct and effective control of behaviour.',
          'Improves information and awareness of social costs/benefits.',
          'Influences behaviour while preserving choice; low coercion.',
          'Ensures access and corrects under-provision of merit goods.',
        ],
        [
          'Limitations',
          'Equity concerns (regressive effects); difficult valuation; less effective if demand is price inelastic.',
          'High monitoring and enforcement costs; inflexible; punitive approach.',
          'Slow impact; effectiveness difficult to measure.',
          'Effectiveness uncertain; potential manipulation concerns.',
          'High fiscal cost; risk of government failure; may crowd out private sector.',
        ],
      ],
    ),
    SlideContent.econTerms(
      EconTerm.values
          .where(
            (term) => term.subunit == Subunit.marketFailureExternalitiesCPR,
          )
          .toList(),
    ),
    SlideContent.realWorldExamples(
      RealWorldExamples.values
          .where(
            (term) => term.subunit == Subunit.marketFailureExternalitiesCPR,
          )
          .toList(),
    ),
  ],
);
