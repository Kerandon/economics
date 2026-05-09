import 'package:economics_app/diagrams/enums/diagram_enum.dart';
import 'package:economics_app/home_page/pages/terms/terms.dart';

import '../../../../../diagrams/enums/unit_type.dart';
import '../../../../models/slide.dart';
import '../../../../models/slide_content.dart';

final marketInequity = Slide(
  subunit: Subunit.marketInequity,
  contents: [
    SlideContent.text('''
    <ul>
  <li>Allocative efficiency answers what and how to produce most efficiently - but not for whom.</li>

  <li>Income distribution depends on ownership of factors of production (circular flow model).</li>

  <li>FOP ownership is unequal due to unemployment, discrimination, education gaps, and inherited wealth.</li>

  <li>Efficient markets can still produce unequal income and wealth distribution.</li>

  <li>Equity is normative and based on value judgments.</li>

  <li>Inequality can indirectly cause market failure via over-consumption of demerit goods and under-consumption of merit goods.</li>
</ul>
    '''),
    SlideContent.diagrams(
      description:
          'The circular flow of income model shows income only flows in reward for labor, land etc. What happens to those unable to generate income?',
      [DiagramEnum.macroCircularFlowTwoSectorEconomy],
    ),
    SlideContent.econTerms(
      EconTerm.values
          .where((term) => term.subunit == Subunit.marketInequity)
          .toList(),
    ),
  ],
);
