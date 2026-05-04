import 'package:economics_app/diagrams/enums/diagram_enum.dart';

import '../../../../../../../diagrams/enums/unit_type.dart';
import '../../../../../../enums/tag.dart';
import '../../../../../../models/slide.dart';
import '../../../../../../models/slide_content.dart';
import '../../../../../../models/term.dart';
import '../../../../../terms/terms.dart';

final explainImpactOfSocialPoliticalBarriersOnEconomicDevelopment = Slide(
  subunit: Subunit.barriersGrowth,
  tags: [Tag.sl, Tag.p1a],
  question:
      'Explain how political and social factors can act as barriers to economic growth and economic development.',
  contents: [
    SlideContent.text('''
    
    <p>The question mentions economic growth (sustained increase in real GDP) <strong>and</strong> economic development (A broader, multidimensional concept which relates to an improvement in standards of living) so these should be clearly defined.</p>
    <p>The impacts of the following political and social factors on economic growth and economic development should be clearly explained.</p>
    
    <ul>
    <li>Weak institutional framework
    <ul>
    <li>Legal system</li>
    <li>Ineffective taxation structures</li>
    <li>Banking system</li>
    <li>Property rights</li>
    </ul>
    </li>
        <li>Gender inequality</li>
        <li>Lack of good governance and corruption</li>
        <li>Unequal political power and status</li>
        </ul>
        <p>Diagrams can illustrate economic growth or the poverty cycle.</p>
       
'''),
    SlideContent.diagrams([
      DiagramEnum.macroClassicalLongTermGrowth,
      DiagramEnum.globalPPCEconomicGrowth,
    ]),
    SlideContent.diagrams([DiagramEnum.globalPovertyCycle]),
    SlideContent.econTerms([
      EconTerm.socialAndPoliticalBarriers,
      EconTerm.economicGrowth,
      EconTerm.economicDevelopment,
    ]),
  ],
);
