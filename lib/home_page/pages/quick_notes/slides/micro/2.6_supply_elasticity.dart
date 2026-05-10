import '../../../../../diagrams/enums/diagram_enum.dart';
import '../../../../../diagrams/enums/unit_type.dart';
import '../../../../enums/tag.dart';
import '../../../../models/slide.dart';
import '../../../../models/slide_content.dart';
import '../../../real_world_examples/real_world_examples.dart';
import '../../../terms/terms.dart';

final supplyElasticitySlide = Slide(
  subunit: Subunit.elasticitySupply,
  contents: [
    SlideContent.text('''
    <h2>PES</h2>
    <p>PES = %∆Qs / %∆P</p>  
      '''),
    SlideContent.simpleTable(
      headers: ['PES Value', 'Responsiveness', 'Example Good'],
      data: [
        ['PES = 0', 'Perfectly Inelastic', 'Picasso Painting / Stadium seats'],
        [
          '0 < PES < 1',
          'Inelastic',
          'Agricultural crops (time/storage/factor mobility/rising marginal costs/transportation)',
        ],
        ['PES = 1', 'Unit Elastic', ''],
        ['1 < PES < ∞', 'Elastic', 'Manufactured goods with spare capacity'],
        [
          'PES = ∞',
          'Perfectly Elastic',
          'Global commodities in a small market',
        ],
      ],
    ),
    SlideContent.text('''
  <h3>Determinants of PES</h3>
  <ul>
    <li>Time</li>
    <li>Mobility of factors of production</li>
    <li>Unused capacity (Spare capacity)</li>
    <li>Ability to store stocks (Inventory)</li>
    <li>Rate at which marginal costs increase</li>
  </ul>
  '''),
    SlideContent.diagrams(
      description:
          'Primary commodities PES < 1 (agricultural goods); Many mass-manufactured goods have PES > 1 such as lego, toys.',
      [DiagramEnum.microSupplyInelastic, DiagramEnum.microSupplyElastic],
    ),
    SlideContent.diagrams(
      description:
          'Concert tickets or a Picasso painting have PES = 0; while software downloads PES is essentially infinite.',
      [
        DiagramEnum.microSupplyPerfectlyInelastic,
        DiagramEnum.microSupplyPerfectlyElastic,
      ],
    ),
    SlideContent.simpleTable(
      tags: [Tag.hl],
      title:
          'Reasons why the PES for primary commodities is generally lower than the PES for manufactured products',
      headers: ['PED < 1', 'PES < 1'],
      data: [
        ['Necessities for production', 'Long time to grow/extract'],
        [
          'Necessities for consumption',
          'Cannot be easily stored (agricultural goods)',
        ],
        ['Small proportion of income', 'Cannot be easily transported'],
        ['', 'Factors of Production immobility'],
        ['', 'Fast-rising marginal costs'],
        ['', 'Usually low spare-capacity'],
      ],
    ),
    SlideContent.diagrams([DiagramEnum.microSupplyPrimaryCommodities]),
    SlideContent.econTerms(
      EconTerm.values
          .where((term) => term.subunit == Subunit.elasticitySupply)
          .toList(),
    ),
    SlideContent.realWorldExamples(
      RealWorldExamples.values
          .where((term) => term.subunit == Subunit.elasticitySupply)
          .toList(),
    ),
  ],
);
