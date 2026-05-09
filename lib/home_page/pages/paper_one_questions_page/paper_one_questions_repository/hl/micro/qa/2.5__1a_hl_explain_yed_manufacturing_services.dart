import '../../../../../../../diagrams/enums/diagram_enum.dart';
import '../../../../../../../diagrams/enums/unit_type.dart';
import '../../../../../../enums/tag.dart';
import '../../../../../../models/slide.dart';
import '../../../../../../models/slide_content.dart';
import '../../../../../../models/term.dart';
import '../../../../../terms/terms.dart';

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
  <li>YED shows how demand for goods and services changes as real incomes rise, affecting the <strong>relative size of economic sectors</strong>.</li>
  <li>Primary sector goods (e.g. agricultural products) are generally income inelastic (0 &lt; YED &lt; 1), so demand rises slowly as income increases.</li>
  <li>Manufactured goods have mixed YED: necessities are income inelastic, while luxury manufactures are income elastic.</li>
  <li>Services (tertiary sector) are usually income elastic (YED &gt; 1), so demand rises proportionally faster as income increases.</li>
  <li>As economies develop, the <strong>tertiary sector</strong> (e.g. finance, education, tourism) tends to grow faster and become a larger share of GDP than the primary sector.</li>
  <li>In a recession, inferior goods (YED &lt; 0) see increased demand as incomes fall (e.g. generic brands, basic transport).</li>
</ul>
'''),

    SlideContent.simpleTable(
      headers: [
        'Primary Sector (agriculture, fishing, oil)',
        'Secondary (manufacturing)',
        'Tertiary (services: banking, tourism, education, internet)',
      ],
      data: [
        [
          'Income inelastic (0 < YED < 1)\nDemand grows slowly',
          'Mixed YED:\nNecessities 0 < YED < 1\nLuxuries YED > 1',
          'Income elastic (YED > 1)\nDemand grows strongly',
        ],
      ],
    ),

    SlideContent.tip('''
As economies develop, demand shifts away from primary goods (e.g. farming) towards services (e.g. education, finance) because YED is higher in the tertiary sector. This drives structural change in output and employment.
'''),

    SlideContent.simpleTable(
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
    SlideContent.diagrams([DiagramEnum.microDemandEngelCurve]),
    SlideContent.diagrams([
      DiagramEnum.microDemandDecrease,
      DiagramEnum.microDemandIncrease,
    ]),
  ],
);
