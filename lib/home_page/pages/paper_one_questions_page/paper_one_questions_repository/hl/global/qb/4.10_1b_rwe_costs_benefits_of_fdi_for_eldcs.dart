import 'package:economics_app/home_page/pages/real_world_examples/real_world_examples.dart';

import '../../../../../../../diagrams/enums/diagram_enum.dart';
import '../../../../../../../diagrams/enums/unit_type.dart';
import '../../../../../../enums/tag.dart';
import '../../../../../../models/slide.dart';
import '../../../../../../models/slide_content.dart';
import '../../../../../../models/term.dart';
import '../../../../../terms/terms.dart';

final rweDiscussCostsAndBenefitsOfFDIForELDCs1bHL = Slide(
  subunit: Subunit.aDAS,
  tags: [Tag.hl, Tag.p1b],
  question:
      'Using real-world examples, discuss the benefits and costs of inward foreign direct investment (FDI) for economically less developed countries. ',
  contents: [
    SlideContent.econTerms([
      EconTerm.foreignDirectInvestment,
      EconTerm.economicallyLessDevelopedCountries,
      EconTerm.multinationalCorporations,
    ]),
    SlideContent.simpleTable(
      title: 'Evaluation of Costs and Benefits of FDI',
      headers: ['Benefits', 'Costs'],
      data: [
        [
          'Investment in physical capital',
          'Avoid taxation / pressure corrupt / poorer government for tax concessions',
        ],
        [
          'Transfer of skills and knowledge',
          'MNCs exploit labour and environment',
        ],
        [
          'Credit to BOP; boosts domestic savings',
          'Transfer pricing (understate profits)',
        ],
        [
          'Higher tax revenue (if taxed)',
          'Crowds out domestic infant industries',
        ],
        [
          'Economic growth / industry development',
          'Promotes excessive consumption',
        ],
        ['Job creation', 'Globalisation reduces local diversity'],
      ],
    ),
    SlideContent.diagrams([DiagramEnum.macroClassicalLongTermGrowth]),
    SlideContent.realWorldExamples([
      RealWorldExamples.foreignDirectInvestmentExamples,
    ]),
  ],
);
