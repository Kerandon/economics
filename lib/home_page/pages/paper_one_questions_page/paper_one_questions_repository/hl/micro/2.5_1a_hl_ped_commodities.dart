import 'package:economics_app/home_page/pages/real_world_examples/real_world_examples.dart';

import '../../../../../../diagrams/enums/diagram_enum.dart';
import '../../../../../../diagrams/enums/unit_type.dart';
import '../../../../../models/slide.dart';
import '../../../../../models/slide_content.dart' show SlideContent;
import '../../../../../models/term.dart';
import '../../../../terms/terms.dart';

final explainPEDLowForCommoditiesComparedToManufactured = Slide(
  subunit: Subunit.elasticityDemand,
  tags: [Tag.hl, Tag.p1a],
  question:
      'Explain why the price elasticity of demand (PED) for primary commodities is generally lower than the PED for manufactured products.',
  contents: [
    SlideContent.econTerms([
      EconTerm.priceInelasticDemand,
      EconTerm.primaryCommodity,
      EconTerm.manufacturedGood,
      EconTerm.primarySector,
      EconTerm.secondarySector,
    ]),
    SlideContent.text('''
<h3>Reasons Primary Commodities PED < 1</h3>
<ul>
  <li>Necessities for consumption (e.g. rice, grains, fish)</li>
  <li>Essential inputs in production (e.g. crude oil, minerals)</li>
  <li>Lack of close substitutes (e.g. oil for fuel/plastics)</li>
  <li>Small proportion of income (e.g. basic food)</li>
</ul>

<h3>Reasons Manufactured Goods tend to be PED > 1 (Generally)</h3>
<ul>
  <li>Often luxuries (e.g. cars, jewelry)</li>
  <li>Many substitutes (e.g. electronics, toys)</li>
  <li>Large proportion of income (e.g. cars, phones)</li>
  <li>Exceptions: necessities with no substitutes (e.g. specific medicines → PED < 1)</li>
</ul>
'''),
    SlideContent.diagrams([DiagramEnum.microDemandInelastic, DiagramEnum.microDemandElastic]),

  ],
);
