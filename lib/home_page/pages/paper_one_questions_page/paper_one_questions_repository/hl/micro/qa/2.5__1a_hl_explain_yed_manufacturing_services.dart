import '../../../../../../../diagrams/enums/diagram_enum.dart';
import '../../../../../../../diagrams/enums/unit_type.dart';
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
  <li>YED determines how demand for goods and services changes as real incomes rise, affecting the <strong>relative size of economic sectors</strong>.</li>
  <li>Primary sector goods (e.g. agricultural products) are generally income inelastic (0 < YED < 1), so demand rises slowly as income increases.</li>
  <li>Manufactured goods show mixed YED: necessities are income inelastic, while luxury manufactures are income elastic.</li>
  <li>Services (tertiary sector) are usually income elastic (YED > 1), so demand increases more than proportionately as incomes rise.</li>
  <li>As a result, the tertiary sector tends to grow faster and becomes a larger share of GDP in developed economies.</li>
  <li>Inferior goods have negative YED, so demand falls as incomes rise (e.g. basic transport or generic brands).</li>
</ul>
'''),

    SlideContent.simpleTable(
      headers: [
        'Primary Sector',
        'Secondary (Manufacturing)',
        'Tertiary (Services)',
      ],
      data: [
        [
          'Income inelastic (0 < YED < 1)\nDemand grows slowly',
          'Mixed YED:\nNecessities 0 < YED < 1\nLuxuries YED > 1',
          'Income elastic (YED > 1)\nDemand grows strongly',
        ],
        [
          'Low contribution to long-run growth',
          'Intermediate role in development',
          'Main driver of economic growth in developed economies',
        ],
      ],
    ),

    SlideContent.tip('''
As economies develop, demand shifts away from primary goods towards services because income elasticity is higher in the tertiary sector. This leads to structural change in output and employment.
'''),

    SlideContent.simpleTable(
      headers: ['YED < 0', '0 < YED < 1', 'YED > 1'],
      data: [
        [
          'Inferior Goods',
          'Normal Goods – Necessities',
          'Normal Goods – Luxuries',
        ],
        [
          'Generic brands, basic transport',
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
