import '../../../../../../diagrams/enums/diagram_enum.dart';
import '../../../../../../diagrams/enums/unit_type.dart';
import '../../../../../models/slide.dart';
import '../../../../../models/slide_content.dart';
import '../../../../../models/term.dart';
import '../../../../terms/terms.dart';

final explainImportanceOfYEDToManufacturingServices = Slide(
  subunit: Subunit.elasticityDemand,
  tags: [Tag.hl, Tag.p1a],
  question:
      'Explain the importance of income elasticity of demand (YED) for the primary, manufacturing and service sectors of the economy when real incomes are rising.',
  contents: [
    SlideContent.econTerms([
      EconTerm.incomeElasticityOfDemand,
      EconTerm.realIncome,
      EconTerm.primarySector,
      EconTerm.secondarySector,
      EconTerm.tertiarySector,
    ]),
    SlideContent.text('''
    <ul>
      <li>As real GDP (national income) increases, consumers have higher real income and increased purchasing power. </li>
      <li>Service sector tends to be income elastic YED > 1. This means when real incomes rise, there is a % bigger increase in quantity demanded for tourism, education, and finance.</li>
      <li>Demand for many manufactured goods is income inelastic (necessities) as used as inputs in production (0 < YED < 1). However some goods such as luxury cars and jewelry which are income elastic (YED > 1).</li>
      <li>Demand for primary sector goods (e.g., basic agricultural products) grows relatively slowly, as income inelastic necessities (0 < YED < 1).</li>
      <li>Demand for inferior goods will fall as incomes rise (e.g., basic public transport, generic brands).</li>
  
      <li>In a recession (fall in real incomes), services and luxury goods in manufacturing see the biggest declines while inferior goods (generic brands) increase in demand.</li>
    
    </ul>
  '''),
    SlideContent.text('''
    <h3>Structural Changes</h3>
    <ul>
      <li>As real GDP increases it causes <strong>structural changes</strong> in the economy.</li>
      <li>as economic growth occurs, demand for primary products will increase more slowly than the demand for secondary/tertiary products.</li>
      <li>In poor countries (ELDCs) around 1/2 of real GDP is from the primary sector. In the USA 3/4 of real GDP is in tertiary sector.</li>
      
    </ul>
  '''),
    SlideContent.alert('''
      As a country develops and real incomes increase, the YED of goods in different sectors change. Meat might initially be a luxury (primary sector) but for rich countries is a necessity.
      '''),
    // 5. Diagram
    SlideContent.diagrams([DiagramEnum.microDemandEngelCurve]),
    SlideContent.simpleTable(
      headers: ['YED < 0', '0 < YED < 1', 'YED > 1'],
      data: [
        [
          'Inferior Goods',
          'Normal Good - Necessities (Inelastic)',
          'Normal Good - Luxuries (Elastic)',
        ],
      ],
    ),
  ],
);
