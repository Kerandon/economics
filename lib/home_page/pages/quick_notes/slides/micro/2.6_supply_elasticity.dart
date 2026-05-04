import '../../../../../diagrams/enums/diagram_enum.dart';
import '../../../../../diagrams/enums/unit_type.dart';
import '../../../../enums/tag.dart';
import '../../../../models/slide.dart';
import '../../../../models/slide_content.dart';
import '../../../real_world_examples/real_world_examples.dart';
import '../../../terms/terms.dart';

final supplyElasticitySlide =  Slide(
  subunit:
  Subunit.elasticitySupply,
  contents: [
    SlideContent.text('''
    <h2>PES</h2>
    <p>PES = %∆Qs / %∆P</p>  
      '''),
    SlideContent.simpleTable(
      headers: ['PES Value', 'Responsiveness', 'Example Good'],
      data: [
        ['PES = 0', 'Perfectly Inelastic', 'Fresh produce on market day / Stadium seats'],
        ['0 < PES < 1', 'Inelastic', 'Agricultural crops (requires growing time)'],
        ['PES = 1', 'Unit Elastic', 'Theoretical constant responsiveness'],
        ['1 < PES < ∞', 'Elastic', 'Manufactured goods with spare capacity'],
        ['PES = ∞', 'Perfectly Elastic', 'Global commodities in a small market'],
      ],
    ),
    SlideContent.text(
        '''
  <h3>Determinants of PES</h3>
  <ul>
    <li><b>Time</b></li>
    <li><b>Mobility of factors of production</b></li>
    <li><b>Unused capacity (Spare capacity)</b></li>
    <li><b>Ability to store stocks (Inventory)</b></li>
    <li><b>Rate at which marginal costs increase</b></li>
  </ul>
  '''
    ),
    SlideContent.diagrams(
        description: 'Primary commodities PES < 1; Many mass-manufactured goods have PES > 1 such as lego, toys.',
        [

      DiagramEnum.microSupplyInelastic,
        DiagramEnum.microSupplyElastic,
    ]),
    SlideContent.diagrams(
        description: 'Concert tickets or a Picasso painting have PES = 0; while software downloads PES is essentially infinite.',
        [
          DiagramEnum.microSupplyPerfectlyInelastic,
          DiagramEnum.microSupplyPerfectlyElastic,
        ]),
    SlideContent.simpleTable(
      tags: [Tag.hl],
      title: 'Reasons why the PES for primary commodities is generally lower than the PES for manufactured products',
      headers: ['PED < 1', 'PES < 1',],
      data: [
        ['Necessities for production', 'Long time to grow/extract',],
        ['Necessities for consumption', 'Cannot be easily stored (agricultural goods)',],
        ['Small proportion of income', 'Cannot be easily transported',],
        ['', 'Factors of Production immobility',],
        ['', 'Fast-rising marginal costs',],
        ['', 'Usually low spare-capacity',],
      ],
    ),
    SlideContent.diagrams([
      DiagramEnum.microSupplyPrimaryCommodities,
    ]),
    SlideContent.econTerms([
      EconTerm.priceElasticitySupply,
    ]),
  ],

);