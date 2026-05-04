import 'package:economics_app/home_page/pages/real_world_examples/real_world_examples.dart';

import '../../../../../../../diagrams/enums/diagram_enum.dart';
import '../../../../../../../diagrams/enums/unit_type.dart';
import '../../../../../../enums/tag.dart';
import '../../../../../../models/slide.dart';
import '../../../../../../models/slide_content.dart' show SlideContent;
import '../../../../../../models/term.dart';
import '../../../../../terms/terms.dart';

final explainPEDLowForCommoditiesComparedToManufactured = Slide(
  subunit: Subunit.elasticityDemand,
  tags: [Tag.hl, Tag.p1a],
  question:
      'Explain why the price elasticity of demand (PED) for primary commodities is generally lower than the PED for manufactured products.',
  contents: [
    SlideContent.econTerms([
      EconTerm.priceInelasticDemand,
      EconTerm.priceElasticDemand,
      EconTerm.primaryCommodity,
      EconTerm.manufacturedGood,
    ]),
    SlideContent.simpleTable(
      headers: [
        'Primary Commodities (PED < 1)',
        'Manufactured Goods (PED > 1) (Generally)',
      ],
      data: [
        [
          'Necessities in consumption (staple foods; rice, grains, fish);\nEssential inputs for production (e.g. oil, minerals)',
          'Often luxuries (cars, jewelry)',
        ],
        [
          'Lack of viable substitutes for primary goods',
          'Many available close substitutes (toys, electronics)',
        ],
        [
          'Tend take small proportion of income (rice, salt)',
          'Tend take bigger proportion of income (cars, computers)',
        ],
        ['', 'Some exceptions: (e.g. specific medicines have PED < 1)'],
      ],
    ),
    SlideContent.diagrams([
      DiagramEnum.microDemandInelastic,
      DiagramEnum.microDemandElastic,
    ]),
  ],
);
