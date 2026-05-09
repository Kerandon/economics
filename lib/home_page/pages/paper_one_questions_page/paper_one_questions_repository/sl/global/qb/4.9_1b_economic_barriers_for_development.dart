import 'package:economics_app/diagrams/enums/diagram_enum.dart';
import 'package:economics_app/home_page/pages/real_world_examples/real_world_examples.dart';

import '../../../../../../../diagrams/enums/unit_type.dart';
import '../../../../../../enums/tag.dart';
import '../../../../../../models/slide.dart';
import '../../../../../../models/slide_content.dart';
import '../../../../../../models/term.dart';
import '../../../../../terms/terms.dart';

final useRWEToDiscussEconomicBarriersOnGrowthAndDevelopment15MarkSL = Slide(
  subunit: Subunit.barriersGrowth,
  tags: [Tag.sl, Tag.p1b],
  question:
      'Using real-world examples, discuss the significance of economic barriers for a country’s economic growth and economic development. ',
  contents: [
    SlideContent.simpleTable(
      headers: ['Economic Barriers to Development'],
      data: [
        ['Lack of access to infrastructure and appropriate technology'],
        ['Rising economic inequality'],
        [
          'Low levels of human capital (limited access to healthcare and education)',
        ],
        ['Dependence on primary sector production'],
        ['Lack of access to international markets'],
        ['Informal economy'],
        ['Capital flight'],
        ['Indebtedness'],
        ['Geography (including landlocked countries)'],
        ['Tropical climates and endemic diseases'],
      ],
    ),
    SlideContent.realWorldExamples([]),
    SlideContent.diagrams([
      DiagramEnum.macroClassicalLongTermGrowth,
      DiagramEnum.globalPPCEconomicGrowth,
    ]),
    SlideContent.diagrams([DiagramEnum.globalPovertyCycle]),
    SlideContent.econTerms([
      EconTerm.economicBarriers,
      EconTerm.economicGrowth,
      EconTerm.economicDevelopment,
      EconTerm.primarySector,
      EconTerm.infrastructure,
      EconTerm.informalEconomy,
      EconTerm.appropriateTechnology,
      EconTerm.capitalFlight,
    ]),
  ],
);
