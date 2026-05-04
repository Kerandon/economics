import '../../../../../diagrams/enums/diagram_enum.dart';
import '../../../../../diagrams/enums/unit_type.dart';
import '../../../../enums/tag.dart';
import '../../../../models/slide.dart';
import '../../../../models/slide_content.dart';
import '../../../real_world_examples/real_world_examples.dart';
import '../../../terms/terms.dart';

final demandElasticitySlide =  Slide(
  subunit:
  Subunit.elasticityDemand,
  contents: [
    SlideContent.text('''
    <h2>PED</h2>
    <p>PED = %∆Qd / %∆P</p>  
      '''),
    SlideContent.simpleTable(
      headers: ['PED Value', 'Responsiveness', 'Example Good'],
      data: [
        ['PED = 0', 'Perfectly Inelastic', 'Life-saving medication (Insulin)'],
        ['0 < PED < 1', 'Inelastic', 'Addictive goods (Cigarettes), Utilities'],
        ['PED = 1', 'Unit Elastic', 'Clothing / cinema'],
        ['1 < PED < ∞', 'Elastic', 'Luxury cars'],
        ['PED = ∞', 'Perfectly Elastic', 'Perfect competition commodities'],
      ],
    ),
    SlideContent.text(
        '''
          <h3>Determinants of PED</h3>
  <ul>
    <li><b>Number and closeness of substitutes</b></li>
    <li><b>Degree of necessity</b></li>
    <li><b>Proportion of income spent</b></li>
    <li><b>Time</b></li>
  </ul>
  '''
    ),
    SlideContent.simpleTable(
      title: 'Importance of PED for Firms',
      headers: ['Strategy', 'Action'],
      data: [
        [
          'Revenue Maximization',
          'Raise price if PED < 1 (inelastic); lower price if PED > 1 (elastic) to increase TR.'
        ],
        [
          'Price Discrimination',
          'Charge higher prices to inelastic segments (e.g., Disneyland weekend prices, last-minute travel flights).'
        ],
        [
          'Limitations',
          'Imperfect data; competition/price wars; alternative goals (MC=MR, CSR, Satisficing).'
        ],
      ],
    ),
    SlideContent.diagrams(
        description: 'Raising the price when PED < 1 will increase TR.',
        [
          DiagramEnum.microDemandInelasticRevenue,
          DiagramEnum.microDemandElasticRevenue,

        ]),
    SlideContent.simpleTable(
      title: 'Importance of PED for Government',
      headers: ['Policy', 'Application'],
      data: [
        [
          'Indirect Tax Revenue',
          'Target goods with PED < 1 (e.g., tobacco, petrol) to maximize tax yield with minimal Qd drop.'
        ],
        [
          'Correcting Externalities',
          'High taxes only reduce consumption of demerit goods effectively if demand is elastic (PED > 1).'
        ],
        [
          'Subsidies',
          'More effective at increasing consumption for goods with elastic demand.'
        ],
        [
          'Limitations',
          'Inaccurate PED estimates lead to unintended tax shortfalls or over-subsidization.'
        ],
      ],
    ),
    SlideContent.simpleTable(
      tags: [Tag.hl],
      title: 'PED: Primary vs. Manufactured',
      headers: ['Primary Commodities (Inelastic)', 'Manufactured Goods (Elastic)'],
      data: [
        [
          'Necessities (staple foods) or essential inputs (oil, minerals).',
          'Often luxuries (designer clothing, high-end electronics).'
        ],
        [
          'Few close substitutes available.',
          'High competition and many close substitutes.'
        ],
        [
          'Small proportion of total income (e.g., rice, salt).',
          'Large proportion of total income (e.g., cars, appliances).'
        ],
        [
          'Result: Low responsiveness to price changes.',
          'Result: High responsiveness to price changes.'
        ],
      ],
    ),
    SlideContent.diagrams(
        description: 'A change in quantity demanded is <b>proportionally</b> greater / smaller than a change it\'s price ',
        [
          DiagramEnum.microDemandElastic,
          DiagramEnum.microDemandInelastic,
        ]),
    SlideContent.diagrams(
        description: 'PED = 1 (Unit elastic)',
        [
          DiagramEnum.microDemandUnitElastic,
        ]),
    SlideContent.diagrams(
        description: 'Perfectly inelastic PED = 0 (organ transplant); PED = infinity (perfect competition)',
        [
          DiagramEnum.microDemandPerfectlyInelastic,
          DiagramEnum.microDemandPerfectlyElastic,
        ]),
    SlideContent.diagrams(
        description: 'PED varies along any downward sloping demand curve. The ration of PED is P / Q. Above midpoint elastic (PED > 1), midpoint (PED = 1); below midpoint PED inelastic (PED < 1)',
        [
          DiagramEnum.microDemandElasticityRevenueChange,
        ]),

    SlideContent.text(
      '''
      <h2>YED</h2>
      <p>YED = %∆QD / %∆Y</p>
     '''
    ),
    SlideContent.simpleTable(
      title: 'Degrees of YED',
      headers: ['YED < 0', '0 < YED < 1', 'YED > 1'],
      data: [
        [
          'Inferior goods',
          'Normal goods – necessities',
          'Normal goods – luxuries',
        ],
        [
          'Generic brands, some public transport',
          'Basic food, utilities',
          'Luxury cars, holidays, dining out',
        ],
      ],
    ),
    SlideContent.text(
        tags: [Tag.hl],
        '''
  <h3>Importance of YED for Firms</h3>
  <ul>
    <li>When real GDP is growing fast, firms should focus on goods with YED > 1 (luxuries and services).</li>
    <li>During a recession, demand for inferior goods increases.</li>
  </ul>
  '''
    ),
    SlideContent.text(
        tags: [Tag.hl],
        '''
  <h3>Importance of YED for Sectoral Structure of Economy</h3>
  <ul>
    <li>Primary sector (e.g. agriculture) is relatively income inelastic.</li>
    <li>Tertiary sector (services) is relatively more income elastic.</li>
    <li>As economies develop, demand shifts from primary goods to services due to higher YED.</li>
    <li>This causes structural change in output and employment.</li>
  </ul>
  '''
    ),
SlideContent.diagrams([DiagramEnum.microDemandEngelCurve]),
    SlideContent.econTerms([
      EconTerm.priceElasticDemand,
      EconTerm.primaryCommodity,
      EconTerm.manufacturedGood,
      EconTerm.incomeElasticityOfDemand,
      EconTerm.primarySector,
      EconTerm.secondarySector,
      EconTerm.tertiarySector,
    ]),
    SlideContent.realWorldExamples([
      RealWorldExamples.disneylandPricing,
      RealWorldExamples.airlinesPriceDiscrimination,
      RealWorldExamples.usSectorStructure,
      RealWorldExamples.burundiSectorStructure,
      RealWorldExamples.hongKongSectorShift,
    ]),
  ],

);