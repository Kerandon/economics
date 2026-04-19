import 'package:economics_app/diagrams/enums/diagram_enum.dart';

import '../../../../../../../diagrams/enums/unit_type.dart';
import '../../../../../../models/slide.dart';
import '../../../../../../models/slide_content.dart';
import '../../../../../../models/term.dart';
import '../../../../../terms/terms.dart';

final explainNRUPaper1aHL = Slide(
  subunit: Subunit.macroObjectives,
  tags: [Tag.hl, Tag.p1a],
  question: 'Explain the natural rate of unemployment.',
  contents: [
    // 2. Definitions / Terms (Updated from the micro terms!)
    SlideContent.econTerms([EconTerm.nru]),

    // 3. Explanation Text
    SlideContent.text('''
<ul>
<li>The natural rate of unemployment (NRU) is the level of unemployment when the economy is at long-run equilibrium (full employment output).</li>
<li>Sum off <b>structural unemployment</b> (skills mismatch, geographic immobility, labor market rigidities); <b>frictional unemployment</b> (workers between jobs) and seasonal unemployment.</li>
<li>At NRU, the economy operates at potential output, so there is <b>no cyclical (demand-deficient) unemployment</b>.</li>
<li>When unemployment equals the NRU, inflation is stable and not accelerating / decelerating.</li>
<li>The NRU is determined by supply-side factors in the labor market, such as education, skills, mobility, and labor market regulations.</li>
</ul>

<h3>Extra:</h3>
<p>The NRU cannot be directly observed and must be estimated. It is relatively low in flexible labor markets (USA); but higher in economies with structural rigidities and skill mismatches (Spain).</p>
'''),
    SlideContent.diagrams([DiagramEnum.macroBusinessCycleNRU]),
    SlideContent.diagrams([DiagramEnum.macroLRPCFallInNRU]),
    SlideContent.diagrams([DiagramEnum.macroNaturalRateOfUnemployment]),
  ],
);
